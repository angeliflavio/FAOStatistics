library(shiny)
library(shinyBS)
library(markdown)


apple <- read.csv('apple.csv',sep = ',')
wine <- read.csv('wine.csv',sep = ',')

shinyUI(
    navbarPage(theme=shinythemes::shinytheme('cerulean'),title='Statistiche FAO',
               tabPanel('Mele',
                        tabsetPanel(
                            tabPanel('Mappa',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('measuremap','Misura',
                                                         choices = c('Produzione (ton)'= 'Production',
                                                                     'Superficie (ettari)'='Area harvested',
                                                                     'Resa (hg/ettaro)'='Yield'),
                                                         selected = 'Produzione'),
                                             selectInput('yearmap','Anno',
                                                         choices = seq(1961,2014),selected = 2014),
                                             br(),
                                             tags$a(href='http://www.fao.org','Fonte FAO') 
                                        ),
                                         mainPanel(
                                             br(),
                                             htmlOutput('worldmap'))
                                     )
                                     ),
                            tabPanel('Grafico',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('countryapplemotion','Paesi',
                                                         choices = c('Tutti',as.vector(unique(apple$Area))),
                                                         selected = 'Tutti',
                                                         multiple = T),
                                             bsTooltip('countryapplemotion','Selezione singola o multipla',
                                                       options = list(container = "body")),
                                             br(),
                                             tags$a(href='http://www.fao.org','Fonte FAO')
                                         ),
                                         mainPanel(
                                             br(),
                                             htmlOutput('motionapple')
                                         )
                                     )
                                     ),
                            tabPanel('Grafico storico',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('measuretimeline','Misura',
                                                         choices = c('Produzione (ton)'= 'Production',
                                                                     'Superficie (ettari)'='Area harvested',
                                                                     'Resa (hg/ettaro)'='Yield'),
                                                         selected = 'Produzione (ton)'),
                                             selectInput('countrytimeline','Paesi',
                                                         choices = as.vector(unique(apple$Area)),
                                                         selected = 'Italy',
                                                         multiple = T),
                                             bsTooltip('countrytimeline','Selezione singola o multipla',
                                                       options = list(container = "body")),
                                             br(),
                                             tags$a(href='http://www.fao.org','Fonte FAO')
                                         ),
                                         mainPanel(
                                             br(),
                                             htmlOutput('timeline'))
                                     )
                                     ),
                            tabPanel('Tabella',
                                     br(),
                                     dataTableOutput('table'))
                        )),
               tabPanel('Vino',
                        tabsetPanel(
                            tabPanel('Mappa',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('yearmapwine','Anno',
                                                         choices = seq(1961,2014),selected = 2014),
                                             br(),
                                             tags$a(href='http://www.fao.org','Fonte FAO')
                                         ),
                                         mainPanel(
                                             br(),
                                             htmlOutput('worldmapwine'))
                                     )),
                            tabPanel('Grafico',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('countrywinemotion','Paesi',
                                                         choices = c('Tutti',as.vector(unique(wine$Area))),
                                                         selected = 'Tutti',
                                                         multiple = T),
                                             bsTooltip('countrywinemotion','Selezione singola o multipla',
                                                       options = list(container = "body")),
                                             br(),
                                             tags$a(href='http://www.fao.org','Fonte FAO')
                                         ),
                                         mainPanel(
                                             br(),
                                             htmlOutput('motionwine')
                                         )
                                     )),
                            tabPanel('Grafico storico',
                                     br(),
                                     sidebarLayout(
                                         sidebarPanel(
                                             selectInput('countrytimelinewine','Paesi',
                                                         choices = as.vector(unique(wine$Area)),
                                                         selected = 'Italy',
                                                         multiple = T),
                                             bsTooltip('countrytimelinewine','Selezione singola o multipla',
                                                       options = list(container = "body")),
                                             br(),
                                             tags$a(href='http://www.fao.org','Fonte FAO')
                                         ),
                                         mainPanel(
                                             br(),
                                             htmlOutput('timelinewine'))
                                     )),
                            tabPanel('Tabella',
                                     br(),
                                     dataTableOutput('tablewine'))
                        )),
               br(),
               br(),
               tags$a(img(src='github.png'),href='https://github.com/angeliflavio/FAOStatistics'))
)



#add year selection
#add value type (produciton, area harvested, yield  )



