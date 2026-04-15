---
name: r-htmlwidgets
description: The htmlwidgets package provides a framework for creating R bindings to JavaScript libraries to produce interactive web visualizations. Use when user asks to create custom interactive widgets, bridge R data with JavaScript libraries, or develop visualization components for Shiny and R Markdown.
homepage: https://cloud.r-project.org/web/packages/htmlwidgets/index.html
---

# r-htmlwidgets

## Overview
The `htmlwidgets` package provides a framework for creating R bindings to JavaScript libraries. It allows R users to create interactive visualizations that work seamlessly across the R console, R Markdown, and Shiny. Every widget consists of dependencies (JS/CSS), an R binding (to pass data), and a JavaScript binding (to render the data).

## Installation
Install the package from CRAN:
```r
install.packages("htmlwidgets")
```

## Core Workflow: Creating a Widget
To create a new widget, it is recommended to use the scaffolding function within an R package structure:

1. **Create Scaffolding**:
   ```r
   # In a new R package directory
   htmlwidgets::scaffoldWidget("mywidget")
   ```
2. **Define R Binding**: Edit `R/mywidget.R`. Use `createWidget()` to pass data (`x`) and options.
   ```r
   mywidget <- function(message, width = NULL, height = NULL) {
     x <- list(message = message)
     htmlwidgets::createWidget("mywidget", x, width = width, height = height)
   }
   ```
3. **Define JS Binding**: Edit `inst/htmlwidgets/mywidget.js`. Implement the `factory` and `renderValue` methods.
   ```javascript
   HTMLWidgets.widget({
     name: "mywidget",
     type: "output",
     factory: function(el, width, height) {
       return {
         renderValue: function(x) {
           el.innerText = x.message;
         },
         resize: function(width, height) {}
       };
     }
   });
   ```

## Data Transformation
R objects are converted to JSON via `jsonlite`. Use these helpers in the JS binding if the library requires specific formats:
- `HTMLWidgets.dataframeToD3(x.data)`: Converts R data frames (column-major) to D3-friendly row-major arrays.
- `HTMLWidgets.transposeArray2D(x.matrix)`: Transposes 2D arrays.

To customize JSON serialization in R, attach the `TOJSON_ARGS` attribute to your data:
```r
attr(x, "TOJSON_ARGS") <- list(digits = 7, na = "string")
```

## Passing JavaScript Functions
To pass a raw JavaScript function from R (e.g., a callback), wrap the string in `JS()`:
```r
options <- list(clickCallback = JS("function(e) { alert('Clicked!'); }"))
```

## Shiny Integration
Every widget should include boilerplate functions for Shiny:
```r
mywidgetOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "mywidget", width, height, package = "mypackage")
}

renderMywidget <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) }
  htmlwidgets::shinyRenderWidget(expr, mywidgetOutput, env, quoted = TRUE)
}
```

## Sizing Policies
Control how widgets behave in different contexts (Viewer, Browser, Knitr) using `sizingPolicy()`:
```r
htmlwidgets::createWidget(
  name, x,
  sizingPolicy = htmlwidgets::sizingPolicy(
    viewer.padding = 0,
    browser.fill = TRUE,
    knitr.defaultWidth = 800
  )
)
```

## Reference documentation
- [HTML Widgets: Advanced Topics](./references/develop_advanced.Rmd)
- [Introduction to HTML Widgets](./references/develop_intro.Rmd)
- [HTML Widget Sizing](./references/develop_sizing.Rmd)