---
name: bioconductor-interactivedisplaybase
description: This tool provides a framework for launching interactive Shiny-based web applications to visualize and subset R and Bioconductor objects. Use when user asks to interactively explore data frames, launch a GUI for data visualization, or subset data objects through a browser-based interface.
homepage: https://bioconductor.org/packages/release/bioc/html/interactiveDisplayBase.html
---


# bioconductor-interactivedisplaybase

name: bioconductor-interactivedisplaybase
description: Use this skill to interactively visualize and subset R objects using the interactiveDisplayBase package. This skill is essential when a user needs to launch a Shiny-based web interface to explore data frames or Bioconductor objects and return modified or subsetted data back to the R console.

# bioconductor-interactivedisplaybase

## Overview
The `interactiveDisplayBase` package provides a framework for launching interactive, browser-based applications (Shiny) directly from the R console. Its primary purpose is to allow users to visually explore, modify, and subset data objects through a Graphical User Interface (GUI) and seamlessly bring those changes back into the R environment.

## Core Workflow

### Launching the Interface
The primary function is `display()`. It automatically detects the object type and generates an appropriate Shiny UI.

```r
library(interactiveDisplayBase)

# Basic usage to view an object
display(mtcars)
```

### Capturing Interactive Results
To save the subsets or modifications made within the web GUI back to your R session, use the assignment operator. The R session will remain "busy" until the application window is closed or the "send back to R" button is clicked in the interface.

```r
# Capture the subset selected in the GUI
selected_data <- display(mtcars)
```

### Supported Objects
While `interactiveDisplayBase` serves as a base for other Bioconductor visualization packages, it natively supports:
- Data frames (table-based filtering and selection)
- Matrix objects
- Various Bioconductor-specific data structures (depending on installed methods)

## Usage Tips
- **Browser Dependency**: The function opens the system's default web browser. Ensure your environment allows launching local web servers (standard for local RStudio/R sessions).
- **Blocking Calls**: Calling `display()` is a blocking operation. You cannot run other R commands in the same console until the Shiny application is terminated.
- **Data Return**: Always check the documentation of the specific object method to see what data is returned (e.g., a subset of the data frame vs. indices).

## Reference documentation
- [interactiveDisplayBase](./references/interactiveDisplayBase.md)