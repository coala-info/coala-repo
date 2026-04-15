---
name: bioconductor-simpleaffy
description: The simpleaffy package provides high-level wrappers for analyzing Affymetrix data, including quality control, expression summarization, and statistical comparisons. Use when user asks to read CEL files, generate QC metrics, perform RMA or MAS5 normalization, conduct pairwise t-tests, or visualize differential expression results.
homepage: https://bioconductor.org/packages/3.5/bioc/html/simpleaffy.html
---

# bioconductor-simpleaffy

## Overview
The `simpleaffy` package provides high-level wrappers for the `affy` package to streamline the analysis of Affymetrix data. It is designed for rapid quality control, expression summarization, and statistical comparison (fold-change and t-tests) between replicate groups. It relies on a `covdesc` file to define experimental design.

## Workflow: Data Loading and Expression
The package requires a directory containing `.CEL` files and a white-space delimited file named `covdesc`. The `covdesc` file must have no header for the first column (CEL file names) and subsequent columns for experimental factors (e.g., "treatment").

```R
library(simpleaffy)

# 1. Read data using the covdesc file in the working directory
raw.data <- read.affy() 

# 2. Generate expression calls
# Use "rma" for Robust Multi-array Average
x.rma <- call.exprs(raw.data, "rma")

# Use "mas5" for MAS 5.0 (uses a fast C implementation 'justMAS')
x.mas5 <- call.exprs(raw.data, "mas5")
```

## Workflow: Quality Control
`simpleaffy` automates the calculation of standard Affymetrix QC metrics, including scale factors, background levels, percent present calls, and 3'/5' ratios for GAPDH and beta-actin.

```R
# Generate QC metrics (requires raw data and MAS5 processed data)
qcs <- qc(raw.data, x.mas5)

# Access specific metrics
ratios(qcs)           # 3'/5' ratios
percent.present(qcs)  # % Present calls
sfs(qcs)              # Scale factors
avbg(qcs)             # Average background

# Visualize QC - Red indicates values outside recommended thresholds
plot(qcs)
```

## Workflow: Pairwise Comparisons and Filtering
Perform statistical comparisons between groups defined in the `covdesc` file.

```R
# 1. Perform pairwise comparison (t-test and fold change)
# 'raw.data' is passed to compute MAS5 detection p-values/PMA calls
results <- pairwise.comparison(x.rma, "treatment", c("control", "treated"), raw.data)

# 2. Filter results
# min.exp: log2 intensity threshold
# fc: log2 fold change threshold (e.g., log2(1.5))
# tt: t-test p-value threshold
significant <- pairwise.filter(results, min.exp=log2(10), fc=log2(1.5), tt=0.001)

# 3. Visualization
plot(results, significant) # Scatter plot highlighting significant genes
plot(results, type="ma")    # M v A plot
plot(results, type="volcano") # Volcano plot
```

## Visualization and Annotation
```R
# Heatmaps
hmap.eset(x.rma, 1:100) # Heatmap of first 100 probesets
hmap.pc(significant, x.rma) # Heatmap of filtered results scaled by SD

# Annotation and Export
# Requires the appropriate metadata package (e.g., "hgu133a")
summary.table <- results.summary(significant, "hgu133a")
write.annotation(summary.table, file="results.xls")
```

## Tips and Best Practices
- **Paired Replicates**: If samples are matched, use `a.order` and `b.order` in `pairwise.comparison` to perform paired t-tests.
- **Logging**: `call.exprs` returns logged data by default. Ensure `logged=TRUE` (default) is set in downstream functions.
- **Custom Chips**: If an array type is not recognized for QC, create a `<cdfname>.qcdef` file and load it using `setQCEnvironment(array, path)`.
- **Fast MAS5**: The `justMAS()` function is a high-speed C implementation of MAS 5.0 used internally by `call.exprs`.

## Reference documentation
- [simpleAffy](./references/simpleAffy.md)