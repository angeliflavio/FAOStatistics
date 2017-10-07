library(shiny)
library(shinyBS)
library(markdown)


apple <- read.csv('apple.csv',sep = ',')
wine <- read.csv('wine.csv',sep = ',')

shinyUI(
    navbarPage(theme=shinythemes::shinytheme('cerulean'),title='FAO Statistics',
               tabPanel('Apple',
                        tabsetPanel(
                            tabPanel('World Map',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('measuremap','Measure',
                                                         choices = c('Production Quantity (tonnes)'= 'Production',
                                                                     'Area Harvested (ha)'='Area harvested',
                                                                     'Yield (hg/ha)'='Yield'),
                                                         selected = 'Production Quantity'),
                                             selectInput('yearmap','Year',
                                                         choices = seq(1961,2014),selected = 2014),
                                             br(),
                                             tags$a(href='http://www.fao.org','FAO Data') 
                                        ),
                                         mainPanel(
                                             h3(paste('Global Apple Statistics')),
                                             br(),
                                             htmlOutput('worldmap'))
                                     )
                                     ),
                            tabPanel('Motion Chart',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('countryapplemotion','Countries',
                                                         choices = c('All',as.vector(unique(apple$Area))),
                                                         selected = 'All',
                                                         multiple = T),
                                             bsTooltip('countryapplemotion','You can select multiple Countries',
                                                       options = list(container = "body")),
                                             br(),
                                             tags$a(href='http://www.fao.org','FAO Data')
                                         ),
                                         mainPanel(
                                             h3('Apple Statistics Motion Chart'),
                                             br(),
                                             htmlOutput('motionapple')
                                         )
                                     )
                                     ),
                            tabPanel('Timeline',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('measuretimeline','Measure',
                                                         choices = c('Production Quantity (tonnes)'= 'Production',
                                                                     'Area Harvested (ha)'='Area harvested',
                                                                     'Yield (hg/ha)'='Yield'),
                                                         selected = 'Production Quantity'),
                                             selectInput('countrytimeline','Country',
                                                         choices = as.vector(unique(apple$Area)),
                                                         selected = 'Italy',
                                                         multiple = T),
                                             bsTooltip('countrytimeline','You can select multiple Countries',
                                                       options = list(container = "body")),
                                             br(),
                                             tags$a(href='http://www.fao.org','FAO Data')
                                         ),
                                         mainPanel(
                                             h3('Historical Apple Statistics'),
                                             br(),
                                             htmlOutput('timeline'))
                                     )
                                     ),
                            tabPanel('Data',
                                     br(),
                                     dataTableOutput('table'))
                        )),
               tabPanel('Wine',
                        tabsetPanel(
                            tabPanel('World Map',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('yearmapwine','Year',
                                                         choices = seq(1961,2014),selected = 2014),
                                             br(),
                                             tags$a(href='http://www.fao.org','FAO Data')
                                         ),
                                         mainPanel(
                                             h3('Global Wine Production in tonnes'),
                                             br(),
                                             htmlOutput('worldmapwine'))
                                     )),
                            tabPanel('Motion Chart',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('countrywinemotion','Countries',
                                                         choices = c('All',as.vector(unique(wine$Area))),
                                                         selected = 'All',
                                                         multiple = T),
                                             bsTooltip('countrywinemotion','You can select multiple Countries',
                                                       options = list(container = "body")),
                                             br(),
                                             tags$a(href='http://www.fao.org','FAO Data')
                                         ),
                                         mainPanel(
                                             h3('Wine Statistics Motion Chart'),
                                             br(),
                                             htmlOutput('motionwine')
                                         )
                                     )),
                            tabPanel('Timeline',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('countrytimelinewine','Country',
                                                         choices = as.vector(unique(wine$Area)),
                                                         selected = 'Italy',
                                                         multiple = T),
                                             bsTooltip('countrytimelinewine','You can select multiple Countries',
                                                       options = list(container = "body")),
                                             br(),
                                             tags$a(href='http://www.fao.org','FAO Data')
                                         ),
                                         mainPanel(
                                             h3('Historical Production in tonnes'),
                                             br(),
                                             htmlOutput('timelinewine'))
                                     )),
                            tabPanel('Data',
                                     br(),
                                     dataTableOutput('tablewine'))
                        )),
               tabPanel('Help',
                        includeMarkdown('help.md')),
               br(),
               br(),
               tags$a(img(src='github.png'),href='https://github.com/angeliflavio'))
)



#add year selection
#add value type (produciton, area harvested, yield  )



