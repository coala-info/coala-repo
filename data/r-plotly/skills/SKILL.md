---
name: r-plotly
description: The r-plotly package creates interactive, web-based visualizations and graphics directly from R. Use when user asks to create interactive charts, convert ggplot2 objects to plotly, build 3D surfaces, or integrate interactive plots into Shiny applications.
homepage: https://cloud.r-project.org/web/packages/plotly/index.html
---


# r-plotly

## Overview
The `plotly` R package is an interface to the plotly.js JavaScript library. It allows for the creation of interactive, publication-quality web graphics directly from R. It supports a "grammar of graphics" approach similar to `ggplot2` and provides a seamless conversion tool for existing `ggplot2` objects.

## Installation
```R
install.packages("plotly")
library(plotly)
```

## Core Workflows

### 1. Converting ggplot2 to plotly
The fastest way to create an interactive plot is to pass a `ggplot` object to `ggplotly()`.
```R
library(ggplot2)
p <- ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) + geom_point()
ggplotly(p)
```

### 2. Native Plotly Interface (plot_ly)
Use `plot_ly()` for direct access to plotly.js features. Use the tilde (`~`) to map data columns to visual attributes.
```R
# Basic scatter plot
plot_ly(data = mtcars, x = ~wt, y = ~mpg, type = "scatter", mode = "markers", color = ~hp)

# Adding traces
plot_ly(economics, x = ~date) %>%
  add_lines(y = ~uempmed, name = "Unemployment Duration") %>%
  add_lines(y = ~psavert, name = "Savings Rate")
```

### 3. Common Trace Types
- `add_markers()`: Scatter plots.
- `add_lines()` / `add_paths()`: Line charts.
- `add_bars()`: Bar charts.
- `add_boxplot()`: Box plots.
- `add_heatmap()` / `add_contour()`: 2D density/matrix data.
- `add_surface()`: 3D surfaces (requires a numeric matrix).

### 4. Layout and Customization
Use `layout()` to modify axes, titles, legends, and margins.
```R
plot_ly(mtcars, x = ~wt, y = ~mpg) %>%
  add_markers() %>%
  layout(
    title = "Customized Plot",
    xaxis = list(title = "Weight", gridcolor = "white"),
    yaxis = list(title = "MPG"),
    paper_bgcolor = "#ebebeb"
  )
```

### 5. Subplots
Combine multiple plotly objects into a single view.
```R
p1 <- plot_ly(mtcars, x = ~wt, y = ~mpg) %>% add_markers()
p2 <- plot_ly(mtcars, x = ~wt, y = ~hp) %>% add_markers()
subplot(p1, p2, nrows = 2, shareX = TRUE)
```

### 6. Animations
Map a variable to the `frame` argument to create animations.
```R
df <- data.frame(
  x = c(1, 2, 1, 2), 
  y = c(1, 2, 2, 1), 
  f = c(1, 1, 2, 2)
)
plot_ly(df, x = ~x, y = ~y, frame = ~f, type = 'scatter', mode = 'markers')
```

## Shiny Integration
In Shiny UI, use `plotlyOutput()`. In the Server, use `renderPlotly()`.
To access user interactions (clicks, brushes, hovers) in Shiny, use `event_data()`.
```R
# Server side
output$plot <- renderPlotly({
  plot_ly(mtcars, x = ~wt, y = ~mpg)
})

# Accessing click data
observeEvent(event_data("plotly_click"), {
  d <- event_data("plotly_click")
  print(d)
})
```

## Tips and Best Practices
- **Formula Syntax**: Always use `~` before variable names when mapping data inside `plot_ly()` or `add_trace()`.
- **Performance**: For very large datasets, use `toWebGL()` to improve rendering performance in the browser.
- **Piping**: The package natively supports the `magrittr` pipe (`%>%`) for layering.
- **Inspecting JSON**: Use `plotly_json(p)` to see the underlying data structure being sent to the JavaScript library for debugging.

## Reference documentation
- [plotly: Create Interactive Web Graphics via 'plotly.js'](./references/reference_manual.md)