

compare3dsUI <- function(id) {
  
  ns <- NS(id)
  
 tagList(
   fluidRow(
     column(6, 
      selectInput(inputId =  ns("follow"), 
                  label = "highlight one country",
                  choices = gapminder$country %>% unique %>% sort 
                  )
      ),
     column(6,
       sliderTextInput(inputId = ns("year"),
                       label = "year", 
                       choices = gapminder$year %>% unique,
                       animate = animationOptions(interval = 2000)
            )
   )
          ), 
   fluidRow(
      column(6, plotlyOutput(ns("contplot"))),
      column(6, plotlyOutput(ns("worldplot")))
   )
)
  
}

compare3ds <- function(input, output, session, cont) {
  
  yearData <- reactive({gapminder %>%
                   mutate(colour = if_else(continent == cont, 1, 0) %>%
                                   {if_else(country == input$follow, 2, .)}
                          ) %>%
                   filter(year == input$year)
                   
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
