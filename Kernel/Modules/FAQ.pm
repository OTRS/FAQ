# --
# Kernel/Modules/FAQ.pm - faq module
# Copyright (C) 2001-2010 OTRS AG, http://otrs.org/
# --
# $Id: FAQ.pm,v 1.56 2010-11-19 21:55:32 cr Exp $
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::FAQ;

use strict;
use warnings;

use Kernel::System::User;
use Kernel::System::FAQ;
use Kernel::System::LinkObject;
use Kernel::System::HTMLUtils;

use vars qw($VERSION);
$VERSION = qw($Revision: 1.56 $) [1];

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # check needed Objects
    for (qw(ParamObject DBObject LayoutObject LogObject ConfigObject UserObject)) {
        $Self->{LayoutObject}->FatalError( Message => "Got no $_!" ) if ( !$Self->{$_} );
    }

    # faq object
    $Self->{FAQObject} = Kernel::System::FAQ->new(%Param);

    # link object
    $Self->{LinkObject} = Kernel::System::LinkObject->new(%Param);

    # agent user object
    $Self->{AgentUserObject} = Kernel::System::User->new(%Param);

    # HTMLUtils object
    $Self->{HTMLUtilsObject} = Kernel::System::HTMLUtils->new(%Param);

    # interface settings
    $Self->{Interface} = $Self->{FAQObject}->StateTypeGet(
        Name   => 'public',
        UserID => $Self->{UserID},
    );
    $Self->{InterfaceStates} = $Self->{FAQObject}->StateTypeList(
        Types  => ['public'],
        UserID => $Self->{UserID},
    );

    # global output vars
    $Self->{Notify} = [];

    return $Self;
}

sub GetExplorer {
    my ( $Self, %Param ) = @_;

    my %Frontend = ();
    my %GetParam = ();
    my @Params   = qw(OrderBy SortBy);

    # manage parameters
    $GetParam{CategoryID} = $Self->{ParamObject}->GetParam( Param => 'CategoryID' ) || 0;
    $GetParam{OrderBy}    = $Self->{ParamObject}->GetParam( Param => 'OrderBy' )    || 'Title';
    $GetParam{SortBy}     = $Self->{ParamObject}->GetParam( Param => 'SortBy' )     || 'up';
    for (@Params) {
        if ( !$GetParam{$_} && !( $GetParam{$_} = $Self->{ParamObject}->GetParam( Param => $_ ) ) )
        {
            return $Self->{LayoutObject}->FatalError( Message => "Need parameter $_" );
        }
    }

    # db action
    my %CategoryData = ();
    if ( $GetParam{CategoryID} ) {
        %CategoryData = $Self->{FAQObject}->CategoryGet(
            CategoryID => $GetParam{CategoryID},
            UserID     => $Self->{UserID},
        );
        if ( !%CategoryData ) {
            return $Self->{LayoutObject}->ErrorScreen();
        }
    }

    # dtl block
    $Self->{LayoutObject}->Block(
        Name => 'Explorer',
        Data => { %CategoryData, %Frontend },
    );

    # FAQ path
    $Self->_GetFAQPath(
        CategoryID => $GetParam{CategoryID},
    );

    # explorer title
    if ( $GetParam{CategoryID} ) {
        $Self->{LayoutObject}->Block(
            Name => 'ExplorerTitle',
            Data => {
                Name    => $CategoryData{Name},
                Comment => $CategoryData{Comment},
            },
        );
    }
    else {
        $Self->{LayoutObject}->Block(
            Name => 'ExplorerTitle',
            Data => {
                Name    => $Self->{ConfigObject}->Get('FAQ::Default::RootCategoryName'),
                Comment => $Self->{ConfigObject}->Get('FAQ::Default::RootCategoryComment'),
            },
        );
    }

    # explorer category list
    if ( !$Param{Mode} ) {
        $Param{Mode} = 'Public';
    }
    if ( !defined( $Param{CustomerUser} ) ) {
        $Param{CustomerUser} = '';
    }
    if ( $Param{Mode} && $Param{Mode} eq 'Customer' ) {
        $Self->_GetExplorerCategoryList(
            CategoryID   => $GetParam{CategoryID},
            OrderBy      => 'Name',
            SortBy       => 'up',
            Mode         => $Param{Mode},
            CustomerUser => $Param{CustomerUser},
        );
    }
    else {
        $Self->_GetExplorerCategoryList(
            CategoryID => $GetParam{CategoryID},
            OrderBy    => 'Name',
            SortBy     => 'up',
            Mode       => $Param{Mode},
        );
    }

    # explorer item list
    $Self->_GetExplorerItemList(
        CategoryID => $GetParam{CategoryID},
        OrderBy    => $GetParam{OrderBy} || 'Title',
        SortBy     => $GetParam{SortBy} || 'up',
    );

    # quicksearch
    my %ShowQuickSearch = %{ $Self->{ConfigObject}->Get('FAQ::Explorer::QuickSearch::Show') };
    if ( exists( $ShowQuickSearch{ $Self->{Interface}{Name} } ) ) {
        $Self->_GetExplorerQuickSearch(
            CategoryID => $GetParam{CategoryID},
        );
    }

    # latest change faq items
    my %ShowLastChange = %{ $Self->{ConfigObject}->Get('FAQ::Explorer::LastChange::Show') };
    if ( exists( $ShowLastChange{ $Self->{Interface}{Name} } ) ) {
        $Self->_GetExplorerLastChangeItems(
            CategoryID   => $GetParam{CategoryID},
            Mode         => $Param{Mode},
            CustomerUser => $Param{CustomerUser},
        );
    }

    # latest create faq items
    my %ShowLastCreate = %{ $Self->{ConfigObject}->Get('FAQ::Explorer::LastCreate::Show') };
    if ( exists( $ShowLastCreate{ $Self->{Interface}{Name} } ) ) {
        $Self->_GetExplorerLastCreateItems(
            CategoryID   => $GetParam{CategoryID},
            Mode         => $Param{Mode},
            CustomerUser => $Param{CustomerUser},
        );
    }

    # top 10 faq items
    my %ShowTop10 = %{ $Self->{ConfigObject}->Get('FAQ::Explorer::Top10::Show') };
    if ( exists( $ShowTop10{ $Self->{Interface}{Name} } ) ) {
        $Self->_GetExplorerTop10Items(
            Mode         => $Param{Mode},
            CategoryID   => $GetParam{CategoryID},
            CustomerUser => $Param{CustomerUser},
        );
    }
}

