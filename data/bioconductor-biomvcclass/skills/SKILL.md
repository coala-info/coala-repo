---
name: bioconductor-biomvcclass
description: This package provides Model-View-Controller structures for managing and synchronizing interactive visualizations of Bioconductor data objects. Use when user asks to create or manage S4 classes for linked views of genomic data, define models for ExpressionSets or graphs, or implement Gene Set Enrichment structures.
homepage: https://bioconductor.org/packages/release/bioc/html/BioMVCClass.html
---

# bioconductor-biomvcclass

name: bioconductor-biomvcclass
description: Specialized skill for using the BioMVCClass R package to create and manage Model-View-Controller (MVC) structures for biological data. Use this skill when you need to define or manipulate S4 classes for linked, interactive views of genomic data, specifically involving Gene Set Enrichment (GSE), graphs, or ExpressionSets.

# bioconductor-biomvcclass

## Overview

The `BioMVCClass` package extends the base `MVCClass` framework to support Bioconductor-specific data structures. It provides a standardized way to separate data storage (Models) from visual representations (Views) for complex biological objects like graphs and expression matrices. This architecture is primarily used by developers building interactive GUI applications (like `iSNetwork`) where multiple views need to stay synchronized with an underlying data model.

## Core Model Classes

Models store data and handle updates. All models in this package inherit from `gModel`.

- **`exprModel`**: Designed for `ExpressionSet` objects.
- **`graphModel`**: Designed for `graph` objects (from the `graph` package).
- **`gseModel`**: Designed for Gene Set Enrichment data using the `GSE` class.

### The GSE (Gene Set Enrichment) Class
The package introduces a specific `GSE` class to bundle enrichment analysis components:
- `incidMat`: Incidence matrix (genes x gene sets).
- `gTestStat`: Gene-level test statistics.
- `gsTestStat`: Gene set-level test statistics.
- `expData`: The underlying experimental data.
- `descr`: Description of the gene sets.

## Core View Classes

Views represent the visual depiction of a model. They inherit from `genView` and `plotView`.

- **`graphView`**: Manages graph visualizations. Includes a `grLayout` slot for `Ragraph` objects (from `Rgraphviz`).
- **`heatmapView`**: Manages heatmap visualizations. Includes slots for `ordering` (dendrogram info) and `rNames` (row names).

## Typical Workflow

### 1. Initialize a Model
To create a model, you wrap your Bioconductor data object in the appropriate class constructor.

```r
library(BioMVCClass)
library(Biobase)

# Example for an ExpressionSet model
# assuming 'myExprSet' is an existing ExpressionSet
myModel <- new("exprModel", 
               modelData = myExprSet, 
               modelName = "MyExpressionModel")
```

### 2. Create a View
Views are linked to models via the `dataName` slot, which should match the `modelName` of the model.

```r
# Example for a Heatmap view
myView <- new("heatmapView", 
              dataName = "MyExpressionModel", 
              win = myGtkWindow) # Requires a Gtk window object
```

### 3. Linking Models (Parent-Child)
Models use the `linkData` slot (containing `toParent` and `fromParent` functions) to synchronize data across different levels of abstraction (e.g., from a graph of pathways down to an expression matrix of genes).

## Key Tips
- **Dependencies**: This package relies heavily on `MVCClass`, `Biobase`, `graph`, and `Rgraphviz`. Ensure these are loaded.
- **Interactive Context**: Most classes in this package expect a GUI environment (specifically `RGtk2` or similar Gtk-based windows) to populate the `win` and `drArea` slots.
- **Data Integrity**: When updating a model, use the provided methods to ensure all linked views are notified of the change to maintain synchronization.

## Reference documentation

- [BioMVCClass](./references/BioMVCClass.md)