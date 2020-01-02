# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Language::sr_Latn_FAQ;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AgentFAQAdd
    $Self->{Translation}->{'Add FAQ Article'} = 'Dodaj ČPP članak';
    $Self->{Translation}->{'Keywords'} = 'Ključne reči';
    $Self->{Translation}->{'A category is required.'} = 'Kategorija je obavezna.';
    $Self->{Translation}->{'Approval'} = 'Odobrenje';

    # Template: AgentFAQCategory
    $Self->{Translation}->{'FAQ Category Management'} = 'Upravljanje ČPP kategorijama';
    $Self->{Translation}->{'Add category'} = 'Dodaj kategoriju';
    $Self->{Translation}->{'Delete Category'} = 'Obriši kategoriju';
    $Self->{Translation}->{'Ok'} = 'U redu';
    $Self->{Translation}->{'Add Category'} = 'Dodaj kategoriju';
    $Self->{Translation}->{'Edit Category'} = 'Uredi kategoriju';
    $Self->{Translation}->{'Subcategory of'} = 'Podkategorija od';
    $Self->{Translation}->{'Please select at least one permission group.'} = 'Molimo da izaberete bar jednu grupu dozvola.';
    $Self->{Translation}->{'Agent groups that can access articles in this category.'} = 'Grupe operatera koje mogu pristupiti člancima u ovoj kategoriji.';
    $Self->{Translation}->{'Will be shown as comment in Explorer.'} = 'Biće prikazano kao komentar u Istraživaču.';
    $Self->{Translation}->{'Do you really want to delete this category?'} = 'Da li stvarno želite da obrišete ovu kategoriju?';
    $Self->{Translation}->{'You can not delete this category. It is used in at least one FAQ article and/or is parent of at least one other category'} =
        'Ne možete obrisati ovau kategoriju. Upotrebljena je u bar jednom ČPP članku i/ili je nadređena najmanje jednoj drugoj kategoriji';
    $Self->{Translation}->{'This category is used in the following FAQ article(s)'} = 'Ova kategorija je upotrebljena u sledećim ČPP člancima';
    $Self->{Translation}->{'This category is parent of the following subcategories'} = 'Ova kategorija je nadređena sledećim podkategorijama';

    # Template: AgentFAQDelete
    $Self->{Translation}->{'Do you really want to delete this FAQ article?'} = 'Da li stvarno želite da obrišete ovaj ČPP članak?';

    # Template: AgentFAQEdit
    $Self->{Translation}->{'FAQ'} = 'ČPP';

    # Template: AgentFAQExplorer
    $Self->{Translation}->{'FAQ Explorer'} = 'ČPP Istraživač';
    $Self->{Translation}->{'Quick Search'} = 'Brzo traženje';
    $Self->{Translation}->{'Wildcards are allowed.'} = 'Džokerski znaci su dozvoljeni.';
    $Self->{Translation}->{'Advanced Search'} = 'Napredna pretraga';
    $Self->{Translation}->{'Subcategories'} = 'Podkategorije';
    $Self->{Translation}->{'FAQ Articles'} = 'ČPP članci';
    $Self->{Translation}->{'No subcategories found.'} = 'Podkategorije nisu pronađene.';

    # Template: AgentFAQHistory
    $Self->{Translation}->{'History of'} = 'Istorija od';

    # Template: AgentFAQJournalOverviewSmall
    $Self->{Translation}->{'No FAQ Journal data found.'} = 'Nisu pronađeni podaci ČPP dnevnika.';

    # Template: AgentFAQLanguage
    $Self->{Translation}->{'FAQ Language Management'} = 'Upravljanje ČPP jezicima';
    $Self->{Translation}->{'Use this feature if you want to work with multiple languages.'} =
        'Upotrebite ovu funkciju ako želite da koristite više jezika.';
    $Self->{Translation}->{'Add language'} = 'Dodaj jezik';
    $Self->{Translation}->{'Delete Language %s'} = 'Obriši jezik %s';
    $Self->{Translation}->{'Add Language'} = 'Dodaj Jezik';
    $Self->{Translation}->{'Edit Language'} = 'Uredi Jezik';
    $Self->{Translation}->{'Do you really want to delete this language?'} = 'Da li zaista želite da izbrišete ovaj jezik?';
    $Self->{Translation}->{'You can not delete this language. It is used in at least one FAQ article!'} =
        'Ne možete obrisati ovaj jezik. Upotrebljen je u bar jednom ČPP članku!';
    $Self->{Translation}->{'This language is used in the following FAQ Article(s)'} = 'Ovaj jezik je upotrebljen u sledećim ČPP člancima';

    # Template: AgentFAQOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Podešavanje konteksta';
    $Self->{Translation}->{'FAQ articles per page'} = 'ČPP članaka po strani';

    # Template: AgentFAQOverviewSmall
    $Self->{Translation}->{'No FAQ data found.'} = 'Nisu pronađeni ČPP podaci.';

    # Template: AgentFAQSearch
    $Self->{Translation}->{'Keyword'} = 'Ključna reč';
    $Self->{Translation}->{'Vote (e. g. Equals 10 or GreaterThan 60)'} = 'Glasaj (npr jednako 10 ili veće od 60)';
    $Self->{Translation}->{'Rate (e. g. Equals 25% or GreaterThan 75%)'} = 'Oceni (npr jednako 25% ili veće od 75%)';
    $Self->{Translation}->{'Approved'} = 'Odobreno';
    $Self->{Translation}->{'Last changed by'} = 'Poslednji je menjao';
    $Self->{Translation}->{'FAQ Article Create Time (before/after)'} = 'Vreme kreiranja ČPP članka (pre/posle)';
    $Self->{Translation}->{'FAQ Article Create Time (between)'} = 'Vreme kreiranja ČPP članka (između)';
    $Self->{Translation}->{'FAQ Article Change Time (before/after)'} = 'Vreme promene ČPP članka (pre/posle)';
    $Self->{Translation}->{'FAQ Article Change Time (between)'} = 'Vreme promene ČPP članka (između)';

    # Template: AgentFAQSearchOpenSearchDescriptionFulltext
    $Self->{Translation}->{'FAQFulltext'} = 'ČPP kompletan tekst';

    # Template: AgentFAQSearchSmall
    $Self->{Translation}->{'FAQ Search'} = 'ČPP pretraga';
    $Self->{Translation}->{'Profile Selection'} = 'Izbor profila';
    $Self->{Translation}->{'Vote'} = 'Glas';
    $Self->{Translation}->{'No vote settings'} = 'Nema podešavanja za glasanje';
    $Self->{Translation}->{'Specific votes'} = 'Specifični glasovi';
    $Self->{Translation}->{'e. g. Equals 10 or GreaterThan 60'} = 'npr jednako 10 ili veće od 60';
    $Self->{Translation}->{'Rate'} = 'Ocena';
    $Self->{Translation}->{'No rate settings'} = 'Nema podešavanja za ocenjivanje';
    $Self->{Translation}->{'Specific rate'} = 'Specifična ocena';
    $Self->{Translation}->{'e. g. Equals 25% or GreaterThan 75%'} = 'npr jednako 25% ili veće od 75%';
    $Self->{Translation}->{'FAQ Article Create Time'} = 'Vreme kreiranja ČPP članka';
    $Self->{Translation}->{'FAQ Article Change Time'} = 'Vreme promene ČPP članka';

    # Template: AgentFAQZoom
    $Self->{Translation}->{'FAQ Information'} = 'ČPP informacija';
    $Self->{Translation}->{'Rating'} = 'Ocenjivanje';
    $Self->{Translation}->{'out of 5'} = 'od 5';
    $Self->{Translation}->{'Votes'} = 'Glasovi';
    $Self->{Translation}->{'No votes found!'} = 'Glasovi nisu pronađeni!';
    $Self->{Translation}->{'No votes found! Be the first one to rate this FAQ article.'} = 'Glasovi nisu pronađeni! Budite prvi koji će oceniti ovaj ČPP članak!';
    $Self->{Translation}->{'Download Attachment'} = 'Preuzmi prilog';
    $Self->{Translation}->{'To open links in the following description blocks, you might need to press Ctrl or Cmd or Shift key while clicking the link (depending on your browser and OS).'} =
        'Da biste otvorili veze u sledećim blokovima opisa, možda ćete trebati da pritisnete „Ctrl” ili „Cmd” ili „Shift” taster dok istovremeno kliknete na vezu (zavisi od vašeg OS i pregledača).';
    $Self->{Translation}->{'How helpful was this article? Please give us your rating and help to improve the FAQ Database. Thank You!'} =
        'Koliko je koristan ovaj članak? Molimo vas da date vašu ocenu i pomognete podizanju kvalitata baze često postavljanih pitanja. Hvala Vam! ';
    $Self->{Translation}->{'not helpful'} = 'nije korisno';
    $Self->{Translation}->{'very helpful'} = 'vrlo korisno';

    # Template: AgentFAQZoomSmall
    $Self->{Translation}->{'Add FAQ title to article subject'} = 'Dodaj ČPP članku naslov';
    $Self->{Translation}->{'Insert FAQ Text'} = 'Unesi ČPP tekst';
    $Self->{Translation}->{'Insert Full FAQ'} = 'Unesi kompletan ČPP';
    $Self->{Translation}->{'Insert FAQ Link'} = 'Unesi ČPP vezu';
    $Self->{Translation}->{'Insert FAQ Text & Link'} = 'Unesi ČPP tekst i vezu';
    $Self->{Translation}->{'Insert Full FAQ & Link'} = 'Unesi kompletan ČPP i vezu';

    # Template: CustomerFAQExplorer
    $Self->{Translation}->{'No FAQ articles found.'} = 'Nisu pronađeni ČPP članci.';

    # Template: CustomerFAQRelatedArticles
    $Self->{Translation}->{'This might be helpful'} = 'Ovo može da bude od pomoći';
    $Self->{Translation}->{'Found no helpful resources for the subject and text.'} = 'Korisni resursi za uneti predmet i tekst nisu pronađeni.';
    $Self->{Translation}->{'Type a subject or text to get a list of helpful resources.'} = 'Za listu korisnih resursa, molimo unesite predmet ili tekst.';

    # Template: CustomerFAQSearch
    $Self->{Translation}->{'Fulltext search in FAQ articles (e. g. "John*n" or "Will*")'} = 'Potpuna tekstualna pretraga u ČPP člancima (npr. "John*n" ili "Will*")';
    $Self->{Translation}->{'Vote restrictions'} = 'Ograničenja glasanja';
    $Self->{Translation}->{'Only FAQ articles with votes...'} = 'Samo ČPP članci sa glasovima...';
    $Self->{Translation}->{'Rate restrictions'} = 'Ograničenja ocenjivanja';
    $Self->{Translation}->{'Only FAQ articles with rate...'} = 'Samo ČPP članci sa ocenom...';
    $Self->{Translation}->{'Only FAQ articles created'} = 'Samo ČPP članci kreirani';
    $Self->{Translation}->{'Only FAQ articles created between'} = 'Samo ČPP članci kreirani između';
    $Self->{Translation}->{'Search-Profile as Template?'} = 'Profil pretrage kao šablon?';

    # Template: CustomerFAQZoom
    $Self->{Translation}->{'Article Number'} = 'Broj članka';
    $Self->{Translation}->{'Search for articles with keyword'} = 'Traži članke sa ključnom reči';

    # Template: PublicFAQSearchOpenSearchDescriptionFAQNumber
    $Self->{Translation}->{'Public'} = 'Javno';

    # Template: PublicFAQSearchResultShort
    $Self->{Translation}->{'Back to FAQ Explorer'} = 'Nazad na ČPP Istraživač';

    # Perl Module: Kernel/Modules/AgentFAQAdd.pm
    $Self->{Translation}->{'You need rw permission!'} = 'Potrebna vam je „rw” dozvola!';
    $Self->{Translation}->{'No categories found where user has read/write permissions!'} = 'Kategorije u kojoj korisnik ima pristup bez ograničenja nisu pronađene!';
    $Self->{Translation}->{'No default language found and can\'t create a new one.'} = 'Nije pronađen podrazumevani jezik i ne može se kreirati nov.';

    # Perl Module: Kernel/Modules/AgentFAQCategory.pm
    $Self->{Translation}->{'Need CategoryID!'} = 'Potreban ID Kategorije!';
    $Self->{Translation}->{'A category should have a name!'} = 'Kategorija treba da ima ime!';
    $Self->{Translation}->{'This category already exists'} = 'Ova kategorija već postoji';
    $Self->{Translation}->{'This category already exists!'} = 'Ova kategorija već postoji!';
    $Self->{Translation}->{'No CategoryID is given!'} = 'Nije dat ID Kategorije!';
    $Self->{Translation}->{'Was not able to delete the category %s!'} = 'Nije bilo moguće obrisati kategoriju %s!';
    $Self->{Translation}->{'FAQ category updated!'} = 'ČPP kategorija ažurirana!';
    $Self->{Translation}->{'FAQ category added!'} = 'ČPP kategorija dodata!';

    # Perl Module: Kernel/Modules/AgentFAQDelete.pm
    $Self->{Translation}->{'No ItemID is given!'} = 'Nije dat ID Stavke!';
    $Self->{Translation}->{'You have no permission for this category!'} = 'Nemate dozvolu za ovu kategoriju!';
    $Self->{Translation}->{'Was not able to delete the FAQ article %s!'} = 'Nije bilo moguće obrisati ČPP članak %s!';

    # Perl Module: Kernel/Modules/AgentFAQExplorer.pm
    $Self->{Translation}->{'The CategoryID %s is invalid.'} = 'ID Kategorije %s je neispravan!';

    # Perl Module: Kernel/Modules/AgentFAQHistory.pm
    $Self->{Translation}->{'Can\'t show history, as no ItemID is given!'} = 'Ne može se prikazati istorijat, jer nije dat ID Stavke!';
    $Self->{Translation}->{'FAQ History'} = 'ČPP istorija';

    # Perl Module: Kernel/Modules/AgentFAQJournal.pm
    $Self->{Translation}->{'FAQ Journal'} = 'ČPP dnevnik';
    $Self->{Translation}->{'Need config option FAQ::Frontend::Overview'} = 'Potrebna konfiguraciona opcija FAQ::Frontend::Overview';
    $Self->{Translation}->{'Config option FAQ::Frontend::Overview needs to be a HASH ref!'} =
        'Konfiguraciona opcija FAQ::Frontend::Overview mora da bude HASH referenca!';
    $Self->{Translation}->{'No config option found for the view "%s"!'} = 'Nije pronađena konfiguraciona stavka za pregled "%s"!';

    # Perl Module: Kernel/Modules/AgentFAQLanguage.pm
    $Self->{Translation}->{'No LanguageID is given!'} = 'Nije dat ID Jezika!';
    $Self->{Translation}->{'The name is required!'} = 'Ime je obavezno!';
    $Self->{Translation}->{'This language already exists!'} = 'Ovaj jezik već postoji!';
    $Self->{Translation}->{'Was not able to delete the language %s!'} = 'Nije bilo moguće obrisati jezik %s!';
    $Self->{Translation}->{'FAQ language updated!'} = 'Ažuriran ČPP jezik!';
    $Self->{Translation}->{'FAQ language added!'} = 'Dodat ČPP jezik!';

    # Perl Module: Kernel/Modules/AgentFAQPrint.pm
    $Self->{Translation}->{'Last update'} = 'Poslednje ažuriranje';
    $Self->{Translation}->{'FAQ Dynamic Fields'} = 'ČPP dinamička polja';

    # Perl Module: Kernel/Modules/AgentFAQRichText.pm
    $Self->{Translation}->{'No %s is given!'} = 'Nije dat %s!';
    $Self->{Translation}->{'Can\'t load LanguageObject!'} = 'Jezički objekt se ne može učitati!';

    # Perl Module: Kernel/Modules/AgentFAQSearch.pm
    $Self->{Translation}->{'No Result!'} = 'Nema rezultata!';
    $Self->{Translation}->{'FAQ Number'} = 'ČPP broj';
    $Self->{Translation}->{'Last Changed by'} = 'Poslednji je menjao';
    $Self->{Translation}->{'FAQ Item Create Time (before/after)'} = 'Vreme kreiranja ČPP stavke (pre/posle)';
    $Self->{Translation}->{'FAQ Item Create Time (between)'} = 'Vreme kreiranja ČPP stavke (između)';
    $Self->{Translation}->{'FAQ Item Change Time (before/after)'} = 'Vreme izmene ČPP stavke (pre/posle)';
    $Self->{Translation}->{'FAQ Item Change Time (between)'} = 'Vreme izmene ČPP stavke (između)';
    $Self->{Translation}->{'Equals'} = 'Jednako';
    $Self->{Translation}->{'Greater than'} = 'Veće od';
    $Self->{Translation}->{'Greater than equals'} = 'Jednako ili veće od';
    $Self->{Translation}->{'Smaller than'} = 'Manje od';
    $Self->{Translation}->{'Smaller than equals'} = 'Jednako ili manje od';

    # Perl Module: Kernel/Modules/AgentFAQZoom.pm
    $Self->{Translation}->{'Need FileID!'} = 'Potreban ID Polja!';
    $Self->{Translation}->{'Thanks for your vote!'} = 'Hvala na vašem glasu!';
    $Self->{Translation}->{'You have already voted!'} = 'Već ste glasali!';
    $Self->{Translation}->{'No rate selected!'} = 'Nije izabrana ni jedna ocena!';
    $Self->{Translation}->{'The voting mechanism is not enabled!'} = 'Mehanizam za glasanje nije aktiviran!';
    $Self->{Translation}->{'The vote rate is not defined!'} = 'Ocenjivanje glasanja nije definisano!';

    # Perl Module: Kernel/Modules/CustomerFAQPrint.pm
    $Self->{Translation}->{'FAQ Article Print'} = 'Štampa ČPP članka';

    # Perl Module: Kernel/Modules/CustomerFAQSearch.pm
    $Self->{Translation}->{'Created between'} = 'Kreiran između';

    # Perl Module: Kernel/Modules/CustomerFAQZoom.pm
    $Self->{Translation}->{'Need ItemID!'} = 'Potreban ID Stavke!';

    # Perl Module: Kernel/Modules/PublicFAQExplorer.pm
    $Self->{Translation}->{'FAQ Articles (new created)'} = 'ČPP članci (novi kreirani)';
    $Self->{Translation}->{'FAQ Articles (recently changed)'} = 'ČPP članci (nedavno menjani)';
    $Self->{Translation}->{'FAQ Articles (Top 10)'} = 'ČPP članci (prvih 10)';

    # Perl Module: Kernel/Modules/PublicFAQRSS.pm
    $Self->{Translation}->{'No Type is given!'} = 'Nije dat Tip!';
    $Self->{Translation}->{'Type must be either LastCreate or LastChange or Top10!'} = 'Type mora biti LastCreate, LastChange ili Top10!';
    $Self->{Translation}->{'Can\'t create RSS file!'} = 'RSS datoteka ne moće biti snimljena!';

    # Perl Module: Kernel/Output/HTML/HeaderMeta/AgentFAQSearch.pm
    $Self->{Translation}->{'%s (FAQFulltext)'} = '%s (ČPP kompletan tekst)';

    # Perl Module: Kernel/Output/HTML/HeaderMeta/CustomerFAQSearch.pm
    $Self->{Translation}->{'%s - Customer (%s)'} = '%s - Klijent (%s)';
    $Self->{Translation}->{'%s - Customer (FAQFulltext)'} = '%s - Klijent (ČPP kompletan tekst)';

    # Perl Module: Kernel/Output/HTML/HeaderMeta/PublicFAQSearch.pm
    $Self->{Translation}->{'%s - Public (%s)'} = '%s - Javno (%s)';
    $Self->{Translation}->{'%s - Public (FAQFulltext)'} = '%s - Javno (ČPP kompletan tekst)';

    # Perl Module: Kernel/Output/HTML/Layout/FAQ.pm
    $Self->{Translation}->{'Need rate!'} = 'Neophodna ocena!';
    $Self->{Translation}->{'This article is empty!'} = 'Članak je prazan!';
    $Self->{Translation}->{'Latest created FAQ articles'} = 'Poslednje kreirani ČPP članci';
    $Self->{Translation}->{'Latest updated FAQ articles'} = 'Poslednje ažurirani ČPP članci';
    $Self->{Translation}->{'Top 10 FAQ articles'} = 'Prvih 10 ČPP članaka';

    # Perl Module: Kernel/Output/HTML/LinkObject/FAQ.pm
    $Self->{Translation}->{'Content Type'} = 'Tip sadržaja';

    # Database XML Definition: FAQ.sopm
    $Self->{Translation}->{'internal'} = 'interno';
    $Self->{Translation}->{'external'} = 'eksterno';
    $Self->{Translation}->{'public'} = 'javno';

    # SysConfig
    $Self->{Translation}->{'A filter for HTML output to add links behind a defined string. The element Image allows two input kinds. First the name of an image (e.g. faq.png). In this case the OTRS image path will be used. The second possibility is to insert the link to the image.'} =
        'Filter za „HTML” izlaz za dodavanje veze iza definisanog niza znakova. Element Slika dozvoljava dva načina unosa. Prvi je naziv slike (npr faq.png). u ovom slučaju biće korišćena „OTRS” putanja do slike.  Druga mogućnost je unos veze do slike.';
    $Self->{Translation}->{'Add FAQ article'} = 'Dodaj ČPP članak';
    $Self->{Translation}->{'CSS color for the voting result.'} = '„CSS” boja za rezultat glasanja.';
    $Self->{Translation}->{'Cache Time To Leave for FAQ items.'} = 'Vreme oslobađanja keša za ČPP stavke.';
    $Self->{Translation}->{'Category Management'} = 'Upravljanje kategorijama';
    $Self->{Translation}->{'Customer FAQ Print.'} = 'Štampanje klijentskih ČPP.';
    $Self->{Translation}->{'Customer FAQ Zoom.'} = 'Detalji klijentskih ČPP.';
    $Self->{Translation}->{'Customer FAQ search.'} = 'Pretraga klijentskih ČPP.';
    $Self->{Translation}->{'Customer FAQ.'} = 'Klijentska ČPP.';
    $Self->{Translation}->{'CustomerFAQRelatedArticles.'} = 'CustomerFAQRelatedArticles.';
    $Self->{Translation}->{'Decimal places of the voting result.'} = 'Broj decimala u rezultatu glasanja.';
    $Self->{Translation}->{'Default category name.'} = 'Naziv podrazumevane kategorije.';
    $Self->{Translation}->{'Default language for FAQ articles on single language mode.'} = 'Podrazumevani jezik ČPP članaka u jednojezičkom načinu rada.';
    $Self->{Translation}->{'Default maximum size of the titles in a FAQ article to be shown.'} =
        'Podrazumevana maksimalna dužina naslova ČPP članka koja će biti prikazana.';
    $Self->{Translation}->{'Default priority of tickets for the approval of FAQ articles.'} =
        'Podrazumevani prioritet tiketa za odobravanje ČPP članaka.';
    $Self->{Translation}->{'Default state for FAQ entry.'} = 'Podrazumevano stanje ČPP unosa.';
    $Self->{Translation}->{'Default state of tickets for the approval of FAQ articles.'} = 'Podrazumevano stanje tiketa za odobravanje ČPP članaka.';
    $Self->{Translation}->{'Default type of tickets for the approval of FAQ articles.'} = 'Podrazumevani tip tiketa za odobravanje ČPP članaka.';
    $Self->{Translation}->{'Default value for the Action parameter for the public frontend. The Action parameter is used in the scripts of the system.'} =
        'Podrazumevana vrednost za „Action” parametar u javnom frontendu. Ovaj parametar koriste skripte sistema. ';
    $Self->{Translation}->{'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js and Core.Agent.LinkObject.js.'} =
        'Definiše Akcije gde je dugme postavki dostupno u povezanom grafičkom elementu objekta (LinkObject::ViewMode = "complex"). Molimo da imate na umu da ove Akcije moraju da budu registrovane u sledećim JS i CSS datotekama: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js i Core.Agent.LinkObject.js.';
    $Self->{Translation}->{'Define if the FAQ title should be concatenated to article subject.'} =
        'Određuje da li naslov ČPP treba da bude dodat na temu članka.';
    $Self->{Translation}->{'Define which columns are shown in the linked FAQs widget (LinkObject::ViewMode = "complex"). Note: Only FAQ attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default.'} =
        'Definiše koje kolone su prikazane u povezanom ČPP grafičkom elementu (LinkObject::ViewMode = "complex"). Napomena: Samo ČPP atributi i Dinamička polja (DynamicField_NameX) su dozvoljeni za podrazumevane kolone. Moguće postavke: 0 = onemogućeno, 1 = dostupno, 2 = podrazumevano aktivirano.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a FAQ journal.'} =
        'Definiše modul pregleda za mali prikaz ČPP dnevnika. ';
    $Self->{Translation}->{'Defines an overview module to show the small view of a FAQ list.'} =
        'Definiše modul pregleda za mali prikaz ČPP liste. ';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in a FAQ search of the agent interface.'} =
        'Definiše podrazumevani atribut za sortiranje ČPP u pretrazi ČPP  u interfejsu  operatera.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in a FAQ search of the customer interface.'} =
        'Definiše podrazumevani atribut za sortiranje ČPP u pretrazi ČPP  u interfejsu  korisnika.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in a FAQ search of the public interface.'} =
        'Definiše podrazumevani atribut za sortiranje ČPP u pretrazi ČPP  u javnom interfejsu.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in the FAQ Explorer of the agent interface.'} =
        'Definiše podrazumevani atribut za sortiranje ČPP u ČPP istraživaču u interfejsu operatera.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in the FAQ Explorer of the customer interface.'} =
        'Definiše podrazumevani atribut za sortiranje ČPP u ČPP istraživaču u interfejsu korisnika.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in the FAQ Explorer of the public interface.'} =
        'Definiše podrazumevani atribut za sortiranje ČPP u ČPP istraživaču u javnom interfejsu.';
    $Self->{Translation}->{'Defines the default FAQ order in the FAQ Explorer result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Definiše podrazumevani redosled ČPP u rezultatima ČPP istraživača  u interfejsu opreratera. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.';
    $Self->{Translation}->{'Defines the default FAQ order in the FAQ Explorer result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Definiše podrazumevani redosled ČPP u rezultatima ČPP istraživača u interfejsu korisnika. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.';
    $Self->{Translation}->{'Defines the default FAQ order in the FAQ Explorer result of the public interface. Up: oldest on top. Down: latest on top.'} =
        'Definiše podrazumevani redosled ČPP u rezultatima ČPP istraživača u javnom interfejsu. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.';
    $Self->{Translation}->{'Defines the default FAQ order of a search result in the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Definiše podrazumevani redosled ČPP u rezultatima pretrage u interfejsu opreratera. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.';
    $Self->{Translation}->{'Defines the default FAQ order of a search result in the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Definiše podrazumevani redosled ČPP u rezultatima pretrage u interfejsu korisnika. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.';
    $Self->{Translation}->{'Defines the default FAQ order of a search result in the public interface. Up: oldest on top. Down: latest on top.'} =
        'Definiše podrazumevani redosled ČPP u rezultatima pretrage u javnom interfejsu. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.';
    $Self->{Translation}->{'Defines the default shown FAQ search attribute for FAQ search screen.'} =
        'Definiše podrazumevani prikazani ČPP atribut pretrage za ČPP prozor za pretragu. ';
    $Self->{Translation}->{'Defines the information to be inserted in a FAQ based Ticket. "Full FAQ" includes text, attachments and inline images.'} =
        'Određuje informacije koje će biti ubačene u ČPP bazirani tiket. „Kompletan ČPP” uključuje tekst, priloge i umetnute slike.';
    $Self->{Translation}->{'Defines the parameters for the dashboard backend. "Limit" defines the number of entries displayed by default. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually.'} =
        'Definiše pozadinske parametre za kontrolnu tablu. "Limit" definiše broj podrezumevano prikazanih unosa. "Grupa" se koristi da ograniči pristup dodatku (npr. Grupa: admin;group1;group2;)."Podrazumevano" ukazuje na to da li je dodatak podrazumevano aktiviran ili da je potrebno da ga korisnik manuelno aktivira.';
    $Self->{Translation}->{'Defines the shown columns in the FAQ Explorer. This option has no effect on the position of the column.'} =
        'Definiše prikazane kolone u ČPP istraživaču. Ova opcije nema uticaj na pozicije kolona.';
    $Self->{Translation}->{'Defines the shown columns in the FAQ journal. This option has no effect on the position of the column.'} =
        'Definiše prikazane kolone u ČPP dnevniku. Ova opcije nema uticaj na pozicije kolona.';
    $Self->{Translation}->{'Defines the shown columns in the FAQ search. This option has no effect on the position of the column.'} =
        'Definiše prikazane kolone u ČPP pretrazi. Ova opcije nema uticaj na pozicije kolona.';
    $Self->{Translation}->{'Defines where the \'Insert FAQ\' link will be displayed.'} = 'Definiše gde će „ubaci ČPP” veza biti prikazana.';
    $Self->{Translation}->{'Definition of FAQ item free text field.'} = 'Definicija polja slobodnog teksta za ČPP stavku.';
    $Self->{Translation}->{'Delete this FAQ'} = 'Obriši ovo ČPP';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ add screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        'Dinamička polja prikazana na ekranu dodavanja ČPP u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i neophodno.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ edit screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        'Dinamička polja prikazana na ekranu izmene ČPP u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i neophodno.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ overview screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        'Dinamička polja prikazana na ekranu pregleda ČPP u interfejsu korisnika. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i neophodno.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ overview screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        'Dinamička polja prikazana na ekranu pregleda ČPP u javnom interfejsu. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i neophodno.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ print screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Dinamička polja prikazana na ekranu za štampu ČPP u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ print screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Dinamička polja prikazana na ekranu za štampu ČPP u interfejsu korisnika. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ print screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Dinamička polja prikazana na ekranu za štampu ČPP u javnom interfejsu. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ search screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and shown by default.'} =
        'Dinamička polja prikazana na ekranu pretrage ČPP u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i podrazumevano se prikazuje.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ search screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and shown by default.'} =
        'Dinamička polja prikazana na ekranu pretrage ČPP u interfejsu korisnika. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i podrazumevano se prikazuje.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ search screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and shown by default.'} =
        'Dinamička polja prikazana na ekranu pretrage ČPP u javnom interfejsu. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i podrazumevano se prikazuje.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ small format overview screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Dinamička polja prikazana na ekranu pregleda ČPP malog formata u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ zoom screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Dinamička polja prikazana na ekranu detaljnog pregleda ČPP u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ zoom screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Dinamička polja prikazana na ekranu detaljnog pregleda ČPP u interfejsu korisnika. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ zoom screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Dinamička polja prikazana na ekranu detaljnog pregleda ČPP u javnom interfejsu. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.';
    $Self->{Translation}->{'Edit this FAQ'} = 'Uredi ovo ČPP';
    $Self->{Translation}->{'Enable multiple languages on FAQ module.'} = 'Aktiviranje više jezika na ČPP modulu.';
    $Self->{Translation}->{'Enable the related article feature for the customer frontend.'} =
        'Aktivira funkciju povezanog članka za interfejs klijenta.';
    $Self->{Translation}->{'Enable voting mechanism on FAQ module.'} = 'Aktiviranje mehanizma za glasanje na ČPP modulu.';
    $Self->{Translation}->{'Explorer'} = 'Istraživač';
    $Self->{Translation}->{'FAQ AJAX Responder'} = 'ČPP „AJAX” odgovarač';
    $Self->{Translation}->{'FAQ AJAX Responder for Richtext.'} = 'ČPP „AJAX” odgovarač za „Richtext”.';
    $Self->{Translation}->{'FAQ Area'} = 'ČPP prostor';
    $Self->{Translation}->{'FAQ Area.'} = 'ČPP prostor.';
    $Self->{Translation}->{'FAQ Delete.'} = 'Obriši ČPP.';
    $Self->{Translation}->{'FAQ Edit.'} = 'Uredi ČPP.';
    $Self->{Translation}->{'FAQ Journal Overview "Small" Limit'} = 'Ograničenje pregleda ČPP dnevnika - "malo"';
    $Self->{Translation}->{'FAQ Overview "Small" Limit'} = 'Ograničenje pregleda ČPP - "malo"';
    $Self->{Translation}->{'FAQ Print.'} = 'Štampaj ČPP.';
    $Self->{Translation}->{'FAQ limit per page for FAQ Journal Overview "Small"'} = 'Ograničenje broja ČPP po strani za pregled ČPP dnevnika - "malo"';
    $Self->{Translation}->{'FAQ limit per page for FAQ Overview "Small"'} = 'Ograničenje broja ČPP po strani za pregled ČPP - "malo"';
    $Self->{Translation}->{'FAQ search backend router of the agent interface.'} = 'ČPPpretraga pozadinskog rutera u interfejsu operatera.';
    $Self->{Translation}->{'Field4'} = 'Polje4';
    $Self->{Translation}->{'Field5'} = 'Polje5';
    $Self->{Translation}->{'Full FAQ'} = 'Kompletan ČPP';
    $Self->{Translation}->{'Group for the approval of FAQ articles.'} = 'Grupa za odobravanje ČPP članaka.';
    $Self->{Translation}->{'History of this FAQ'} = 'Istorijat ovog ČPP';
    $Self->{Translation}->{'Include internal fields on a FAQ based Ticket.'} = 'Uključi interna polja u ČPP baziran tiket.';
    $Self->{Translation}->{'Include the name of each field in a FAQ based Ticket.'} = 'Uključi naziv svakog polja u ČPP baziran tiket.';
    $Self->{Translation}->{'Interfaces where the quick search should be shown.'} = 'Interfejs na kom treba prikazati brzu pretragu.';
    $Self->{Translation}->{'Journal'} = 'Dnevnik';
    $Self->{Translation}->{'Language Management'} = 'Upravljanje jezicima';
    $Self->{Translation}->{'Limit for the search to build the keyword FAQ article list.'} = 'Ograničenje pretrage za generisanje liste ključnih reči ČPP članaka.';
    $Self->{Translation}->{'Link another object to this FAQ item'} = 'Poveži drugi objekat sa ovom stavkom ČPP';
    $Self->{Translation}->{'List of queue names for which the related article feature is enabled.'} =
        'Lista imena redova za koje je funcija povezanog članka aktivirana.';
    $Self->{Translation}->{'List of state types which can be used in the agent interface.'} =
        'Lista tipova stanja koji se mogu koristiti u interfejsu operatera.';
    $Self->{Translation}->{'List of state types which can be used in the customer interface.'} =
        'Lista tipova stanja koji se mogu koristiti u interfejsu korisnika.';
    $Self->{Translation}->{'List of state types which can be used in the public interface.'} =
        'Lista tipova stanja koji se mogu koristiti u javnom interfejsu.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ Explorer result of the agent interface.'} =
        'Maksimalni broj ČPP članaka koji će biti prikazani u rezultatu ČPP istraživača u interfejsu operatera.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ Explorer result of the customer interface.'} =
        'Maksimalni broj ČPP članaka koji će biti prikazani u rezultatu ČPP istraživača u interfejsu korisnika.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ Explorer result of the public interface.'} =
        'Maksimalni broj ČPP članaka koji će biti prikazani u rezultatu ČPP istraživača u javnom interfejsu.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ journal in the agent interface.'} =
        'Maksimalni broj ČPP članaka koji će biti prikazani u ČPP dnevniku u interfejsu operatera.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the result of a search in the agent interface.'} =
        'Maksimalni broj ČPP članaka koji će biti prikazani u rezultatu pretrage u interfejsu operatera.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the result of a search in the customer interface.'} =
        'Maksimalni broj ČPP članaka koji će biti prikazani u rezultatu pretrage u interfejsu korisnika.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the result of a search in the public interface.'} =
        'Maksimalni broj ČPP članaka koji će biti prikazani u rezultatu pretrage u javnom interfejsu.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Explorer in the agent interface.'} =
        'Maksimalna dužina naslova u ČPP članaku koji će biti prikazani u ČPP istraživaču u interfejsu operatera.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Explorer in the customer interface.'} =
        'Maksimalna dužina naslova u ČPP članaku koji će biti prikazani u ČPP istraživaču u interfejsu klijenta.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Explorer in the public interface.'} =
        'Maksimalna dužina naslova u ČPP članaku koji će biti prikazani u ČPP istraživaču u javnom interfejsu.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Search in the agent interface.'} =
        'Maksimalna dužina naslova u ČPP članaku koji će biti prikazani u ČPP pretrazi u interfejsu operatera.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Search in the customer interface.'} =
        'Maksimalna dužina naslova u ČPP članaku koji će biti prikazani u ČPP pretrazi u interfejsu klijenta.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Search in the public interface.'} =
        'Maksimalna dužina naslova u ČPP članaku koji će biti prikazani u ČPP pretrazi u javnom interfejsu.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ journal in the agent interface.'} =
        'Maksimalna dužina naslova u ČPP članaku koji će biti prikazani u ČPP dnevniku u interfejsu operatera.';
    $Self->{Translation}->{'Module to generate HTML OpenSearch profile for short FAQ search in the customer interface.'} =
        'Modul za generisanje „HTML OpenSearch” profila za kratku ČPP pretragu u interfejsu klijenta.';
    $Self->{Translation}->{'Module to generate HTML OpenSearch profile for short FAQ search in the public interface.'} =
        'Modul za generisanje „HTML OpenSearch” profila za kratku ČPP pretragu u javnom profilu.';
    $Self->{Translation}->{'Module to generate html OpenSearch profile for short FAQ search.'} =
        'Modul za generisanje „html OpenSearch” profila za kratku ČPP pretragu.';
    $Self->{Translation}->{'New FAQ Article'} = 'Novi ČPP članak';
    $Self->{Translation}->{'New FAQ articles need approval before they get published.'} = 'Novi ČPP članci trebaju biti odobreni pre objavljivanja.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed in the FAQ Explorer of the customer interface.'} =
        'Broj ČPP članaka koji će biti prikazani u ČPP Istraživaču u interfejsu klijenta.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed in the FAQ Explorer of the public interface.'} =
        'Broj ČPP članaka koji će biti prikazani u ČPP Istraživaču u javnom interfejsu.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed on each page of a search result in the customer interface.'} =
        'Broj ČPP članaka koji će biti prikazani na svakoj strani rezultata pretrage u interfejsu klijenta.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed on each page of a search result in the public interface.'} =
        'Broj ČPP članaka koji će biti prikazani na svakoj strani rezultata pretrage u javnom interfejsu.';
    $Self->{Translation}->{'Number of shown items in last changes.'} = 'Broj prikazanih stavki u poslednjim izmenama.';
    $Self->{Translation}->{'Number of shown items in last created.'} = 'Broj prikazanih stavki u poslednje kreiranim.';
    $Self->{Translation}->{'Number of shown items in the top 10 feature.'} = 'Broj prikazanih stavki u "prvih 10" .';
    $Self->{Translation}->{'Output filter to add Java-script to CustomerTicketMessage screen.'} =
        'Izlazni filter za ubacivanje JavaScript u CustomerTicketMessage ekran.';
    $Self->{Translation}->{'Output limit for the related FAQ articles.'} = 'Ograničenje izlaza za povezane ČPP članake.';
    $Self->{Translation}->{'Parameters for the pages (in which the FAQ items are shown) of the small FAQ journal overview.'} =
        'Parametri stranica (na kojima su ČPP stavke prikazane) na malom prikazu pregleda ČPP dnevnika.';
    $Self->{Translation}->{'Parameters for the pages (in which the FAQ items are shown) of the small FAQ overview.'} =
        'Parametri stranica (na kojima su vidljive ČPP stavke) smanjenog pregleda ČPP.';
    $Self->{Translation}->{'Print this FAQ'} = 'Štampaj ovo ČPP';
    $Self->{Translation}->{'Public FAQ Print.'} = 'Štampanje javnih ČPP.';
    $Self->{Translation}->{'Public FAQ Zoom.'} = 'Detalji javnih ČPP.';
    $Self->{Translation}->{'Public FAQ search.'} = 'Pretraga javnih ČPP.';
    $Self->{Translation}->{'Public FAQ.'} = 'Javno ČPP.';
    $Self->{Translation}->{'Queue for the approval of FAQ articles.'} = 'Red za odobravanje ČPP članaka.';
    $Self->{Translation}->{'Rates for voting. Key must be in percent.'} = 'Ocene za glasanje. Ključ mora biti u procentima.';
    $Self->{Translation}->{'S'} = 'S';
    $Self->{Translation}->{'Search FAQ'} = 'Pretraži ČPP';
    $Self->{Translation}->{'Select how many items should be shown in Journal Overview "Small" by default.'} =
        '';
    $Self->{Translation}->{'Select how many items should be shown in Overview "Small" by default.'} =
        '';
    $Self->{Translation}->{'Set the default height (in pixels) of inline HTML fields in AgentFAQZoom.'} =
        'Podesi podrazumevanu visinu (u pikselima) inline HTML polja u AgentFAQZoom.';
    $Self->{Translation}->{'Set the default height (in pixels) of inline HTML fields in CustomerFAQZoom (and PublicFAQZoom).'} =
        'Podesi podrazumevanu visinu (u pikselima) inline HTML polja u CustomerFAQZoom (i PublicFAQZoom).';
    $Self->{Translation}->{'Set the maximum height (in pixels) of inline HTML fields in AgentFAQZoom.'} =
        'Podesi maksimalnu visinu (u pikselima) inline HTML polja u AgentFAQZoom.';
    $Self->{Translation}->{'Set the maximum height (in pixels) of inline HTML fields in CustomerFAQZoom (and PublicFAQZoom).'} =
        'Podesi maksimalnu visinu (u pikselima) inline HTML polja u CustomerFAQZoom (i PublicFAQZoom).';
    $Self->{Translation}->{'Show "Insert FAQ Link" Button in AgentFAQZoomSmall for public FAQ Articles.'} =
        'Prikaži "Ubaci ČPP link" dugme u AgentFAQZoomSmall za javne ČPP artikle.';
    $Self->{Translation}->{'Show "Insert FAQ Text & Link" / "Insert Full FAQ & Link" Button in AgentFAQZoomSmall for public FAQ Articles.'} =
        'Prikaži "Ubaci ČPP Tekst i Link" / "Ubaci Ceo ČPP i Link" dugme u AgentFAQZoomSmall za javne ČPP artikle.';
    $Self->{Translation}->{'Show "Insert FAQ Text" / "Insert Full FAQ" Button in AgentFAQZoomSmall.'} =
        'Prikaži "Ubaci ČPP tekst" / "Ubaci Ceo ČPP" dugme u AgentFAQZoomSmall.';
    $Self->{Translation}->{'Show FAQ Article with HTML.'} = 'Prikaz ČPP članka kao „HTML”.';
    $Self->{Translation}->{'Show FAQ path yes/no.'} = 'Prikaži putanju do ČPP da/ne.';
    $Self->{Translation}->{'Show invalid items in the FAQ Explorer result of the agent interface.'} =
        'Prikaz neisprvnih stavki u rezultatima ČPP istraživača na interfejsu operatera';
    $Self->{Translation}->{'Show items of subcategories.'} = 'Prikaži stavke subkategorija.';
    $Self->{Translation}->{'Show last change items in defined interfaces.'} = 'Prikaži zadnje promenjene stavke u definisanim interfejsima.';
    $Self->{Translation}->{'Show last created items in defined interfaces.'} = 'Prikaži zadnje kreirane stavke u definisanim interfejsima.';
    $Self->{Translation}->{'Show the stars for the articles with a rating equal or greater like the defined value (set value \'0\' to deactive the output).'} =
        'Prikaži zvezdice za članke sa jednakom ili boljom ocenom od određene vrednosti (postavi vrednost 0 za deaktiviranje izlaza).';
    $Self->{Translation}->{'Show top 10 items in defined interfaces.'} = 'Prikaži prvih 10 stavki u definisanim interfejsima.';
    $Self->{Translation}->{'Show voting in defined interfaces.'} = 'Prikaži glasanje u definisanim interfejsima.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a FAQ with another object in the zoom view of such FAQ of the agent interface.'} =
        'U meniju prikazuje vezu koja omogićava povezivanje ČPP sa drugim objektom u detaljnom prikazu tog ČPP u operaterskom interfejsu.';
    $Self->{Translation}->{'Shows a link in the menu that allows to delete a FAQ in its zoom view in the agent interface.'} =
        'U meniju prikazuje vezu koja omogićava brisanje ČPP u detaljnom prikazu operaterskog interfejsa.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a FAQ in its zoom view of the agent interface.'} =
        'U meniju prikazuje vezu za pristup istorijatu ČPP u detaljnom prikazu operaterskog interfejsa.';
    $Self->{Translation}->{'Shows a link in the menu to edit a FAQ in the its zoom view of the agent interface.'} =
        'U meniju prikazuje vezu za izmenu ČPP u detaljnom prikazu operaterskog interfejsa.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the FAQ zoom view of the agent interface.'} =
        'U meniju prikazuje vezu za povratak u detaljni prikaz ČPP u operaterskom interfejsu.';
    $Self->{Translation}->{'Shows a link in the menu to print a FAQ in the its zoom view of the agent interface.'} =
        'U meniju prikazuje vezu za štampanje ČPP u detaljnom prikazu operaterskog interfejsa.';
    $Self->{Translation}->{'Solution'} = 'Rešenje';
    $Self->{Translation}->{'Symptom'} = 'Simptom';
    $Self->{Translation}->{'Text Only'} = 'Samo tekst';
    $Self->{Translation}->{'The default languages for the related FAQ articles.'} = 'Podrazumevani jezici za povezane ČPP članake.';
    $Self->{Translation}->{'The identifier for a FAQ, e.g. FAQ#, KB#, MyFAQ#. The default is FAQ#.'} =
        'Identifikator za ČPP, npr ČPP#, BZ#, MojČPP#. Podrazumevano je ČPP#.';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'FAQ\' objects using the \'Normal\' link type.'} =
        'Ovo podešavanje definiše da ČPP objekt može da se poveže sa drugim ČPP objektima koristeći „normalnu” vezu.';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'FAQ\' objects using the \'ParentChild\' link type.'} =
        'Ovo podešavanje definiše da ČPP objekt može da se poveže sa drugim ČPP objektima koristeći vezu tipa „roditelj/potomak”.';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'Ticket\' objects using the \'Normal\' link type.'} =
        'Ovo podešavanje definiše da ČPP objekt može da se poveže sa drugim tiket objektima koristeći „normalnu” vezu.';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'Ticket\' objects using the \'ParentChild\' link type.'} =
        'Ovo podešavanje definiše da ČPP objekt može da se poveže sa drugim tiket objektima koristeći vezu tipa „roditelj/potomak”.';
    $Self->{Translation}->{'Ticket body for approval of FAQ article.'} = 'Sadržaj tiketa za odobravanje ČPP članaka.';
    $Self->{Translation}->{'Ticket subject for approval of FAQ article.'} = 'Predmet tiketa za odobravanje ČPP članaka.';
    $Self->{Translation}->{'Toolbar Item for a shortcut.'} = 'Stavka alatne linije za skraćenicu.';
    $Self->{Translation}->{'external (customer)'} = 'eksterno (klijent)';
    $Self->{Translation}->{'internal (agent)'} = 'interno (operater)';
    $Self->{Translation}->{'public (public)'} = 'javno (javno)';

}

1;
