# --
# Copyright (C) 2001-2019 OTRS AG, https://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Language::es_MX_FAQ;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AAAFAQ
    $Self->{Translation}->{'internal'} = 'interno';
    $Self->{Translation}->{'public'} = 'público';
    $Self->{Translation}->{'external'} = 'externo';
    $Self->{Translation}->{'FAQ Number'} = 'Número de artículo FAQ';
    $Self->{Translation}->{'Latest updated FAQ articles'} = 'Últimos artículos FAQ modificados';
    $Self->{Translation}->{'Latest created FAQ articles'} = 'Últimos artículos FAQ creados';
    $Self->{Translation}->{'Top 10 FAQ articles'} = 'Top 10 de artículos FAQ';
    $Self->{Translation}->{'Subcategory of'} = 'Subcategoría de';
    $Self->{Translation}->{'No rate selected!'} = '¡No se ha seleccionado ninguna puntuación!';
    $Self->{Translation}->{'Explorer'} = 'Explorador';
    $Self->{Translation}->{'public (all)'} = 'público (todos)';
    $Self->{Translation}->{'external (customer)'} = 'externo (cliente)';
    $Self->{Translation}->{'internal (agent)'} = 'interno (agente)';
    $Self->{Translation}->{'Start day'} = 'Día de inicio';
    $Self->{Translation}->{'Start month'} = 'Mes de inicio';
    $Self->{Translation}->{'Start year'} = 'Año de inicio';
    $Self->{Translation}->{'End day'} = 'Día de finalización';
    $Self->{Translation}->{'End month'} = 'Mes de finalización';
    $Self->{Translation}->{'End year'} = 'Año de finalización';
    $Self->{Translation}->{'Thanks for your vote!'} = '¡Gracias por su voto!';
    $Self->{Translation}->{'You have already voted!'} = '¡Usted ya ha votado!';
    $Self->{Translation}->{'FAQ Article Print'} = 'Imprimir el artículo FAQ';
    $Self->{Translation}->{'FAQ Articles (Top 10)'} = 'Artículos FAQ (Top 10)';
    $Self->{Translation}->{'FAQ Articles (new created)'} = 'Artículos FAQ (nuevos)';
    $Self->{Translation}->{'FAQ Articles (recently changed)'} = 'Artículos FAQ (modificados recientemente)';
    $Self->{Translation}->{'FAQ category updated!'} = 'Actualizada categoría de FAQ';
    $Self->{Translation}->{'FAQ category added!'} = 'Añadida categoría de FAQ';
    $Self->{Translation}->{'A category should have a name!'} = '¡Las categorías debe tener nombre!';
    $Self->{Translation}->{'This category already exists'} = 'Esta categoría ya existe';
    $Self->{Translation}->{'FAQ language added!'} = 'Añadido idioma de FAQ';
    $Self->{Translation}->{'FAQ language updated!'} = 'Actualizado idioma de FAQ.';
    $Self->{Translation}->{'The name is required!'} = 'El nombre es imprescindible.';
    $Self->{Translation}->{'This language already exists!'} = 'Este idioma ya existe.';
    $Self->{Translation}->{'Symptom'} = 'Síntoma';
    $Self->{Translation}->{'Solution'} = 'Solución';

    # Template: AgentFAQAdd
    $Self->{Translation}->{'Add FAQ Article'} = 'Añadir artículo FAQ.';
    $Self->{Translation}->{'Keywords'} = 'Palabras Clave';
    $Self->{Translation}->{'A category is required.'} = 'Se requiere una categoría.';
    $Self->{Translation}->{'Approval'} = 'Aprobación';

    # Template: AgentFAQCategory
    $Self->{Translation}->{'FAQ Category Management'} = 'Gestión de categorías de FAQ';
    $Self->{Translation}->{'Add category'} = 'Añadir categoría';
    $Self->{Translation}->{'Delete Category'} = 'Borrar categoría';
    $Self->{Translation}->{'Ok'} = 'Aceptar';
    $Self->{Translation}->{'Add Category'} = 'Añadir categoría';
    $Self->{Translation}->{'Edit Category'} = 'Editar categoría';
    $Self->{Translation}->{'Please select at least one permission group.'} = 'Por favor, seleccione al menos un grupo de permisos';
    $Self->{Translation}->{'Agent groups that can access articles in this category.'} = 'Grupos de agentes que pueden acceder a los artículos de esta categoría';
    $Self->{Translation}->{'Will be shown as comment in Explorer.'} = 'Se mostrará como comentario en el explorador.';
    $Self->{Translation}->{'Do you really want to delete this category?'} = '¿Seguro que desea borrar esta categoría?';
    $Self->{Translation}->{'You can not delete this category. It is used in at least one FAQ article and/or is parent of at least one other category'} =
        'No puede borrar esta categoría. Está siendo usada por al menos un artículo FAQ y/o es padre de al menos otra categoría';
    $Self->{Translation}->{'This category is used in the following FAQ article(s)'} = 'Esta categoría está siendo usada por los siguientes artículos FAQ';
    $Self->{Translation}->{'This category is parent of the following subcategories'} = 'Esta categoría es padre de las siguientes subcategorías';

    # Template: AgentFAQDelete
    $Self->{Translation}->{'Do you really want to delete this FAQ article?'} = '¿Seguro que desea borrar este artículo FAQ?';

    # Template: AgentFAQEdit
    $Self->{Translation}->{'FAQ'} = 'FAQ';

    # Template: AgentFAQExplorer
    $Self->{Translation}->{'FAQ Explorer'} = 'Explorador FAQ';
    $Self->{Translation}->{'Quick Search'} = 'Búsqueda Rápida';
    $Self->{Translation}->{'Wildcards are allowed.'} = 'Se permiten comodines.';
    $Self->{Translation}->{'Advanced Search'} = 'Búsqueda Avanzada';
    $Self->{Translation}->{'Subcategories'} = 'Subcategorías';
    $Self->{Translation}->{'FAQ Articles'} = 'Artículos FAQ';
    $Self->{Translation}->{'No subcategories found.'} = 'No se encontraron subcategorías.';

    # Template: AgentFAQJournalOverviewSmall
    $Self->{Translation}->{'No FAQ Journal data found.'} = 'No se encontraron datos en la Bitácora FAQ';

    # Template: AgentFAQLanguage
    $Self->{Translation}->{'FAQ Language Management'} = 'Gestión de Idiomas de FAQ';
    $Self->{Translation}->{'Use this feature if you want to work with multiple languges.'} =
        'Utilice esta funcionalidad si desea trabajar con múltiples idiomas.';
    $Self->{Translation}->{'Add language'} = 'Añadir Idioma';
    $Self->{Translation}->{'Delete Language %s'} = 'Borrar Idioma %s';
    $Self->{Translation}->{'Add Language'} = 'Añadir Idioma';
    $Self->{Translation}->{'Edit Language'} = 'Editar Idioma';
    $Self->{Translation}->{'Do you really want to delete this language?'} = '¿Seguro que desea borrar este idioma?';
    $Self->{Translation}->{'You can not delete this language. It is used in at least one FAQ article!'} =
        'No puede borrar este idioma. Está siendo usado por al menos un artículo FAQ';
    $Self->{Translation}->{'This language is used in the following FAQ Article(s)'} = 'Este idioma esta siendo usado por los siguientes Artículos FAQ';

    # Template: AgentFAQOverviewNavBar
    $Self->{Translation}->{'Context Settings'} = 'Ajustes de Contexto';
    $Self->{Translation}->{'FAQ articles per page'} = 'Artículos FAQ por página';

    # Template: AgentFAQOverviewSmall
    $Self->{Translation}->{'No FAQ data found.'} = 'No se encontraron datos de FAQ.';

    # Template: AgentFAQPrint
    $Self->{Translation}->{'FAQ-Info'} = 'Información-FAQ';
    $Self->{Translation}->{'Votes'} = 'Votos';
    $Self->{Translation}->{'Last update'} = 'Última Actualización';

    # Template: AgentFAQSearch
    $Self->{Translation}->{'Keyword'} = 'Palabra clave';
    $Self->{Translation}->{'Vote (e. g. Equals 10 or GreaterThan 60)'} = 'Voto (e.g. Igual a 10 o MayorQue 60)';
    $Self->{Translation}->{'Rate (e. g. Equals 25% or GreaterThan 75%)'} = 'Valoración (e.g. Igual a 25% o MayorQue 75%)';
    $Self->{Translation}->{'Approved'} = 'Aprobado';
    $Self->{Translation}->{'Last changed by'} = 'Último cambio por';
    $Self->{Translation}->{'FAQ Article Create Time (before/after)'} = 'Tiempo de Creación del Artículo FAQ (antes/después)';
    $Self->{Translation}->{'FAQ Article Create Time (between)'} = 'Tiempo de Creación del Artículo FAQ (entre)';
    $Self->{Translation}->{'FAQ Article Change Time (before/after)'} = 'Tiempo de Modificación del Artículo FAQ (antes/después)';
    $Self->{Translation}->{'FAQ Article Change Time (between)'} = 'Tiempo de Modificación del Artículo FAQ (entre)';

    # Template: AgentFAQSearchOpenSearchDescriptionFulltext
    $Self->{Translation}->{'FAQFulltext'} = 'Texto completo FAQ';

    # Template: AgentFAQSearchSmall
    $Self->{Translation}->{'FAQ Search'} = 'Búsqueda FAQ';
    $Self->{Translation}->{'Profile Selection'} = 'Selección de perfil';
    $Self->{Translation}->{'Vote'} = 'Voto';
    $Self->{Translation}->{'No vote settings'} = 'Sin configuración de votación';
    $Self->{Translation}->{'Specific votes'} = 'Votos especóificos';
    $Self->{Translation}->{'e. g. Equals 10 or GreaterThan 60'} = 'e.g. Igual a 10 o MayorQue 60';
    $Self->{Translation}->{'Rate'} = 'Valoración';
    $Self->{Translation}->{'No rate settings'} = 'Sin configuración de valoración';
    $Self->{Translation}->{'Specific rate'} = 'Valoración específica';
    $Self->{Translation}->{'e. g. Equals 25% or GreaterThan 75%'} = 'e.g. Igual a 25% o Mayor Que 75%';
    $Self->{Translation}->{'FAQ Article Create Time'} = 'Tiempo de creación del artículo FAQ';
    $Self->{Translation}->{'Specific date'} = 'Fecha específica';
    $Self->{Translation}->{'Date range'} = 'Rango de fechas';
    $Self->{Translation}->{'FAQ Article Change Time'} = 'Tiempo de modificación del artículo FAQ';

    # Template: AgentFAQZoom
    $Self->{Translation}->{'FAQ Information'} = 'Información FAQ';
    $Self->{Translation}->{'Rating'} = 'Puntuación';
    $Self->{Translation}->{'out of 5'} = 'de 5';
    $Self->{Translation}->{'No votes found!'} = '¡No se encontró ningún voto!';
    $Self->{Translation}->{'No votes found! Be the first one to rate this FAQ article.'} = 'No se encontró ningún voto. Sea el primero en valorar este artículo FAQ';
    $Self->{Translation}->{'Download Attachment'} = 'Descargar Adjunto';
    $Self->{Translation}->{'To open links in the following description blocks, you might need to press Ctrl or Cmd or Shift key while clicking the link (depending on your browser and OS).'} =
        'Para abrir los enlaces de las siguientes descripciones, puede necesitar presionar la tecla Ctrl, Cmd o Shift mientras hace clic en el enlace (dependiendo del navegador y SO que esté utilizando)';
    $Self->{Translation}->{'How helpful was this article? Please give us your rating and help to improve the FAQ Database. Thank You!'} =
        '¿Cómo de útil fue este artículo? Por favor, dénos su puntuación y ayude a mejorar la base de datos de FAQ. Gracias.';
    $Self->{Translation}->{'not helpful'} = 'poco útil';
    $Self->{Translation}->{'very helpful'} = 'muy útil';

    # Template: AgentFAQZoomSmall
    $Self->{Translation}->{'Add FAQ title to article subject'} = 'Agregar el título del FAQ al asunto del artículo';
    $Self->{Translation}->{'Insert FAQ Text'} = 'Insertar Texto de la FAQ';
    $Self->{Translation}->{'Insert Full FAQ'} = 'Insertar FAQ Completo';
    $Self->{Translation}->{'Insert FAQ Link'} = 'Insertar Enlace a la FAQ';
    $Self->{Translation}->{'Insert FAQ Text & Link'} = 'Insertar texto y Enlace a la FAQ';
    $Self->{Translation}->{'Insert Full FAQ & Link'} = 'Insertar FAQ Completo & Enlace';

    # Template: CustomerFAQExplorer
    $Self->{Translation}->{'No FAQ articles found.'} = 'No se encontraron artículos FAQ';

    # Template: CustomerFAQSearch
    $Self->{Translation}->{'Fulltext search in FAQ articles (e. g. "John*n" or "Will*")'} = 'Búsqueda de texto completo en artículos FAQ (ej: "John*n" o "Will*")';
    $Self->{Translation}->{'Vote restrictions'} = 'Restricciones de votación';
    $Self->{Translation}->{'Only FAQ articles with votes...'} = 'Únicamente artículos FAQ con votos...';
    $Self->{Translation}->{'Rate restrictions'} = 'Restricciones de valoración';
    $Self->{Translation}->{'Only FAQ articles with rate...'} = 'Solo artículos FAQ con valoración...';
    $Self->{Translation}->{'Only FAQ articles created'} = 'únicamente artículos FAQ creados';
    $Self->{Translation}->{'Only FAQ articles created between'} = 'Únicamente artículos FAQ creados entre';
    $Self->{Translation}->{'Search-Profile as Template?'} = '¿Perfil de búsqueda como plantilla?';

    # Template: CustomerFAQZoom
    $Self->{Translation}->{'Article Number'} = 'Número de Artículo';
    $Self->{Translation}->{'Search for articles with keyword'} = 'Buscar artículos con la palabra clave';

    # Template: PublicFAQSearchOpenSearchDescriptionFAQNumber
    $Self->{Translation}->{'Public'} = 'Público';

    # Template: PublicFAQSearchResultShort
    $Self->{Translation}->{'Back to FAQ Explorer'} = 'Regresar al Explorador de FAQ';

    # SysConfig
    $Self->{Translation}->{'A filter for HTML output to add links behind a defined string. The element Image allows two input kinds. First the name of an image (e.g. faq.png). In this case the OTRS image path will be used. The second possibility is to insert the link to the image.'} =
        'Filtro para el HTML resultante para añadir enlaces a una cadena determinada. El elemento Imagen contempla dos tipos de registros. El primero es el nombre de una imagen (por ejemplo faq.png). En este caso se utilizará la ruta de imágenes de OTRS. La segunda posibilidad es insertar el enlace a la imagen..';
    $Self->{Translation}->{'CSS color for the voting result.'} = 'Color CSS para el resultado de la votación.';
    $Self->{Translation}->{'Cache Time To Leave for FAQ items.'} = 'Tiempo de vida de la caché para los elementos FAQ.';
    $Self->{Translation}->{'Category Management'} = 'Gestión de las Categorías';
    $Self->{Translation}->{'Decimal places of the voting result.'} = 'Número de decimales para el resultado de la votación';
    $Self->{Translation}->{'Default category name.'} = 'Nombre predeterminado de la categoría';
    $Self->{Translation}->{'Default language for FAQ articles on single language mode.'} = 'Idioma por omisión para los artículos FAQ en modo idioma único';
    $Self->{Translation}->{'Default maximum size of the titles in a FAQ article to be shown.'} =
        'Máximo tamaño por defecto a mostrar de los títulos en un artículo FAQ.';
    $Self->{Translation}->{'Default priority of tickets for the approval of FAQ articles.'} =
        'Prioridad por omisión de los tickets para aprobación de los artículos FAQ.';
    $Self->{Translation}->{'Default state for FAQ entry.'} = 'Estado por omisión para los artículos FAQ.';
    $Self->{Translation}->{'Default state of tickets for the approval of FAQ articles.'} = 'Estado por omisión de los tickets para aprobación de los artículos FAQ.';
    $Self->{Translation}->{'Default type of tickets for the approval of FAQ articles.'} = 'Tipo por defecto de los tickets para aprobación de artículos FAQ.';
    $Self->{Translation}->{'Default value for the Action parameter for the public frontend. The Action parameter is used in the scripts of the system.'} =
        'Valor por omisión para el parámetro "Action" para la interfaz pública. El parámetro "Action" se usa en los "scripts" del sistema.';
    $Self->{Translation}->{'Define if the FAQ title should be concatenated to article subject.'} =
        'Define si el título del FAQ debe estar concatenado al asunto del artículo.';
    $Self->{Translation}->{'Defines an overview module to show the small view of a FAQ journal.'} =
        'Define un módulo de vista general para mostrar la vista pequeña de la bitácora de FAQ';
    $Self->{Translation}->{'Defines an overview module to show the small view of a FAQ list.'} =
        'Define un módulo de vista previa para mostrar la vista pequeña de un listado de FAQs';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in a FAQ search of the agent interface.'} =
        'Define el atributo por omisión para ordenar los artículos FAQ en una búsqueda de FAQ en la interfaz del agente.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in a FAQ search of the customer interface.'} =
        'Define el atributo por omisión para ordenar los artículos FAQ en una búsqueda de FAQ en la interfaz del cliente.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in a FAQ search of the public interface.'} =
        'Define el atributo por omisión para ordenar los artículos FAQ en una búsqueda de FAQ en la interfaz pública.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in the FAQ Explorer of the agent interface.'} =
        'Define el atributo por omisión para ordenar los artículos FAQ en el explorador de FAQ de la interfaz del agente.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in the FAQ Explorer of the customer interface.'} =
        'DEfine el atributo por omisión para ordenar las FAQ en el explorador de FAQ de la interfaz del cliente.';
    $Self->{Translation}->{'Defines the default FAQ attribute for FAQ sorting in the FAQ Explorer of the public interface.'} =
        'Define el atributo de FAQ que se usará por omisión para ordenar las FAQ en el explorador de FAQ de la interfaz pública.';
    $Self->{Translation}->{'Defines the default FAQ order in the FAQ Explorer result of the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Define el orden por omisión de las FAQ en los resultados del explorador de FAQ de la interfaz del agente. Arriba: los más antiguos en la parte superior. Abajo: Los últimos en la parte superior.';
    $Self->{Translation}->{'Defines the default FAQ order in the FAQ Explorer result of the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Define el orden por omisión de las FAQ en los resultados del explorador de FAQ de la interfaz del cliente. Arriba: los más antiguos en la parte superior. Abajo: los más recientes en la parte superior.';
    $Self->{Translation}->{'Defines the default FAQ order in the FAQ Explorer result of the public interface. Up: oldest on top. Down: latest on top.'} =
        'Define el orden por omisión de las FAQ en el explorador de FAQ de la interfaz pública. Arriba: los más antiguos en la parte superior. Abajo: los más recientes en la parte superior.';
    $Self->{Translation}->{'Defines the default FAQ order of a search result in the agent interface. Up: oldest on top. Down: latest on top.'} =
        'Define el orden por omisión de los resultados de una búsqueda en la interface del agente. Arriba: los más antiguos en la parte superior. Abajo: los últimos en la parte superior.';
    $Self->{Translation}->{'Defines the default FAQ order of a search result in the customer interface. Up: oldest on top. Down: latest on top.'} =
        'Define el orden por omisión de los resultados de una búsqueda en la interface del cliente. Arriba: los más antiguos en la parte superior. Abajo: los últimos en la parte superior.';
    $Self->{Translation}->{'Defines the default FAQ order of a search result in the public interface. Up: oldest on top. Down: latest on top.'} =
        'Define el orden por omisión de los resultados de una búsqueda en la interface pública. Arriba: los más antiguos en la parte superior. Abajo: los últimos en la parte superior.';
    $Self->{Translation}->{'Defines the default shown FAQ search attribute for FAQ search screen.'} =
        'Define el atributo de búsqueda de FAQ mostrado por defecto en la pantalla de búsqueda de FAQ.';
    $Self->{Translation}->{'Defines the information to be inserted in a FAQ based Ticket. "Full FAQ" includes text, attachments and inline images.'} =
        'Define la información a insertar en un FAQ basado en un ticket. "FAQ completo" incluye texto, adjuntos e imágenes incrustadas.';
    $Self->{Translation}->{'Defines the parameters for the dashboard backend. "Limit" defines the number of entries displayed by default. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually.'} =
        '';
    $Self->{Translation}->{'Defines the shown columns in the FAQ Explorer. This option has no effect on the position of the column.'} =
        'Define las columnas que se mostrarán en el Explorador de FAQ. Esta opción no tiene efectos en la posición de las columnas.';
    $Self->{Translation}->{'Defines the shown columns in the FAQ journal. This option has no effect on the position of the column.'} =
        'Define las columnas que se mostrarán en la bitácora de FAQ. Esta opción no tiene efectos en la posición de las columnas.';
    $Self->{Translation}->{'Defines the shown columns in the FAQ search. This option has no effect on the position of the column.'} =
        'Define las columnas que se mostrarán en la búsqueda de FAQ. Esta opción no tiene efectos en la posición de las columnas.';
    $Self->{Translation}->{'Defines where the \'Insert FAQ\' link will be displayed.'} = '';
    $Self->{Translation}->{'Definition of FAQ item free text field.'} = 'Definición del campo «texto libre» para los artículos FAQ.';
    $Self->{Translation}->{'Delete this FAQ'} = 'Borrar este artículo FAQ';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ add screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ edit screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ overview screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ overview screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ print screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ print screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ print screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ search screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and shown by default.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ search screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and shown by default.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ search screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and shown by default.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ small format overview screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ zoom screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ zoom screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        '';
    $Self->{Translation}->{'Dynamic fields shown in the FAQ zoom screen of the public interface. Possible settings: 0 = Disabled, 1 = Enabled.'} =
        '';
    $Self->{Translation}->{'Edit this FAQ'} = 'Editar este artículo FAQ';
    $Self->{Translation}->{'Enable multiple languages on FAQ module.'} = 'Habilitar múltiples idiomas en el módulo FAQ';
    $Self->{Translation}->{'Enable voting mechanism on FAQ module.'} = 'Habilitar el mecanismo de votación en el módulo FAQ';
    $Self->{Translation}->{'FAQ Journal'} = 'Bitácora de FAQ';
    $Self->{Translation}->{'FAQ Journal Overview "Small" Limit'} = 'Límite para la vista general «pequeña» de la Bitácora de FAQ';
    $Self->{Translation}->{'FAQ Overview "Small" Limit'} = 'Límite para la vista general «pequeña» de FAQ';
    $Self->{Translation}->{'FAQ limit per page for FAQ Journal Overview "Small"'} = 'Límite de FAQ por página para la vista general «pequeña» de la Bitácora de FAQ';
    $Self->{Translation}->{'FAQ limit per page for FAQ Overview "Small"'} = 'Límite de FAQ por página para la vista general «pequeña» de FAQ';
    $Self->{Translation}->{'FAQ path separator.'} = 'Separador de la ruta de FAQ.';
    $Self->{Translation}->{'FAQ search backend router of the agent interface.'} = 'Encaminador para la búsqueda de FAQ en la interfaz del agente.';
    $Self->{Translation}->{'FAQ-Area'} = 'Área-FAQ';
    $Self->{Translation}->{'Field4'} = '';
    $Self->{Translation}->{'Field5'} = '';
    $Self->{Translation}->{'Frontend module registration for the public interface.'} = 'Registro de módulo "Frontend" en la interfaz pública.';
    $Self->{Translation}->{'Group for the approval of FAQ articles.'} = 'Grupo para la aprobación de los artículos FAQ.';
    $Self->{Translation}->{'History of this FAQ'} = 'Historia de este artículo FAQ';
    $Self->{Translation}->{'Include internal fields on a FAQ based Ticket.'} = 'Incluir campos internos en los tickets basados en un artículo FAQ';
    $Self->{Translation}->{'Include the name of each field in a FAQ based Ticket.'} = 'Incluir el nombre de cada campo en los tickets basados en un artículo FAQ';
    $Self->{Translation}->{'Interfaces where the quick search should be shown.'} = '';
    $Self->{Translation}->{'Journal'} = 'Bitácora';
    $Self->{Translation}->{'Language Management'} = 'Gestión de Idiomas';
    $Self->{Translation}->{'Link another object to this FAQ item'} = 'Enlazar otro objecto a este artículo FAQ';
    $Self->{Translation}->{'List of state types which can be used in the agent interface.'} =
        '';
    $Self->{Translation}->{'List of state types which can be used in the customer interface.'} =
        '';
    $Self->{Translation}->{'List of state types which can be used in the public interface.'} =
        '';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ Explorer result of the agent interface.'} =
        'Número máximo de artículos FAQ a mostrar en los resultados del explorador FAQ de la interfaz del agente.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ Explorer result of the customer interface.'} =
        'Número máximo de artículos FAQ a mostrar en los resultados del explorador FAQ de la interfaz del cliente.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ Explorer result of the public interface.'} =
        'Número máximo de artículos FAQ a mostrar en los resultados del explorador FAQ de la interfaz pública.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the FAQ journal in the agent interface.'} =
        'Número máximo de artículos FAQ a mostrar en la bitácora de FAQ en la interfaz del agente.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the result of a search in the agent interface.'} =
        'Número máximo de artículos FAQ a mostrar como resultado de una búsqueda en la interfaz del agente.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the result of a search in the customer interface.'} =
        'Número máximo de artículos FAQ a mostrar como resultado de una búsqueda en la interfaz del cliente.';
    $Self->{Translation}->{'Maximum number of FAQ articles to be displayed in the result of a search in the public interface.'} =
        'Número máximo de artículos FAQ a mostrar como resultado de una búsqueda en la interfaz pública.';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Explorer in the agent interface.'} =
        '';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Explorer in the customer interface.'} =
        '';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Explorer in the public interface.'} =
        '';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Search in the agent interface.'} =
        '';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Search in the customer interface.'} =
        '';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ Search in the public interface.'} =
        '';
    $Self->{Translation}->{'Maximum size of the titles in a FAQ article to be shown in the FAQ journal in the agent interface.'} =
        '';
    $Self->{Translation}->{'Module to generate HTML OpenSearch profile for short FAQ search in the public interface.'} =
        '';
    $Self->{Translation}->{'Module to generate HTML OpenSearch profile for short faq search in the customer interface.'} =
        '';
    $Self->{Translation}->{'Module to generate html OpenSearch profile for short faq search.'} =
        'Módulo para generar el perfil html "OpenSearch" para búsquedas cortas de FAQ.';
    $Self->{Translation}->{'New FAQ Article'} = 'Nuevo artículo FAQ';
    $Self->{Translation}->{'New FAQ articles need approval before they get published.'} = 'Los nuevos artículos FAQ requieren aprobación antes de publicarse.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed in the FAQ Explorer of the customer interface.'} =
        'Número de artículos FAQ a mostrar en el explorador de FAQ de la interfaz del cliente.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed in the FAQ Explorer of the public interface.'} =
        'Número de artículos FAQ a mostrar en el explorador de FAQ de la interfaz pública.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed on each page of a search result in the customer interface.'} =
        'Número de artículos FAQ a mostrar en cada página de los resultados de una búsqueda en la interfaz del cliente.';
    $Self->{Translation}->{'Number of FAQ articles to be displayed on each page of a search result in the public interface.'} =
        'Número de artículos FAQ a mostrar en cada página de los resultados de una búsqueda en la interfaz pública.';
    $Self->{Translation}->{'Number of shown items in last changes.'} = 'Número de elementos a mostrar en últimos cambios.';
    $Self->{Translation}->{'Number of shown items in last created.'} = 'Número de elementos a mostrar en últimos creados.';
    $Self->{Translation}->{'Number of shown items in the top 10 feature.'} = 'Número de elementos a mostrar en el Top 10.';
    $Self->{Translation}->{'Parameters for the pages (in which the FAQ items are shown) of the small FAQ journal overview.'} =
        'Parámetros de las páginas (en las que se muestran los elementos FAQ) de la vista general pequeña de la bitácora de FAQ.';
    $Self->{Translation}->{'Parameters for the pages (in which the FAQ items are shown) of the small FAQ overview.'} =
        'Parámetros de las páginas (en las que se muestran los elementos FAQ) de la vista general de FAQ pequeña.';
    $Self->{Translation}->{'Print this FAQ'} = 'Imprimir esta FAQ';
    $Self->{Translation}->{'Queue for the approval of FAQ articles.'} = 'Fila para la aprobación de los artículos FAQ.';
    $Self->{Translation}->{'Rates for voting. Key must be in percent.'} = 'Ponderación para la votación. La clave debe expresarse en porcentaje.';
    $Self->{Translation}->{'Search FAQ'} = 'Búsqueda de FAQ';
    $Self->{Translation}->{'Set the default height (in pixels) of inline HTML fields in AgentFAQZoom.'} =
        'Establecer la altura predeterminada (en píxeles) de los campos HTML «inline» de AgentFAQZoom';
    $Self->{Translation}->{'Set the default height (in pixels) of inline HTML fields in CustomerFAQZoom (and PublicFAQZoom).'} =
        'Establecer la altura predeterminada (en píxeles) de los campos HTML «inline» de CustomerFAQZoom (y PublicFAQZoom).';
    $Self->{Translation}->{'Set the maximum height (in pixels) of inline HTML fields in AgentFAQZoom.'} =
        'Establecer la altura máxima (en píxeles) de los campos HTML «inline» de AgentFAQZoom';
    $Self->{Translation}->{'Set the maximum height (in pixels) of inline HTML fields in CustomerFAQZoom (and PublicFAQZoom).'} =
        'Establecer la altura máxima (en píxeles) de los campos HTML «inline» de CustomerFAQZoom (y PublicFAQZoom).';
    $Self->{Translation}->{'Show "Insert FAQ Link" Button in AgentFAQZoomSmall for public FAQ Articles.'} =
        'Mostrar botón «Insertar enlace a FAQ» en AgentFAQZoomSmall para los artículos FAQ públicos.';
    $Self->{Translation}->{'Show "Insert FAQ Text & Link" / "Insert Full FAQ & Link" Button in AgentFAQZoomSmall for public FAQ Articles.'} =
        '';
    $Self->{Translation}->{'Show "Insert FAQ Text" / "Insert Full FAQ" Button in AgentFAQZoomSmall.'} =
        '';
    $Self->{Translation}->{'Show FAQ Article with HTML.'} = '¿Mostrar contenido HTML en los artículos FAQ?.';
    $Self->{Translation}->{'Show FAQ path yes/no.'} = '¿Mostrar la ruta de la FAQ? sí/no.';
    $Self->{Translation}->{'Show items of subcategories.'} = '¿Mostrar los elementos de las subcategorías.';
    $Self->{Translation}->{'Show last change items in defined interfaces.'} = 'Mostrar los últimos artículos actualizados en las interfaces definidas.';
    $Self->{Translation}->{'Show last created items in defined interfaces.'} = 'Mostrar los últimos artículos creados en las interfaces definidas.';
    $Self->{Translation}->{'Show top 10 items in defined interfaces.'} = 'Mostrar los artículos Top 10 en las interfaces definidas.';
    $Self->{Translation}->{'Show voting in defined interfaces.'} = 'Mostrar la votación en las interfaces definidas.';
    $Self->{Translation}->{'Shows a link in the menu that allows linking a FAQ with another object in the zoom view of such FAQ of the agent interface.'} =
        'Muestra un enlace en el menú que permite enlazar a un artículo FAQ con otro objeto en su vista ampliada de esa FAQ en la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu that allows to delete a FAQ in its zoom view in the agent interface.'} =
        'Muestra un enlace en el menú que permite borrar un artículo FAQ en la vista ampliada de esa FAQ en la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to access the history of a FAQ in its zoom view of the agent interface.'} =
        'Muestra un enlace en el menú para acceder al historial de un artículo FAQ en su vista ampliada en la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to edit a FAQ in the its zoom view of the agent interface.'} =
        'Muestra un enlace en el menú para editar un artículo FAQ en su vista ampliada en la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to go back in the FAQ zoom view of the agent interface.'} =
        'Muestra un enlace en el menú para retroceder en la vista ampliada de FAQ en la interfaz del agente.';
    $Self->{Translation}->{'Shows a link in the menu to print a FAQ in the its zoom view of the agent interface.'} =
        'Muestra un enlace en el menú para imprimir un artículo FAQ en su vista ampliada en la interfaz del agente.';
    $Self->{Translation}->{'The identifier for a FAQ, e.g. FAQ#, KB#, MyFAQ#. The default is FAQ#.'} =
        'El identificador para una FAQ, por ejemplo FAQ#, KB#, MiFAQ#. FAQ# es la opción por omisión';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'FAQ\' objects using the \'Normal\' link type.'} =
        'Este ajuste define que un objeto «FAQ» puede enlazarse con otros objetos «FAQ» utilizando el tipo de enlace «Normal».';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'FAQ\' objects using the \'ParentChild\' link type.'} =
        'Este ajuste define que un objeto «FAQ» puede enlazarse con otros objetos «FAQ» utilizando el tipo de enlace «ParentChild».';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'Ticket\' objects using the \'Normal\' link type.'} =
        'Este ajuste define que un objeto «FAQ» puede enlazarse con otros objetos «Ticket» utilizando el tipo de enlace «Normal».';
    $Self->{Translation}->{'This setting defines that a \'FAQ\' object can be linked with other \'Ticket\' objects using the \'ParentChild\' link type.'} =
        'Este ajuste define que un objeto «FAQ» puede enlazarse con otros objetos «Ticket» utilizando el tipo de enlace «ParentChild».';
    $Self->{Translation}->{'Ticket body for approval of FAQ article.'} = 'Cuerpo del ticket para aprobación de artículos FAQ.';
    $Self->{Translation}->{'Ticket subject for approval of FAQ article.'} = 'Asunto del ticket para aprobación de artículos FAQ.';

}

1;
