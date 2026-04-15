---
name: bioconductor-alabaster.bumpy
description: This package implements the alabaster framework for the serialization and de-serialization of BumpyMatrix objects. Use when user asks to save a BumpyMatrix to disk, load a BumpyMatrix from a directory, or ensure cross-session portability for ragged data structures.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.bumpy.html
---

# bioconductor-alabaster.bumpy

## Overview

The `alabaster.bumpy` package provides the implementation for the **alabaster** framework to handle `BumpyMatrix` objects. A `BumpyMatrix` is a 2D array where each entry is a `DataFrame`, making it ideal for "ragged" data like multiple observations per cell-gene combination. This skill focuses on the serialization (`saveObject`) and de-serialization (`readObject`) of these complex structures to ensure data integrity and cross-session portability.

## Saving a BumpyMatrix

To save a `BumpyMatrix` to a directory, use the `saveObject` function. This will create a directory containing the data in a combination of HDF5 and JSON formats.

```r
library(BumpyMatrix)
library(S4Vectors)
library(alabaster.bumpy)

# Example: Create a BumpyMatrix
df <- DataFrame(x=runif(100), y=runif(100))
f <- factor(sample(letters[1:20], nrow(df), replace=TRUE), letters[1:20])
mat <- BumpyMatrix(split(df, f), c(5, 4))

# Save to a specified directory
destination <- "my_bumpy_matrix_data"
saveObject(mat, destination)
```

The resulting directory contains:
- `OBJECT`: Identifies the object type.
- `partitions.h5`: Stores the structure/dimensions of the matrix.
- `concatenated/`: Contains the actual data values in HDF5 format.

## Loading a BumpyMatrix

Loading is handled by the generic `readObject` function from `alabaster.base`. The function automatically detects that the directory contains a `BumpyMatrix` and uses the appropriate loading logic.

```r
library(alabaster.base)

# Load the object back into R
mat_restored <- readObject(destination)

# mat_restored will be a BumpyDataFrameMatrix
```

## Typical Workflow

1.  **Data Preparation**: Organize ragged data into a `BumpyMatrix` using the `BumpyMatrix` package.
2.  **Serialization**: Use `saveObject(matrix, path)` to write the object to disk. This is often part of a larger "stage" in an ArtifactDB or local file-based project.
3.  **Distribution**: The resulting directory can be moved or shared.
4.  **Reconstruction**: Use `readObject(path)` to bring the data back into an R session for analysis.

## Tips

- **Dependencies**: Ensure both `alabaster.base` and `alabaster.bumpy` are loaded or available in the namespace for `readObject` to work correctly.
- **Complex Columns**: `BumpyMatrix` objects often contain `DataFrame`s with various column types; `alabaster.bumpy` handles the serialization of these internal columns automatically.
- **Integration**: This package is designed to work within the broader `alabaster` ecosystem, meaning it can be used to save `BumpyMatrix` objects that are nested inside other Bioconductor containers like `SummarizedExperiment` assays.

## Reference documentation

- [Saving BumpyMatrices to file](./references/userguide.md)