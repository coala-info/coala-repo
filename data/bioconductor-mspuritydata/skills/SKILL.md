---
name: bioconductor-mspuritydata
description: This package provides fragmentation spectral libraries and test mass spectrometry datasets for the msPurity R package. Use when user asks to access MoNA-derived spectral libraries, retrieve test mzML datasets for LC-MS or DI-MS, or perform spectral matching workflows in metabolomics.
homepage: https://bioconductor.org/packages/release/data/experiment/html/msPurityData.html
---


# bioconductor-mspuritydata

name: bioconductor-mspuritydata
description: Access and utilize the msPurityData package, which provides fragmentation spectral libraries and test datasets (LC-MS, LC-MS/MS, and DI-MS) for the msPurity R package. Use this skill when a user needs to perform spectral matching, test msPurity workflows, or access the default MoNA-derived fragmentation library for metabolomics data analysis.

# bioconductor-mspuritydata

## Overview
The `msPurityData` package is a specialized Bioconductor ExperimentData package. It serves as the data backbone for the `msPurity` package, providing essential fragmentation spectral libraries and reduced-size mass spectrometry datasets (mzML format). Its primary role is to facilitate testing, demonstration, and spectral matching within the msPurity ecosystem.

## Usage and Workflows

### Loading the Package
To access the data and libraries, first load the package in the R environment:

```r
library(msPurityData)
```

### Accessing Spectral Libraries
The package contains a comprehensive fragmentation spectral library created from MoNA (MassBank, GNPS, LipidBlast, and HMDB). This is used by `msPurity` for spectral matching.

To find the path to the included SQLite database library:
```r
lib_path <- system.file("extdata", "library", "spectral_library.db", package="msPurityData")
```

### Accessing Test Datasets
The package includes raw data files (mzML) and processed outputs (.rds, .csv) located in the `extdata` directory. These are organized into `lcms`, `dims`, and `publication` folders.

**Locating LC-MS and DI-MS data:**
```r
# List available directories
data_dir <- system.file("extdata", package="msPurityData")
list.dirs(data_dir, recursive = FALSE)

# Access specific mzML files for testing
lcms_files <- list.files(system.file("extdata", "lcms", "mzML", package="msPurityData"), full.names = TRUE)
dims_files <- list.files(system.file("extdata", "dims", "mzML", package="msPurityData"), full.names = TRUE)
```

### Integration with msPurity
The data in this package is specifically formatted to work with `msPurity` functions. For example, when performing spectral matching:

```r
# Example of using the library path in an msPurity workflow
# (Requires msPurity package to be installed)
# library(msPurity)
# result <- spectral_matching(msObj, library_path = lib_path)
```

## Tips
- **Data Reduction:** Note that the mzML files in this package are reduced in size (fewer scans and limited m/z range) to keep the package lightweight. They are intended for testing code logic rather than full biological discovery.
- **Library Source:** The default library is based on a MoNA download from November 2018. For the most up-to-date matching, users may need to generate their own libraries using `msp2db`.
- **Publication Data:** Data related to the original `msPurity` publication can be found in the `extdata/publication` folder for reproducibility studies.

## Reference documentation
- [msPurityData Reference Manual](./references/reference_manual.md)