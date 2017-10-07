library(googleVis)
library(shiny)
library(dplyr)
library(zoo)
library(tidyr)

apple <- read.csv('apple.csv',sep = ',')
apple <- na.omit(apple)
wine <- read.csv('wine.csv',sep = ',')
wine <- na.omit(wine)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
    output$worldmap <- renderGvis({
        world <- filter(apple,Year==input$yearmap,Element==input$measuremap)
        gvisGeoChart(world,locationvar = 'Area',colorvar = 'Value',
                          options = list(width='automatic',colors="['blue']"))
    })
    
    output$table <- renderDataTable({
        apple[,c('Area','Element','Year','Unit','Value','Flag.Description')]
    })
  
    output$timeline <- renderGvis({
        subset <- filter(apple,Area %in% input$countrytimeline ,Element==input$measuretimeline)
        subset$Year <- as.Date(paste(subset$Year,'12-31',sep = '-'))
        gvisAnnotationChart(subset,datevar = 'Year',numvar = 'Value',idvar = 'Area',
                            options = list(width='90%',displayZoomButtons=F))
    })
    
    output$motionapple <- renderGvis({
        a <- apple[,c('Area','Element','Year','Value')]
        if (input$countryapplemotion!='All'){
            a <- filter(a,Area %in% input$countryapplemotion)
        }
        p <- spread(a,Element,Value)
        m <- gvisMotionChart(p, idvar = "Area", timevar = "Year",
                             options=list(width='800'))
        m
    })
    
    output$worldmapwine <- renderGvis({
        winemap <- filter(wine,Year==input$yearmapwine)
        gvisGeoChart(winemap,locationvar = 'Area',colorvar = 'Value',
                     options = list(width='automatic',colors="['blue']"))
    })
    
    output$timelinewine <- renderGvis({
        subsetwine <- filter(wine,Area %in% input$countrytimelinewine)
        subsetwine$Year <- as.Date(paste(subsetwine$Year,'12-31',sep = '-'))
        gvisAnnotationChart(subsetwine,datevar = 'Year',numvar = 'Value',idvar = 'Area',
                            options = list(width='90%',displayZoomButtons=F))
    })
    
    output$tablewine <- renderDataTable({
        wine[,c('Area','Element','Year','Unit','Value','Flag.Description')]
    })
    
    output$motionwine <- renderGvis({
        a <- wine[,c('Area','Element','Year','Value')]
        names(a) <- c('Area','Measure','Year','Production')
        if (input$countrywinemotion!='All'){
            a <- filter(a,Area %in% input$countrywinemotion)
        }
        w <- gvisMotionChart(a, idvar = "Area", timevar = "Year",sizevar = 'Production',
                             options=list(width='800'))
        w
    })
    

    
})




