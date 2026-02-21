---
name: r-biom
description: Skill for using the CRAN R package r-biom.
homepage: https://cran.r-project.org/web/packages/biom/index.html
---

# r-biom

name: r-biom
description: Use this skill when working with the 'biom' R package to read, write, and manipulate BIOM (Biological Observation Matrix) files. This is essential for microbiome data analysis, allowing conversion between BIOM formats and R objects like matrices or data frames.

# r-biom

## Overview
The `biom` package is an R interface for the BIOM file format. It provides functions to read BIOM files (typically version 1.0 JSON) into R, access their data (counts, sample metadata, and taxonomy/observation metadata), and write R objects back to BIOM format. It is a core utility for bioinformaticians processing OTU tables from pipelines like QIIME.

## Installation
```R
install.packages("biom")
```

## Core Workflows

### Reading BIOM Files
To import a BIOM file into R:
```R
library(biom)
# Read a BIOM file
biom_data <- read_biom("path/to/file.biom")
```

### Accessing Data Components
Once loaded, use these accessor functions to extract specific parts of the BIOM object:
- `biom_data(biom_data)`: Extracts the main observation matrix (usually counts).
- `sample_metadata(biom_data)`: Returns a data frame of sample information.
- `observation_metadata(biom_data)`: Returns a data frame of observation/OTU information (e.g., taxonomy).
- `header(biom_data)`: Returns the header information of the BIOM file.

### Manipulating Data
The data extracted via `biom_data()` is often a sparse matrix. You can convert it to a standard dense matrix if needed:
```R
counts <- as(biom_data(biom_data), "matrix")
```

### Writing BIOM Files
To save an R object as a BIOM file:
```R
# Write a biom object to a file
write_biom(biom_data, "output_file.biom")
```

## Tips
- **Format Support**: The package primarily supports BIOM version 1.0 (JSON). For BIOM version 2.1 (HDF5), you may need the `rhdf5` package or the `biomformat` package from Bioconductor.
- **S4 Classes**: The package uses S4 classes. Use `slotNames(biom_data)` to inspect the internal structure if standard accessors are insufficient.
- **Data Integrity**: When manually creating BIOM objects, ensure that the dimensions of the data matrix match the number of rows in the sample and observation metadata.

## Reference documentation
- [biom: Binary Observation Matrix (BIOM) Format](https://cran.r-project.org/web/packages/biom/index.html)