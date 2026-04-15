---
name: bioconductor-mvcclass
description: This package provides a framework for implementing the Model-View-Controller design pattern in R to manage complex data-view relationships. Use when user asks to create linked interactive data visualizations, manage MVC components in Bioconductor workflows, or synchronize data models with multiple views using a messaging system.
homepage: https://bioconductor.org/packages/release/bioc/html/MVCClass.html
---

# bioconductor-mvcclass

name: bioconductor-mvcclass
description: A skill for working with the MVCClass R package from Bioconductor. Use this skill when you need to implement or interact with the Model-View-Controller (MVC) design pattern in R, specifically for creating linked, interactive data visualizations or managing complex data-view relationships in Bioconductor workflows.

# bioconductor-mvcclass

## Overview

The `MVCClass` package provides a foundational framework for the Model-View-Controller (MVC) design pattern in R. It is primarily used as a "backend" package for other Bioconductor tools (like `iSPlot`, `iSNetwork`, and `BioMVCClass`) to create interactive, linked views of data. It defines virtual and concrete classes for Models (data storage), Views (visual representations), and Controllers (logic/coordination), along with a messaging system that allows these components to communicate (e.g., updating a view when the model changes).

## Core Classes and Structure

### 1. MVC Objects
The MVC object binds a model, its views, and a controller together.
- `singleModelMVC`: Represents a standalone MVC object.
- `linkedModelMVC`: Represents an MVC object that can have a `parentMVC` and a `childMVCList`, allowing for hierarchical data relationships.

### 2. Model Classes (`gModel`)
Models store and update data.
- `dfModel`: A concrete class for data frames or matrices.
- Slots include `modelData` (the dataset), `linkData` (functions to link to parents/children), and `modelName`.

### 3. View Classes (`genView`)
Views are visual depictions of the model.
- `spreadView`: A spreadsheet-style view.
- `plotView`: A virtual class for plots.
- `sPlotView`: Scatterplot view (slots: `xvar`, `yvar`, `dfRows`).
- `qqPlotView`: QQ-plot view.

### 4. Message Classes (`gMessage`)
Messages facilitate communication when data or views change.
- `gAddDataMessage` / `gAddViewMessage`: For creating new components.
- `gUpdateDataMessage` / `gUpdateViewMessage`: For synchronizing changes.
- `gSendParentMessage` / `gSendChildMessage`: For propagating changes across linked MVC objects.

## Typical Workflow

While `MVCClass` is often used internally by other packages, you can interact with its structure using S4 methods:

### Initializing a Model
```r
# Create a data frame model
my_model <- new("dfModel", 
                modelData = my_dataframe, 
                modelName = "ExampleModel")
```

### Creating an MVC Container
```r
# Bind the model into a single MVC object
my_mvc <- new("singleModelMVC", 
              model = my_model, 
              viewList = list(), 
              controller = new.env())
```

### Handling Messages
The package defines generic functions that must be implemented by the user or inheriting packages to handle interactivity:
- `handleMessage(message, mvc)`: Processes a message object within an MVC context.
- `updateModel(model, message)`: Updates the data within a model based on a message.
- `updateView(view, message)`: Refreshes a specific view.

### Interactivity and Callbacks
Use the `gEventFun` class to wrap callback functions for events like mouse clicks or movements:
```r
# Define a callback function
my_callback <- function(item) { 
  print(paste("Selected:", item)) 
}

# Wrap in gEventFun
event_handler <- new("gEventFun", 
                     callFun = my_callback, 
                     shortName = "Print Selection")
```

## Key Generic Functions
When extending this package, you will likely need to define methods for:
- `redrawView(view)`: To completely refresh a graphic.
- `clickEvent(view, ...)`: To handle mouse clicks.
- `motionEvent(view, ...)`: To handle mouse-over events.
- `identifyView(view, ...)`: To identify specific data points on a plot.

## Reference documentation
- [MVCClass](./references/MVCClass.md)