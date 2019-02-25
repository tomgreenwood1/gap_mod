

compare3dsUI <- function(id) {
  
  ns <- NS(id)
  
 tagList(
   sliderInput(inputId = ns("year"),
            label = "year", 
            min = 1952, 
            max = 2007, 
            value = 1952,
            step = 5,
            animate = animationOptions(interval = 500)), 
   fluidRow(
      column(6, plotlyOutput(ns("contplot"))),
      column(6, plotlyOutput(ns("worldplot")))
   )
)
  
}

compare3ds <- function(input, output, session, cont) {
  
  yearData <- reactive({gapminder %>% filter(year == input$year) %>%
                   mutate(colour = if_else(continent == cont, 1, 0))
  })
  
  output$contplot <- renderPlotly(yearData() %>% filter(continent == cont) %>% 
                                    plot_3d(lifeExp, pop, gdpPercap, 
                                            text = country,
                                            title = cont,
                                            color = colour
                                            
                                          )
  )
  
  output$worldplot <- renderPlotly(yearData() %>% 
                                     plot_3d(lifeExp, pop, gdpPercap, 
                                             text = country,
                                             title = "World",
                                             color = colour
                                          )
  )
}
