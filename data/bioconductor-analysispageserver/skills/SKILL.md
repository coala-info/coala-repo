---
name: bioconductor-analysispageserver
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/AnalysisPageServer.html
---

# bioconductor-analysispageserver

name: bioconductor-analysispageserver
description: Create and deploy interactive R analysis pages and web servers. Use this skill to generate interactive reports (SVG + JSON), build dynamic web applications with R backends (Rook, RApache, FastRWeb), and configure complex parameter sets for user input.

# bioconductor-analysispageserver

## Overview

The `AnalysisPageServer` package is a modular system for sharing customizable R analyses via the web. It enables the creation of interactive plots (SVG) linked to metadata (data.frames), allowing users to perform rollovers, zooming, filtering, and tagging directly in a browser. It supports both static reports (no server required) and dynamic applications (where R code runs in response to user input).

## Core Workflows

### 1. Creating Static Interactive Reports
Use this workflow to generate a self-contained directory of HTML/JS/SVG files that can be shared or hosted on any web server.

```r
library(AnalysisPageServer)

# 1. Prepare data and plot
df <- data.frame(x = rnorm(100), y = rnorm(100), label = letters[1:100])
plot_file <- tempfile(fileext = ".svg")
svg(plot_file, width = 9, height = 7)
plot(df$x, df$y, pch = 19)
dev.off()

# 2. Generate static page
# show.xy = TRUE links the SVG elements to data.frame rows by coordinates
result <- static.analysis.page(outdir = "my_report",
                               svg.files = plot_file,
                               dfs = df,
                               show.xy = TRUE,
                               title = "My Analysis")
# Open result$URL in a browser
```

### 2. Building Dynamic Services
Services are non-interactive endpoints that return data (usually JSON) or plots.

```r
# Define a handler function
my_handler <- function(n = 10) {
  return(data.frame(val = runif(n)))
}

# Build the service object
hello_service <- build.service(my_handler, name = "get_random")

# Create a registry to hold services
reg <- new.registry(hello_service)
```

### 3. Building Fully Interactive Applications
Interactive pages combine a handler function with a parameter set to create a web UI.

```r
# 1. Define handler (returns a data.frame for the table/interactivity)
volcano_handler <- function(color1 = "red", color2 = "blue") {
  col <- colorRampPalette(c(color1, color2))(50)
  image(datasets::volcano, col = col)
  return(as.data.frame(volcano)) 
}

# 2. Define the page
volcano_page <- new.analysis.page(handler = volcano_handler,
                                  name = "volcano",
                                  description = "Interactive Volcano Plot")

# 3. Register and start a local development server (Rook)
reg <- new.registry(volcano_page)
srv <- startRookAnalysisPageServer(reg, port = 3198)

# 4. Stop server when done
kill.process(srv)
```

## Parameter Configuration
Control how user inputs are rendered in the web UI using `AnalysisPageParam` objects.

- **Simple**: `simple.param(name, label, value)` for text/numeric input.
- **Dropdown**: `select.param(name, choices, allow.multiple = FALSE)`.
- **Slider**: `slider.param(name, min, max, step)`.
- **Combobox**: `combobox.param(name, uri)` for server-side search-ahead.
- **Advanced**: Set `advanced = 1` to hide parameters behind an "Advanced" toggle.
- **Conditional**: Use `show.if = list(name = "other_param", values = "trigger_val")`.

## Deployment Options

1.  **Static**: Use `static.analysis.page()`. Best for sharing fixed results.
2.  **Rook**: Use `startRookAnalysisPageServer()`. Best for local prototyping and debugging.
3.  **RApache**: Use `apache.httpd.conf()` and `rapache.app.from.registry()`. Best for stable, multi-user production environments.
4.  **FastRWeb**: Use `new.FastRWeb.analysis.page.run()`. A stable alternative to RApache using Rserve.

## Tips for Success
- **Coordinate Matching**: When using `static.analysis.page`, ensure your data.frame contains `x` and `y` columns that match the plotting order in the SVG for rollover to work correctly.
- **JSON Encoding**: The server automatically encodes return values to JSON. To return raw HTML or binary images, wrap the output in `new.response(body, content.type)`.
- **Persistence**: Use the `persistent` argument in parameter constructors to share values (like a "Study ID") across different tools in the same application.

## Reference documentation
- [AnalysisPageServer Overview](./references/AnalysisPageServer.md)
- [Deployment with Apache](./references/ApacheDeployment.md)
- [Non-interactive Servers and Rook](./references/ExampleServers.md)
- [Deployment with FastRWeb](./references/FastRWebDeployment.md)
- [Interactive Applications](./references/InteractiveApps.md)
- [Interactivity Guide](./references/Interactivity.md)
- [External Licenses](./references/Licenses.md)
- [Static Content Generation](./references/StaticContent.md)
- [Trapping Conditions](./references/TrappingConditions.md)
- [Embedding APS Datasets](./references/embedding.md)