

ui <- navbarPage("Gapminder modules",

        tabPanel(title = "Africa", 
                 sliderInput(inputId = "year",
                             label = "year", 
                             min = 1952, 
                             max = 2007, 
                             value = 1952,
                             step = 5,
                             animate = animationOptions(interval = 500)), 
            fluidRow(
              column(6, plotlyOutput("contplot")),
              column(6, plotlyOutput("worldplot"))
                   )
                 
                 )
        
    
)

