---
name: bioconductor-tkwidgets
description: This tool provides Tcl/Tk-based graphical user interfaces for data import, package exploration, and object management in R. Use when user asks to import data via a wizard, explore R package contents and vignettes, browse environment objects, or build custom interactive widgets.
homepage: https://bioconductor.org/packages/release/bioc/html/tkWidgets.html
---


# bioconductor-tkwidgets

name: bioconductor-tkwidgets
description: Use this skill when working with the Bioconductor R package tkWidgets to create or interact with Tcl/Tk-based graphical user interfaces (GUIs). This includes importing data via the importWizard, exploring R packages (pExplorer), viewing vignettes (vExplorer), browsing objects (objectBrowser), or building custom widgets using the widgetTools framework.

## Overview

The `tkWidgets` package provides a collection of interactive widgets for R, primarily focused on data import, package exploration, and object management within the Bioconductor ecosystem. It leverages the `tcltk` and `widgetTools` packages to provide "Excel-style" wizards and hierarchical browsers that simplify common bioinformatics workflows for users who prefer graphical interfaces over command-line interaction.

## Core Workflows

### Data Import with importWizard
The `importWizard` is a three-step GUI for importing delimited text files into R.

```r
library(tkWidgets)

# Launch the wizard
# It returns a list: [[1]] arguments used, [[2]] the imported data frame
result <- importWizard()

# Or launch with a specific file
result <- importWizard("my_data.csv")

# Access the imported data
my_df <- result[[2]]
```

*   **Step 1 (File Selection):** Browse for files, set the starting row for import, and choose between delimited or fixed-width (delimited is the primary supported mode).
*   **Step 2 (Separators):** Select delimiters (comma, tab, semicolon, etc.) and quote characters.
*   **Step 3 (Column Specs):** Define column names, data types, or choose to drop specific columns before finishing.

### Package and Vignette Exploration
These tools are useful for developers and users to navigate installed Bioconductor resources.

*   **pExplorer(package, path):** Explore the directory structure and file contents of a specific package.
    ```r
    pExplorer("tkWidgets")
    ```
*   **vExplorer(package):** Interactive browser for package vignettes. It allows users to view PDFs and execute code chunks sequentially.
    ```r
    vExplorer("Biobase")
    ```
*   **eExplorer(package):** Specifically designed to browse and execute example code found in a package's help files.
    ```r
    eExplorer("tkWidgets")
    ```

### Object and File Browsing
*   **objectBrowser():** Opens a window to browse objects currently in the R Global Environment. Users can select objects to return them to the console.
*   **fileBrowser():** A widget for selecting one or multiple files from local directories.

## Custom Widget Construction
The package allows building custom interfaces by combining `button` objects and `widget` layouts.

```r
# Create a simple environment for the widget
myEnv <- new.env(hash = TRUE)

# Define a button
btn <- button(wName = "myBtn", wValue = "Click Me", 
              wFuns = list(command = function() print("Hello World")), 
              wEnv = myEnv)

# Display in a widget window
if(interactive()){
  widget(wTitle = "My App", list(A = list(btn)), env = myEnv)
}
```

## Tips and Best Practices
*   **Interactive Mode:** Most functions in this package require an interactive R session. They will fail or hang in non-interactive/headless environments.
*   **Return Values:** Many widgets return values invisibly. Always assign the function call to a variable (e.g., `val <- objectBrowser()`) to capture the user's selection.
*   **Sequential Execution:** In `vExplorer`, code chunks must be evaluated sequentially. Buttons for later chunks remain inactive until previous ones are executed to maintain state consistency.

## Reference documentation
- [Expected behavior of importWizard](./references/importWizard.md)
- [Examples of some of the widgets](./references/tkWidgets.md)