sub _GetFAQPath {
    my ( $Self, %Param ) = @_;

    $Self->{LayoutObject}->Block(
        Name => 'FAQPathCategoryElement',
        Data => {
            'Name'       => $Self->{ConfigObject}->Get('FAQ::Default::RootCategoryName'),
            'CategoryID' => '0',
        },
    );

    if ( $Self->{ConfigObject}->Get('FAQ::Explorer::Path::Show') ) {
        my @CategoryList = @{
            $Self->{FAQObject}->FAQPathListGet(
                CategoryID => $Param{CategoryID},
                UserID     => $Self->{UserID}
                )
            };
        for my $Data (@CategoryList) {
            $Self->{LayoutObject}->Block(
                Name => 'FAQPathCategoryElement',
                Data => { %{$Data} },
            );
        }
        return 1;
    }
    return 0;
}

sub _GetExplorerCategoryList {
    my ( $Self, %Param ) = @_;

    my %Frontend = ();
    $Frontend{CssRow} = '';

    # check needed parameters
    for (qw(OrderBy SortBy)) {
        if ( !$Param{$_} ) {
            $Self->{LayoutObject}->FatalError( Message => "Need parameter $_!" )
        }
    }
    my @CategoryIDs = ();
    if ( $Param{Mode} && $Param{Mode} eq 'Agent' ) {
        @CategoryIDs = @{
            $Self->{FAQObject}->AgentCategorySearch(
                ParentID => $Param{CategoryID},
                UserID   => $Self->{UserID},
                )
            };
    }
    elsif ( $Param{Mode} && $Param{Mode} eq 'Customer' ) {
        @CategoryIDs = @{
            $Self->{FAQObject}->CustomerCategorySearch(
                ParentID     => $Param{CategoryID},
                CustomerUser => $Param{CustomerUser},
                Mode         => $Param{Mode},
                UserID       => $Self->{UserID},
                )
            };
    }
    else {
        @CategoryIDs = @{
            $Self->{FAQObject}->PublicCategorySearch(
                ParentID => $Param{CategoryID},
                Mode     => $Param{Mode},
                UserID   => $Self->{UserID},
                )
            };
    }

    if (@CategoryIDs) {
        $Self->{LayoutObject}->Block(
            Name => 'ExplorerCategoryList',
        );
        for (@CategoryIDs) {
            my %Data = $Self->{FAQObject}->CategoryGet(
                CategoryID => $_,
                UserID     => $Self->{UserID},
            );
            $Data{CategoryNumber} = $Self->{FAQObject}->CategoryCount(
                ParentIDs => [$_],
                UserID    => $Self->{UserID},
            );
            my $OnlyApproved = 1;
            if ( $Param{Mode} eq 'Agent' ) {
                $OnlyApproved = 0;
            }
            $Data{ArticleNumber} = $Self->{FAQObject}->FAQCount(
                CategoryIDs  => [$_],
                ItemStates   => $Self->{InterfaceStates},
                OnlyApproved => $OnlyApproved,
                UserID       => $Self->{UserID},
            );

            # css configuration
            if ( $Frontend{CssRow} eq 'searchpassive' ) {
                $Frontend{CssRow} = 'searchactive';
            }
            else {
                $Frontend{CssRow} = 'searchpassive';
            }
            $Self->{LayoutObject}->Block(
                Name => 'ExplorerCategoryRow',
                Data => { %Data, %Frontend },
            );
        }
    }
    return;
}

sub _GetExplorerItemList {
    my ( $Self, %Param ) = @_;

    # check needed parameters
    for (qw(OrderBy SortBy)) {
        if ( !$Param{$_} ) {
            $Self->{LayoutObject}->FatalError( Message => "Need parameter $_!" )
        }
    }

    my $CssRow  = '';
    my @ItemIDs = $Self->{FAQObject}->FAQSearch(
        CategoryIDs => [ $Param{CategoryID} ],
        States      => $Self->{InterfaceStates},
        OrderBy     => [ $Param{OrderBy} ],
        SortBy      => $Param{SortBy},
        Interface   => $Self->{Interface}{Name},
        Limit       => 300,
        UserID      => $Self->{UserID},
    );

    if (@ItemIDs) {
        $Self->{LayoutObject}->Block(
            Name => 'ExplorerFAQItemList',
            Data => {%Param},
        );
        for (@ItemIDs) {
            my %Frontend = ();
            my %Data = $Self->{FAQObject}->FAQGet( ItemID => $_ );

            # css configuration
            if ( $CssRow eq 'searchpassive' ) {
                $CssRow = 'searchactive';
            }
            else {
                $CssRow = 'searchpassive';
            }
            $Frontend{CssRow}                = $CssRow;
            $Frontend{CssColumnVotingResult} = 'color:'
                . $Self->{LayoutObject}->GetFAQItemVotingRateColor( Rate => $Data{VoteResult} )
                . ';';

            $Self->{LayoutObject}->Block(
                Name => 'ExplorerFAQItemRow',
                Data => {
                    %Data,
                    %Frontend,
                },
            );
        }
    }
    return;
}

