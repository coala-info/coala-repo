---
name: bioconductor-omicsviewer
description: This tool provides an interactive Shiny-based interface for exploring and visualizing high-throughput omics data stored in ExpressionSet or SummarizedExperiment objects. Use when user asks to interactively visualize omics data, perform on-the-fly enrichment analysis, conduct network analysis with StringDB, or launch a web-based dashboard for statistical results.
homepage: https://bioconductor.org/packages/release/bioc/html/omicsViewer.html
---

# bioconductor-omicsviewer

## Overview

The `omicsViewer` package provides an interactive Shiny-based interface for exploring high-throughput omics data. It specifically visualizes `ExpressionSet` or `SummarizedExperiment` objects, allowing users to interactively select features (genes/proteins) and samples to trigger on-the-fly analyses like enrichment (fGSEA, ORA), network analysis (StringDB), and significance testing.

## Core Workflow

### 1. Data Preparation
The package requires an `ExpressionSet` or `SummarizedExperiment` where metadata columns follow a specific naming convention: `Analysis|Subset|Variable`.

```r
library(omicsViewer)
library(Biobase)

# 1. Load your expression matrix, feature data (fd), and phenotype data (pd)
# 2. Define statistical tests (e.g., t-tests)
tests <- rbind(
  c("GroupColumn", "GroupA", "GroupB"),
  c("StatusColumn", "Mutant", "WT")
)

# 3. Use the helper to create the omicsViewer-compatible object
obj <- prepOmicsViewer(
  expr = expr_matrix, 
  pData = pd, 
  fData = fd,
  PCA = TRUE, 
  t.test = tests,
  stringDB = fd$ProteinID, # Optional: for StringDB integration
  SummarizedExperiment = FALSE
)

# 4. Set default visual axes (optional but recommended)
attr(obj, "fx") <- "ttest|GroupA_vs_GroupB|mean.diff"
attr(obj, "fy") <- "ttest|GroupA_vs_GroupB|log.fdr"
```

### 2. Launching the Viewer
You can launch the viewer by pointing it to a directory containing `.RDS` files of prepared objects.

```r
# Launch using a directory path
omicsViewer("path/to/rds_files/")

# Or launch with a specific object in the global environment
# (Save it first as the app reads from disk)
saveRDS(obj, "my_data.RDS")
omicsViewer("./")
```

### 3. Extending Metadata
You can add additional analysis results (like correlations) to an existing object using `extendMetaData`.

```r
# Perform correlation analysis between expression and a phenotype variable
cor_results <- correlationAnalysis(exprs(obj), pheno = pd[, "DrugSensitivity", drop=FALSE])

# Append to feature data
obj <- extendMetaData(obj, cor_results, where = "fData")
```

## Key Features & Reserved Keywords

To enable specific "Analyst" tabs in the UI, use these reserved keywords in your metadata headers:

*   **Surv**: Use in phenotype data for survival analysis (Kaplan-Meier).
*   **StringDB**: Use in feature data to enable StringDB network queries.
*   **GS**: Use in feature data to enable Over-Representation Analysis (ORA) and fGSEA.

## Deployment Options

*   **Local**: Run `omicsViewer()` directly in R.
*   **Shiny Server**: Use `app_ui` and `app_module` in `ui.R` and `server.R`.
*   **Docker**: Use the `mengchen18/omicsviewer` image for standalone deployment.

## Reference documentation

- [Quick Start and Data Preparation](./references/quickStart.md)