# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Language::sr_Cyrl_FAQ;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AAAFAQ
    $Self->{Translation}->{'internal'} = 'интерно';
    $Self->{Translation}->{'public'} = 'јавно';
    $Self->{Translation}->{'external'} = 'екстерно';
    $Self->{Translation}->{'FAQ Number'} = 'ЧПП број';
    $Self->{Translation}->{'Latest updated FAQ articles'} = 'Последње ажурирани ЧПП чланци';
    $Self->{Translation}->{'Latest created FAQ articles'} = 'Последње креирани ЧПП чланци';
    $Self->{Translation}->{'Top 10 FAQ articles'} = 'Првих 10 ЧПП чланака';
    $Self->{Translation}->{'Subcategory of'} = 'Подкатегорија од';
    $Self->{Translation}->{'No rate selected!'} = 'Није изабрана ни једна оцена!';
    $Self->{Translation}->{'Explorer'} = 'Истраживач';
    $Self->{Translation}->{'public (all)'} = 'јавно (све)';
    $Self->{Translation}->{'external (customer)'} = 'екстерно (клијент)';
    $Self->{Translation}->{'internal (agent)'} = 'интерно (оператер)';
    $Self->{Translation}->{'Start day'} = 'Дан почетка';
    $Self->{Translation}->{'Start month'} = 'Месец почетка';
    $Self->{Translation}->{'Start year'} = 'Година почетка';
    $Self->{Translation}->{'End day'} = 'Дан завршетка';
    $Self->{Translation}->{'End month'} = 'Месец завршетка';
    $Self->{Translation}->{'End year'} = 'Година завршетка';
    $Self->{Translation}->{'Thanks for your vote!'} = 'Хвала на вашем гласу!';
    $Self->{Translation}->{'You have already voted!'} = 'Већ сте гласали!';
    $Self->{Translation}->{'FAQ Article Print'} = 'Штампа ЧПП чланка';
    $Self->{Translation}->{'FAQ Articles (Top 10)'} = 'ЧПП чланци (првих 10)';
    $Self->{Translation}->{'FAQ Articles (new created)'} = 'ЧПП чланци (новокреирани)';
    $Self->{Translation}->{'FAQ Articles (recently changed)'} = 'ЧПП чланци (недавно мењани)';
    $Self->{Translation}->{'FAQ category updated!'} = 'ЧПП категорија ажурирана!';
    $Self->{Translation}->{'FAQ category added!'} = 'ЧПП категорија додата!';
    $Self->{Translation}->{'A category should have a name!'} = 'Категорија треба да има име!';
    $Self->{Translation}->{'This category already exists'} = 'Ова категорија већ постоји';
    $Self->{Translation}->{'FAQ language added!'} = 'Додат ЧПП језик!';
    $Self->{Translation}->{'FAQ language updated!'} = 'Ажуриран ЧПП језик!';
    $Self->{Translation}->{'The name is required!'} = 'Име је обавезно!';
    $Self->{Translation}->{'This language already exists!'} = 'Овај језик већ постоји!';
    $Self->{Translation}->{'Symptom'} = 'Симптом';
    $Self->{Translation}->{'Solution'} = 'Решење';

    # Template: AgentFAQAdd
    $Self->{Translation}->{'Add FAQ Article'} = 'Додај ЧПП чланак';
    $Self->{Translation}->{'Keywords'} = 'Кључне речи';
    $Self->{Translation}->{'A category is required.'} = 'Категорија је обавезна.';
    $Self->{Translation}->{'Approval'} = 'Одобрење';

    # Template: AgentFAQCategory
    $Self->{Translation}->{'FAQ Category Management'} = 'Управљање ЧПП категоријама';
    $Self->{Translation}->{'Add category'} = 'Додај категорију';
    $Self->{Translation}->{'Delete Category'} = 'Обриши категорију';
    $Self->{Translation}->{'Ok'} = 'У реду';
    $Self->{Translation}->{'Add Category'} = 'Додај категорију';
    $Self->{Translation}->{'Edit Category'} = 'Измени категорију';
    $Self->{Translation}->{'Please select at least one permission group.'} = 'Молимо да изаберете бар једну групу дозвола.';
    $Self->{Translation}->{'Agent groups that can access articles in this category.'} = 'Групе оператера које могу приступити чланцима у овој категорији.';
    $Self->{Translation}->{'Will be shown as comment in Explorer.'} = 'Биће приказано као коментар у Истраживачу.';
    $Self->{Translation}->{'Do you really want to delete this category?'} = 'Да ли стварно желите да обришете ову категорију?';
    $Self->{Translation}->{'You can not delete this category. It is used in at least one FAQ article and/or is parent of at least one other category'} =
        'Не можете обрисати овау категорију. Употребљена је у бар једном ЧПП чланку и/или је родитељ најмање једној другој категорији';
    $Self->{Translation}->{'This category is used in the following FAQ article(s)'} = 'Ова категорија је употребљена у следећим ЧПП чланцима';
    $Self->{Translation}->{'This category is parent of the following subcategories'} = 'Ова категорија је родитељ следећим подкатегоријама';

    # Template: AgentFAQDelete
    $Self->{Translation}->{'Do you really want to delete this FAQ article?'} = 'Да ли стварно желите да обришете овај ЧПП чланак?';

    # Template: AgentFAQEdit
    $Self->{Translation}->{'FAQ'} = 'ЧПП';

    # Template: AgentFAQExplorer
    $Self->{Translation}->{'FAQ Explorer'} = 'ЧПП Истраживач';
    $Self->{Translation}->{'Quick Search'} = 'Брзо тражење';
    $Self->{Translation}->{'Wildcards are allowed.'} = 'Џокерски знаци су дозвољени.';
    $Self->{Translation}->{'Advanced Search'} = 'Напредна претрага';
    $Self->{Translation}->{'Subcategories'} = 'Подкатегорије';
    $Self->{Translation}->{'FAQ Articles'} = 'ЧПП чланци';
    $Self->{Translation}->{'No subcategories found.'} = 'Подкатегорије нису пронађене.';

    # Template: AgentFAQJournalOverviewSmall
    $Self->{Translation}->{'No FAQ Journal data found.'} = 'Нису пронађени подаци ЧПП дневника.';

    # Template: AgentFAQLanguage
    $Self->{Translation}->{'FAQ Language Management'} = 'Управљање ЧПП језицима';
    $Self->{Translation}->{'Use this feature if you want to work with multiple languges.'} =
        'Употребите ову функцију ако желите да користите више језика.';
    $Self->{Translation}->{'Add language'} = 'Додај језик';
    $Self->{Translation}->{'Delete Language %s'} = 'Обриши језик %s';
    $Self->{Translation}->{'Add Language'} = 'Додај Језик';
    $Self->{Translation}->{'Edit Language'} = 'Уреди Језик';
    $Self->{Translation}->{'Do you really want to delete this language?'} = 'Да ли заиста желите да избришете овај језик?';
    $Self->{Translation}->{'You can not delete this language. It is used in at least one FAQ article!'} =
        'Не можете обрисати овај језик. Употребљен је у бар једном ЧПП чланку!';
    $Self->{Translation}->{'This language is used in the following FAQ Article(s)'} = 'Овај језик је употребљен у следећим ЧПП чланцима';

    # Template: AgentFAQOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Подешавање контекста';
    $Self->{Translation}->{'FAQ articles per page'} = 'ЧПП чланака по страни';

    # Template: AgentFAQOverviewSmall
    $Self->{Translation}->{'No FAQ data found.'} = 'Нису пронађени ЧПП подаци.';

    # Template: AgentFAQPrint
    $Self->{Translation}->{'FAQ-Info'} = 'ЧПП-инфо';
    $Self->{Translation}->{'Votes'} = 'Гласови';
    $Self->{Translation}->{'Last update'} = 'Последње ажурирање';

    # Template: AgentFAQSearch
    $Self->{Translation}->{'Keyword'} = 'Кључна реч';
    $Self->{Translation}->{'Vote (e. g. Equals 10 or GreaterThan 60)'} = 'Гласај (нпр једнако 10 или веће од 60)';
    $Self->{Translation}->{'Rate (e. g. Equals 25% or GreaterThan 75%)'} = 'Оцени (нпр једнако 25% или веће од 75%)';
    $Self->{Translation}->{'Approved'} = 'Одобрено';
    $Self->{Translation}->{'Last changed by'} = 'Последњи је мењао';
    $Self->{Translation}->{'FAQ Article Create Time (before/after)'} = 'Време креирања ЧПП чланка (пре/после)';
    $Self->{Translation}->{'FAQ Article Create Time (between)'} = 'Време креирања ЧПП чланка (између)';
    $Self->{Translation}->{'FAQ Article Change Time (before/after)'} = 'Време промене ЧПП чланка (пре/после)';
    $Self->{Translation}->{'FAQ Article Change Time (between)'} = 'Време промене ЧПП чланка (између)';

    # Template: AgentFAQSearchOpenSearchDescriptionFulltext
    $Self->{Translation}->{'FAQFulltext'} = 'ЧПП комплетан текст';

    # Template: AgentFAQSearchSmall
    $Self->{Translation}->{'FAQ Search'} = 'ЧПП претрага';
    $Self->{Translation}->{'Profile Selection'} = 'Избор профила';
    $Self->{Translation}->{'Vote'} = 'Глас';
    $Self->{Translation}->{'No vote settings'} = 'Нема подешавања за гласање';
    $Self->{Translation}->{'Specific votes'} = 'Специфични гласови';
    $Self->{Translation}->{'e. g. Equals 10 or GreaterThan 60'} = 'нпр једнако 10 или веће од 60';
    $Self->{Translation}->{'Rate'} = 'Оцена';
    $Self->{Translation}->{'No rate settings'} = 'Нема подешавања за оцењивање';
    $Self->{Translation}->{'Specific rate'} = 'Специфична оцена';
    $Self->{Translation}->{'e. g. Equals 25% or GreaterThan 75%'} = 'нпр једнако 25% или веће од 75%';
    $Self->{Translation}->{'FAQ Article Create Time'} = 'Време креирања ЧПП чланка';
    $Self->{Translation}->{'Specific date'} = 'Специфичан датум';
    $Self->{Translation}->{'Date range'} = 'Распон датума';
    $Self->{Translation}->{'FAQ Article Change Time'} = 'Време промене ЧПП чланка';

    # Template: AgentFAQZoom
    $Self->{Translation}->{'FAQ Information'} = 'ЧПП информација';
    $Self->{Translation}->{'Rating'} = 'Оцењивање';
    $Self->{Translation}->{'out of 5'} = 'од 5';
    $Self->{Translation}->{'No votes found!'} = 'Гласови нису пронађени!';
    $Self->{Translation}->{'No votes found! Be the first one to rate this FAQ article.'} = 'Гласови нису пронађени! Будите први који ће оценити овај ЧПП чланак!';
    $Self->{Translation}->{'Download Attachment'} = 'Преузми прилог';
    $Self->{Translation}->{'To open links in the following description blocks, you might need to press Ctrl or Cmd or Shift key while clicking the link (depending on your browser and OS).'} =
        'Да бисте отворили везе у следећим блоковима описа, можда ћете требати да притиснете „Ctrl” или „Cmd” или „Shift” тастер док истовремено кликнете на везу (зависи од вашег ОС и прегледача).';
    $Self->{Translation}->{'How helpful was this article? Please give us your rating and help to improve the FAQ Database. Thank You!'} =
        'Колико је користан овај чланак? Молимо вас да дате вашу оцену и помогнете подизању квалитата базе често постављаних питања. Хвала Вам! ';
    $Self->{Translation}->{'not helpful'} = 'није корисно';
    $Self->{Translation}->{'very helpful'} = 'врло корисно';

    # Template: AgentFAQZoomSmall
    $Self->{Translation}->{'Add FAQ title to article subject'} = 'Додај ЧПП чланку наслов';
    $Self->{Translation}->{'Insert FAQ Text'} = 'Унеси ЧПП текст';
    $Self->{Translation}->{'Insert Full FAQ'} = 'Унеси комплетан ЧПП';
    $Self->{Translation}->{'Insert FAQ Link'} = 'Унеси ЧПП везу';
    $Self->{Translation}->{'Insert FAQ Text & Link'} = 'Унеси ЧПП текст и везу';
    $Self->{Translation}->{'Insert Full FAQ & Link'} = 'Унеси комплетан ЧПП и везу';

    # Template: CustomerFAQExplorer
    $Self->{Translation}->{'No FAQ articles found.'} = 'Нису пронађени ЧПП чланци.';

    # Template: CustomerFAQSearch
    $Self->{Translation}->{'Fulltext search in FAQ articles (e. g. "John*n" or "Will*")'} = 'Потпуна текстуална претрага у ЧПП чланцима (нпр. "John*n" или "Will*")';
    $Self->{Translation}->{'Vote restrictions'} = 'Огранјчења гласања';
    $Self->{Translation}->{'Only FAQ articles with votes...'} = 'Само ЧПП чланци са гласовима...';
    $Self->{Translation}->{'Rate restrictions'} = 'Ограничења оцењивања';
    $Self->{Translation}->{'Only FAQ articles with rate...'} = 'Само ЧПП чланци са оценом...';
    $Self->{Translation}->{'Only FAQ articles created'} = 'Само ЧПП чланци креирани';
    $Self->{Translation}->{'Only FAQ articles created between'} = 'Само ЧПП чланци креирани између';
    $Self->{Translation}->{'Search-Profile as Template?'} = 'Профил претраге као шаблон?';

    # Template: CustomerFAQZoom
    $Self->{Translation}->{'Article Number'} = 'Број чланка';
    $Self->{Translation}->{'Search for articles with keyword'} = 'Тражи чланке са кључном речи';

    # Template: PublicFAQSearchOpenSearchDescriptionFAQNumber
    $Self->{Translation}->{'Public'} = 'Јавно';

    # Template: PublicFAQSearchResultShort
    $Self->{Translation}->{'Back to FAQ Explorer'} = 'Нназад на ЧПП Истраживач';

    # SysConfig
    $Self->{Translation}->{'A filter for HTML output to add links behind a defined string. The element Image allows two input kinds. First the name of an image (e.g. faq.png). In this case the OTRS image path will be used. The second possibility is to insert the link to the image.'} =
        'Филтер за „HTML” излаз за додавање везе иза дефинисаног низа знакова. Елемент слика дозвољава два начина уноса. Први је назив слике (нпр faq.png). у овом случају биће коришћена „OTRS” путања до слике.  Друга могућност је унос везе до слике.';
    $Self->{Translation}->{'CSS color for the voting result.'} = 'CSS боја за резултат гласања.';
    $Self->{Translation}->{'Cache Time To Leave for FAQ items.'} = '';
    $Self->{Translation}->{'Category Management'} = 'Управљање категоријама';
    $Self->{Translation}->{'Decimal places of the voting result.'} = 'Број децимала у резултату гласања.';
    $Self->{Translation}->{'Default category name.'} = 'Назив подразумеване категорије.';
    $Self->{Translation}->{'Default language for FAQ articles on single language mode.'} = 'Подразумевани језик ЧПП чланака у једнојезичком начину рада.';
    $Self->{Translation}->{'Default maximum size of the titles in a FAQ article to be shown.'} =
        'Подразумевана максимална дужина наслова ЧПП чланка која ће бити приказана.';
    $Self->{Translation}->{'Default priority of tickets for the approval of FAQ articles.'} =
        'Подразумевани приоритет тикета за одобравање ЧПП чланака.';
    $Self->{Translation}->{'Default state for FAQ entry.'} = 'Подразумевани статус ЧПП уноса.';
    $Self->{Translation}->{'Default state of tickets for the approval of FAQ articles.'} = 'Подразумевано стање тикета за одобравање ЧПП чланака.';
    $Self->{Translation}->{'Default type of tickets for the approval of FAQ articles.'} = 'Подразумевани тип тикета за одобравање ЧПП чланака.';
    $Self->{Translation}->{'Default value for the Action parameter for the public frontend. The Action parameter is used in the scripts of the system.'} =
        'Подразумевана вредност за Action параметар у јавном фронтенду. Овај параметар користе скрипте система. ';
    $Self->{Translation}->{'Define if the FAQ title should be concatenated to article subject.'} =
        'Одређује да ли наслов ЧПП треба да буде додат на тему чланка.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a FAQ journal.'} =
        'Дефинише модул прегледа за мали приказ ЧПП дневника. ';
    $Self->{Translation}->{'Defines an overview module to show the small view of a FAQ list.'} =
        'Дефинише модул прегледа за мали приказ ЧПП листе. ';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in a FAQ search of the agent interface.'} =
        'Дефинише подразумевани атрибут за сортирање ЧПП у претрази ЧПП  у интерфејсу  оператера.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in a FAQ search of the customer interface.'} =
        'Дефинише подразумевани атрибут за сортирање ЧПП у претрази ЧПП  у интерфејсу  корисника.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in a FAQ search of the public interface.'} =
        'Дефинише подразумевани атрибут за сортирање ЧПП у претрази ЧПП  у јавном интерфејсу.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in the FAQ Explorer of the agent interface.'} =
        'Дефинише подразумевани атрибут за сортирање ЧПП у ЧПП истраживачу у интерфејсу оператера.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in the FAQ Explorer of the customer interface.'} =
        'Дефинише подразумевани атрибут за сортирање ЧПП у ЧПП истраживачу у интерфејсу корисника.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in the FAQ Explorer of the public interface.'} =
        'Дефинише подразумевани атрибут за сортирање ЧПП у ЧПП истраживачу у јавном интерфејсу.';
    $Self->{Translation}->{'Defines the default FAQ order in the FAQ Explorer result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Дефинише подразумевани редослед ЧПП у резултатима ЧПП истраживача  у интерфејсу опрератера. Горе: Најстарији на врху. Доле: Најновије на врху.';
    $Self->{Translation}->{'Defines the default FAQ order in the FAQ Explorer result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Дефинише подразумевани редослед ЧПП у резултатима ЧПП истраживача у интерфејсу корисника. Горе: Најстарији на врху. Доле: Најновије на врху.';
    $Self->{Translation}->{'Defines the default FAQ order in the FAQ Explorer result of the public interface. Up: oldest on top. Down: latest on top.'} =
        'Дефинише подразумевани редослед ЧПП у резултатима ЧПП истраживача у јавном интерфејсу. Горе: Најстарији на врху. Доле: Најновије на врху.';
    $Self->{Translation}->{'Defines the default FAQ order of a search result in the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Дефинише подразумевани редослед ЧПП у резултатима претраге у интерфејсу опрератера. Горе: Најстарији на врху. Доле: Најновије на врху.';
    $Self->{Translation}->{'Defines the default FAQ order of a search result in the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Дефинише подразумевани редослед ЧПП у резултатима претраге у интерфејсу корисника. Горе: Најстарији на врху. Доле: Најновије на врху.';
    $Self->{Translation}->{'Defines the default FAQ order of a search result in the public interface. Up: oldest on top. Down: latest on top.'} =
        'Дефинише подразумевани редослед ЧПП у резултатима претраге у јавном интерфејсу. Горе: Најстарији на врху. Доле: Најновије на врху.';
    $Self->{Translation}->{'Defines the default shown FAQ search attribute for FAQ search screen.'} =
        'Дефинише подразумевани приказани ЧПП атрибут претраге за ЧПП прозор за претрагу. ';
    $Self->{Translation}->{'Defines the information to be inserted in a FAQ based Ticket. "Full FAQ" includes text, attachments and inline images.'} =
        'Одређује информације које ће бити убачене у ЧПП базирани тикет. „Комплетан ЧПП” укључује текст, прилоге и уметнуте слике.';
    $Self->{Translation}->{'Defines the parameters for the dashboard backend. "Limit" defines the number of entries displayed by default. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually.'} =
        'Дефинише позадинске параметре за контролну таблу. "Лимит" дефинише број подрезумевано приказаних уноса. "Група" се користи да ограничи приступ додатку (нпр. Група: admin;group1;group2;)."Подразумевано" указује на то да ли је додатак подразумевано активиран или да је потребно да га корисник мануелно активира.';
    $Self->{Translation}->{'Defines the shown columns in the FAQ Explorer. This option has no effect on the position of the column.'} =
        'Дефинише приказане колоне у ЧПП истраживачу. Ова опције нема утицај на позиције колона.';
    $Self->{Translation}->{'Defines the shown columns in the FAQ journal. This option has no effect on the position of the column.'} =
        'Дефинише приказане колоне у ЧПП дневнику. Ова опције нема утицај на позиције колона.';
    $Self->{Translation}->{'Defines the shown columns in the FAQ search. This option has no effect on the position of the column.'} =
        'Дефинише приказане колоне у ЧПП претрази. Ова опције нема утицај на позиције колона.';
    $Self->{Translation}->{'Defines where the \'Insert FAQ\' link will be displayed.'} = 'Дефинише где ће „убаци ЧПП” веза бити приказана.';
    $Self->{Translation}->{'Definition of FAQ item free text field.'} = 'Дефиниција поља слободног текста за ЧПП ставку.';
    $Self->{Translation}->{'Delete this FAQ'} = 'Обриши ово ЧПП';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ add screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        'Динамичка поља приказана на екрану додавања ЧПП у интерфејсу оператера. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено, 2 = Омогућено и неопходно.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ edit screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        'Динамичка поља приказана на екрану измене ЧПП у интерфејсу оператера. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено, 2 = Омогућено и неопходно.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ overview screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        'Динамичка поља приказана на екрану прегледа ЧПП у интерфејсу корисника. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено, 2 = Омогућено и неопходно.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ overview screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        'Динамичка поља приказана на екрану прегледа ЧПП у јавном интерфејсу. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено, 2 = Омогућено и неопходно.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ print screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Динамичка поља приказана на екрану за штампу ЧПП у интерфејсу оператера. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ print screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Динамичка поља приказана на екрану за штампу ЧПП у интерфејсу корисника. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ print screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Динамичка поља приказана на екрану за штампу ЧПП у јавном интерфејсу. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ search screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and shown by default.'} =
        'Динамичка поља приказана на екрану претраге ЧПП у интерфејсу оператера. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено, 2 = Омогућено и подразумевано се приказује.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ search screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and shown by default.'} =
        'Динамичка поља приказана на екрану претраге ЧПП у интерфејсу корисника. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено, 2 = Омогућено и подразумевано се приказује.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ search screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and shown by default.'} =
        'Динамичка поља приказана на екрану претраге ЧПП у јавном интерфејсу. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено, 2 = Омогућено и подразумевано се приказује.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ small format overview screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Динамичка поља приказана на екрану прегледа ЧПП малог формата у интерфејсу оператера. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ zoom screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Динамичка поља приказана на екрану детаљног прегледа ЧПП у интерфејсу оператера. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ zoom screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Динамичка поља приказана на екрану детаљног прегледа ЧПП у интерфејсу корисника. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено.';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ zoom screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        'Динамичка поља приказана на екрану детаљног прегледа ЧПП у јавном интерфејсу. Могућа подешавања: 0 = Онемогућено, 1 = Омогућено.';
    $Self->{Translation}->{'Edit this FAQ'} = 'Уреди ово ЧПП';
    $Self->{Translation}->{'Enable multiple languages on FAQ module.'} = 'Активирање више језика на ЧПП модулу.';
    $Self->{Translation}->{'Enable voting mechanism on FAQ module.'} = 'Активирање механизма за гласање на ЧПП модулу.';
    $Self->{Translation}->{'FAQ Journal'} = 'ЧПП дневник';
    $Self->{Translation}->{'FAQ Journal Overview "Small" Limit'} = 'Ограничење прегледа ЧПП журнала - "мало"';
    $Self->{Translation}->{'FAQ Overview "Small" Limit'} = 'Ограничење прегледа ЧПП - "мало"';
    $Self->{Translation}->{'FAQ limit per page for FAQ Journal Overview "Small"'} = 'Ограничење броја ЧПП по страни за преглед ЧПП дневника - "мало"';
    $Self->{Translation}->{'FAQ limit per page for FAQ Overview "Small"'} = 'Ограничење броја ЧПП по страни за преглед ЧПП - "мало"';
    $Self->{Translation}->{'FAQ path separator.'} = 'Разделник путање до ЧПП.';
    $Self->{Translation}->{'FAQ search backend router of the agent interface.'} = 'ЧППпретрага позадинског рутера у интерфејсу оператера.';
    $Self->{Translation}->{'FAQ-Area'} = 'ЧПП простор';
    $Self->{Translation}->{'Field4'} = 'Поље4';
    $Self->{Translation}->{'Field5'} = 'Поље5';
    $Self->{Translation}->{'Frontend module registration for the public interface.'} = 'Регистрација приступног модула за јавни интерфејс.';
    $Self->{Translation}->{'Group for the approval of FAQ articles.'} = 'Група за одобравање ЧПП чланака.';
    $Self->{Translation}->{'History of this FAQ'} = 'Историјат овог ЧПП';
    $Self->{Translation}->{'Include internal fields on a FAQ based Ticket.'} = 'Укључи интерна поља у ЧПП базиран тикет.';
    $Self->{Translation}->{'Include the name of each field in a FAQ based Ticket.'} = 'Укључи назив сваког поља у ЧПП базиран тикет.';
    $Self->{Translation}->{'Interfaces where the quick search should be shown.'} = 'Интерфејс на ком треба приказати брзу претрагу.';
    $Self->{Translation}->{'Journal'} = 'Дневник';
    $Self->{Translation}->{'Language Management'} = 'Управљање језицима';
    $Self->{Translation}->{'Link another object to this FAQ item'} = 'Повежи објекат са овом ставком ЧПП';
    $Self->{Translation}->{'List of state types which can be used in the agent interface.'} =
        'Листа типова статуса који се могу користити у интерфејсу оператера.';
    $Self->{Translation}->{'List of state types which can be used in the customer interface.'} =
        'Листа типова статуса који се могу користити у интерфејсу корисника.';
    $Self->{Translation}->{'List of state types which can be used in the public interface.'} =
        'Листа типова статуса који се могу користити у јавном интерфејсу.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ Explorer result of the agent interface.'} =
        'Максимални број ЧПП чланака који ће бити приказани у резултату ЧПП истраживача у интерфејсу оператера.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ Explorer result of the customer interface.'} =
        'Максимални број ЧПП чланака који ће бити приказани у резултату ЧПП истраживача у интерфејсу корисника.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ Explorer result of the public interface.'} =
        'Максимални број ЧПП чланака који ће бити приказани у резултату ЧПП истраживача у јавном интерфејсу.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ journal in the agent interface.'} =
        'Максимални број ЧПП чланака који ће бити приказани у ЧПП дневнику у интерфејсу оператера.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the result of a search in the agent interface.'} =
        'Максимални број ЧПП чланака који ће бити приказани у резултату претраге у интерфејсу оператера.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the result of a search in the customer interface.'} =
        'Максимални број ЧПП чланака који ће бити приказани у резултату претраге у интерфејсу корисника.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the result of a search in the public interface.'} =
        'Максимални број ЧПП чланака који ће бити приказани у резултату претраге у јавном интерфејсу.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Explorer in the agent interface.'} =
        'Максимална дужина наслова у ЧПП чланаку који ће бити приказани у ЧПП истраживачу у интерфејсу оператера.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Explorer in the customer interface.'} =
        'Максимална дужина наслова у ЧПП чланаку који ће бити приказани у ЧПП истраживачу у интерфејсу клијента.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Explorer in the public interface.'} =
        'Максимална дужина наслова у ЧПП чланаку који ће бити приказани у ЧПП истраживачу у јавном интерфејсу.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Search in the agent interface.'} =
        'Максимална дужина наслова у ЧПП чланаку који ће бити приказани у ЧПП претрази у интерфејсу оператера.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Search in the customer interface.'} =
        'Максимална дужина наслова у ЧПП чланаку који ће бити приказани у ЧПП претрази у интерфејсу клијента.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Search in the public interface.'} =
        'Максимална дужина наслова у ЧПП чланаку који ће бити приказани у ЧПП претрази у јавном интерфејсу.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ journal in the agent interface.'} =
        'Максимална дужина наслова у ЧПП чланаку који ће бити приказани у ЧПП дневнику у интерфејсу оператера.';
    $Self->{Translation}->{'Module to generate HTML OpenSearch profile for short FAQ search in the public interface.'} =
        'Модул за генерисање „HTML OpenSearch” профила за кратку ЧПП претрагу у јавном профилу.';
    $Self->{Translation}->{'Module to generate HTML OpenSearch profile for short faq search in the customer interface.'} =
        'Модул за генерисање „HTML OpenSearch” профила за кратку ЧПП претрагу у профилу клијента.';
    $Self->{Translation}->{'Module to generate html OpenSearch profile for short faq search.'} =
        'Модул за генерисање „HTML OpenSearch” профила за кратку ЧПП претрагу.';
    $Self->{Translation}->{'New FAQ Article'} = 'Нови ЧПП чланак';
    $Self->{Translation}->{'New FAQ articles need approval before they get published.'} = 'Нови ЧПП чланци требају бити одобрени пре објављивања.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed in the FAQ Explorer of the customer interface.'} =
        'Број ЧПП чланака који ће бити приказани у ЧПП Истраживачу у интерфејсу клијента.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed in the FAQ Explorer of the public interface.'} =
        'Број ЧПП чланака који ће бити приказани у ЧПП Истраживачу у јавном интерфејсу.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed on each page of a search result in the customer interface.'} =
        'Број ЧПП чланака који ће бити приказани на свакој страни резултата претраге у интерфејсу клијента.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed on each page of a search result in the public interface.'} =
        'Број ЧПП чланака који ће бити приказани на свакој страни резултата претраге у јавном интерфејсу.';
    $Self->{Translation}->{'Number of shown items in last changes.'} = 'Број приказаних ставки у последњим изменама.';
    $Self->{Translation}->{'Number of shown items in last created.'} = 'Број приказаних ставки у последње креираним.';
    $Self->{Translation}->{'Number of shown items in the top 10 feature.'} = 'Број приказаних ставки у "првих 10" .';
    $Self->{Translation}->{'Parameters for the pages (in which the FAQ items are shown) of the small FAQ journal overview.'} =
        'Параметри страница (на којима су ЧПП ставке приказане) на малом приказу прегледа ЧПП дневника.';
    $Self->{Translation}->{'Parameters for the pages (in which the FAQ items are shown) of the small FAQ overview.'} =
        'Параметри страница (на којима су видљиве ЧПП ставке) смањеног прегледа ЧПП.';
    $Self->{Translation}->{'Print this FAQ'} = 'Штампај ово ЧПП';
    $Self->{Translation}->{'Queue for the approval of FAQ articles.'} = 'Ред за одобравање ЧПП чланака.';
    $Self->{Translation}->{'Rates for voting. Key must be in percent.'} = 'Оцене за гласање. Кључ мора бити у процентима.';
    $Self->{Translation}->{'Search FAQ'} = 'Претражи ЧПП';
    $Self->{Translation}->{'Set the default height (in pixels) of inline HTML fields in AgentFAQZoom.'} =
        '';
    $Self->{Translation}->{'Set the default height (in pixels) of inline HTML fields in CustomerFAQZoom (and PublicFAQZoom).'} =
        '';
    $Self->{Translation}->{'Set the maximum height (in pixels) of inline HTML fields in AgentFAQZoom.'} =
        '';
    $Self->{Translation}->{'Set the maximum height (in pixels) of inline HTML fields in CustomerFAQZoom (and PublicFAQZoom).'} =
        '';
    $Self->{Translation}->{'Show "Insert FAQ Link" Button in AgentFAQZoomSmall for public FAQ Articles.'} =
        '';
    $Self->{Translation}->{'Show "Insert FAQ Text & Link" / "Insert Full FAQ & Link" Button in AgentFAQZoomSmall for public FAQ Articles.'} =
        '';
    $Self->{Translation}->{'Show "Insert FAQ Text" / "Insert Full FAQ" Button in AgentFAQZoomSmall.'} =
        '';
    $Self->{Translation}->{'Show FAQ Article with HTML.'} = 'Приказ ЧПП чланци као „HTML”.';
    $Self->{Translation}->{'Show FAQ path yes/no.'} = 'Прикажи путању до ЧПП да/не.';
    $Self->{Translation}->{'Show items of subcategories.'} = 'Прикажи ставке у субкатегоријама.';
    $Self->{Translation}->{'Show last change items in defined interfaces.'} = 'Прикажи задње промењене ставке у дефинисаним интерфејсима.';
    $Self->{Translation}->{'Show last created items in defined interfaces.'} = 'Прикажи задње креиране ставке у дефинисаним интерфејсима.';
    $Self->{Translation}->{'Show top 10 items in defined interfaces.'} = 'Прикажи првих 10 ставки у дефинисаним интерфејсима.';
    $Self->{Translation}->{'Show voting in defined interfaces.'} = 'Прикажи гласање у дефинисаним интерфејсима.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a FAQ with another object in the zoom view of such FAQ of the agent interface.'} =
        'У менију приказује везу која омогићава повезивање ЧПП са другим објектом у детаљном приказу тог ЧПП у оператерском интерфејсу.';
    $Self->{Translation}->{'Shows a link in the menu that allows to delete a FAQ in its zoom view in the agent interface.'} =
        'У менију приказује везу која омогићава брисање ЧПП у детаљном приказу оператерског интерфејса.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a FAQ in its zoom view of the agent interface.'} =
        'У менију приказује везу за приступ историјату ЧПП у детаљном приказу оператерског интерфејса.';
    $Self->{Translation}->{'Shows a link in the menu to edit a FAQ in the its zoom view of the agent interface.'} =
        'У менију приказује везу за измену ЧПП у детаљном приказу оператерског интерфејса.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the FAQ zoom view of the agent interface.'} =
        'У менију приказује везу за повратак у детаљни приказ ЧПП у оператерском интерфејсу.';
    $Self->{Translation}->{'Shows a link in the menu to print a FAQ in the its zoom view of the agent interface.'} =
        'У менију приказује везу за штампање ЧПП у детаљном приказу оператерског интерфејса.';
    $Self->{Translation}->{'The identifier for a FAQ, e.g. FAQ#, KB#, MyFAQ#. The default is FAQ#.'} =
        '';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'FAQ\' objects using the \'Normal\' link type.'} =
        'Ово подешавање дефинише да ЧПП објект може да се повеже са другим ЧПП објектима користећи „нормалну” везу.';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'FAQ\' objects using the \'ParentChild\' link type.'} =
        'Ово подешавање дефинише да ЧПП објект може да се повеже са другим ЧПП објектима користећи везу типа „родитељ/потомак”.';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'Ticket\' objects using the \'Normal\' link type.'} =
        'Ово подешавање дефинише да ЧПП објект може да се повеже са другим тикет објектима користећи „нормалну” везу.';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'Ticket\' objects using the \'ParentChild\' link type.'} =
        'Ово подешавање дефинише да ЧПП објект може да се повеже са другим тикет објектима користећи везу типа „родитељ/потомак”.';
    $Self->{Translation}->{'Ticket body for approval of FAQ article.'} = 'Садржај тикета за одобравање ЧПП чланака.';
    $Self->{Translation}->{'Ticket subject for approval of FAQ article.'} = 'Предмет тикета за одобравање ЧПП чланака.';

}

1;
