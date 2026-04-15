---
name: bioconductor-immunespacer
description: ImmuneSpaceR provides a programmatic interface to connect to the ImmuneSpace database for retrieving curated immunology datasets and gene expression matrices. Use when user asks to connect to ImmuneSpace studies, fetch tabular datasets or expression matrices, and visualize immunology data.
homepage: https://bioconductor.org/packages/3.8/bioc/html/ImmuneSpaceR.html
---

# bioconductor-immunespacer

## Overview
The `ImmuneSpaceR` package provides a thin wrapper around `Rlabkey` to connect to the [ImmuneSpace](https://www.immunespace.org) database. It allows users to programmatically retrieve curated datasets and gene expression matrices from various immunology studies (e.g., SDY269, SDY144). The package uses R6 classes for connection management and local caching to improve performance.

## Configuration
To connect to ImmuneSpace, you must have a `.netrc` (UNIX) or `_netrc` (Windows) file in your home directory with your credentials.

```r
library(ImmuneSpaceR)
# If you don't have a netrc file, use the interactive helper:
# interactive_netrc() 
```

## Basic Workflow

### 1. Create a Connection
Instantiate a connection to a specific study or the entire project.
```r
# Single study connection
con <- CreateConnection("SDY269")

# Cross-study connection (all studies)
all_con <- CreateConnection("")
```

### 2. Explore Available Data
List the datasets and expression matrices available in the current connection.
```r
con$listDatasets()
con$listDatasets(output = "expression") # Only show matrices
```

### 3. Fetch Datasets
Retrieve tabular data such as HAI, ELISA, or demographics.
```r
# Fetch a dataset
hai <- con$getDataset("hai")

# Fetch with filters (using Rlabkey)
library(Rlabkey)
myFilter <- makeFilter(c("gender", "EQUAL", "Female"))
hai_female <- con$getDataset("hai", colFilter = myFilter)
```

### 4. Fetch Gene Expression Matrices
Retrieve processed expression data as `ExpressionSet` objects.
```r
# Fetch by matrix name
eset <- con$getGEMatrix("SDY269_PBMC_TIV_Geo")

# Fetch summarized version (gene symbols instead of probes)
eset_sum <- con$getGEMatrix("SDY269_PBMC_TIV_Geo", 
                            outputType = "summary", 
                            annotation = "latest")
```

### 5. Visualization
The package provides a `plot` method that automatically selects appropriate visualizations (boxplot, heatmap, violin, or line) based on the dataset.
```r
con$plot("hai")
con$plot("elisa", type = "boxplot")
```

## Advanced Usage

### Combining Matrices
You can combine multiple matrices into a single `ExpressionSet` by passing a vector of names. This is highly recommended for cross-study analysis using summarized matrices.
```r
combined_eset <- all_con$getGEMatrix(c("SDY269_PBMC_TIV_Geo", "SDY144_Other_TIV_Geo"),
                                     outputType = "summary",
                                     annotation = "latest")
```

### Caching and Reloading
`ImmuneSpaceR` caches data in the connection object. To force a fresh download, use the `reload` argument.
```r
# Clear specific cache
hai <- con$getDataset("hai", reload = TRUE)

# Clear all cache
con$clearCache()
```

## Tips
- **Data.table**: Datasets are returned as `data.table` objects for performance. Use `data.table` syntax for efficient manipulation.
- **Original View**: Use `original_view = TRUE` in `getDataset()` to get the "Full" view (ImmPort format) instead of the curated "Default" view.
- **Verbose Mode**: Use `CreateConnection(study, verbose = TRUE)` to see detailed logs and valid dataset names during errors.

## Reference documentation
- [An Introduction to the ImmuneSpaceR Package](./references/Intro_to_ImmuneSpaceR.md)
- [Downloading Datasets with getDataset](./references/getDataset.md)
- [Handling Expression Matrices with ImmuneSpaceR](./references/getGEMatrix.md)
- [interactive_netrc() Function Walkthrough](./references/interactiveNetrc.md)
- [SDY144: Correlation of HAI/Virus Neutralizition Titer and Cell Counts](./references/report_SDY144.md)
- [SDY180: Abundance of Plasmablasts Measured by Multiparameter Flow Cytometry](./references/report_SDY180.md)
- [SDY269: Correlating HAI with Flow Cytometry and ELISPOT Results](./references/report_SDY269.md)