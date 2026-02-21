---
name: bioconductor-gse13015
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/GSE13015.html
---

# bioconductor-gse13015

name: bioconductor-gse13015
description: Access and utilize the GSE13015 dataset from Bioconductor's ExperimentHub. This skill should be used when a user needs to load normalized microarray expression data and clinical metadata for septicemic patients (GEO accession GSE13015) for downstream analysis such as differential expression or modular repertoire analysis.

# bioconductor-gse13015

## Overview
The GSE13015 package provides access to a curated dataset of microarray expression profiles from 67 septicemic patients. The data is hosted on Bioconductor's ExperimentHub and is provided as a `SummarizedExperiment` object. This format integrates the expression matrix (platform GPL6106) with associated clinical metadata, making it ready for immediate use in bioinformatics workflows.

## Data Retrieval Workflow
To use this dataset, you must interface with `ExperimentHub`. The data is not contained directly within the package but is fetched from the remote repository.

### Loading the Dataset
```r
library(ExperimentHub)
library(SummarizedExperiment)

# Initialize ExperimentHub
eh = ExperimentHub()

# Query for the GSE13015 dataset
hub_data = query(eh, "GSE13015")

# Retrieve the specific SummarizedExperiment object (ID: EH5429)
se = hub_data[["EH5429"]]
```

## Working with the Data
Once loaded, the object `se` is a `SummarizedExperiment`. You can interact with it using standard Bioconductor methods:

### Accessing Expression Data
To get the normalized expression matrix:
```r
exprs_matrix = assay(se)
head(exprs_matrix)
```

### Accessing Clinical Metadata
To view the patient metadata (e.g., septicemic status, clinical variables):
```r
clinical_info = colData(se)
summary(clinical_info)
```

### Accessing Feature Information
To view information about the probes/genes:
```r
feature_info = rowData(se)
```

## Typical Use Cases
1. **Differential Expression Analysis**: Use the `assay(se)` and `colData(se)` as inputs for packages like `limma` to identify genes differentially expressed in sepsis.
2. **Modular Repertoire Analysis**: Use the expression data to perform blood genomics module analysis.
3. **Benchmarking**: Use this well-characterized clinical dataset to test new bioinformatic algorithms.

## Tips
- **Caching**: `ExperimentHub` caches the data locally after the first download. Subsequent calls to `hub_data[["EH5429"]]` will be significantly faster.
- **Dependencies**: Ensure `SummarizedExperiment` is loaded to properly dispatch methods like `assay()` and `colData()`.

## Reference documentation
- [GSE13015](./references/GSE13015.md)