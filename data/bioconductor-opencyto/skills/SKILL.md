---
name: bioconductor-opencyto
description: This tool provides a data-driven framework for automated, hierarchical gating of flow cytometry data using spreadsheet-based templates and various gating algorithms. Use when user asks to automate flow cytometry gating, create or apply CSV gating templates, perform 1D or 2D automated gating, or manage GatingSet objects within the Bioconductor ecosystem.
homepage: https://bioconductor.org/packages/release/bioc/html/openCyto.html
---

# bioconductor-opencyto

name: bioconductor-opencyto
description: Automated gating of flow cytometry data using the openCyto framework. Use this skill to create and apply hierarchical gating templates (CSV), perform 1D/2D automated gating (mindensity, flowClust, singletGate), and manage GatingSet objects within the Bioconductor ecosystem.

# bioconductor-opencyto

## Overview
The `openCyto` package provides a data-driven framework for automating flow cytometry gating. It mimics manual gating hierarchies by using a spreadsheet-based "gating template" to define sequential gating steps. It integrates with `flowCore` and `flowWorkspace` to manage `GatingSet` objects, allowing for reproducible, high-throughput analysis of flow data.

## Core Workflow

### 1. Data Preparation
Before gating, data must be loaded, compensated, and transformed.
```r
library(openCyto)
library(flowWorkspace)

# Load data
fcs_files <- list.files(pattern = ".fcs", full.names = TRUE)
cs <- load_cytoset_from_fcs(fcs_files)
gs <- GatingSet(cs)

# Compensation and Transformation
compMat <- spillover(cs[[1]])$SPILL # or load from workspace
gs <- compensate(gs, compMat)
trans <- estimateLogicle(gs[[1]], channels = colnames(compMat))
gs <- transform(gs, trans)
```

### 2. Defining Gating Templates (CSV)
The power of `openCyto` lies in the CSV template. Key columns include:
- **alias**: Name of the population.
- **pop**: Population pattern (`+`, `-`, `+/-`, `++`, `+/-+/-`).
- **parent**: The alias of the parent population (or `root`).
- **dims**: Channels/markers (e.g., `FSC-A`, `CD3,CD4`).
- **gating_method**: The algorithm (e.g., `mindensity`, `flowClust`, `singletGate`).
- **gating_args**: Parameters for the method (e.g., `gate_range=c(1,3)`).

### 3. Applying the Template
```r
# Load the template
gt <- gatingTemplate("my_gating_scheme.csv")

# Run the automated gating pipeline
gt_gating(gt, gs)

# Visualize the hierarchy
plot(gs[[1]])
```

## Automated Gating Methods

### 1D Gating
- **mindensity**: Finds the minimum between two peaks. Use `gate_range` or `adjust` to fine-tune.
- **tailgate**: Used when only one major peak is present; identifies the "tail" of the distribution.
- **quantileGate**: Sets a cutpoint based on a specific event quantile (useful for rare populations).

### 2D Gating
- **singletGate**: Identifies single cells using Area vs. Height (e.g., `FSC-A, FSC-H`).
- **flowClust.2d**: Uses clustering to identify populations. Requires `K` (number of clusters) and optionally `target`.
- **boundary**: Constructs a rectangle gate to filter out boundary events.
- **quadGate.tmix**: Fits a t-mixture model to identify four quadrants when markers are not well-resolved.

## Interactive Gating (No CSV)
For prototyping, you can add or remove methods directly to a `GatingSet`:
```r
# Add a method
gs_add_gating_method(gs, alias = "lymph", pop = "+", parent = "root", 
                     dims = "FSC-A,SSC-A", gating_method = "flowClust", 
                     gating_args = "K=2")

# Remove the last added method
gs_remove_gating_method(gs)
```

## Tips for Success
- **Population Expansion**: Using `pop = "+/-+/-"` on two dimensions automatically generates all four quadrant populations and the necessary reference gates.
- **Collapsing Data**: Set `collapseDataForGating = TRUE` in the template to pool samples for gate calculation, which is useful when individual samples have low event counts.
- **Node Management**: Use `gs_pop_set_visibility()` to hide intermediate `refGate` nodes and `gs_pop_set_name()` to clean up the hierarchy for final reporting.

## Reference documentation
- [How to use different auto gating functions](./references/HowToAutoGating.md)
- [How to write a csv gating template](./references/HowToWriteCSVTemplate.md)
- [An Introduction to the openCyto package](./references/openCytoVignette.md)