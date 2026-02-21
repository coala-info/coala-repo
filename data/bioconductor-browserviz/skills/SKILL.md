---
name: bioconductor-browserviz
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BrowserViz.html
---

# bioconductor-browserviz

## Overview

BrowserViz is a base class that facilitates "loose coupling" between R and a web browser. Unlike frameworks that create R representations of web objects, BrowserViz focuses on high-level message passing via websockets and JSON. It allows R to act as a controller for sophisticated Javascript-based visualizations (like d3 or cytoscape.js) while keeping the two environments independent.

## Core Workflow

### 1. Initialization
To start a BrowserViz session, you must point to an HTML/JS file that contains the client-side websocket logic.

```r
library(BrowserViz)
library(jsonlite)

# Locate the demo HTML file included in the package
browserFile <- system.file(package="BrowserViz", "browserCode", "dist", "bvDemoApp.html")

# Initialize the application (opens a browser window/tab)
if(BrowserViz::webBrowserAvailableForTesting()){
   bvApp <- BrowserViz(browserFile=browserFile, quiet=TRUE)
}
```

### 2. Message Protocol
Messages are passed as JSON objects with four required fields:
- `cmd`: The operation to perform.
- `status`: Usually "request" for outgoing messages.
- `callback`: The function name the receiver should call upon completion.
- `payload`: The data (string, list, or complex nested structure).

### 3. Common Methods
The following methods are available on a `BrowserViz` object:

- `getBrowserWindowTitle(obj)`: Returns the current title of the browser window.
- `setBrowserWindowTitle(obj, newTitle)`: Updates the browser window title.
- `getBrowserWindowSize(obj)`: Returns a list with width and height.
- `displayHTMLInDiv(obj, htmlText, divId)`: Injects HTML content into a specific div in the browser.
- `roundTripTest(obj, data)`: Sends data to the browser and expects it to be returned immediately; useful for testing connection integrity.
- `closeWebSocket(obj)`: Properly terminates the connection.

### 4. Data Exchange Example
```r
# Sending a list to the browser and getting it back
data_to_send <- list(a = 1:5, b = "test")
returned_json <- roundTripTest(bvApp, data_to_send)
returned_data <- fromJSON(returned_json)

# Updating the UI
displayHTMLInDiv(bvApp, "<h1>Hello from R</h1>", "bvDemoDiv")
```

## Tips for Usage
- **Subclassing**: BrowserViz is designed to be a base class. For complex apps, create an S4 class that inherits from BrowserViz.
- **Port Management**: By default, BrowserViz searches for an available port. You can specify a port or range during initialization if needed.
- **JSON Conversion**: Use `jsonlite` to handle the conversion between R lists/data frames and the JSON format required by the websocket.
- **Event Loop**: BrowserViz handles the websocket polling; ensure your R session remains active to receive callbacks.

## Reference documentation
- [BrowserViz: A base class providing simple, extensible message passing between your R session and web browser, for interactive data visualization.](./references/BrowserViz.Rmd)
- [BrowserViz: A base class providing simple, extensible message passing between your R session and web browser, for interactive data visualization.](./references/BrowserViz.md)