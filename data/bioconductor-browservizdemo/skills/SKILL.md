---
name: bioconductor-browservizdemo
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/BrowserVizDemo.html
---

# bioconductor-browservizdemo

name: bioconductor-browservizdemo
description: Interactive R-to-browser x-y plotting using the BrowserViz framework. Use this skill to create web-based visualizations from R, handle websocket communications between R and a browser, and retrieve user selections (d3-based) from the browser back into the R session.

# bioconductor-browservizdemo

## Overview

The `BrowserVizDemo` package is a subclass of `BrowserViz` that provides a minimal example of interactive plotting in a web browser controlled by R. It uses JSON messages over websockets to communicate. It serves as both a functional tool for simple x-y plotting and a template for developers looking to build more complex browser-based visualization tools in Bioconductor.

## Core Workflow

### 1. Initialization
To start a session, initialize the `BrowserVizDemo` object. This will attempt to open a websocket connection and launch your default web browser.

```r
library(BrowserVizDemo)

# Initialize with a range of possible ports
plotter <- BrowserVizDemo(port=8000:8100)

# Verify the connection is ready
if(ready(plotter)) {
  print("Browser connection established.")
}
```

### 2. Basic Plotting
The package provides a simple `plot` method that sends data to the browser for rendering.

```r
# Set a title for the browser window
setBrowserWindowTitle(plotter, "My Interactive Plot")

# Plot x and y vectors
x <- 1:10
y <- (1:10)^2
plot(plotter, x, y)
```

### 3. Interactive Selection
One of the primary features is the ability to retrieve data selected by the user in the browser (via d3 mouse dragging).

```r
# After selecting points in the browser with the mouse:
selectedPoints <- getSelection(plotter)

# selectedPoints will contain the identifiers of the points highlighted in the UI
print(selectedPoints)
```

### 4. Session Management
Always close the websocket connection when the analysis is complete to free up the port.

```r
closeWebSocket(plotter)
```

## Inherited Methods
Since `BrowserVizDemo` inherits from `BrowserViz`, the following utility methods are also available:

- `port(obj)`: Returns the port being used.
- `getBrowserWindowSize(obj)`: Returns the dimensions of the browser window.
- `getBrowserWindowTitle(obj)`: Returns the current window title.
- `setBrowserWindowTitle(obj, title)`: Updates the window title.
- `send(obj, msg)`: Sends a custom four-field JSON message (cmd, status, callback, payload).

## Tips for Usage
- **Port Conflicts**: If the default port is taken, provide a range (e.g., `8000:8100`) to allow the package to find an available slot.
- **Browser Requirements**: Ensure you are using a modern HTML5 compliant browser (Chrome, Firefox, or Safari) for the d3 visualizations to render correctly.
- **Latency**: When calling `plot()`, there is a brief "sleepInterval" while R waits for the browser to acknowledge the command. This is normal behavior.

## Reference documentation
- [BrowserVizDemo](./references/BrowserVizDemo.md)