---
name: bioconductor-singlemoleculefootprintingdata
description: This package provides access to example data and BAM files for Single Molecule Footprinting analysis workflows. Use when user asks to retrieve experimental data for SMF analysis, access NRF1 binding site BAM files, or download example datasets for the SingleMoleculeFootprinting package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SingleMoleculeFootprintingData.html
---

# bioconductor-singlemoleculefootprintingdata

name: bioconductor-singlemoleculefootprintingdata
description: Access and manage example data for Single Molecule Footprinting (SMF) analysis. Use this skill when needing to retrieve experimental data, BAM files, or indices required for the SingleMoleculeFootprinting R package workflows, specifically for NRF1 binding site examples.

# bioconductor-singlemoleculefootprintingdata

## Overview

The `SingleMoleculeFootprintingData` package is an ExperimentHub-based data package. It provides the necessary raw and processed data files (such as BAM files and their indices) required to run the vignettes and examples in the `SingleMoleculeFootprinting` analysis package. Its primary role is to serve as a data repository that handles caching and retrieval of large genomic files.

## Data Access and Usage

The package uses accessor functions to download and cache data from ExperimentHub.

### Loading the Package
```r
library(SingleMoleculeFootprintingData)
```

### Accessing Specific Data Objects
The package provides specific functions to retrieve paths to cached files. These are typically used to construct input files for the `QuasR` alignment package or for direct analysis.

```r
# Access the BAM file index for the NRF1 pair example
bam_index <- SingleMoleculeFootprintingData::NRF1pair.bam.bai()

# Access the BAM file itself
bam_file <- SingleMoleculeFootprintingData::NRF1pair.bam()
```

### Integration with SingleMoleculeFootprinting
In most standard workflows, users do not need to call these functions manually. The `SingleMoleculeFootprinting` package calls these data accessors "under the hood" to set up the `QuasR` input files required for its own vignettes.

If you are building a custom workflow using the example data:
1. Use the accessor functions to get the local file paths.
2. Pass these paths to `QuasR::qAlign` or SMF processing functions.

## Workflow Tips

- **Caching**: The first time an accessor function is called, the data is downloaded from Bioconductor's ExperimentHub. Subsequent calls will return the path to the local cache.
- **ExperimentHub**: You can also explore the available data using the `ExperimentHub` interface:
  ```r
  library(ExperimentHub)
  eh <- ExperimentHub()
  query(eh, "SingleMoleculeFootprintingData")
  ```

## Reference documentation

- [SingleMoleculeFootprintingData](./references/SingleMoleculeFootprintingData.md)