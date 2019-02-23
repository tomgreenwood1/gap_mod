
# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  yearData <- reactive({gapminder %>% filter(year == input$year)
                 })
  
  output$contplot <- renderPlotly(yearData() %>% filter(continent == "Africa") %>% 
                                    plot_3d(lifeExp, pop, gdpPercap )
                              )
  
  output$worldplot <- renderPlotly(yearData() %>% 
                                    plot_3d(lifeExp, pop, gdpPercap )
                              )
}