sub _GetExplorerLastChangeItems {
    my ( $Self, %Param ) = @_;

    if ( $Self->{ConfigObject}->Get('FAQ::Explorer::LastChange::Show') ) {

        # check needed parameters
        for (qw(CategoryID)) {
            if ( !defined( $Param{$_} ) ) {
                $Self->{LayoutObject}->FatalError( Message => "Need parameter $_!" )
            }
        }
        my @ItemIDs = ();
        if ( defined( $Param{CategoryID} ) ) {

            # add current categoryid
            my @CategoryIDs = ();
            if ( $Param{CategoryID} ) {
                push( @CategoryIDs, ( $Param{CategoryID} ) );
            }
            if ( !defined( $Param{Mode} ) ) {
                $Param{Mode} = '';
            }
            if ( !defined( $Param{CustomerUser} ) ) {
                $Param{CustomerUser} = '';
            }

            # add subcategoryids
            if ( $Self->{ConfigObject}->Get('FAQ::Explorer::LastChange::ShowSubCategoryItems') ) {
                my @SubCategoryIDs = @{
                    $Self->{FAQObject}->CategorySubCategoryIDList(
                        ParentID     => $Param{CategoryID},
                        ItemStates   => $Self->{InterfaceStates},
                        Mode         => $Param{Mode},
                        CustomerUser => $Param{CustomerUser},
                        UserID       => $Self->{UserID},
                        )
                    };
                push( @CategoryIDs, @SubCategoryIDs );
            }
            $Self->{LayoutObject}->Block(
                Name => 'ExplorerLatestChange',
            );
            if ( $Param{Mode} =~ /public/i ) {
                $Self->{LayoutObject}->Block(
                    Name => 'ExplorerLatestChangeRss',
                    Data => {},
                );
            }
            if (@CategoryIDs) {
                @ItemIDs = $Self->{FAQObject}->FAQSearch(
                    CategoryIDs => \@CategoryIDs,
                    States      => $Self->{InterfaceStates},
                    OrderBy     => ['Changed'],
                    SortBy      => 'down',
                    Interface   => $Self->{Interface}{Name},
                    Limit       => $Self->{ConfigObject}->Get('FAQ::Explorer::LastChange::Limit'),
                    UserID      => $Self->{UserID},
                );
            }
        }
        else {
            $Self->{LayoutObject}->Block(
                Name => 'ExplorerLatestChange'
            );
            @ItemIDs = $Self->{FAQObject}->FAQSearch(
                States    => $Self->{InterfaceStates},
                OrderBy   => ['Changed'],
                SortBy    => 'down',
                Interface => $Self->{Interface}{Name},
                Limit     => $Self->{ConfigObject}->Get('FAQ::Explorer::LastChange::Limit'),
            );
        }
        for (@ItemIDs) {
            my %Data = $Self->{FAQObject}->FAQGet(
                ItemID => $_,
                UserID => $Self->{UserID},
            );
            $Self->{LayoutObject}->Block(
                Name => 'ExplorerLatestChangeFAQItemRow',
                Data => {%Data},
            );
        }
        return 1;
    }
    return 0;
}

sub _GetExplorerLastCreateItems {
    my ( $Self, %Param ) = @_;

    if ( $Self->{ConfigObject}->Get('FAQ::Explorer::LastCreate::Show') ) {

        # check needed parameters
        for (qw(CategoryID)) {
            if ( !defined( $Param{$_} ) ) {
                $Self->{LayoutObject}->FatalError( Message => "Need parameter $_!" )
            }
        }
        my @ItemIDs = ();
        if ( defined( $Param{CategoryID} ) ) {

            # add current categoryid
            my @CategoryIDs = ();
            if ( $Param{CategoryID} ) {
                push( @CategoryIDs, ( $Param{CategoryID} ) );
            }
            if ( !defined( $Param{Mode} ) ) {
                $Param{Mode} = '';
            }
            if ( !defined( $Param{CustomerUser} ) ) {
                $Param{CustomerUser} = '';
            }

            # add subcategoryids
            if ( $Self->{ConfigObject}->Get('FAQ::Explorer::LastCreate::ShowSubCategoryItems') ) {
                my @SubCategoryIDs = @{
                    $Self->{FAQObject}->CategorySubCategoryIDList(
                        ParentID     => $Param{CategoryID},
                        ItemStates   => $Self->{InterfaceStates},
                        Mode         => $Param{Mode},
                        CustomerUser => $Param{CustomerUser},
                        UserID       => $Self->{UserID},
                        )
                    };
                push( @CategoryIDs, @SubCategoryIDs );
            }
            $Self->{LayoutObject}->Block(
                Name => 'ExplorerLatestCreate'
            );
            if ( $Param{Mode} =~ /public/i ) {
                $Self->{LayoutObject}->Block(
                    Name => 'ExplorerLatestCreateRss',
                    Data => {},
                );
            }
            if (@CategoryIDs) {
                @ItemIDs = $Self->{FAQObject}->FAQSearch(
                    CategoryIDs => \@CategoryIDs,
                    States      => $Self->{InterfaceStates},
                    OrderBy     => ['Created'],
                    SortBy      => 'down',
                    Interface   => $Self->{Interface}{Name},
                    Limit       => $Self->{ConfigObject}->Get('FAQ::Explorer::LastCreate::Limit'),
                    UserID      => $Self->{UserID},
                );
            }
        }
        else {
            $Self->{LayoutObject}->Block(
                Name => 'ExplorerLatestCreate'
            );
            @ItemIDs = $Self->{FAQObject}->FAQSearch(
                States    => $Self->{InterfaceStates},
                OrderBy   => ['Created'],
                SortBy    => 'down',
                Interface => $Self->{Interface}{Name},
                Limit     => $Self->{ConfigObject}->Get('FAQ::Explorer::LastCreate::Limit'),
                UserID    => $Self->{UserID},

            );
        }

        # dtl block
        for (@ItemIDs) {
            my %Data = $Self->{FAQObject}->FAQGet(
                ItemID => $_,
                UserID => $Self->{UserID},
            );
            $Self->{LayoutObject}->Block(
                Name => 'ExplorerLatestCreateFAQItemRow',
                Data => {%Data},
            );
        }
        return 1;
    }
    return 0;
}

