---
name: r-ramclustr
description: R package ramclustr (documentation from project home).
homepage: https://cran.r-project.org/web/packages/ramclustr/index.html
---

# r-ramclustr

name: r-ramclustr
description: Feature clustering and interpretation for non-targeted mass spectrometry (MS) metabolomics data. Use this skill when you need to group MS features into spectra, handle GC-MS or LC-MS data (including indiscriminant MS/MS), perform batch/QC normalization, or export deconvoluted features in MSP format for annotation.

## Overview

The `ramclustr` package provides a robust algorithm for clustering mass spectrometric features into groups representing individual compounds. It is particularly effective for "indiscriminant" MS/MS data where precursor-product ion relationships are not explicitly defined by the instrument. The package supports both a high-level "all-in-one" function and a granular stepwise workflow for data cleaning, normalization, and clustering.

## Installation

To install the package from CRAN:

```R
install.packages("ramclustr")
```

To install the development version:

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("cbroeckl/RAMClustR", build_vignettes = TRUE)
```

## Core Workflows

### 1. The Main ramclustR Function
Use this for a streamlined process when you have a feature table (CSV) or an `xcms` object.

```R
library(RAMClustR)

# Example using a CSV input
ramclustobj <- ramclustR(
  ms = "path/to/peaks.csv",      # MS1 feature table
  pheno_csv = "path/to/pheno.csv", # Phenotype/metadata
  st = 5,                        # Sigma t: retention time similarity window
  maxt = 1,                      # Maximum time difference for clustering
  blocksize = 1000               # Processing block size
)

# Inspect results
print(ramclustobj$ann)           # Annotations
print(ramclustobj$SpecAbund)     # Spectral abundances
```

### 2. Stepwise Workflow (rc. functions)
Use this for finer control over data preprocessing, such as blank filtering and QC-based normalization.

```R
# 1. Load data (from xcms or other sources)
ramclustObj <- rc.get.xcms.data(xcmsObj = xdata)

# 2. Preprocessing
ramclustObj <- rc.expand.sample.names(ramclustObj)
ramclustObj <- rc.feature.replace.na(ramclustObj)
ramclustObj <- rc.feature.filter.blanks(ramclustObj, blank.tag = "Blank")

# 3. Normalization (QC-centric)
# Adjusts for batch effects and run-order effects using QC samples
ramclustObj <- rc.feature.normalize.qc(ramclustObj, qc.tag = "QC")
ramclustObj <- rc.feature.filter.cv(ramclustObj)

# 4. Clustering and Annotation
ramclustObj <- rc.ramclustr(ramclustObj)
ramclustObj <- rc.qc(ramclustObj)
ramclustObj <- do.findmain(ramclustObj) # Find molecular ions
```

## Key Parameters and Tips

- **Feature Naming**: By default, the package expects feature column names in the format `mz_rt`.
- **Normalization**: The `batch.qc` normalization requires three vectors: batch, order, and qc. It corrects for systematic batch effects and local run-order drift.
- **MSP Export**: After clustering, the package typically generates an `spectra` folder containing `.msp` files. These can be used for spectral library searching (e.g., NIST, MS-FINDER).
- **Sigma t (`st`)**: This is a critical parameter representing the expected retention time deviation. Smaller values lead to tighter clusters.

## Reference documentation

- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [cran-comments.md](./references/cran-comments.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)