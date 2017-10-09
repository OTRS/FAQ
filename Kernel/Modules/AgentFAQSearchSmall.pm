# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentFAQSearchSmall;

use strict;
use warnings;

use Kernel::System::FAQ;
use Kernel::System::SearchProfile;
use Kernel::System::Valid;
use Kernel::System::VariableCheck qw(:all);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # check needed objects
    for my $Object (
        qw(ParamObject DBObject LayoutObject LogObject UserObject GroupObject ConfigObject MainObject EncodeObject)
        )
    {
        if ( !$Self->{$Object} ) {
            $Self->{LayoutObject}->FatalError( Message => "Got no $Object!" );
        }
    }

    # create additional objects
    $Self->{FAQObject}           = Kernel::System::FAQ->new(%Param);
    $Self->{SearchProfileObject} = Kernel::System::SearchProfile->new(%Param);
    $Self->{ValidObject}         = Kernel::System::Valid->new(%Param);

    # get config for frontend
    $Self->{Config} = $Self->{ConfigObject}->Get("FAQ::Frontend::AgentFAQSearch");

    # set default interface settings
    $Self->{Interface} = $Self->{FAQObject}->StateTypeGet(
        Name   => 'internal',
        UserID => $Self->{UserID},
    );
    $Self->{InterfaceStates} = $Self->{FAQObject}->StateTypeList(
        Types  => $Self->{ConfigObject}->Get('FAQ::Agent::StateTypes'),
        UserID => $Self->{UserID},
    );

    $Self->{MultiLanguage} = $Self->{ConfigObject}->Get('FAQ::MultiLanguage');

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $Output;

    # get config data
    $Self->{StartHit} = int( $Self->{ParamObject}->GetParam( Param => 'StartHit' ) || 1 );
    $Self->{SearchLimit} = $Self->{Config}->{SearchLimit} || 500;
    $Self->{SortBy} = $Self->{ParamObject}->GetParam( Param => 'SortBy' )
        || $Self->{Config}->{'SortBy::Default'}
        || 'FAQID';
    $Self->{OrderBy} = $Self->{ParamObject}->GetParam( Param => 'OrderBy' )
        || $Self->{Config}->{'Order::Default'}
        || 'Down';
    $Self->{Profile}        = $Self->{ParamObject}->GetParam( Param => 'Profile' )        || '';
    $Self->{SaveProfile}    = $Self->{ParamObject}->GetParam( Param => 'SaveProfile' )    || '';
    $Self->{TakeLastSearch} = $Self->{ParamObject}->GetParam( Param => 'TakeLastSearch' ) || '';
    $Self->{SelectTemplate} = $Self->{ParamObject}->GetParam( Param => 'SelectTemplate' ) || '';
    $Self->{EraseTemplate}  = $Self->{ParamObject}->GetParam( Param => 'EraseTemplate' )  || '';
    my $Nav = $Self->{ParamObject}->GetParam( Param => 'Nav' ) || '';

    # search with a saved template
    if ( $Self->{ParamObject}->GetParam( Param => 'SearchTemplate' ) && $Self->{Profile} ) {
        return $Self->{LayoutObject}->Redirect(
            OP =>
                "Action=AgentFAQSearchSmall;Subaction=Search;TakeLastSearch=1;SaveProfile=1;Profile=$Self->{Profile};Nav=$Nav"
        );
    }

    # get single params
    my %GetParam;

    # load profiles string params (press load profile)
    if ( ( $Self->{Subaction} eq 'LoadProfile' && $Self->{Profile} ) || $Self->{TakeLastSearch} ) {
        %GetParam = $Self->{SearchProfileObject}->SearchProfileGet(
            Base      => 'FAQSearch',
            Name      => $Self->{Profile},
            UserLogin => $Self->{UserLogin},
        );
    }

    # get search string params (get submitted params)
    else {

        # get scalar search params
        for my $ParamName (qw(Number Title Keyword Fulltext ResultForm)) {
            $GetParam{$ParamName} = $Self->{ParamObject}->GetParam( Param => $ParamName );

            # remove whitespace on the start and end
            if ( $GetParam{$ParamName} ) {
                $GetParam{$ParamName} =~ s{ \A \s+ }{}xms;
                $GetParam{$ParamName} =~ s{ \s+ \z }{}xms;
            }

            # db quote to prevent SQL injection
            $GetParam{$ParamName} = $Self->{DBObject}->Quote( $GetParam{$ParamName} );
        }

        # get array search params
        for my $SearchParam (qw(CategoryIDs LanguageIDs ValidIDs)) {
            my @Array = $Self->{ParamObject}->GetArray( Param => $SearchParam );
            if (@Array) {
                $GetParam{$SearchParam} = \@Array;
            }
        }
    }

    # set result form env
    if ( !$GetParam{ResultForm} ) {
        $GetParam{ResultForm} = '';
    }

    # show result site
    if ( $Self->{Subaction} eq 'Search' && !$Self->{EraseTemplate} ) {

        # fill up profile name (e.g. with last-search)
        if ( !$Self->{Profile} || !$Self->{SaveProfile} ) {
            $Self->{Profile} = 'last-search';
        }

        # store last queue screen
        my $URL = "Action=AgentFAQSearchSmall;Subaction=Search;Profile=$Self->{Profile};SortBy=$Self->{SortBy}"
            . ";OrderBy=$Self->{OrderBy};TakeLastSearch=1;StartHit=$Self->{StartHit};Nav=$Nav";
        $Self->{SessionObject}->UpdateSessionID(
            SessionID => $Self->{SessionID},
            Key       => 'LastScreenOverview',
            Value     => $URL,
        );
        $Self->{SessionObject}->UpdateSessionID(
            SessionID => $Self->{SessionID},
            Key       => 'LastScreenView',
            Value     => $URL,
        );

        # save search profile (under last-search or real profile name)
        $Self->{SaveProfile} = 1;

        # remember last search values
        if ( $Self->{SaveProfile} && $Self->{Profile} ) {

            # remove old profile stuff
            $Self->{SearchProfileObject}->SearchProfileDelete(
                Base      => 'FAQSearch',
                Name      => $Self->{Profile},
                UserLogin => $Self->{UserLogin},
            );

            # insert new profile params
            for my $Key ( sort keys %GetParam ) {
                if ( $GetParam{$Key} ) {
                    $Self->{SearchProfileObject}->SearchProfileAdd(
                        Base      => 'FAQSearch',
                        Name      => $Self->{Profile},
                        Key       => $Key,
                        Value     => $GetParam{$Key},
                        UserLogin => $Self->{UserLogin},
                    );
                }
            }
        }

        # prepare fulltext search
        if ( $GetParam{Fulltext} ) {
            $GetParam{ContentSearch} = 'OR';
            $GetParam{What}          = $GetParam{Fulltext};
        }

        # Get UserCategoryGroup Hash
        # This returns a Hash of the following sample data structure:
        #
        # $UserCatGroup = {
        #   '1' => {
        #          '3' => 'MiscSub'
        #        },
        #   '3' => {},
        #   '0' => {
        #            '1' => 'Misc',
        #            '2' => 'secret'
        #          },
        #   '2' => {}
        # };
        #
        # Keys of the outer hash inform about subcategories
        # 0 Shows top level CategoryIDs.
        # 1 Shows the SubcategoryIDs of Category 1.
        # 2 and 3 are empty hashes because these categories don't have subcategories.
        #
        # Keys of the inner hashes are CategoryIDs a user is allowed to have rw access to.
        # Values are the Category names.

        my $UserCatGroup = $Self->{FAQObject}->GetUserCategories(
            Type   => 'rw',
            UserID => $Self->{UserID},
        );

        # Find CategoryIDs the current User is allowed to view
        my %AllowedCategoryIDs = ();

        if ( $UserCatGroup && ref $UserCatGroup eq 'HASH' ) {

            # So now we have to extract all Category ID's of the "inner hashes".
            # -> Loop through the outer category ID's
            for my $Level ( sort keys %{$UserCatGroup} ) {

                # Check if the Value of the current hash key is a hash ref
                if ( $UserCatGroup->{$Level} && ref $UserCatGroup->{$Level} eq 'HASH' ) {

                    # Map the keys of the inner hash to a TempIDs hash
                    # Original Datastructure:
                    # {
                    #  '1' => 'Misc',
                    #  '2' => 'secret'
                    # }
                    #
                    # after mapping:
                    #
                    # {
                    #  '1' => 1,
                    #  '2' => 1'
                    # }

                    my %TempIDs = map { $_ => 1 } keys %{ $UserCatGroup->{$Level} };

                    # Put the TempIDs over the formally found AllowedCategorys
                    # to produce a hash that holds all CategoryID as keys
                    # and the number 1 as values.
                    %AllowedCategoryIDs = (
                        %AllowedCategoryIDs,
                        %TempIDs
                    );
                }
            }
        }

        # For the database query it's necessary to have an array
        # of CategoryIDs
        my @CategoryIDs = ();

        if (%AllowedCategoryIDs) {
            @CategoryIDs = sort keys %AllowedCategoryIDs;
        }

        # Categories got from the web request could include a not allowed category if the user
        #    temper with the categories dropbox, a check is needed.
        #
        # "Map" copy from one array to another, while "grep" will only let pass the categories
        #    that are defined in the %AllowedCategoryIDs hash
        if ( IsArrayRefWithData( $GetParam{CategoryIDs} ) ) {
            @{ $GetParam{CategoryIDs} } = map {$_} grep { $AllowedCategoryIDs{$_} } @{ $GetParam{CategoryIDs} };
        }

        # Just search if we do have categories, we have access to.
        # If we don't have access to any category, a search with no CategoryIDs
        # would result in finding all categories.
        #
        # It is not possible to create FAQ's without categories
        # so at least one category has to be present

        my @ViewableFAQIDs = ();

        if (@CategoryIDs) {

            # perform FAQ search
            @ViewableFAQIDs = $Self->{FAQObject}->FAQSearch(
                OrderBy             => [ $Self->{SortBy} ],
                OrderByDirection    => [ $Self->{OrderBy} ],
                Limit               => $Self->{SearchLimit},
                UserID              => $Self->{UserID},
                States              => $Self->{InterfaceStates},
                Interface           => $Self->{Interface},
                ContentSearchPrefix => '*',
                ContentSearchSuffix => '*',
                CategoryIDs         => \@CategoryIDs,
                %GetParam,
            );
        }

        # start html page
        my $Output = $Self->{LayoutObject}->Header( Type => 'Small' );
        $Self->{LayoutObject}->Print( Output => \$Output );
        $Output = '';

        $Self->{Filter} = $Self->{ParamObject}->GetParam( Param => 'Filter' ) || '';
        $Self->{View}   = $Self->{ParamObject}->GetParam( Param => 'View' )   || '';

        # show FAQ's
        my $LinkPage = 'Filter='
            . $Self->{LayoutObject}->LinkEncode( $Self->{Filter} )
            . ';View=' . $Self->{LayoutObject}->LinkEncode( $Self->{View} )
            . ';SortBy=' . $Self->{LayoutObject}->LinkEncode( $Self->{SortBy} )
            . ';OrderBy=' . $Self->{LayoutObject}->LinkEncode( $Self->{OrderBy} )
            . ';Profile=' . $Self->{Profile} . ';TakeLastSearch=1;Subaction=Search'
            . ';Nav=' . $Nav
            . ';';
        my $LinkSort = 'Filter='
            . $Self->{LayoutObject}->LinkEncode( $Self->{Filter} )
            . ';View=' . $Self->{LayoutObject}->LinkEncode( $Self->{View} )
            . ';Profile=' . $Self->{Profile} . ';TakeLastSearch=1;Subaction=Search'
            . ';Nav=' . $Nav

            . ';';
        my $LinkFilter = 'TakeLastSearch=1;Subaction=Search;Profile='
            . $Self->{LayoutObject}->LinkEncode( $Self->{Profile} )
            . ';Nav=' . $Nav
            . ';';
        my $LinkBack = 'Subaction=LoadProfile;Profile='
            . $Self->{LayoutObject}->LinkEncode( $Self->{Profile} )
            . ';Nav=' . $Nav
            . ';TakeLastSearch=1;';

        my $FilterLink = 'SortBy=' . $Self->{LayoutObject}->LinkEncode( $Self->{SortBy} )
            . ';OrderBy=' . $Self->{LayoutObject}->LinkEncode( $Self->{OrderBy} )
            . ';View=' . $Self->{LayoutObject}->LinkEncode( $Self->{View} )
            . ';Profile=' . $Self->{Profile} . ';TakeLastSearch=1;Subaction=Search'
            . ';Nav=' . $Nav
            . ';';

        # find out which columns should be shown
        my @ShowColumns;
        if ( $Self->{Config}->{ShowColumns} ) {

            # get all possible columns from config
            my %PossibleColumn = %{ $Self->{Config}->{ShowColumns} };

            # get the column names that should be shown
            COLUMNNAME:
            for my $Name ( sort keys %PossibleColumn ) {
                next COLUMNNAME if !$PossibleColumn{$Name};
                push @ShowColumns, $Name;
            }

            # enforce FAQ number column since is the link MasterAction hook
            if ( !$PossibleColumn{'Number'} ) {
                push @ShowColumns, 'Number';
            }
        }

        $Output .= $Self->{LayoutObject}->FAQListShow(
            FAQIDs => \@ViewableFAQIDs,
            Total  => scalar @ViewableFAQIDs,

            View => $Self->{View},

            Env        => $Self,
            LinkPage   => $LinkPage,
            LinkSort   => $LinkSort,
            LinkFilter => $LinkFilter,
            LinkBack   => $LinkBack,
            Profile    => $Self->{Profile},

            TitleName => 'Search Result',
            Limit     => $Self->{SearchLimit},

            Filter     => $Self->{Filter},
            FilterLink => $FilterLink,

            OrderBy => $Self->{OrderBy},
            SortBy  => $Self->{SortBy},

            ShowColumns => \@ShowColumns,
            Nav         => $Nav,
        );

        # build footer
        $Output .= $Self->{LayoutObject}->Footer( Type => 'Small' );
        return $Output;
    }

    else {
        $Output = $Self->{LayoutObject}->Header( Type => 'Small' );

        # create output
        $Output .= $Self->_MaskForm(
            Nav => $Nav,
            %GetParam,
        );
        $Output .= $Self->{LayoutObject}->Footer( Type => 'Small' );

        return $Output;
    }
}