sub _GetExplorerTop10Items {
    my ( $Self, %Param ) = @_;

    my $Top10ItemIDsRef;

    # check needed parameters
    for my $ParamName (qw(CategoryID)) {
        if ( !defined( $Param{$ParamName} ) ) {
            $Self->{LayoutObject}->FatalError( Message => "Need parameter $ParamName!" )
        }
    }

    if ( $Self->{ConfigObject}->Get('FAQ::Explorer::Top10::Show') ) {

        # show top 10 block
        $Self->{LayoutObject}->Block(
            Name => 'ExplorerTop10',
        );

        # show RSS feed
        if ( $Param{Mode} =~ /public/i ) {
            $Self->{LayoutObject}->Block(
                Name => 'ExplorerTop10Rss',
                Data => {},
            );
        }

        if ( defined( $Param{CategoryID} ) ) {

            # add current categoryID
            my @CategoryIDs = ();

            if ( $Param{CategoryID} ) {
                push( @CategoryIDs, ( $Param{CategoryID} ) );
            }
            if ( !defined( $Param{Mode} ) ) {
                $Param{Mode} = '';
            }
            if ( !defined( $Param{CustomerUser} ) ) {
                $Param{CustomerUser} = '';
            }

            # add subcategoryIDs
            if ( $Self->{ConfigObject}->Get('FAQ::Explorer::LastCreate::ShowSubCategoryItems') ) {
                my @SubCategoryIDs = @{
                    $Self->{FAQObject}->CategorySubCategoryIDList(
                        ParentID     => $Param{CategoryID},
                        ItemStates   => $Self->{InterfaceStates},
                        Mode         => $Param{Mode},
                        CustomerUser => $Param{CustomerUser},
                        UserID       => $Self->{UserID},
                        )
                    };
                push( @CategoryIDs, @SubCategoryIDs );
            }

            if (@CategoryIDs) {

                # get the top 10 articles for categories with at least ro permissions
                $Top10ItemIDsRef = $Self->{FAQObject}->FAQTop10Get(
                    Interface   => $Self->{Interface}{Name},
                    CategoryIDs => \@CategoryIDs,
                    Limit       => $Self->{ConfigObject}->Get('FAQ::Explorer::Top10::Limit') || 10,
                    UserID      => $Self->{UserID},
                );
            }
        }
        else {

            # get the top 10 articles
            $Top10ItemIDsRef = $Self->{FAQObject}->FAQTop10Get(
                Interface => $Self->{Interface}{Name},
                Limit     => $Self->{ConfigObject}->Get('FAQ::Explorer::Top10::Limit') || 10,
                UserID    => $Self->{UserID},
            );
        }

        # show each top 10 entry
        my $Number;
        for my $ItemIDRef ( @{$Top10ItemIDsRef} ) {
            $Number++;
            my %Data = $Self->{FAQObject}->FAQGet(
                ItemID => $ItemIDRef->{ItemID},
                UserID => $Self->{UserID},
            );
            $Self->{LayoutObject}->Block(
                Name => 'ExplorerTop10FAQItemRow',
                Data => {
                    %Data,
                    Number => $Number,
                    Count  => $ItemIDRef->{Count},
                },
            );
        }
        return 1;
    }
    return 0;
}

sub _GetExplorerQuickSearch {
    my ( $Self, %Param ) = @_;

    if ( $Self->{ConfigObject}->Get('FAQ::Explorer::QuickSearch::Show') ) {

        # check needed parameters
        for (qw()) {
            if ( !$Param{$_} ) {
                $Self->{LayoutObject}->FatalError( Message => "Need parameter $_!" )
            }
        }

        # dtl block
        $Self->{LayoutObject}->Block(
            Name => 'ExplorerQuickSearch',
            Data => { CategoryID => $Param{CategoryID} },
        );
        return 1;
    }
    return 0;
}

