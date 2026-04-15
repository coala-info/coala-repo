---
name: bioconductor-flowtime
description: The flowTime package analyzes flow cytometry data from budding yeast by providing tools for automated gating, metadata annotation, and fluorescence summarization. Use when user asks to annotate flowSet objects with metadata, implement automated gating for yeast cells and singlets, or calculate summary statistics for time-course and steady-state experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/flowTime.html
---

# bioconductor-flowtime

## Overview
The `flowTime` package is designed for the analysis of flow cytometry data from budding yeast, with a focus on dynamic responses in synthetic biology. It provides tools for annotating `flowSet` objects with experimental metadata, implementing automated gating to distinguish yeast cells from debris and singlets from doublets, and summarizing fluorescence measurements across time-course or steady-state experiments.

## Core Workflow

### 1. Data Import and Annotation
Load `.fcs` files into a `flowSet` and merge them with a metadata data frame (CSV).
```r
library(flowTime)
library(flowCore)

# Load raw data
fs <- read.flowSet(path = "path/to/fcs_files", alter.names = TRUE)

# Load metadata (must contain a column matching sampleNames(fs))
annotation <- read.csv("metadata.csv")

# Annotate the flowSet
adat <- annotateFlowSet(yourFlowSet = fs, annotation_df = annotation, mergeBy = "name")
```

### 2. Automated Gating
`flowTime` uses `openCyto` and `flowClust` for reproducible gating.

*   **Yeast Gate:** Removes debris using an ellipsoid gate on FSC-A vs SSC-A.
*   **Singlet Gate:** Removes doublets by comparing FSC-A (Area) to FSC-H (Height).

```r
# Load pre-defined gates or create new ones
loadGates(gatesFile = "C6Gates.RData", path = system.file("extdata", package = "flowTime"))

# Manual creation of a yeast gate using a single merged frame for better representation
data.1frame <- adat[[1]]
exprs(data.1frame) <- fsApply(adat, exprs)
yeast_gate <- gate_flowclust_2d(data.1frame, xChannel = "FSC.A", yChannel = "SSC.A", K = 1, quantile = 0.95)

# Save gates for future use
saveGates(yeastGate = yeast_gate, dipsingletGate = my_singlets, fileName = "my_gates.RData")
```

### 3. Data Analysis
Depending on the experiment type, use `steadyState` or `summarizeFlow`.

*   **Steady-State:** Returns a data frame of every event (useful for population distributions/boxplots).
*   **Time-Course:** Returns summary statistics (mean, median, SD) per sample (useful for activation curves).

```r
# Steady-state analysis (returns all events)
ss_data <- steadyState(flowset = adat, ploidy = "diploid", only = "singlets")

# Time-course analysis (returns summary stats)
tc_summary <- summarizeFlow(adat, ploidy = "diploid", only = "singlets", channel = "FL1.A")
```

## Key Functions
*   `annotateFlowSet()`: Merges experimental metadata into the `phenoData` of a `flowSet`.
*   `createAnnotation()`: Generates a template data frame based on `sampleNames`.
*   `loadGates()` / `saveGates()`: Manages `.RData` files containing gate objects.
*   `summarizeFlow()`: Gates data and calculates summary statistics for specified channels.
*   `steadyState()`: Gates data and extracts all events into a tidy data frame.

## Tips for Yeast Cytometry
*   **Parameter Names:** Use `FSC.A` and `SSC.A` in R code to avoid "minus" operator confusion with `FSC-A`.
*   **Logicle Transform:** Use `scale_x_logicle()` in `ggcyto` plots to better visualize yeast populations near the origin.
*   **Doublet Discrimination:** Always gate for singlets when measuring signaling pathways to reduce noise from dividing cells.

## Reference documentation
- [Yeast gating](./references/gating-vignette.md)
- [Steady-state analysis of flow cytometry data](./references/steady-state-vignette.md)
- [Time course analysis of flow cytometry data](./references/time-course-vignette.md)