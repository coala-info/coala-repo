---
name: bioconductor-curatedbladderdata
description: This package provides a curated collection of standardized gene expression data and clinical metadata for bladder cancer meta-analysis. Use when user asks to load bladder cancer microarray datasets, perform cross-study comparisons, or access harmonized clinical metadata for transcriptomic research.
homepage: https://bioconductor.org/packages/release/data/experiment/html/curatedBladderData.html
---


# bioconductor-curatedbladderdata

## Overview
The `curatedBladderData` package provides a manually curated collection of gene expression data and clinical metadata for patients with bladder cancer. It harmonizes heterogeneous microarray technologies and study designs into standardized Bioconductor `ExpressionSet` objects, enabling immediate meta-analysis and cross-study comparisons.

## Loading Datasets
To explore and load the available studies:

```R
library(curatedBladderData)

# List all available datasets in the package
data(package="curatedBladderData")

# Load a specific dataset (e.g., GSE89)
data(GSE89_eset)

# Inspect the ExpressionSet
GSE89_eset
```

## Automated Filtering and Meta-Analysis Setup
The package includes internal scripts to filter samples across multiple datasets based on clinical criteria (e.g., minimum sample size, specific stages, or presence of survival data).

```R
# 1. Load the default filtering configuration
source(system.file("extdata", "patientselection_all.config", package="curatedBladderData"))

# 2. (Optional) Modify filter variables loaded into the global environment
# min.sample.size <- 20
# strict.checking <- TRUE

# 3. Generate a list of filtered ExpressionSets
source(system.file("extdata", "createEsetList.R", package="curatedBladderData"))

# The resulting 'esets' object is a list of filtered ExpressionSets
names(esets)
```

## Handling Non-Unique Gene Symbols
Datasets use official HGNC symbols. Some probesets map to multiple symbols (e.g., "ABCA11P///ZNF721"). Use the following pattern to expand these into unique features:

```R
expandProbesets <- function (eset, sep = "///") {
  x <- lapply(featureNames(eset), function(x) strsplit(x, sep)[[1]])
  eset <- eset[order(sapply(x, length)), ]
  x <- lapply(featureNames(eset), function(x) strsplit(x, sep)[[1]])
  idx <- unlist(sapply(1:length(x), function(i) rep(i, length(x[[i]]))))
  xx <- !duplicated(unlist(x))
  idx <- idx[xx]
  x <- unlist(x)[xx]
  eset <- eset[idx, ]
  featureNames(eset) <- x
  return(eset)
}

# Apply to an ExpressionSet
GSE89_expanded <- expandProbesets(GSE89_eset)
```

## Accessing Clinical Metadata
Clinical characteristics are standardized across studies. Common variables include `stage`, `grade`, `histological_type`, `vital_status`, and `days_to_death`.

```R
# View clinical data for a study
clinical_data <- pData(GSE89_eset)
head(clinical_data)

# Summarize datasets using the package's internal utility
source(system.file("extdata", "summarizeEsets.R", package="curatedBladderData"))
# This creates a 'summary.table' object
print(summary.table)
```

## Reference documentation
- [curatedBladderData: Clinically Annotated Data for the Bladder Cancer Transcriptome](./references/curatedBladderData_vignette.md)