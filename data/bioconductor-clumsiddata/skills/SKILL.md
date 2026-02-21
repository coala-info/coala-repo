---
name: bioconductor-clumsiddata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/CluMSIDdata.html
---

# bioconductor-clumsiddata

name: bioconductor-clumsiddata
description: Access and utilize example LC-MS/MS and GC-MS datasets provided by the CluMSIDdata package. Use this skill when you need sample mass spectrometry data to demonstrate or test workflows for the CluMSID (Cluster-based MS/MS IDentification) package, including spectral similarity calculations and metabolite clustering.

# bioconductor-clumsiddata

## Overview
CluMSIDdata is a Bioconductor ExperimentData package. Its primary purpose is to provide high-quality example datasets—including Liquid Chromatography-Multi-Stage Mass Spectrometry (LC-MS/MS) and Gas Chromatography-Mass Spectrometry (GC-MS) data—specifically formatted for use with the `CluMSID` R package. It contains both pre-processed R objects and raw data files.

## Usage in R

### Loading the Package
To access the datasets, first load the library:
```r
library(CluMSIDdata)
```

### Accessing Available Datasets
The package uses lazy loading for R objects. You can list all available datasets using:
```r
data(package = "CluMSIDdata")
```

Commonly used datasets in CluMSID vignettes include:
- `GAPDH_pos`: LC-MS/MS data (positive mode) of a GAPDH sample.
- `GAPDH_neg`: LC-MS/MS data (negative mode) of a GAPDH sample.
- `low_res_measurement`: A low-resolution GC-MS or LC-MS example for testing clustering algorithms.

To load a specific dataset into your environment:
```r
data("GAPDH_pos")
```

### Locating Raw Data Files
CluMSIDdata also contains raw data files (e.g., .mzXML or .netCDF) located in the `extdata` directory. These are useful for testing data import functions in `CluMSID` or `MSnbase`.

To find the path to these files:
```r
# List all files in the extdata folder
list.files(system.file("extdata", package = "CluMSIDdata"))

# Get the absolute path to a specific file (e.g., an mzXML file)
raw_file_path <- system.file("extdata", "example_file.mzXML", package = "CluMSIDdata")
```

### Integration with CluMSID
The typical workflow involves loading data from CluMSIDdata and passing it directly to `CluMSID` functions like `getFeatures()`, `getSimilarities()`, or `CluMSIDcluster()`.

```r
library(CluMSID)
library(CluMSIDdata)

# Load example feature list
data("GAPDH_pos")

# Example: Generate a correlation matrix (assuming GAPDH_pos is a feature list)
# feat_list <- getFeatures(GAPDH_pos) 
# sim_matrix <- getSimilarities(feat_list)
```

## Tips
- Use `?dataset_name` (e.g., `?GAPDH_pos`) to view the specific metadata and experimental conditions associated with a dataset.
- If you are developing new MS/MS analysis tools, use these datasets as standardized benchmarks for spectral clustering performance.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)