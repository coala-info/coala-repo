---
name: bioconductor-shiny.gosling
description: This package provides an R wrapper for Gosling.js to create interactive, scalable genomic data visualizations within Shiny applications. Use when user asks to integrate Gosling visualizations into R, build interactive genomic tracks, or render declarative genomics charts in Shiny.
homepage: https://bioconductor.org/packages/release/bioc/html/shiny.gosling.html
---

# bioconductor-shiny.gosling

## Overview
The `shiny.gosling` package acts as an R wrapper for Gosling.js, a declarative grammar for interactive genomics data visualization. It allows R users to integrate scalable, high-performance genomic visualizations directly into Shiny applications. It follows a component-based architecture where users define tracks, views, and layouts using R functions that map to Gosling's JSON specification.

## Core Workflow

### 1. Basic Application Structure
A `shiny.gosling` app requires the standard UI/Server structure with specific initialization functions.

```r
library(shiny)
library(shiny.gosling)

ui <- fluidUI(
  use_gosling(), # Required to initialize dependencies
  goslingOutput("my_plot")
)

server <- function(input, output, session) {
  output$my_plot <- renderGosling({
    # Gosling definition goes here
    gosling(
      add_track(...)
    )
  })
}

shinyApp(ui, server)
```

### 2. Defining Tracks
Tracks are the building blocks of a visualization. Use `add_track()` to specify data sources, marks, and visual encodings.

- **Data**: Use `data_track()` to point to files (CSV, BigWig, Multivec, Beddb).
- **Marks**: Common marks include `rect`, `bar`, `line`, `area`, `point`, `triangle`, and `text`.
- **Encodings**: Map data fields to visual channels like `x`, `y`, `color`, `size`, and `row`.

```r
track <- add_track(
  data = data_track(
    url = "https://server.com/data.bigwig",
    type = "bigwig"
  ),
  mark = "line",
  x = visual_channel_x(field = "position", type = "genomic"),
  y = visual_channel_y(field = "value", type = "quantitative"),
  color = visual_channel_color(value = "blue"),
  width = 600, height = 200
)
```

### 3. Composing Views
Combine multiple tracks into a single view or arrange multiple views into a layout.

- **Single View**: `compose_view(tracks = list(track1, track2))`
- **Multiple Views**: Use `arrange_views()` to set the layout (linear, circular, or matrix).

### 4. Interactivity and Shiny Integration
- **Zooming/Panning**: Handled automatically by the Gosling engine.
- **Reactive Updates**: Use `observeEvent` or `reactive` expressions in the server to update the `renderGosling` output based on Shiny inputs (e.g., dropdowns for chromosome selection).
- **Brushing/Clicking**: Use `input$my_plot_brushed` or `input$my_plot_clicked` (if enabled in the spec) to capture user interactions back into R.

## Key Functions Reference

- `use_gosling()`: Must be called in the UI to load JavaScript/CSS assets.
- `goslingOutput(outputId)`: UI placeholder for the plot.
- `renderGosling(expr)`: Server-side function to render the plot.
- `gosling(component)`: The top-level function to create a Gosling object.
- `add_track(...)`: Defines a single genomic track.
- `visual_channel_*()`: Functions to define specific aesthetics (x, y, color, size, text, etc.).
- `data_track()`: Defines the data source and type.

## Tips for Success
- **Genomic Coordinates**: Always set `type = "genomic"` for X/Y channels when mapping to chromosome positions.
- **Circular Layouts**: To create a circos-style plot, set `layout = "circular"` within the `gosling()` or `compose_view()` call.
- **Data Hosting**: Gosling.js often requires data to be served via HTTP/HTTPS or indexed formats (like `.tbi` or `.bw`). For local files in Shiny, ensure they are in the `www/` directory or handled via a local file server if they are large genomic formats.
- **JSON Validation**: If a plot doesn't render, check the browser console. `shiny.gosling` converts R lists to JSON; ensure the structure matches the Gosling.js schema.

## Reference documentation
- [shiny.gosling Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/shiny.gosling.html)