---
name: bioconductor-shinytandem
description: This package provides a Shiny-based web interface for visualizing protein identification results and managing X!Tandem searches. Use when user asks to visualize rTANDEM results, launch X!Tandem searches through a GUI, or manage protein identification search parameters.
homepage: https://bioconductor.org/packages/3.8/bioc/html/shinyTANDEM.html
---

# bioconductor-shinytandem

## Overview
The `shinyTANDEM` package provides a Shiny-based web interface for the `rTANDEM` package. It allows users to visualize protein identification results, manage search parameters, and launch X!Tandem searches from within an interactive browser environment. It is specifically optimized for small to medium-sized datasets.

## Core Workflow

### Launching the Interface
The primary function is `shinyTANDEM()`. You can launch it empty or pass an existing rTANDEM result object.

```r
library(shinyTANDEM)

# Launch with an existing result object (rTANDEM result)
# shinyTANDEM(my_result_object)

# Launch empty to load files via the GUI
shinyTANDEM()
```

### Loading Data
The interface supports two main data sources:
1.  **RDS Files**: Fast loading of pre-saved R objects.
2.  **XML Files**: X!Tandem output files. 
    *   *Note*: XML parsing happens in-memory. For files larger than a few hundred MB, use `rTANDEM::GetResultFromXML()` first to create an R object, then pass that object to `shinyTANDEM()`.

### Search and Conversion
Beyond visualization, the GUI provides tools for:
*   Creating and modifying parameter objects for X!Tandem searches.
*   Launching new searches directly from the interface.
*   Converting between R objects and XML formats.

## Usage Tips
*   **Memory Management**: The GUI loads the entire dataset into memory. If the browser becomes unresponsive, consider filtering the dataset in `rTANDEM` before visualization.
*   **Exiting**: To stop the GUI and return to the R console, use `Ctrl+C` or `Esc` in the R session.
*   **Example Data**: To explore the interface with built-in data:
    ```r
    example(shinyTANDEM)
    ```

## Reference documentation
- [shinyTANDEM](./references/shinyTANDEM.md)