---
name: bioconductor-facsdorit
description: the package prada.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/facsDorit.html
---

# bioconductor-facsdorit

name: bioconductor-facsdorit
description: Access and use the facsDorit Bioconductor experiment data package. Use this skill when a user needs to load, inspect, or analyze the example Flow Cytometry Standard (FCS) 3.0 datasets (apoptosis and MAP-Kinase pathways) provided for the prada package.

# bioconductor-facsdorit

## Overview
The `facsDorit` package is a Bioconductor ExperimentData package containing Flow Cytometry Standard (FCS) 3.0 files. It serves as a primary example dataset for cell-based assays, specifically characterizing effectors of the MAP-Kinase and apoptotic pathways. The data is structured to represent 96-well microtitre plates and is designed for use with the `prada` package.

## Loading and Using Data
The package provides two main directories of FCS files: `apoptosis` and `map`. These files are stored within the package's `extdata` directory.

### Accessing File Paths
To locate the example files on your system, use `system.file`:

```r
# Path to a specific apoptosis file
apo_path <- system.file("extdata", "apoptosis", "test2933T3.A01", package="facsDorit")

# Path to a specific MAP-Kinase file
map_path <- system.file("extdata", "map", "060304MAPK_controls.A01", package="facsDorit")
```

### Importing Data
Use functions from the `prada` package (or `flowCore`) to read the data:

1.  **Single File**: Use `readFCS()` to import a single well.
2.  **Entire Plate**: Use `readCytoSet()` to import all 96 files in a directory.

```r
library(facsDorit)
library(prada)

# Read a single FCS file
apo_data <- readFCS(system.file("extdata", "apoptosis", "test2933T3.A01", package="facsDorit"))

# Inspect the object
print(apo_data)

# Access expression matrix (first 3 rows)
exprs(apo_data)[1:3, ]

# Access keywords/description metadata
description(apo_data)[3:6]
```

### Workflow Tips
- **Data Structure**: The data consists of 96 FCS files per experiment, corresponding to a standard microtitre plate layout.
- **Integration**: This package is intended to be used alongside `prada`. Ensure `library(prada)` is loaded to provide the necessary methods for the `cytoSet` and `fcs` objects.
- **Exploration**: Use `list.files(system.file("extdata", "apoptosis", package="facsDorit"))` to see all available well files.

## Reference documentation
- [Apoptosis and MAP-Kinase example data](./references/reference_manual.md)