sub GetItemView {
    my ( $Self, %Param ) = @_;

    my %Frontend = ();
    my %GetParam = ();
    my @Params   = qw(ItemID);

    # manage parameters
    for (@Params) {
        if ( !( $GetParam{$_} = $Self->{ParamObject}->GetParam( Param => $_ ) ) ) {
            $Self->{LayoutObject}->FatalError( Message => "Need parameter $_" );
        }
    }

    # db action
    my %ItemData = $Self->{FAQObject}->FAQGet(
        ItemID => $GetParam{ItemID},
        UserID => $Self->{UserID},
    );
    if ( !%ItemData ) {
        return $Self->{LayoutObject}->ErrorScreen();
    }

    KEY:
    for my $Key (qw (Field1 Field2 Field3 Field4 Field5 Field6)) {
        next KEY if !$ItemData{$Key};

        # rewrite links to embedded images for customer and public interface
        if ( $Self->{Interface}{Name} eq 'external' ) {
            $ItemData{$Key}
                =~ s{ index[.]pl [?] Action=AgentFAQ }{customer.pl?Action=CustomerFAQ}gxms;
        }
        elsif ( $Self->{Interface}{Name} eq 'public' ) {
            $ItemData{$Key} =~ s{ index[.]pl [?] Action=AgentFAQ }{public.pl?Action=PublicFAQ}gxms;
        }

        # no quoting if html view is enabled
        next KEY if $Self->{ConfigObject}->Get('FAQ::Item::HTML');

        # html quoting
        $ItemData{$Key} = $Self->{LayoutObject}->Ascii2Html(
            NewLine        => 0,
            Text           => $ItemData{$Key},
            VMax           => 5000,
            HTMLResultMode => 1,
            LinkFeature    => 1,
        );
    }

    # permission check
    if ( !exists( $Self->{InterfaceStates}{ $ItemData{StateTypeID} } ) ) {
        return $Self->{LayoutObject}->NoPermission( WithHeader => 'no' );
    }
    if ( ( $Self->{Interface}{Name} eq 'public' ) || ( $Self->{Interface}{Name} eq 'external' ) ) {
        if ( !$ItemData{Approved} ) {
            return $Self->{LayoutObject}->NoPermission( WithHeader => 'no' );
        }
    }

    # user info
    my %UserInfo = $Self->{AgentUserObject}->GetUserData(
        UserID => $ItemData{CreatedBy},
    );
    $Frontend{CreatedByLogin} = $UserInfo{UserLogin};
    %UserInfo = $Self->{AgentUserObject}->GetUserData(
        UserID => $ItemData{ChangedBy},
    );
    $Frontend{ChangedByLogin} = $UserInfo{UserLogin};

    # item view
    $Frontend{CssColumnVotingResult} = 'color:'
        . $Self->{LayoutObject}->GetFAQItemVotingRateColor( Rate => $ItemData{VoteResult} ) . ';';
    $Self->{LayoutObject}->Block(
        Name => 'View',
        Data => { %Param, %ItemData, %Frontend },
    );
    if ( $Param{Permission} && $Param{Permission} eq 'rw' ) {
        $Self->{LayoutObject}->Block(
            Name => 'FAQItemViewLinkUpdate',
            Data => { %Param, %ItemData, %Frontend },
        );
        $Self->{LayoutObject}->Block(
            Name => 'FAQItemViewLinkDelete',
            Data => { %Param, %ItemData, %Frontend },
        );
    }

    # approval state
    if ( $Self->{ConfigObject}->Get('FAQ::ApprovalRequired') ) {
        $Frontend{Approval} = $ItemData{Approved} ? 'Yes' : 'No';
        $Self->{LayoutObject}->Block(
            Name => 'ViewApproval',
            Data => {%Frontend},
        );
    }

    # FAQ path
    if ( $Self->_GetFAQPath( CategoryID => $ItemData{CategoryID} ) ) {
        $Self->{LayoutObject}->Block(
            Name => 'FAQPathItemElement',
            Data => \%ItemData,
        );
    }

    # item attachment
    my @AttachmentIndex = $Self->{FAQObject}->AttachmentIndex(
        ItemID     => $GetParam{ItemID},
        ShowInline => 0,
        UserID     => $Self->{UserID},
    );
    if (@AttachmentIndex) {
        $Self->{LayoutObject}->Block(
            Name => 'FAQItemViewAttachment',
            Data => {%ItemData},
        );
        for my $Attachment (@AttachmentIndex) {
            $Self->{LayoutObject}->Block(
                Name => 'FAQItemViewAttachmentRow',
                Data => { %ItemData, %{$Attachment} },
            );
        }
    }

    # item fields
    $Self->_GetItemFields(
        ItemData => \%ItemData,
    );

    # item voting
    my %ShowItemVoting = %{ $Self->{ConfigObject}->Get('FAQ::Item::Voting::Show') };
    if ( exists( $ShowItemVoting{ $Self->{Interface}{Name} } ) ) {
        $Self->_GetItemVoting(
            ItemData => \%ItemData,
        );
    }

    # show keywords as search links
    if ( $ItemData{Keywords} ) {

        # replace commas and semicolons
        $ItemData{Keywords} =~ s/,/ /g;
        $ItemData{Keywords} =~ s/;/ /g;

        my @Keywords = split /\s+/, $ItemData{Keywords};
        for my $Keyword (@Keywords) {
            $Self->{LayoutObject}->Block(
                Name => 'Keywords',
                Data => {
                    Keyword => $Keyword,
                },
            );
        }
    }

    if ( $Param{Links} && $Param{Links} == 1 ) {

        # get linked objects
        my $LinkListWithData = $Self->{LinkObject}->LinkListWithData(
            Object => 'FAQ',
            Key    => $GetParam{ItemID},
            State  => 'Valid',
            UserID => $Self->{UserID},
        );

        # get link table view mode
        my $LinkTableViewMode = $Self->{ConfigObject}->Get('LinkObject::ViewMode');

        # create the link table
        my $LinkTableStrg = $Self->{LayoutObject}->LinkObjectTableCreate(
            LinkListWithData => $LinkListWithData,
            ViewMode         => $LinkTableViewMode,
        );

        # output the simple link table
        if ($LinkTableStrg) {
            $Self->{LayoutObject}->Block(
                Name => 'LinkTable' . $LinkTableViewMode,
                Data => {
                    LinkTableStrg => $LinkTableStrg,
                },
            );
        }
    }
    return;
}

sub GetItemSmallView {
    my ( $Self, %Param ) = @_;

    my %Frontend = ();
    my %GetParam = ();
    my @Params   = qw(ItemID);

    # manage parameters
    for (@Params) {
        if ( !( $GetParam{$_} = $Self->{ParamObject}->GetParam( Param => $_ ) ) ) {
            $Self->{LayoutObject}->FatalError( Message => "Need parameter $_" );
        }
    }

    # db action
    my %ItemData = $Self->{FAQObject}->FAQGet(
        ItemID => $GetParam{ItemID},
        UserID => $Self->{UserID},
    );
    if ( !%ItemData ) {
        return $Self->{LayoutObject}->ErrorScreen();
    }

    # permission check
    if ( !exists( $Self->{InterfaceStates}{ $ItemData{StateTypeID} } ) ) {
        return $Self->{LayoutObject}->NoPermission( WithHeader => 'yes' );
    }

    # user info
    my %UserInfo = $Self->{AgentUserObject}->GetUserData(
        UserID => $ItemData{CreatedBy},
    );
    $Frontend{CreatedByLogin} = $UserInfo{UserLogin};
    %UserInfo = $Self->{AgentUserObject}->GetUserData(
        UserID => $ItemData{ChangedBy},
    );
    $Frontend{ChangedByLogin} = $UserInfo{UserLogin};

    # item view
    $Frontend{CssColumnVotingResult} = 'color:'
        . $Self->{LayoutObject}->GetFAQItemVotingRateColor( Rate => $ItemData{VoteResult} ) . ';';
    $Frontend{ItemFieldValues} = $Self->_GetItemFieldValues( ItemData => \%ItemData );

    # only convert html to plain text if rich text editor is not used
    if ( $Self->{ConfigObject}->Get('Frontend::RichText') ) {
        $Frontend{ItemFieldValuesPlainText} = $Frontend{ItemFieldValues};
    }
    else {
        $Frontend{ItemFieldValuesPlainText} = $Self->{HTMLUtilsObject}->ToAscii(
            String => $Frontend{ItemFieldValues},
        );
    }

    # remove inline image links to faq images
    $Frontend{ItemFieldValuesPlainText}
        =~ s{ <img [^<>]+ Action=(Agent|Customer|Public)FAQ [^<>]+ > }{}gxms;

    $Self->{LayoutObject}->Block(
        Name => 'ViewSmall',
        Data => { %Param, %ItemData, %Frontend },
    );

    # show keywords as search links
    if ( $ItemData{Keywords} ) {

        # replace commas and semicolons
        $ItemData{Keywords} =~ s/,/ /g;
        $ItemData{Keywords} =~ s/;/ /g;

        my @Keywords = split /\s+/, $ItemData{Keywords};
        for my $Keyword (@Keywords) {
            $Self->{LayoutObject}->Block(
                Name => 'Keywords',
                Data => {
                    Keyword => $Keyword,
                },
            );
        }
    }

    # FAQ path
    if ( $Self->_GetFAQPath( CategoryID => $ItemData{CategoryID} ) ) {
        $Self->{LayoutObject}->Block(
            Name => 'FAQPathItemElementSmall',
            Data => \%ItemData,
        );
    }

    # item attachment
    if ( defined( $ItemData{Filename} ) ) {
        $Self->{LayoutObject}->Block(
            Name => 'FAQItemViewAttachmentSmall',
            Data => { %Param, %ItemData },
        );
    }

    return;
}

