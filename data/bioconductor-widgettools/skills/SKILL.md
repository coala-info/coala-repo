---
name: bioconductor-widgettools
description: This tool creates and manages interactive GUI widgets in R using S4 classes and the Model-View-Controller pattern. Use when user asks to build custom dialog boxes, create interactive data entry interfaces, or manage Tcl/Tk UI elements within Bioconductor workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/widgetTools.html
---

# bioconductor-widgettools

name: bioconductor-widgettools
description: Create and manage interactive GUI widgets in R using S4 classes and the Model-View-Controller (MVC) pattern. Use this skill when you need to build custom dialog boxes, file browsers, or interactive data entry interfaces within Bioconductor workflows without writing low-level Tcl/Tk code.

## Overview

The `widgetTools` package simplifies the creation of interactive R widgets by encapsulating Tcl/Tk functionality into S4 classes. It follows the Model-View-Controller (MVC) pattern:
- **Model (`pWidget`)**: Stores the data and state of individual UI elements.
- **View (`widgetView`)**: Manages the visual representation and low-level Tcl/Tk IDs.
- **Controller (`widget`)**: Orchestrates multiple `pWidget` objects and handles event logic.

## Core Workflow

### 1. Initialize an Environment
Always create a dedicated environment to store and manipulate your widget objects to avoid global namespace pollution and facilitate data retrieval.

```r
library(widgetTools)
PWEnv <- new.env(hash = TRUE, parent = parent.frame(1))
```

### 2. Define UI Elements (pWidgets)
Create individual components using specific constructor functions. Each requires a `wName`, `wValue`, and the `wEnv`.

- **Labels & Entries**: `label()`, `entryBox()`
- **Buttons**: `button()` (use `wFuns = list(command = function)` for actions)
- **Selections**: `listBox()`, `radioButton()`, `checkButton()`
- **Text Areas**: `textBox()`

Example of a button that updates an entry box:
```r
# Define the action
browseAction <- function() {
    tempValue <- tclvalue(tkgetOpenFile())
    target <- get("entry1", env = PWEnv)
    wValue(target) <- tempValue
    assign("entry1", target, env = PWEnv)
}

# Create widgets
label1 <- label(wName = "label1", wValue = "File:", wEnv = PWEnv)
entry1 <- entryBox(wName = "entry1", wValue = "", wEnv = PWEnv)
btn1 <- button(wName = "btn1", wValue = "Browse", 
               wFuns = list(command = browseAction), wEnv = PWEnv)
```

### 3. Define Layout
Layout is defined by a nested list. The outer list represents **rows** (vertical), and the inner lists represent **columns** (horizontal) within those rows.

```r
pWidgets <- list(
    row1 = list(label1 = label1, entry1 = entry1, btn1 = btn1),
    row2 = list(submit = button(wName = "submit", wValue = "Finish", wEnv = PWEnv))
)
```

### 4. Construct and Display the Widget
Use the `widget()` function to render the GUI.

```r
aWidget <- widget(wTitle = "My App", 
                  pWidgets = pWidgets, 
                  funs = list(), 
                  preFun = function() print("Starting..."),
                  postFun = function() print("Closing..."), 
                  env = PWEnv)
```

### 5. Retrieve Values
After the user interacts with the widget, extract the updated values using the `wValue()` accessor.

```r
# Accessing a specific value from the widget object
val <- wValue(pWidgets(aWidget)[["row1"]][["entry1"]])
```

## Key Functions and Accessors

- `wValue(obj)` / `wValue(obj) <- value`: Get or set the internal value of a widget.
- `wName(obj)`: Get or set the internal name.
- `makeViewer()`: A helper for creating simple text viewers.
- `tooltip()`: Add tooltips to widgets for better UX.

## Tips for Success
- **Unique Names**: Ensure every `wName` is unique within the environment.
- **Named Vectors**: For `listBox`, `radioButton`, and `checkButton`, use named vectors in `wValue`. The names become the labels shown to the user, while the logical values (TRUE/FALSE) represent the selection state.
- **Interactive Mode**: GUI elements require an active X11/Windows/Quartz session. Use `if(interactive())` when wrapping widget code in scripts.

## Reference documentation
- [Building a widget using widgetTools](./references/widgetTools.md)