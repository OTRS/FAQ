# --
# Copyright (C) 2001-2019 OTRS AG, https://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Modules::CustomerFAQZoom;

use strict;
use warnings;

use Kernel::System::FAQ;
use Kernel::System::Valid;
use Kernel::System::DynamicField;
use Kernel::System::DynamicField::Backend;
use Kernel::System::VariableCheck qw(:all);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # check needed objects
    for my $Object (
        qw(ParamObject DBObject LayoutObject LogObject ConfigObject UserObject)
        )
    {
        if ( !$Self->{$Object} ) {
            $Self->{LayoutObject}->CustomerFatalError( Message => "Got no $Object!" );
        }
    }

    # create needed objects
    $Self->{FAQObject}          = Kernel::System::FAQ->new(%Param);
    $Self->{ValidObject}        = Kernel::System::Valid->new(%Param);
    $Self->{DynamicFieldObject} = Kernel::System::DynamicField->new(%Param);
    $Self->{BackendObject}      = Kernel::System::DynamicField::Backend->new(%Param);

    # get config of frontend module
    $Self->{Config} = $Self->{ConfigObject}->Get("FAQ::Frontend::$Self->{Action}");

    # set default interface settings
    $Self->{Interface} = $Self->{FAQObject}->StateTypeGet(
        Name   => 'external',
        UserID => $Self->{UserID},
    );
    $Self->{InterfaceStates} = $Self->{FAQObject}->StateTypeList(
        Types  => $Self->{ConfigObject}->Get('FAQ::Customer::StateTypes'),
        UserID => $Self->{UserID},
    );

    # get default options
    $Self->{MultiLanguage} = $Self->{ConfigObject}->Get('FAQ::MultiLanguage');
    $Self->{Voting}        = $Self->{ConfigObject}->Get('FAQ::Voting');

    # get the dynamic fields for this screen
    $Self->{DynamicField} = $Self->{DynamicFieldObject}->DynamicFieldListGet(
        Valid       => 1,
        ObjectType  => 'FAQ',
        FieldFilter => $Self->{Config}->{DynamicField} || {},
    );

    if ( !defined $Self->{DoNotShowBrowserLinkMessage} ) {
        my %UserPreferences = $Self->{UserObject}->GetPreferences(
            UserID => $Self->{UserID},
        );

        if ( $UserPreferences{UserCustomerDoNotShowBrowserLinkMessage} ) {
            $Self->{DoNotShowBrowserLinkMessage} = 1;
        }
        else {
            $Self->{DoNotShowBrowserLinkMessage} = 0;
        }
    }

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get params
    my %GetParam;
    $GetParam{ItemID} = $Self->{ParamObject}->GetParam( Param => 'ItemID' );
    $GetParam{Rate}   = $Self->{ParamObject}->GetParam( Param => 'Rate' );

    # save, if browser link message was closed
    if ( $Self->{Subaction} eq 'BrowserLinkMessage' ) {

        $Self->{UserObject}->SetPreferences(
            UserID => $Self->{UserID},
            Key    => 'UserCustomerDoNotShowBrowserLinkMessage',
            Value  => 1,
        );

        return $Self->{LayoutObject}->Attachment(
            ContentType => 'text/html',
            Content     => 1,
            Type        => 'inline',
            NoCache     => 1,
        );
    }

    # check needed stuff
    if ( !$GetParam{ItemID} ) {
        return $Self->{LayoutObject}->CustomerFatalError( Message => 'Need ItemID!' );
    }

    # get FAQ item data
    my %FAQData = $Self->{FAQObject}->FAQGet(
        ItemID        => $GetParam{ItemID},
        ItemFields    => 1,
        UserID        => $Self->{UserID},
        DynamicFields => 1,
    );
    if ( !%FAQData ) {
        return $Self->{LayoutObject}->CustomerFatalError();
    }

    # get the valid ids
    my @ValidIDs      = $Self->{ValidObject}->ValidIDsGet();
    my %ValidIDLookup = map { $_ => 1 } @ValidIDs;

    # check user permission
    my $Permission = $Self->{FAQObject}->CheckCategoryCustomerPermission(
        CustomerUser => $Self->{UserLogin},
        CategoryID   => $FAQData{CategoryID},
        UserID       => $Self->{UserID},
    );

    # permission check
    if (
        !$Permission
        || !$FAQData{Approved}
        || !$ValidIDLookup{ $FAQData{ValidID} }
        || !$Self->{InterfaceStates}->{ $FAQData{StateTypeID} }
        )
    {
        return $Self->{LayoutObject}->CustomerNoPermission( WithHeader => 'yes' );
    }

    # store the last screen in session
    $Self->{SessionObject}->UpdateSessionID(
        SessionID => $Self->{SessionID},
        Key       => 'LastScreenView',
        Value     => $Self->{RequestedURL},
    );

    # ---------------------------------------------------------- #
    # HTMLView Subaction
    # ---------------------------------------------------------- #
    if ( $Self->{Subaction} eq 'HTMLView' ) {

        # get params
        my $Field = $Self->{ParamObject}->GetParam( Param => "Field" );

        # needed params
        for my $Needed (qw( ItemID Field )) {
            if ( !$Needed ) {
                $Self->{LogObject}->Log(
                    Message  => "Needed Param: $Needed!",
                    Priority => 'error',
                );
                return;
            }
        }

        # get the Field content
        my $FieldContent = $Self->{FAQObject}->ItemFieldGet(
            ItemID => $GetParam{ItemID},
            Field  => $Field,
            UserID => $Self->{UserID},
        );

        # rewrite handle and action
        $FieldContent
            =~ s{ index[.]pl [?] Action=AgentFAQZoom }{customer.pl?Action=CustomerFAQZoom}gxms;

        # take care of old style before FAQ 2.0.x
        $FieldContent =~ s{
            index[.]pl [?] Action=AgentFAQ [&](amp;)? Subaction=Download [&](amp;)?
        }{customer.pl?Action=CustomerFAQZoom;Subaction=DownloadAttachment;}gxms;

        # build base URL for inline images
        my $SessionID = '';
        if ( $Self->{SessionID} && !$Self->{SessionIDCookie} ) {
            $SessionID = ';' . $Self->{SessionName} . '=' . $Self->{SessionID};
            $FieldContent =~ s{
                (Action=CustomerFAQZoom;Subaction=DownloadAttachment;ItemID=\d+;FileID=\d+)
            }{$1$SessionID}gmsx;
        }

        # add needed HTML headers
        $FieldContent = $Self->{LayoutObject}->{HTMLUtilsObject}->DocumentComplete(
            String  => $FieldContent,
            Charset => 'utf-8',
        );

        # return complete HTML as an attachment
        return $Self->{LayoutObject}->Attachment(
            Type        => 'inline',
            ContentType => 'text/html',
            Content     => $FieldContent,
        );
    }

    # ---------------------------------------------------------- #
    # DownloadAttachment Subaction
    # ---------------------------------------------------------- #
    if ( $Self->{Subaction} eq 'DownloadAttachment' ) {

        # manage parameters
        $GetParam{FileID} = $Self->{ParamObject}->GetParam( Param => 'FileID' );
        if ( !defined $GetParam{FileID} ) {
            return $Self->{LayoutObject}->CustomerFatalError( Message => 'Need FileID' );
        }

        # get attachments
        my %File = $Self->{FAQObject}->AttachmentGet(
            ItemID => $GetParam{ItemID},
            FileID => $GetParam{FileID},
            UserID => $Self->{UserID},
        );
        if (%File) {
            return $Self->{LayoutObject}->Attachment(%File);
        }
        else {
            $Self->{LogObject}->Log(
                Message  => "No such attachment ($GetParam{FileID})! May be an attack!!!",
                Priority => 'error',
            );
            return $Self->{LayoutObject}->CustomerFatalError();
        }
    }

    # output header
    my $Output = $Self->{LayoutObject}->CustomerHeader(
        Value => $FAQData{Title},
    );
    $Output .= $Self->{LayoutObject}->CustomerNavigationBar();

    # get FAQ vote information
    my $VoteData;
    if ( $Self->{Voting} ) {
        $VoteData = $Self->{FAQObject}->VoteGet(
            CreateBy  => $Self->{UserID},
            ItemID    => $FAQData{ItemID},
            Interface => $Self->{Interface}->{StateID},
            IP        => $ENV{'REMOTE_ADDR'},
            UserID    => $Self->{UserID},
        );
    }

    # check if user already voted this FAQ item
    my $AlreadyVoted;
    if ($VoteData) {

        # item/change_time > voting/create_time
        my $ItemChangedSystemTime = $Self->{TimeObject}->TimeStamp2SystemTime(
            String => $FAQData{Changed} || '',
        );
        my $VoteCreatedSystemTime = $Self->{TimeObject}->TimeStamp2SystemTime(
            String => $VoteData->{Created} || '',
        );
        if ( $ItemChangedSystemTime <= $VoteCreatedSystemTime ) {
            $AlreadyVoted = 1;
        }
    }

    # ---------------------------------------------------------- #
    # Vote Subaction
    # ---------------------------------------------------------- #
    if ( $Self->{Subaction} eq 'Vote' ) {

        # customer can't use this subaction if is not enabled
        if ( !$Self->{Voting} ) {
            $Self->{LayoutObject}->CustomerFatalError(
                Message => "The voting mechanism is not enabled!",
            );
        }

        # user can vote only once per FAQ revision
        if ($AlreadyVoted) {
            $Output .= $Self->{LayoutObject}->Notify(
                Priority => 'Error',
                Info     => 'You have already voted!',
            );
        }

        # set the vote if any
        elsif ( defined $GetParam{Rate} ) {

            # get rates config
            my $VotingRates = $Self->{ConfigObject}->Get('FAQ::Item::Voting::Rates');
            my $Rate        = $GetParam{Rate};

            # send error if rate is not defined in config
            if ( !$VotingRates->{$Rate} ) {
                $Self->{LayoutObject}->CustomerFatalError(
                    Message => "The vote rate is not defined!"
                );
            }

            # otherwise add the vote
            else {
                $Self->{FAQObject}->VoteAdd(
                    CreatedBy => $Self->{UserID},
                    ItemID    => $GetParam{ItemID},
                    IP        => $ENV{'REMOTE_ADDR'},
                    Interface => $Self->{Interface}->{StateID},
                    Rate      => $GetParam{Rate},
                    UserID    => $Self->{UserID},
                );

                # do not show the voting form
                $AlreadyVoted = 1;

                # refresh FAQ item data
                %FAQData = $Self->{FAQObject}->FAQGet(
                    ItemID     => $GetParam{ItemID},
                    ItemFields => 1,
                    UserID     => $Self->{UserID},
                );
                if ( !%FAQData ) {
                    return $Self->{LayoutObject}->CustomerFatalError();
                }

                $Output .= $Self->{LayoutObject}->Notify( Info => 'Thanks for your vote!' );
            }
        }

        # user is able to vote but no rate has been selected
        else {
            $Output .= $Self->{LayoutObject}->Notify(
                Priority => 'Error',
                Info     => 'No rate selected!',
            );
        }
    }

    # prepare fields data (Still needed for PlainText)
    FIELD:
    for my $Field (qw(Field1 Field2 Field3 Field4 Field5 Field6)) {
        next FIELD if !$FAQData{$Field};

        # rewrite links to embedded images for customer interface
        if ( $Self->{Interface}->{Name} eq 'external' ) {

            # rewrite handle and action
            $FAQData{$Field}
                =~ s{ index[.]pl [?] Action=AgentFAQZoom }{customer.pl?Action=CustomerFAQZoom}gxms;

            # take care of old style before FAQ 2.0.x
            $FAQData{$Field} =~ s{
                index[.]pl [?] Action=AgentFAQ [&](amp;)? Subaction=Download [&](amp;)?
            }{customer.pl?Action=CustomerFAQZoom;Subaction=DownloadAttachment;}gxms;
        }

        # no quoting if HTML view is enabled
        next FIELD if $Self->{ConfigObject}->Get('FAQ::Item::HTML');

        # HTML quoting
        $FAQData{$Field} = $Self->{LayoutObject}->Ascii2Html(
            NewLine        => 0,
            Text           => $FAQData{$Field},
            VMax           => 5000,
            HTMLResultMode => 1,
            LinkFeature    => 1,
        );
    }

    # set voting results
    $Param{VotingResultColor} = $Self->{LayoutObject}->GetFAQItemVotingRateColor(
        Rate => $FAQData{VoteResult},
    );

    if ( !$Param{VotingResultColor} || $FAQData{Votes} eq '0' ) {
        $Param{VotingResultColor} = 'Gray';
    }

    # show back link
    $Self->{LayoutObject}->Block(
        Name => 'Back',
        Data => \%Param,
    );

    # show language
    if ( $Self->{MultiLanguage} ) {
        $Self->{LayoutObject}->Block(
            Name => 'Language',
            Data => {%FAQData},
        );
    }

    # show votes
    if ( $Self->{Voting} ) {

        # always displays Votes result even if its 0
        $Self->{LayoutObject}->Block(
            Name => 'ViewVotes',
            Data => {%FAQData},
        );
    }

    # show FAQ path
    my $ShowFAQPath = $Self->{LayoutObject}->FAQPathShow(
        FAQObject  => $Self->{FAQObject},
        CategoryID => $FAQData{CategoryID},
        UserID     => $Self->{UserID},
    );
    if ($ShowFAQPath) {
        $Self->{LayoutObject}->Block(
            Name => 'FAQPathItemElement',
            Data => {%FAQData},
        );
    }

    # show keywords as search links
    if ( $FAQData{Keywords} ) {

        # replace commas and semicolons
        $FAQData{Keywords} =~ s/,/ /g;
        $FAQData{Keywords} =~ s/;/ /g;

        my @Keywords = split /\s+/, $FAQData{Keywords};
        for my $Keyword (@Keywords) {
            $Self->{LayoutObject}->Block(
                Name => 'Keywords',
                Data => {
                    Keyword => $Keyword,
                },
            );
        }
    }

    # output rating stars
    if ( $Self->{Voting} ) {
        $Self->{LayoutObject}->FAQRatingStarsShow(
            VoteResult => $FAQData{VoteResult},
            Votes      => $FAQData{Votes},
        );
    }

    # output attachments if any
    my @AttachmentIndex = $Self->{FAQObject}->AttachmentIndex(
        ItemID     => $GetParam{ItemID},
        ShowInline => 0,
        UserID     => $Self->{UserID},
    );

    # output attachments
    if (@AttachmentIndex) {
        $Self->{LayoutObject}->Block(
            Name => 'AttachmentHeader',
        );
        for my $Attachment (@AttachmentIndex) {
            $Self->{LayoutObject}->Block(
                Name => 'AttachmentRow',
                Data => {
                    %FAQData,
                    %{$Attachment},
                },
            );
        }
    }

    # show message about links in iframes, if user didn't close it already
    if ( !$Self->{DoNotShowBrowserLinkMessage} ) {
        $Self->{LayoutObject}->Block(
            Name => 'BrowserLinkMessage',
        );
    }

    # show FAQ Content
    $Self->{LayoutObject}->FAQContentShow(
        FAQObject       => $Self->{FAQObject},
        InterfaceStates => $Self->{InterfaceStates},
        FAQData         => {%FAQData},
        UserID          => $Self->{UserID},
    );

    # cycle trough the activated Dynamic Fields for ticket object
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        my $Value = $Self->{BackendObject}->ValueGet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $GetParam{ItemID},
        );

        # get print string for this dynamic field
        my $ValueStrg = $Self->{BackendObject}->DisplayValueRender(
            DynamicFieldConfig => $DynamicFieldConfig,
            Value              => $Value,
            ValueMaxChars      => 250,
            LayoutObject       => $Self->{LayoutObject},
        );

        my $Label = $DynamicFieldConfig->{Label};

        $Self->{LayoutObject}->Block(
            Name => 'FAQDynamicField',
            Data => {
                Label => $Label,
                Value => $ValueStrg->{Value},
                Title => $ValueStrg->{Title},
            },
        );

        # example of dynamic fields order customization
        $Self->{LayoutObject}->Block(
            Name => 'FAQDynamicField_' . $DynamicFieldConfig->{Name},
            Data => {
                Label => $Label,
                Value => $ValueStrg->{Value},
                Title => $ValueStrg->{Title},
            },
        );
    }

    # show FAQ Voting
    if ( $Self->{Voting} ) {

        # get voting config
        my $ShowVotingConfig = $Self->{ConfigObject}->Get('FAQ::Item::Voting::Show');
        if ( $ShowVotingConfig->{ $Self->{Interface}->{Name} } ) {

            # check if the user already voted after last change
            if ( !$AlreadyVoted ) {
                $Self->_FAQVoting( FAQData => {%FAQData} );
            }
        }
    }

    # log access to this FAQ item
    $Self->{FAQObject}->FAQLogAdd(
        ItemID    => $Self->{ParamObject}->GetParam( Param => 'ItemID' ),
        Interface => $Self->{Interface}->{Name},
        UserID    => $Self->{UserID},
    );

    # start template output
    $Output .= $Self->{LayoutObject}->Output(
        TemplateFile => 'CustomerFAQZoom',
        Data         => {
            %FAQData,
            %GetParam,
            %Param,
        },
    );

    # add footer
    $Output .= $Self->{LayoutObject}->CustomerFooter();

    return $Output;
}

sub _FAQVoting {
    my ( $Self, %Param ) = @_;

    my %FAQData = %{ $Param{FAQData} };

    # output voting block
    $Self->{LayoutObject}->Block(
        Name => 'FAQVoting',
        Data => {%FAQData},
    );

    # get Voting rates setting
    my $VotingRates = $Self->{ConfigObject}->Get('FAQ::Item::Voting::Rates');
    for my $RateValue ( sort { $a <=> $b } keys %{$VotingRates} ) {

        # create data structure for output
        my %Data = (
            Value => $RateValue,
            Title => $VotingRates->{$RateValue},
        );

        # output vote rating row block
        $Self->{LayoutObject}->Block(
            Name => 'FAQVotingRateRow',
            Data => {%Data},
        );
    }
}

1;
