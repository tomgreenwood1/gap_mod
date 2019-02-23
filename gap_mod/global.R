library(r2d3)
library(magrittr)
library(rlang)
library(plotly)
library(randomForest)
library(gapminder)
library(tidyverse)
library(shiny)

# function for scatter matrix
#######################################################################################
plot_d3sm <- function(data, target, vars) {
  
  all <- c(vars, target)
  data %<>% select(!!!all)
  col <- paste0("d.", target)
  col_range <- data[[target]] %>% {paste("[", min(., na.rm = T), ",", max(., na.rm = T), "]", collapse = "" ) }
  
  r2d3(data = data,
       script = "scatter_matrix.js",
       d3_version = "3", 
       css = "scatter_matrix.css", 
       options = list(exclude = target, col = "d.mpg", col_range = col_range)
  )
}     




# function for 3d plots
########################################################################################

plot_3d <- function(df, x, y, z) {
  
  x <- enquo(x)
  y <- enquo(y)
  z <- enquo(z) 
  
  # build a model 
  m <- randomForest(expr(!!get_expr(x) ~ !!get_expr(y) + !!get_expr(z)) %>% as.formula, df)
  
  # add the predictions to df
  df %<>% mutate(preds = predict(m, newdata = df ))
  
  plot_ly(df) %>%
    add_trace(x = x, y = y, z = z, 
              opacity = 0.7,
              type = "scatter3d", 
              mode = "markers",
              colors = c("grey", "blue"),
              name = "true values",
              size = 10
    ) %>%
    add_trace(x = ~preds, y = y, z = z,
              opacity = 0.7,
              type = "scatter3d", 
              mode = "markers",
              name = "modelled values",
              size = 10
    ) %>%
    layout(scene = list(xaxis = list(title = quo_text(x)),
                        yaxis = list(title = quo_text(y)),
                        zaxis = list(title = quo_text(z))
    )
    )
  
}