sub GetItemPrint {
    my ( $Self, %Param ) = @_;

    my %GetParam = ();
    my @Params   = qw(ItemID);

    # manage parameters
    for (@Params) {
        if ( !( $GetParam{$_} = $Self->{ParamObject}->GetParam( Param => $_ ) ) ) {
            $Self->{LayoutObject}->FatalError( Message => "Need parameter $_" );
        }
    }

    # db action
    my %ItemData = $Self->{FAQObject}->FAQGet(
        ItemID => $GetParam{ItemID},
        UserID => $Self->{UserID},
    );
    if ( !%ItemData ) {
        return $Self->{LayoutObject}->ErrorScreen();
    }

    # html quoting
    KEY:
    for my $Key (qw (Field1 Field2 Field3 Field4 Field5 Field6)) {
        next KEY if !$ItemData{$Key};
        if ( $Self->{ConfigObject}->Get('FAQ::Item::HTML') ) {
            $ItemData{$Key} =~ s/\n/\<br\>/g;
        }
        else {
            $ItemData{$Key} = $Self->{LayoutObject}->Ascii2Html(
                NewLine        => 0,
                Text           => $ItemData{$Key},
                VMax           => 5000,
                HTMLResultMode => 1,
                LinkFeature    => 1,
            );
        }
    }

    # permission check
    if ( !exists( $Self->{InterfaceStates}{ $ItemData{StateTypeID} } ) ) {
        return $Self->{LayoutObject}->NoPermission( WithHeader => 'yes' );
    }

    # add article
    $Self->{LayoutObject}->Block(
        Name => 'Print',
        Data => \%ItemData,
    );

    # approval state
    if (
        $Self->{ConfigObject}->Get('FAQ::ApprovalRequired')
        && $Self->{Interface}{Name} eq 'internal'
        )
    {
        my %Data;
        $Data{Approval} = $ItemData{Approved} ? 'Yes' : 'No';
        $Self->{LayoutObject}->Block(
            Name => 'PrintApproval',
            Data => {%Data},
        );
    }

    # fields
    $Self->_GetItemFields(
        ItemData => \%ItemData,
    );
    return;
}

sub _GetItemFields {
    my ( $Self, %Param ) = @_;

    my %GetParam = ();
    my @Params   = qw(ItemData);

    # manage parameters
    for (@Params) {
        if ( !exists( $Param{$_} ) ) {
            return $Self->{LayoutObject}->FatalError( Message => "Need parameter $_" );
        }
    }

    # config values
    my %ItemFields = ();
    for ( my $i = 1; $i < 7; $i++ ) {
        my %ItemConfig = %{ $Self->{ConfigObject}->Get( 'FAQ::Item::Field' . $i ) };
        if ( $ItemConfig{Show} ) {
            $ItemFields{ "Field" . $i } = \%ItemConfig;
        }
    }
    for my $Key ( sort( { $ItemFields{$a}{Prio} <=> $ItemFields{$b}{Prio} } keys(%ItemFields) ) ) {
        my %StateTypeData = %{
            $Self->{FAQObject}->StateTypeGet(
                Name   => $ItemFields{$Key}{Show},
                UserID => $Self->{UserID},
                )
            };

        # show yes /no
        if ( exists( $Self->{InterfaceStates}->{ $StateTypeData{StateID} } ) ) {
            $Self->{LayoutObject}->Block(
                Name => 'FAQItemField',
                Data => {
                    %{ $ItemFields{$Key} },
                    'StateName' => $StateTypeData{Name},
                    'Key'       => $Key,
                    'Value'     => $Param{ItemData}{$Key} || '',
                },
            );
        }
    }
    return;
}

sub _GetItemFieldValues {
    my ( $Self, %Param ) = @_;

    my %GetParam = ();
    my @Params   = qw(ItemData);

    # manage parameters
    for (@Params) {
        if ( !exists( $Param{$_} ) ) {
            return $Self->{LayoutObject}->FatalError( Message => "Need parameter $_" );
        }
    }

    # config values
    my %ItemFields = ();
    for ( my $i = 1; $i < 7; $i++ ) {
        my %ItemConfig = %{ $Self->{ConfigObject}->Get( 'FAQ::Item::Field' . $i ) };
        if ( $ItemConfig{Show} ) {
            $ItemFields{ "Field" . $i } = \%ItemConfig;
        }
    }
    my $String = '';
    for my $Key ( sort( { $ItemFields{$a}{Prio} <=> $ItemFields{$b}{Prio} } keys(%ItemFields) ) ) {
        if ( $ItemFields{$Key}{Show} eq 'internal' ) {
            next;
        }
        my %StateTypeData = %{
            $Self->{FAQObject}->StateTypeGet(
                Name   => $ItemFields{$Key}{Show},
                UserID => $Self->{UserID},
                )
            };

        # show yes /no
        if ( exists( $Self->{InterfaceStates}{ $StateTypeData{ID} } ) ) {
            $String .= $Param{ItemData}{$Key} || '';
            $String .= "\n\n";
        }
    }
    return $String;
}

