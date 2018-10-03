# --
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

## no critic (Modules::RequireExplicitPackage)
use strict;
use warnings;
use utf8;

use vars (qw($Self));

my $Selenium = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

$Selenium->RunTest(
    sub {

        my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'Frontend::RichText',
            Value => 1,
        );
        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'Ticket::Service',
            Value => 0,
        );
        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'Ticket::Type',
            Value => 0,
        );
        $Helper->ConfigSettingChange(
            Valid => 0,
            Key   => 'FAQ::Frontend::CustomerFAQRelatedArticles###QueuesEnabled',
        );

        my $FAQObject = $Kernel::OM->Get('Kernel::System::FAQ');

        my %Category = $FAQObject->CategoryGet(
            CategoryID => 1,
            UserID     => 1,
        );

        my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

        # Add FAQ articles.
        my @FAQArticles;
        for my $Item (qw(subject body)) {
            my $Title   = 'title' . $Helper->GetRandomID();
            my $Keyword = $Item . $Helper->GetRandomID();
            my $ItemID  = $FAQObject->FAQAdd(
                Title       => $Title,
                CategoryID  => 1,
                StateID     => 1,
                LanguageID  => 1,
                Keywords    => $Keyword,
                Field1      => 'Symptom...',
                Field2      => 'Problem...',
                Field3      => 'Solution...',
                ContentType => 'text/html',
                UserID      => 1,
            );

            $Self->True(
                $ItemID,
                "FAQ article is created - $ItemID",
            );

            my %FAQ;
            $FAQ{ID}      = $ItemID;
            $FAQ{Keyword} = $Keyword;
            $FAQ{Title}   = $Title . " ($Category{Name})";

            push @FAQArticles, \%FAQ;
        }

        # Create test customer user and login.
        my $TestCustomerUserLogin = $Helper->TestCustomerUserCreate(
        ) || die "Did not get test customer user";

        $Selenium->Login(
            Type     => 'Customer',
            User     => $TestCustomerUserLogin,
            Password => $TestCustomerUserLogin,
        );

        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        $Selenium->VerifiedGet("${ScriptAlias}customer.pl?Action=CustomerTicketMessage");

        # Check CustomerTicketMessage overview screen.
        for my $ID (qw(Dest Subject RichText PriorityID submitRichText)) {
            my $Element = $Selenium->find_element( "#$ID", 'css' );
            $Element->is_enabled();
            $Element->is_displayed();
        }

        # Check if until RelatedFAQArticles box is displayed
        $Selenium->WaitFor(
            JavaScript => 'return typeof($) === "function" && $("#FAQRelatedArticles:visible").length'
        );

        $Self->True(
            index( $Selenium->get_page_source(), 'Type a subject or text to get a list of helpful resources.' ) > -1,
            "Found initial message for related FAQ article",
        );

        my $SubjectRandom = "Subject" . $Helper->GetRandomID();
        my $TextRandom    = "Text" . $Helper->GetRandomID();
        $Selenium->find_element( "#Subject", 'css' )->send_keys($SubjectRandom);

        # Set body text and add a whitespace at the end to trigger the AJAX request for the related faq article.
        sleep 1;
        $Selenium->execute_script("CKEDITOR.instances.RichText.setData('$FAQArticles[1]->{Keyword}');");
        $Selenium->WaitFor( JavaScript => 'return CKEDITOR.instances.RichText.getData()' );
        $Selenium->find_element( "#Subject", 'css' )->send_keys(" ");
        $Selenium->find_element( "#Subject", 'css' )->send_keys("\N{U+E004}");

        # Wait that the hint is no longer visible.
        $Selenium->WaitFor(
            JavaScript => 'return typeof($) === "function" && !$("#FAQRelatedArticles .Hint").length'
        );

        # Wait for ajax call after customer user selection.
        $Selenium->WaitFor(
            JavaScript => 'return typeof($) === "function" && !$("span.AJAXLoader:visible").length'
        );

        # Check if there is the related FAQ article for the insert text in the body.
        $Self->True(
            $Selenium->find_element("//a[\@title='$FAQArticles[1]->{Title}']"),
            "Related FAQ article for body '$FAQArticles[1]->{Keyword}' is found - $FAQArticles[1]->{Title}"
        );
        $Self->True(
            $Selenium->find_element("//a[contains(\@href, 'Action=CustomerFAQZoom;ItemID=$FAQArticles[1]->{ID}')]"),
            "Link for related FAQ article is found - $FAQArticles[0]->{Title}"
        );

        # Change the body, to have a text which should not return some related faq article.
        sleep 1;
        $Selenium->execute_script('CKEDITOR.instances.RichText.setData();');
        $Selenium->find_element( "#Subject", 'css' )->send_keys('Nothing');
        $Selenium->find_element( "#Subject", 'css' )->send_keys(" ");
        $Selenium->find_element( "#Subject", 'css' )->send_keys("\N{U+E004}");

        # Wait for AJAX call after customer user selection.
        $Selenium->WaitFor(
            JavaScript => 'return typeof($) === "function" && !$("span.AJAXLoader:visible").length'
        );
        $Selenium->WaitFor(
            JavaScript => 'return typeof($) === "function" && $("#FAQRelatedArticles .Hint").length'
        );

        $Self->True(
            index( $Selenium->get_page_source(), 'Found no helpful resources for the subject and text.' ) > -1,
            "Found message for no related FAQ article",
        );

        # Test case for bug#12900 ( https://bugs.otrs.org/show_bug.cgi?id=12900 ).
        # Create new category which is subcategory of default 'Misc' category.
        my $RandomID      = $Helper->GetRandomID();
        my $SubCategoryID = $FAQObject->CategoryAdd(
            Name     => 'SubCategory' . $RandomID,
            Comment  => 'SubCategory',
            ParentID => 1,
            ValidID  => 1,
            UserID   => 1,
        );
        my $GroupID = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
            Group => 'users',
        );
        $FAQObject->SetCategoryGroup(
            CategoryID => $SubCategoryID,
            GroupIDs   => [$GroupID],
            UserID     => 1,
        );

        # Create two FAQ articles in Misc and test created subcategory.
        my @Articles = (
            {
                Title      => "MiscArticle $RandomID",
                CategoryID => 1,
            },
            {
                Title      => "SubCategoryArticle $RandomID",
                CategoryID => $SubCategoryID,
            },
        );

        my $Keyword = "Keyword $RandomID";
        my @RelatedFAQArticles;
        for my $Test (@Articles) {
            my $ItemID = $FAQObject->FAQAdd(
                Title       => $Test->{Title},
                CategoryID  => $Test->{CategoryID},
                StateID     => 3,
                LanguageID  => 1,
                Keywords    => $Keyword,
                Field1      => 'Symptom...',
                Field2      => 'Problem...',
                Field3      => 'Solution...',
                ContentType => 'text/html',
                UserID      => 1,
            );
            $Self->True(
                $ItemID,
                "FAQ article in category $Test->{CategoryID} is created - $ItemID",
            );
            push @RelatedFAQArticles, {
                ID    => $ItemID,
                Title => $Test->{Title},
            };
        }

        $Selenium->VerifiedRefresh();

        # Type in subject keyword to show two FAQ articles in the side widget hint.
        # One from 'Misc' category and second one from subcategory of 'Misc'.
        $Selenium->find_element( "#Subject", 'css' )->send_keys($Keyword);
        $Selenium->find_element( "#Subject", 'css' )->send_keys("\N{U+E004}");

        $Selenium->WaitFor(
            JavaScript => 'return typeof($) === "function" && !$("span.AJAXLoader:visible").length'
        );
        $Selenium->WaitFor(
            JavaScript => 'return $(".FAQMiniList a:visible").length;'
        );

        my $Count = scalar @RelatedFAQArticles;
        for my $Check (@RelatedFAQArticles) {
            $Count--;
            $Self->Is(
                $Selenium->execute_script("return \$('.FAQMiniList a:eq($Count)').text().trim();"),
                $Check->{Title},
                "Related FAQ article for subject keyword $RandomID is found - $Check->{Title}"
            );

            $Self->True(
                $Selenium->find_element("//a[contains(\@href, 'Action=CustomerFAQZoom;ItemID=$Check->{ID}')]"),
                "Link for related FAQ article is found - $Check->{Title}"
            );
        }

        my $Success;
        for my $FAQ ( @FAQArticles, @RelatedFAQArticles ) {
            $Success = $FAQObject->FAQDelete(
                ItemID => $FAQ->{ID},
                UserID => 1,
            );
            $Self->True(
                $Success,
                "FAQ is deleted - $FAQ->{ID}",
            );
        }

        # Delete test created subcategory.
        $Success = $FAQObject->CategoryDelete(
            CategoryID => $SubCategoryID,
            UserID     => 1,
        );
        $Self->True(
            $Success,
            "FAQ category ID $SubCategoryID is deleted",
        );

        for my $Cache (qw(FAQ FAQKeywordArticleList)) {
            $CacheObject->CleanUp(
                Type => $Cache,
            );
        }
    }
);

1;
