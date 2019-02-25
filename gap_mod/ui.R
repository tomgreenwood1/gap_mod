
source("compare3ds.R")

ui <- navbarPage("Gapminder modules", theme = "bootstrap.css",

        tabPanel(title = "Africa", 
                 compare3dsUI("Africa")
              ),
        tabPanel(title = "Europe", 
                 compare3dsUI("Europe")
        ),
        tabPanel(title = "Americas", 
                 compare3dsUI("Americas")
        ),
        tabPanel(title = "Oceania", 
                 compare3dsUI("Oceania")
        ),
        tabPanel(title = "Asia", 
                 compare3dsUI("Asia")
        )
)

