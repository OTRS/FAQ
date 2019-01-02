# --
# Copyright (C) 2001-2019 OTRS AG, https://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Modules::AgentFAQSearchSmall;

use strict;
use warnings;

use Kernel::System::FAQ;
use Kernel::System::SearchProfile;
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
    $Self->{DynamicFieldObject}  = Kernel::System::DynamicField->new(%Param);
    $Self->{BackendObject}       = Kernel::System::DynamicField::Backend->new(%Param);

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

    # get dynamic field config for frontend module
    $Self->{DynamicFieldFilter} = $Self->{Config}->{DynamicField};

    # get the dynamic fields for ticket object
    $Self->{DynamicField} = $Self->{DynamicFieldObject}->DynamicFieldListGet(
        Valid       => 1,
        ObjectType  => 'FAQ',
        FieldFilter => $Self->{DynamicFieldFilter} || {},
    );

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
        for my $ParamName (
            qw(Number Title Keyword Fulltext ResultForm VoteSearch VoteSearchType VoteSearchOption
            RateSearch RateSearchType RateSearchOption ApprovedSearch
            TimeSearchType ChangeTimeSearchType
            ItemCreateTimePointFormat ItemCreateTimePoint
            ItemCreateTimePointStart
            ItemCreateTimeStart ItemCreateTimeStartDay ItemCreateTimeStartMonth
            ItemCreateTimeStartYear
            ItemCreateTimeStop ItemCreateTimeStopDay ItemCreateTimeStopMonth
            ItemCreateTimeStopYear
            ItemChangeTimePointFormat ItemChangeTimePoint
            ItemChangeTimePointStart
            ItemChangeTimeStart ItemChangeTimeStartDay ItemChangeTimeStartMonth
            ItemChangeTimeStartYear
            ItemChangeTimeStop ItemChangeTimeStopDay ItemChangeTimeStopMonth
            ItemChangeTimeStopYear
            )
            )
        {
            $GetParam{$ParamName} = $Self->{ParamObject}->GetParam( Param => $ParamName );

            # remove whitespace on the start and end
            if ( $GetParam{$ParamName} ) {
                $GetParam{$ParamName} =~ s{ \A \s+ }{}xms;
                $GetParam{$ParamName} =~ s{ \s+ \z }{}xms;
            }
        }

        # get array search params
        for my $SearchParam (
            qw(CategoryIDs LanguageIDs ValidIDs StateIDs CreatedUserIDs LastChangedUserIDs)
            )
        {
            my @Array = $Self->{ParamObject}->GetArray( Param => $SearchParam );
            if (@Array) {
                $GetParam{$SearchParam} = \@Array;
            }
        }

        # get Dynamic fields from param object
        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            # get search field preferences
            my $SearchFieldPreferences = $Self->{BackendObject}->SearchFieldPreferences(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

            PREFERENCE:
            for my $Preference ( @{$SearchFieldPreferences} ) {

                # extract the dynamic field value from the web request
                my $DynamicFieldValue = $Self->{BackendObject}->SearchFieldValueGet(
                    DynamicFieldConfig     => $DynamicFieldConfig,
                    ParamObject            => $Self->{ParamObject},
                    ReturnProfileStructure => 1,
                    LayoutObject           => $Self->{LayoutObject},
                    Type                   => $Preference->{Type},
                );

                # set the complete value structure in GetParam to store it later in the search profile
                if ( IsHashRefWithData($DynamicFieldValue) ) {
                    %GetParam = ( %GetParam, %{$DynamicFieldValue} );
                }
            }
        }
    }

    # get approved option
    if ( $GetParam{ApprovedSearch} && $GetParam{ApprovedSearch} eq 'Yes' ) {
        $GetParam{Approved} = 1;
    }
    elsif ( $GetParam{ApprovedSearch} && $GetParam{ApprovedSearch} eq 'No' ) {
        $GetParam{Approved} = 0;
    }

    # get vote option
    if ( !$GetParam{VoteSearchOption} ) {
        $GetParam{'VoteSearchOption::None'} = 'checked="checked"';
    }
    elsif ( $GetParam{VoteSearchOption} eq 'VotePoint' ) {
        $GetParam{'VoteSearchOption::VotePoint'} = 'checked="checked"';
    }

    # get rate option
    if ( !$GetParam{RateSearchOption} ) {
        $GetParam{'RateSearchOption::None'} = 'checked="checked"';
    }
    elsif ( $GetParam{RateSearchOption} eq 'RatePoint' ) {
        $GetParam{'RateSearchOption::RatePoint'} = 'checked="checked"';
    }

    # get create time option
    if ( !$GetParam{TimeSearchType} ) {
        $GetParam{'TimeSearchType::None'} = 'checked="checked"';
    }
    elsif ( $GetParam{TimeSearchType} eq 'TimePoint' ) {
        $GetParam{'TimeSearchType::TimePoint'} = 'checked="checked"';
    }
    elsif ( $GetParam{TimeSearchType} eq 'TimeSlot' ) {
        $GetParam{'TimeSearchType::TimeSlot'} = 'checked="checked"';
    }

    # get change time option
    if ( !$GetParam{ChangeTimeSearchType} ) {
        $GetParam{'ChangeTimeSearchType::None'} = 'checked="checked"';
    }
    elsif ( $GetParam{ChangeTimeSearchType} eq 'TimePoint' ) {
        $GetParam{'ChangeTimeSearchType::TimePoint'} = 'checked="checked"';
    }
    elsif ( $GetParam{ChangeTimeSearchType} eq 'TimeSlot' ) {
        $GetParam{'ChangeTimeSearchType::TimeSlot'} = 'checked="checked"';
    }

    # set result form ENV
    if ( !$GetParam{ResultForm} ) {
        $GetParam{ResultForm} = '';
    }

    # show result site
    if ( $Self->{Subaction} eq 'Search' && !$Self->{EraseTemplate} ) {

        # fill up profile name (e.g. with last-search)
        if ( !$Self->{Profile} || !$Self->{SaveProfile} ) {
            $Self->{Profile} = 'last-search';
        }

        # store last overview screen
        my $URL = "Action=AgentFAQSearchSmall;Subaction=Search"
            . ";Profile=" . $Self->{LayoutObject}->LinkEncode( $Self->{Profile} )
            . ";SortBy=" . $Self->{LayoutObject}->LinkEncode( $Self->{SortBy} )
            . ";OrderBy=" . $Self->{LayoutObject}->LinkEncode( $Self->{OrderBy} )
            . ";TakeLastSearch=1"
            . ";StartHit=" . $Self->{LayoutObject}->LinkEncode( $Self->{StartHit} )
            . ";Nav=$Nav";

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

        # prepare votes search
        if ( IsNumber( $GetParam{VoteSearch} ) && $GetParam{VoteSearchOption} ) {
            $GetParam{Votes} = {
                $GetParam{VoteSearchType} => $GetParam{VoteSearch}
            };
        }

        # prepare rate search
        if ( IsNumber( $GetParam{RateSearch} ) && $GetParam{RateSearchOption} ) {
            $GetParam{Rate} = {
                $GetParam{RateSearchType} => $GetParam{RateSearch}
            };
        }

        my %TimeMap = (
            ItemCreate => 'Time',
            ItemChange => 'ChangeTime',
        );

        for my $TimeType ( sort keys %TimeMap ) {

            # get create time settings
            if ( !$GetParam{ $TimeMap{$TimeType} . 'SearchType' } ) {

                # do nothing with time stuff
            }
            elsif ( $GetParam{ $TimeMap{$TimeType} . 'SearchType' } eq 'TimeSlot' ) {
                for my $Key (qw(Month Day)) {
                    $GetParam{ $TimeType . 'TimeStart' . $Key }
                        = sprintf( "%02d", $GetParam{ $TimeType . 'TimeStart' . $Key } );
                    $GetParam{ $TimeType . 'TimeStop' . $Key }
                        = sprintf( "%02d", $GetParam{ $TimeType . 'TimeStop' . $Key } );
                }
                if (
                    $GetParam{ $TimeType . 'TimeStartDay' }
                    && $GetParam{ $TimeType . 'TimeStartMonth' }
                    && $GetParam{ $TimeType . 'TimeStartYear' }
                    )
                {
                    $GetParam{ $TimeType . 'TimeNewerDate' } = $GetParam{ $TimeType . 'TimeStartYear' } . '-'
                        . $GetParam{ $TimeType . 'TimeStartMonth' } . '-'
                        . $GetParam{ $TimeType . 'TimeStartDay' }
                        . ' 00:00:00';
                }
                if (
                    $GetParam{ $TimeType . 'TimeStopDay' }
                    && $GetParam{ $TimeType . 'TimeStopMonth' }
                    && $GetParam{ $TimeType . 'TimeStopYear' }
                    )
                {
                    $GetParam{ $TimeType . 'TimeOlderDate' } = $GetParam{ $TimeType . 'TimeStopYear' } . '-'
                        . $GetParam{ $TimeType . 'TimeStopMonth' } . '-'
                        . $GetParam{ $TimeType . 'TimeStopDay' }
                        . ' 23:59:59';
                }
            }
            elsif ( $GetParam{ $TimeMap{$TimeType} . 'SearchType' } eq 'TimePoint' ) {
                if (
                    $GetParam{ $TimeType . 'TimePoint' }
                    && $GetParam{ $TimeType . 'TimePointStart' }
                    && $GetParam{ $TimeType . 'TimePointFormat' }
                    )
                {
                    my $Time = 0;
                    if ( $GetParam{ $TimeType . 'TimePointFormat' } eq 'minute' ) {
                        $Time = $GetParam{ $TimeType . 'TimePoint' };
                    }
                    elsif ( $GetParam{ $TimeType . 'TimePointFormat' } eq 'hour' ) {
                        $Time = $GetParam{ $TimeType . 'TimePoint' } * 60;
                    }
                    elsif ( $GetParam{ $TimeType . 'TimePointFormat' } eq 'day' ) {
                        $Time = $GetParam{ $TimeType . 'TimePoint' } * 60 * 24;
                    }
                    elsif ( $GetParam{ $TimeType . 'TimePointFormat' } eq 'week' ) {
                        $Time = $GetParam{ $TimeType . 'TimePoint' } * 60 * 24 * 7;
                    }
                    elsif ( $GetParam{ $TimeType . 'TimePointFormat' } eq 'month' ) {
                        $Time = $GetParam{ $TimeType . 'TimePoint' } * 60 * 24 * 30;
                    }
                    elsif ( $GetParam{ $TimeType . 'TimePointFormat' } eq 'year' ) {
                        $Time = $GetParam{ $TimeType . 'TimePoint' } * 60 * 24 * 365;
                    }
                    if ( $GetParam{ $TimeType . 'TimePointStart' } eq 'Before' ) {

                        # more than ... ago
                        $GetParam{ $TimeType . 'TimeOlderMinutes' } = $Time;
                    }
                    elsif ( $GetParam{ $TimeType . 'TimePointStart' } eq 'Next' ) {

                        # within next
                        $GetParam{ $TimeType . 'TimeNewerMinutes' } = 0;
                        $GetParam{ $TimeType . 'TimeOlderMinutes' } = -$Time;
                    }
                    else {
                        # within last ...
                        $GetParam{ $TimeType . 'TimeOlderMinutes' } = 0;
                        $GetParam{ $TimeType . 'TimeNewerMinutes' } = $Time;
                    }
                }
            }
        }

        # prepare full-text search
        if ( $GetParam{Fulltext} ) {
            $GetParam{ContentSearch} = 'OR';
            $GetParam{What}          = $GetParam{Fulltext};
        }

        # get valid list
        my %ValidList   = $Self->{ValidObject}->ValidList();
        my @AllValidIDs = keys %ValidList;

        # prepare search states
        my $SearchStates;
        if ( !IsArrayRefWithData( $GetParam{StateIDs} ) ) {
            $SearchStates = $Self->{InterfaceStates};
        }
        else {
            STATETYPEID:
            for my $StateTypeID ( @{ $GetParam{StateIDs} } ) {
                next STATETYPEID if !$StateTypeID;
                next STATETYPEID if !$Self->{InterfaceStates}->{$StateTypeID};
                $SearchStates->{$StateTypeID} = $Self->{InterfaceStates}->{$StateTypeID};
            }
        }

        # prepare votes search
        if ( IsNumber( $GetParam{VoteSearch} ) && $GetParam{VoteSearchOption} ) {
            $GetParam{Votes} = {
                $GetParam{VoteSearchType} => $GetParam{VoteSearch}
            };
        }

        # prepare rate search
        if ( IsNumber( $GetParam{RateSearch} ) && $GetParam{RateSearchOption} ) {
            $GetParam{Rate} = {
                $GetParam{RateSearchType} => $GetParam{RateSearch}
            };
        }

        # dynamic fields search parameters for FAQ search
        my %DynamicFieldSearchParameters;

        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            # get search field preferences
            my $SearchFieldPreferences = $Self->{BackendObject}->SearchFieldPreferences(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

            PREFERENCE:
            for my $Preference ( @{$SearchFieldPreferences} ) {

                # extract the dynamic field value from the profile
                my $SearchParameter = $Self->{BackendObject}->SearchFieldParameterBuild(
                    DynamicFieldConfig => $DynamicFieldConfig,
                    Profile            => \%GetParam,
                    LayoutObject       => $Self->{LayoutObject},
                    Type               => $Preference->{Type},
                );

                # set search parameter
                if ( defined $SearchParameter ) {
                    $DynamicFieldSearchParameters{ 'DynamicField_' . $DynamicFieldConfig->{Name} }
                        = $SearchParameter->{Parameter};
                }
            }
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
            Type   => 'ro',
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
        #    temper with the categories drop-box, a check is needed.
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
            # default search on all valid ids, this can be overwritten by %GetParam
            @ViewableFAQIDs = $Self->{FAQObject}->FAQSearch(
                OrderBy             => [ $Self->{SortBy} ],
                OrderByDirection    => [ $Self->{OrderBy} ],
                Limit               => $Self->{SearchLimit},
                UserID              => $Self->{UserID},
                States              => $SearchStates,
                Interface           => $Self->{Interface},
                ContentSearchPrefix => '*',
                ContentSearchSuffix => '*',
                ValidIDs            => \@AllValidIDs,
                CategoryIDs         => \@CategoryIDs,
                %GetParam,
                %DynamicFieldSearchParameters,
            );
        }

        # start HTML page
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
            . ';Profile=' . $Self->{LayoutObject}->LinkEncode( $Self->{Profile} )
            . ';TakeLastSearch=1;Subaction=Search'
            . ';Nav=' . $Nav
            . ';';
        my $LinkSort = 'Filter='
            . $Self->{LayoutObject}->LinkEncode( $Self->{Filter} )
            . ';View=' . $Self->{LayoutObject}->LinkEncode( $Self->{View} )
            . ';Profile=' . $Self->{LayoutObject}->LinkEncode( $Self->{Profile} )
            . ';TakeLastSearch=1;Subaction=Search'
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
            . ';Profile=' . $Self->{LayoutObject}->LinkEncode( $Self->{Profile} )
            . ';TakeLastSearch=1;Subaction=Search'
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

    # get list type
    my $TreeView = 0;
    if ( $Self->{ConfigObject}->Get('Ticket::Frontend::ListType') eq 'tree' ) {
        $TreeView = 1;
    }

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

    # drop-down menu for 'languages'
    $Param{LanguagesSelectionStrg} = $Self->{LayoutObject}->BuildSelection(
        Data       => \%Languages,
        Name       => 'LanguageIDs',
        Size       => 5,
        Multiple   => 1,
        SelectedID => $Param{LanguageIDs} || [],
    );

    # get categories (with category long names) where user has rights
    my $UserCategoriesLongNames = $Self->{FAQObject}->GetUserCategoriesLongNames(
        Type   => 'ro',
        UserID => $Self->{UserID},
    );

    # build the category selection
    $Param{CategoriesSelectionStrg} = $Self->{LayoutObject}->BuildSelection(
        Data        => $UserCategoriesLongNames,
        Name        => 'CategoryIDs',
        SelectedID  => $Param{CategoryIDs} || [],
        Size        => 5,
        Translation => 0,
        Multiple    => 1,
        TreeView    => $TreeView,
    );

    # get valid list
    my %ValidList = $Self->{ValidObject}->ValidList();

    # build the valid selection
    $Param{ValidSelectionStrg} = $Self->{LayoutObject}->BuildSelection(
        Data        => \%ValidList,
        Name        => 'ValidIDs',
        SelectedID  => $Param{ValidIDs} || [],
        Size        => 5,
        Translation => 0,
        Multiple    => 1,
    );

    # create a mix of state and state types hash in order to have the state type IDs with state
    # names
    my %StateList = $Self->{FAQObject}->StateList(
        UserID => $Self->{UserID},
    );

    my %States;
    for my $StateID ( sort keys %StateList ) {
        my %StateData = $Self->{FAQObject}->StateGet(
            StateID => $StateID,
            UserID  => $Self->{UserID},
        );
        $States{ $StateData{TypeID} } = $StateData{Name};
    }

    $Param{StateSelectionStrg} = $Self->{LayoutObject}->BuildSelection(
        Data        => \%States,
        Name        => 'StateIDs',
        SelectedID  => $Param{StateIDs} || [],
        Size        => 3,
        Translation => 1,
        Multiple    => 1,
    );

    my %VotingOperators = (
        Equals            => 'Equals',
        GreaterThan       => 'GreaterThan',
        GreaterThanEquals => 'GreaterThanEquals',
        SmallerThan       => 'SmallerThan',
        SmallerThanEquals => 'SmallerThanEquals',
    );

    $Param{VoteSearchTypeSelectionStrg} = $Self->{LayoutObject}->BuildSelection(
        Data        => \%VotingOperators,
        Name        => 'VoteSearchType',
        SelectedID  => $Param{VoteSearchType} || '',
        Size        => 1,
        Translation => 1,
        Multiple    => 0,
    );

    $Param{RateSearchTypeSelectionStrg} = $Self->{LayoutObject}->BuildSelection(
        Data        => \%VotingOperators,
        Name        => 'RateSearchType',
        SelectedID  => $Param{RateSearchType} || '',
        Size        => 1,
        Translation => 1,
        Multiple    => 0,
    );
    $Param{RateSearchSelectionStrg} = $Self->{LayoutObject}->BuildSelection(
        Data => {
            0   => '0%',
            25  => '25%',
            50  => '50%',
            75  => '75%',
            100 => '100%',
        },
        Sort        => 'NumericKey',
        Name        => 'RateSearch',
        SelectedID  => $Param{RateSearch} || '',
        Size        => 1,
        Translation => 0,
        Multiple    => 0,
    );

    $Param{ApprovedStrg} = $Self->{LayoutObject}->BuildSelection(
        Data => {
            No  => 'No',
            Yes => 'Yes',
        },
        Name         => 'ApprovedSearch',
        SelectedID   => $Param{ApprovedSearch} || '',
        Multiple     => 0,
        Translation  => 1,
        PossibleNone => 1,
    );

    # get a list of all users to display
    my %ShownUsers = $Self->{UserObject}->UserList(
        Type  => 'Long',
        Valid => 1,
    );

    # get the UserIDs from FAQ and faq_admin members
    my %GroupUsers;
    for my $Group (qw(faq faq_admin)) {
        my $GroupID = $Self->{GroupObject}->GroupLookup( Group => $Group );
        my %Users   = $Self->{GroupObject}->GroupMemberList(
            GroupID => $GroupID,
            Type    => 'rw',
            Result  => 'HASH',
        );
        %GroupUsers = ( %GroupUsers, %Users );
    }

    # remove all users that are not in the FAQ or faq_admin groups
    for my $UserID ( sort keys %ShownUsers ) {
        if ( !$GroupUsers{$UserID} ) {
            delete $ShownUsers{$UserID};
        }
    }
    $Param{CreatedUserStrg} = $Self->{LayoutObject}->BuildSelection(
        Data       => \%ShownUsers,
        Name       => 'CreatedUserIDs',
        Multiple   => 1,
        Size       => 5,
        SelectedID => $Param{CreatedUserIDs},
    );
    $Param{LastChangedUserStrg} = $Self->{LayoutObject}->BuildSelection(
        Data       => \%ShownUsers,
        Name       => 'LastChangedUserIDs',
        Multiple   => 1,
        Size       => 5,
        SelectedID => $Param{LastChangedUserIDs},
    );

    $Param{ItemCreateTimePointStrg} = $Self->{LayoutObject}->BuildSelection(
        Data       => [ 1 .. 59 ],
        Name       => 'ItemCreateTimePoint',
        SelectedID => $Param{ItemCreateTimePoint},
    );
    $Param{ItemCreateTimePointStartStrg} = $Self->{LayoutObject}->BuildSelection(
        Data => {
            'Last'   => 'within the last ...',
            'Before' => 'more than ... ago',
        },
        Name       => 'ItemCreateTimePointStart',
        SelectedID => $Param{ItemCreateTimePointStart} || 'Last',
    );
    $Param{ItemCreateTimePointFormatStrg} = $Self->{LayoutObject}->BuildSelection(
        Data => {
            minute => 'minute(s)',
            hour   => 'hour(s)',
            day    => 'day(s)',
            week   => 'week(s)',
            month  => 'month(s)',
            year   => 'year(s)',
        },
        Name       => 'ItemCreateTimePointFormat',
        SelectedID => $Param{ItemCreateTimePointFormat},
    );
    $Param{ItemCreateTimeStartStrg} = $Self->{LayoutObject}->BuildDateSelection(
        %Param,
        Prefix   => 'ItemCreateTimeStart',
        Format   => 'DateInputFormat',
        DiffTime => -( ( 60 * 60 * 24 ) * 30 ),
    );
    $Param{ItemCreateTimeStopStrg} = $Self->{LayoutObject}->BuildDateSelection(
        %Param,
        Prefix => 'ItemCreateTimeStop',
        Format => 'DateInputFormat',
    );

    $Param{ItemChangeTimePointStrg} = $Self->{LayoutObject}->BuildSelection(
        Data       => [ 1 .. 59 ],
        Name       => 'ItemChangeTimePoint',
        SelectedID => $Param{ItemChangeTimePoint},
    );
    $Param{ItemChangeTimePointStartStrg} = $Self->{LayoutObject}->BuildSelection(
        Data => {
            'Last'   => 'within the last ...',
            'Before' => 'more than ... ago',
        },
        Name       => 'ItemChangeTimePointStart',
        SelectedID => $Param{ItemChangeTimePointStart} || 'Last',
    );
    $Param{ItemChangeTimePointFormatStrg} = $Self->{LayoutObject}->BuildSelection(
        Data => {
            minute => 'minute(s)',
            hour   => 'hour(s)',
            day    => 'day(s)',
            week   => 'week(s)',
            month  => 'month(s)',
            year   => 'year(s)',
        },
        Name       => 'ItemChangeTimePointFormat',
        SelectedID => $Param{ItemChangeTimePointFormat},
    );
    $Param{ItemChangeTimeStartStrg} = $Self->{LayoutObject}->BuildDateSelection(
        %Param,
        Prefix   => 'ItemChangeTimeStart',
        Format   => 'DateInputFormat',
        DiffTime => -( ( 60 * 60 * 24 ) * 30 ),
    );
    $Param{ItemChangeTimeStopStrg} = $Self->{LayoutObject}->BuildDateSelection(
        %Param,
        Prefix => 'ItemChangeTimeStop',
        Format => 'DateInputFormat',
    );

    # create HTML strings for all dynamic fields
    my %DynamicFieldHTML;

    # cycle trough the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        # get search field preferences
        my $SearchFieldPreferences = $Self->{BackendObject}->SearchFieldPreferences(
            DynamicFieldConfig => $DynamicFieldConfig,
        );

        next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

        PREFERENCE:
        for my $Preference ( @{$SearchFieldPreferences} ) {

            # get field HTML
            $DynamicFieldHTML{ $DynamicFieldConfig->{Name} . $Preference->{Type} }
                = $Self->{BackendObject}->SearchFieldRender(
                DynamicFieldConfig => $DynamicFieldConfig,
                Profile            => \%Param,
                DefaultValue =>
                    $Self->{Config}->{Defaults}->{DynamicField}
                    ->{ $DynamicFieldConfig->{Name} },
                LayoutObject => $Self->{LayoutObject},
                Type         => $Preference->{Type},
                );
        }
    }

    # HTML search mask output
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

    # output Dynamic fields blocks
    # cycle trough the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        # get search field preferences
        my $SearchFieldPreferences = $Self->{BackendObject}->SearchFieldPreferences(
            DynamicFieldConfig => $DynamicFieldConfig,
        );

        next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

        PREFERENCE:
        for my $Preference ( @{$SearchFieldPreferences} ) {

            # skip fields that HTML could not be retrieved
            next PREFERENCE if !IsHashRefWithData(
                $DynamicFieldHTML{ $DynamicFieldConfig->{Name} . $Preference->{Type} }
            );

            $Self->{LayoutObject}->Block(
                Name => 'DynamicField',
                Data => {
                    Label =>
                        $DynamicFieldHTML{ $DynamicFieldConfig->{Name} . $Preference->{Type} }
                        ->{Label},
                    Field =>
                        $DynamicFieldHTML{ $DynamicFieldConfig->{Name} . $Preference->{Type} }
                        ->{Field},
                },
            );
        }
    }

    # HTML search mask output
    return $Self->{LayoutObject}->Output(
        TemplateFile => 'AgentFAQSearchSmall',
        Data         => {%Param},
    );
}

1;