sub _MaskForm {
    my ( $Self, %Param ) = @_;

    # get profiles list
    my %Profiles = $Self->{SearchProfileObject}->SearchProfileList(
        Base      => 'FAQSearch',
        UserLogin => $Self->{UserLogin},
    );

    # build profiles output list
    $Param{ProfilesStrg} = $Self->{LayoutObject}->BuildSelection(
        Data         => {%Profiles},
        PossibleNone => 1,
        Name         => 'Profile',
        SelectedID   => $Param{Profile},
    );

    # get languages list
    my %Languages = $Self->{FAQObject}->LanguageList(
        UserID => $Self->{UserID},
    );

    # build languages output list
    $Param{LanguagesStrg} = $Self->{LayoutObject}->BuildSelection(
        Data       => {%Languages},
        Name       => 'LanguageIDs',
        Multiple   => 1,
        Size       => 5,
        SelectedID => $Param{LanguageIDs},
    );

    # get categories list
    my $Categories = $Self->{FAQObject}->GetUserCategoriesLongNames(
        CustomerUser => $Self->{UserLogin},
        Type         => 'rw',
        UserID       => $Self->{UserID},
    );

    # build categories output list
    $Param{CategoriesStrg} = $Self->{LayoutObject}->BuildSelection(
        Data       => $Categories,
        Name       => 'CategoryIDs',
        Multiple   => 1,
        Size       => 5,
        SelectedID => $Param{CategoryIDs},
    );

    # get valid list
    my %ValidList = $Self->{ValidObject}->ValidList();

    # build the valid selection
    $Param{ValidSelectionString} = $Self->{LayoutObject}->BuildSelection(
        Data        => \%ValidList,
        Name        => 'ValidIDs',
        SelectedIDs => $Param{ValidIDs} || [],
        Size        => 5,
        Translation => 0,
        Multiple    => 1,
    );

    # html search mask output
    $Self->{LayoutObject}->Block(
        Name => 'Search',
        Data => {%Param},
    );

    # show languages select
    if ( $Self->{MultiLanguage} ) {
        $Self->{LayoutObject}->Block(
            Name => 'Language',
            Data => {%Param},
        );
    }

    # html search mask output
    return $Self->{LayoutObject}->Output(
        TemplateFile => 'AgentFAQSearchSmall',
        Data         => {%Param},
    );
}

1;
