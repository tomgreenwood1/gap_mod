library(r2d3)
library(magrittr)
library(rlang)
library(plotly)
library(randomForest)
library(gapminder)
library(tidyverse)
library(shiny)


# function for 3d plots
########################################################################################

plot_3d <- function(df, x, y, z, title, text, color) {
  
  x <- enquo(x)
  y <- enquo(y)
  z <- enquo(z) 
  text <- enquo(text)
  color <- enquo(color)

  
  
  plot_ly(df) %>%
    add_trace(x = x, y = y, z = z, text = text, 
              opacity = 0.7,
              type = "scatter3d",
              mode = "markers",
              size = 10,
              text = text,
              color = color,
              colors = c("grey", "red")
              
    ) %>% hide_colorbar %>%
    layout(title = title,
           scene = list(xaxis = list(title = quo_text(x)),
                        yaxis = list(title = quo_text(y)),
                        zaxis = list(title = quo_text(z)) 
          
   )
  )
  
}
