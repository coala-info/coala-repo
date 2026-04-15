---
name: r-metaboanalyst
description: MetaboAnalystR provides a comprehensive R-based workflow for metabolomics data processing, statistical analysis, and functional interpretation. Use when user asks to process LC-MS raw data, perform statistical tests like PCA or PLS-DA, conduct metabolite set enrichment analysis, or map peaks to biological pathways.
homepage: https://cran.r-project.org/web/packages/metaboanalyst/index.html
---

# r-metaboanalyst

## Overview

MetaboAnalystR is the R implementation of the popular MetaboAnalyst web server. It provides a unified workflow for global metabolomics, covering raw data processing (LC-MS1 feature detection), compound annotation (MS/MS deconvolution), and high-level functional interpretation. It is designed for reproducibility, allowing users to run the same pipelines locally that are available on the web platform.

## Installation

To install the package and its extensive dependencies, use the following R commands:

```R
# Install devtools if not already present
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")

# Install MetaboAnalystR from GitHub
devtools::install_github("xia-lab/MetaboAnalystR", build_vignettes = TRUE)
```

## Core Workflow

The package operates using a centralized object-oriented approach where an `mSet` object stores data and results throughout the analysis.

### 1. Initialization and Data Loading
Every analysis starts by initializing the `mSet` object and specifying the module (e.g., "stat", "pathway", "mummichog").

```R
library(MetaboAnalystR)
mSet <- InitDataObjects("pktable", "stat", FALSE)
mSet <- Read.TextData(mSet, "data_path.csv", "rowu", "disc")
```

### 2. Data Processing and Normalization
Standardize data before statistical testing.

```R
mSet <- SanityCheckData(mSet)
mSet <- ReplaceMin(mSet)
mSet <- PrepareProcessedData(mSet)
mSet <- Normalization(mSet, "MedianNorm", "LogNorm", "AutoNorm", ratio=FALSE, ratioNum=20)
```

### 3. Statistical Analysis
Perform common metabolomics statistical tests.

```R
# PCA
mSet <- PCA.Anal(mSet)
mSet <- PlotPCAPairSummary(mSet, "pca_pair_0.png", "png", 72, width=NA)

# PLS-DA
mSet <- PLSR.Anal(mSet)
mSet <- PlotPLS2DScore(mSet, "pls_score2d_0.png", "png", 72, width=NA)
```

### 4. Functional Analysis (Mummichog/GSEA)
For LC-MS peaks without prior identification, use the "Peaks to Paths" module.

```R
mSet <- InitDataObjects("mass_all", "mummichog", FALSE)
mSet <- Read.PeakListData(mSet, "peak_list.txt")
mSet <- SanityCheckMummichogData(mSet)
mSet <- SetPeakEnrichMethod(mSet, "mummichog", "v2")
mSet <- PerformPSEA(mSet, "hsa_mfn", "fc", 0.05)
```

## Key Modules
- **Stat**: Univariate (t-tests, ANOVA) and multivariate (PCA, PLS-DA, Random Forest) analysis.
- **Pathway**: Knowledge-based pathway enrichment and topology analysis.
- **Raw**: LC-MS spectra processing (peak picking, alignment, grouping).
- **Enrich**: Metabolite Set Enrichment Analysis (MSEA).
- **Biomarker**: ROC curve analysis and power analysis.

## Tips for Success
- **Memory Management**: Large LC-MS datasets can be memory-intensive. Use `BiocParallel` for multi-core processing where supported.
- **Object Persistence**: Most functions return the updated `mSet` object. Always assign the output back to `mSet` (e.g., `mSet <- Function(mSet, ...)`).
- **Web Sync**: You can download the R command history from the MetaboAnalyst web server to reproduce web-based results exactly in your local R environment.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)