sub _GetItemVoting {
    my ( $Self, %Param ) = @_;

    # check needed parameters
    for (qw(ItemData)) {
        if ( !$Param{$_} ) {
            $Self->{LayoutObject}->FatalError( Message => "Need parameter $_!" );
        }
    }
    my %ItemData = %{ $Param{ItemData} };

    $Self->{LayoutObject}->Block(
        Name => "Voting",
    );
    my $VoteData = $Self->{FAQObject}->VoteGet(
        CreateBy  => $Self->{UserID},
        ItemID    => $ItemData{ItemID},
        Interface => $Self->{Interface}{StateID},
        IP        => $ENV{'REMOTE_ADDR'},
        UserID    => $Self->{UserID},
    );

    my $Flag = 0;

    # already voted?
    if ($VoteData) {

        # item/change_time > voting/create_time
        my $ItemChangedSystemTime = $Self->{TimeObject}->TimeStamp2SystemTime(
            String => $ItemData{Changed} || '',
        );
        my $VoteCreatedSystemTime = $Self->{TimeObject}->TimeStamp2SystemTime(
            String => $VoteData->{Created} || '',
        );

        if ( $ItemChangedSystemTime > $VoteCreatedSystemTime ) {
            $Flag = 1;
        }
        else {
            push( @{ $Self->{Notify} }, [ 'Info', 'You have already voted!' ] );
            return;
        }
    }
    else {
        $Flag = 1;
    }
    if ( $Self->{Subaction} eq 'Vote' && $Flag ) {

        # check needed parameters
        for (qw(ItemData)) {
            if ( !$Param{$_} ) {
                $Self->{LayoutObject}->FatalError( Message => "Need parameter $_!" )
            }
        }

        # manage parameters
        my %GetParam = ();
        my @Params   = qw(ItemID Rate);
        for (@Params) {
            $GetParam{$_} = $Self->{ParamObject}->GetParam( Param => $_ );
        }

        if ( $GetParam{Rate} eq '0' or $GetParam{Rate} ) {
            $Self->{FAQObject}->VoteAdd(
                CreatedBy => $Self->{UserID},
                ItemID    => $GetParam{ItemID},
                IP        => $ENV{'REMOTE_ADDR'},
                Interface => $Self->{Interface}{ID},
                Rate      => $GetParam{Rate},
                UserID    => $Self->{UserID},
            );
            push( @{ $Self->{Notify} }, [ 'Info', 'Thanks for your vote!' ] );
            return;

        }
        else {
            push( @{ $Self->{Notify} }, [ 'Error', 'No rate selected!' ] );
            $Self->_GetItemVotingForm(
                ItemData => $Param{ItemData},
            );

            return;
        }
    }

    # form
    $Self->_GetItemVotingForm(
        ItemData => $Param{ItemData},
    );

    return;
}

sub _GetItemVotingForm {
    my ( $Self, %Param ) = @_;

    # check needed parameters
    for (qw(ItemData)) {
        if ( !$Param{$_} ) {
            $Self->{LayoutObject}->FatalError( Message => "Need parameter $_!" )
        }
    }
    $Self->{LayoutObject}->Block(
        Name => 'VoteForm',
        Data => { %Param, %{ $Param{ItemData} } },
    );

    my %VotingRates = %{ $Self->{ConfigObject}->Get('FAQ::Item::Voting::Rates') };
    for my $key ( sort( { $b <=> $a } keys(%VotingRates) ) ) {
        my %Data = ( "Value" => $key, "Title" => $VotingRates{$key} );
        $Self->{LayoutObject}->Block(
            Name => "VotingRateRow",
            Data => \%Data,
        );
    }
    return;
}

