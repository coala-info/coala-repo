---
name: bioconductor-rnainteract
description: This package analyzes quantitative pairwise genetic interaction screens from high-throughput RNAi data. Use when user asks to create RNAinteract objects from text files, estimate main effects, compute genetic interaction scores, perform statistical testing, or generate HTML reports for screening data.
homepage: https://bioconductor.org/packages/3.6/bioc/html/RNAinteract.html
---

# bioconductor-rnainteract

name: bioconductor-rnainteract
description: Analysis of quantitative pairwise interaction screens (RNAi). Use this skill to create RNAinteract objects from text files, estimate main effects, compute genetic interaction scores (PI-scores), perform statistical testing (limma, Hotelling T2), and generate HTML reports for high-throughput screening data.

# bioconductor-rnainteract

## Overview

The `RNAinteract` package provides a pipeline for analyzing data from quantitative genetic interaction screens, specifically those using a template-query design. It allows for the estimation of single-perturbation effects (main effects) and the identification of pairwise interactions (PI-scores) that deviate from a non-interacting model. The package supports multiple readout channels, replicates, and automated HTML report generation for quality control and hit visualization.

## Core Workflow

### 1. Data Preparation and Object Creation
The package requires five specific tab-delimited text files: `Targets.txt`, `Reagents.txt`, `TemplateDesign.txt`, `QueryDesign.txt`, and `Platelist.txt`.

```r
library(RNAinteract)

# Create RNAinteract object from a directory containing the required files
inputpath <- "path/to/your/data"
sgi <- createRNAinteractFromFiles(name = "My Interaction Screen", path = inputpath)
```

### 2. Estimating Effects and Interactions
The analysis follows a sequential estimation process.

```r
# 1. Estimate main effects (single perturbation effects)
# Usually normalized against a negative control like "Ctrl_Fluc"
sgi <- estimateMainEffect(sgi, use.query = "Ctrl_Fluc")

# 2. Compute Pairwise Interaction (PI) scores
sgi <- computePI(sgi)

# 3. Summarize replicates (optional)
sgim <- summarizeScreens(sgi, screens = c("1", "2"))
sgi <- bindscreens(sgi, sgim)
```

### 3. Statistical Testing
Compute p-values using different methods depending on the experimental design.

```r
# Standard t-test with regularized variance
sgi <- computePValues(sgi)

# Moderated t-test using limma
sgi_limma <- computePValues(sgi, method = "limma")

# Multivariate testing for multiple channels
sgi_T2 <- computePValues(sgi, method = "HotellingT2")
```

### 4. Data Access
Use `getData` to extract specific values from the object.

```r
# Extract PI-scores as a target matrix
pi_matrix <- getData(sgi, type = "pi", format = "targetMatrix")

# Extract p-values
p_vals <- getData(sgi, type = "p.value", format = "targetMatrix")

# Extract raw data (inverse log-transform if necessary)
raw_data <- getData(sgi, type = "data", do.inv.trafo = TRUE)
```

### 5. Visualization and Reporting
The package includes built-in plotting functions and a comprehensive HTML reporter.

```r
# Plot a heatmap of interactions for a specific channel
plotHeatmap(sgi, screen = "1", channel = "nrCells")

# Double perturbation plot for a specific gene
plotDoublePerturbation(sgi, screen = "1", channel = "nrCells", target = "Ras85D")

# Generate a full HTML report
outputpath <- "RNAinteract_Report"
report <- startReport(outputpath)
reportAnnotation(sgi, path = outputpath, report = report)
reportStatistics(sgi, path = outputpath, report = report)
reportGeneLists(sgi, path = outputpath, report = report)
reportHeatmap(sgi, path = outputpath, report = report)
endReport(report)
```

## Tips and Best Practices
- **File Formats**: Ensure `Targets.txt` contains the mandatory columns `TID`, `Symbol`, and `group`.
- **Log Transformation**: Data in `RNAinteract` objects is typically log-transformed by default. Use `do.inv.trafo = TRUE` in `getData` if you need the original scale.
- **Control Grouping**: Correctly labeling "neg" and "pos" controls in the `group` column of `Targets.txt` is essential for meaningful quality control plots in the HTML report.
- **Channel Names**: Use `getChannelNames(sgi)` to verify the available readout channels before plotting or data extraction.

## Reference documentation
- [Analysis of Pairwise Interaction Screens](./references/RNAinteract.md)