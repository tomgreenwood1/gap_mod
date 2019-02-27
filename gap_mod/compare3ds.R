

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
  
  cont_counts <- reactive({ gapminder %>% filter(continent == cont) %>% 
                                          pull(country)  })
  
  yearData <- reactive({gapminder %>%
                   mutate(colour = if_else(continent == cont, 1, 2) %>%
                                   {if_else(country == input$follow, 3, .)}
                          ) %>%
                   filter(year == input$year)
                   
  })
  
  output$contplot <- renderPlotly(yearData() %>% filter(continent == cont) %>% 
                                    plot_3d(lifeExp, pop, gdpPercap, 
                                            text = country,
                                            title = cont,
                                            color = colour,
                                            colors = if (input$follow %in% cont_counts()) {
                                                             c("red", "blue") } else {
                                                               "red" } 
                                            
                                          )
  )
  
  output$worldplot <- renderPlotly(yearData() %>% 
                                     plot_3d(lifeExp, pop, gdpPercap, 
                                             text = country,
                                             title = "World",
                                             color = colour,
                                             colors = c("red", "grey", "blue")
                                          )
  )
}