sub GetItemSearch {
    my ( $Self, %Param ) = @_;

    my %GetParam = ();
    my %Frontend = ();

    # get params
    for (qw(LanguageIDs CategoryIDs)) {
        my @Array = $Self->{ParamObject}->GetArray( Param => $_ );
        if (@Array) {
            $GetParam{$_} = \@Array;
        }
    }
    for (qw(QuickSearch Number Title What Keyword)) {
        $GetParam{$_} = $Self->{ParamObject}->GetParam( Param => $_ );
    }

    # quicksearch in subcategories?
    if ( $GetParam{QuickSearch} ) {
        if ( $Self->{ConfigObject}->Get('FAQ::Explorer::QuickSearch::ShowSubCategoryItems') ) {
            if ( !$Param{Mode} ) {
                $Param{Mode} = 'Public';
            }
            if ( !defined( $Param{User} ) ) {
                $Param{User} = '';
            }
            my @SubCategoryIDs = @{
                $Self->{FAQObject}->CategorySubCategoryIDList(
                    ParentID => $GetParam{CategoryIDs}->[0] || 0,
                    ItemStates   => $Self->{InterfaceStates},
                    CustomerUser => $Param{CustomerUser},
                    UserID       => $Param{User},
                    Mode         => $Param{Mode},
                    )
                };
            push( @{ $GetParam{CategoryIDs} }, @SubCategoryIDs );
        }
    }
    $Frontend{LanguageOption} = $Self->{LayoutObject}->OptionStrgHashRef(
        Data                => { $Self->{FAQObject}->LanguageList() },
        Size                => 5,
        Name                => 'LanguageIDs',
        Multiple            => 1,
        SelectedIDRefArray  => $GetParam{LanguageIDs} || [],
        HTMLQuote           => 1,
        LanguageTranslation => 0,
        UserID              => $Self->{UserID},
    );
    my $Categories = {};
    if ( $Param{Mode} && $Param{Mode} eq 'Agent' ) {
        $Categories = $Self->{FAQObject}->GetUserCategories(
            UserID => $Self->{UserID},
            Type   => 'rw',
        );
    }
    elsif ( $Param{Mode} && $Param{Mode} eq 'Customer' ) {

        # get customer categories
        $Categories = $Self->{FAQObject}->GetCustomerCategories(
            CustomerUser => $Param{CustomerUser},
            Type         => 'rw',
        );

        # extract category ids
        my %AllCategoryIDs = ();
        for my $ParentID ( keys %{$Categories} ) {
            for my $CategoryID ( keys %{ $Categories->{$ParentID} } ) {
                $AllCategoryIDs{$CategoryID} = 1;
            }
        }

        # get all customer category ids
        my @CustomerCategoryIDs = ();
        for my $CategoryID ( 0, keys %AllCategoryIDs ) {
            push @CustomerCategoryIDs, @{
                $Self->{FAQObject}->CustomerCategorySearch(
                    ParentID     => $CategoryID,
                    CustomerUser => $Param{CustomerUser},
                    Mode         => $Param{Mode},
                    )
                };
        }

        # build customer category hash
        $Categories = {};
        for my $CategoryID (@CustomerCategoryIDs) {
            my %Category = $Self->{FAQObject}->CategoryGet(
                CategoryID => $CategoryID,
                UserID     => $Self->{UserID},
            );
            $Categories->{ $Category{ParentID} }->{ $Category{CategoryID} } = $Category{Name};
        }
    }
    else {

        # get all categories
        $Categories = $Self->{FAQObject}->CategoryList( UserID => $Self->{UserID} );

        # extract category ids
        my %AllCategoryIDs = ();
        for my $ParentID ( keys %{$Categories} ) {
            for my $CategoryID ( keys %{ $Categories->{$ParentID} } ) {
                $AllCategoryIDs{$CategoryID} = 1;
            }
        }

        # get all public category ids
        my @PublicCategoryIDs = ();
        for my $CategoryID ( 0, keys %AllCategoryIDs ) {
            push @PublicCategoryIDs, @{
                $Self->{FAQObject}->PublicCategorySearch(
                    ParentID => $CategoryID,
                    Mode     => $Param{Mode},
                    )
                };
        }

        # build public category hash
        $Categories = {};
        for my $CategoryID (@PublicCategoryIDs) {
            my %Category = $Self->{FAQObject}->CategoryGet(
                CategoryID => $CategoryID,
                UserID     => $Self->{UserID},
            );
            $Categories->{ $Category{ParentID} }->{ $Category{CategoryID} } = $Category{Name};
        }
    }

    $Frontend{CategoryOption} = $Self->{LayoutObject}->AgentFAQCategoryListOption(
        CategoryList        => $Categories,
        Size                => 5,
        Name                => 'CategoryIDs',
        Multiple            => 1,
        SelectedIDs         => $GetParam{CategoryIDs} || [],
        HTMLQuote           => 1,
        LanguageTranslation => 0,
    );
    $Self->{LayoutObject}->Block(
        Name => 'Search',
        Data => { %Param, %GetParam, %Frontend },
    );

    # build result
    if ( $Self->{ParamObject}->GetParam( Param => 'Submit' ) ) {
        my $CssRow = '';

        my @ItemIDs = $Self->{FAQObject}->FAQSearch(
            %Param,
            %GetParam,
            States    => $Self->{InterfaceStates},
            Interface => $Self->{Interface}{Name},
            Limit     => 25,
        );
        $Self->{LayoutObject}->Block(
            Name => 'SearchResult',
            Data => { %Param, %Frontend },
        );
        for (@ItemIDs) {
            %Frontend = ();
            my %Data = $Self->{FAQObject}->FAQGet( ItemID => $_ );
            my $Permission = 'ro';
            if ( $Param{Mode} && $Param{Mode} eq 'Agent' ) {
                $Permission = $Self->{FAQObject}->CheckCategoryUserPermission(
                    UserID     => $Param{User},
                    CategoryID => $Data{CategoryID},
                );
            }
            elsif ( $Param{Mode} && $Param{Mode} eq 'Customer' ) {
                $Permission = $Self->{FAQObject}->CheckCategoryCustomerPermission(
                    CustomerUser => $Param{CustomerUser},
                    CategoryID   => $Data{CategoryID},
                );
            }
            if ( $Permission ne '' ) {
                if ( $CssRow eq 'searchpassive' ) {
                    $CssRow = 'searchactive';
                }
                else {
                    $CssRow = 'searchpassive';
                }
                $Data{CssRow} = $CssRow;
                $Frontend{CssColumnVotingResult}
                    = 'color:'
                    . $Self->{LayoutObject}->GetFAQItemVotingRateColor( Rate => $Data{VoteResult} )
                    . ';';

                $Self->{LayoutObject}->Block(
                    Name => 'SearchResultRow',
                    Data => {
                        %Data,
                        %Frontend,
                    },
                );
            }
        }
    }
    return;
}

sub GetSystemHistory {
    my ( $Self, %Param ) = @_;

    my %Frontend = ();

    $Self->{LayoutObject}->Block(
        Name => 'SystemHistory',
        Data => {%Param},
    );

    $Frontend{CssRow} = '';
    my @History = @{ $Self->{FAQObject}->HistoryGet() };
    for my $Row (@History) {

        # css configuration
        if ( $Frontend{CssRow} eq 'searchpassive' ) {
            $Frontend{CssRow} = 'searchactive';
        }
        else {
            $Frontend{CssRow} = 'searchpassive';
        }
        my %Data = %{$Row};    #$Self->{FAQObject}->FAQGet(ItemID => $Row->{ItemID});
        my %User = $Self->{UserObject}->GetUserData(
            UserID => $Row->{CreatedBy},
            Cached => 1,
        );
        $Self->{LayoutObject}->Block(
            Name => 'SystemHistoryRow',
            Data => { %Data, %Frontend, %User, Name => $Row->{Name} },
        );
    }
    return;
}

1;
