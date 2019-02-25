
# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  Africa <- callModule(compare3ds, "Africa", cont = "Africa")
  Europe <- callModule(compare3ds, "Europe", cont = "Europe")
  Americas <- callModule(compare3ds, "Americas", cont = "Americas")
  Oceania <- callModule(compare3ds, "Oceania", cont = "Oceania")
  Asia <- callModule(compare3ds, "Asia", cont = "Asia")
}
