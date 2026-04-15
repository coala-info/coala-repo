---
name: bioconductor-grmetrics
description: The GRmetrics package calculates and visualizes growth rate inhibition metrics to account for cell proliferation rates in drug response assays. Use when user asks to calculate GR50 or IC50 values, fit dose-response curves, or visualize growth rate inhibition data using scatterplots and boxplots.
homepage: https://bioconductor.org/packages/release/bioc/html/GRmetrics.html
---

# bioconductor-grmetrics

## Overview

The `GRmetrics` package provides tools to calculate and visualize growth rate inhibition (GR) metrics. Unlike traditional metrics like IC50, GR metrics account for the number of cell divisions during an assay, preventing slow-growing cell lines from appearing artificially resistant. It calculates both GR-based metrics (GR50, GRmax, GEC50, GRinf, GR_AOC) and traditional relative cell count metrics (IC50, Emax, AUC).

## Core Workflow

### 1. Data Preparation

The package supports two primary input formats via the `GRfit` function:

**Case A (Short Format - Recommended):**
Each row contains the treated cell count and its corresponding control/time-0 values.
- `concentration`: Dose (not log-transformed).
- `cell_count`: Count at the end of treatment.
- `cell_count__time0`: Count at the start of treatment (Time 0).
- `cell_count__ctrl`: Count of untreated control at the end of the assay.

**Case C (Long Format):**
Treated and control measurements are stacked in the same columns.
- `concentration`: 0 for controls.
- `time`: 0 for Time 0 measurements, or the assay duration (e.g., 72) for endpoint measurements.

### 2. Calculating Metrics

Use `GRfit` to process the data. It returns a `SummarizedExperiment` object.

```r
library(GRmetrics)

# For Case A data
drc_output <- GRfit(inputData = my_data, 
                    groupingVariables = c('cell_line', 'treatment'))

# For Case C data
drc_output <- GRfit(inputData = my_data, 
                    groupingVariables = c('cell_line', 'treatment'), 
                    case = "C")
```

### 3. Accessing Results

Extract specific tables from the `SummarizedExperiment` object:

- `GRgetMetrics(drc_output)`: Returns the fitted parameters (GR50, GRmax, IC50, etc.) and goodness-of-fit statistics.
- `GRgetValues(drc_output)`: Returns the original data appended with calculated GR values and relative cell counts for each row.
- `GRgetDefs(drc_output)`: Returns definitions for all calculated metrics.
- `GRgetGroupVars(drc_output)`: Returns the variables used for grouping.

### 4. Visualization

The package includes three main plotting functions. By default, these produce interactive `plotly` objects. Use `plotly = FALSE` for static `ggplot2` images.

```r
# Dose-response curves
GRdrawDRC(drc_output, experiments = c('Line1 DrugA'), plotly = FALSE)

# Scatterplot comparing metrics across conditions
GRscatter(drc_output, metric = 'GR50', xaxis = 'treatment', 
          y_values = c('DrugA', 'DrugB'), z_axis = 'cell_line')

# Boxplots of metrics grouped by variables
GRbox(drc_output, metric = 'GRinf', groupVariable = 'cell_line', 
      pointColor = 'treatment')
```

## Key Metrics Definitions

- **GR50**: Concentration at which GR value is 0.5.
- **GRmax**: Maximum effect at the highest tested concentration.
- **GR_AOC**: Area Over the Curve (integrated 1-GR(c)); a robust measure of total drug efficacy.
- **GEC50**: Concentration at half-maximal effect (potency).
- **GRinf**: Asymptotic efficacy (effect at infinite concentration).

## Tips for Success

- **Flat Fits**: If a sigmoidal curve does not fit significantly better than a horizontal line (p > 0.05), the package defaults to a "flat fit." You can override this using `force = TRUE` in `GRfit`.
- **Concentration**: Ensure concentrations are provided in their actual values, not log-transformed.
- **Grouping**: Any columns in your data frame not specified in `groupingVariables` (and not mandatory count columns) will be treated as additional keys for grouping.

## Reference documentation

- [GRmetrics: an R package for calculation and visualization of dose-response metrics based on growth rate inhibition](./references/GRmetrics-vignette.md)
- [GRmetrics Vignette Source](./references/GRmetrics-vignette.Rmd)