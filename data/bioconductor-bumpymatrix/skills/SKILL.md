---
name: bioconductor-bumpymatrix
description: The BumpyMatrix package provides a two-dimensional container where each cell holds non-scalar objects of variable length, such as DataFrames or vectors. Use when user asks to create ragged matrices from long-format data, perform 3D subsetting on internal DataFrame columns, or apply mathematical aggregations to complex biological data structures.
homepage: https://bioconductor.org/packages/release/bioc/html/BumpyMatrix.html
---

# bioconductor-bumpymatrix

name: bioconductor-bumpymatrix
description: Specialized knowledge for the BumpyMatrix R package. Use when working with 2D containers where each entry contains non-scalar objects of variable length (ragged 3rd dimension). Ideal for complex biological data like multiplexed FISH (gene x cell entries containing coordinate data frames) or any zero-to-many mapping scenarios within a matrix structure.

## Overview
The `BumpyMatrix` package provides a two-dimensional container where each cell holds a non-scalar object (like a `DataFrame` or a vector) of variable length. This "bumpiness" allows for the representation of complex data that doesn't fit into standard scalar matrices but still benefits from a 2D row/column organization (e.g., genes vs. samples). It is designed to be compatible with Bioconductor's `SummarizedExperiment` framework.

## Core Workflows

### Construction
The most common way to create a `BumpyMatrix` is from a long-format `DataFrame` using `splitAsBumpyMatrix()`.

```r
library(BumpyMatrix)
library(S4Vectors)

# Example: Long-format data
df <- DataFrame(
    x = rnorm(100), 
    y = rnorm(100),
    gene = rep(paste0("GENE_", 1:10), each = 10),
    cell = rep(paste0("CELL_", 1:10), 10)
)

# Create a BumpyDataFrameMatrix
# row and column arguments define the 2D structure
mat <- splitAsBumpyMatrix(df[, c("x", "y")], row = df$gene, column = df$cell)

# Use sparse=TRUE for large datasets with many empty entries
smat <- splitAsBumpyMatrix(df[, c("x", "y")], row = df$gene, column = df$cell, sparse = TRUE)
```

### Subsetting and Access
`BumpyMatrix` supports standard 2D indexing, but `BumpyDataFrameMatrix` adds a 3rd index for columns within the internal DataFrames.

*   **2D Subsetting**: `mat[1:5, 1:2]` returns a sub-BumpyMatrix.
*   **Dropping to List**: `mat[1, , drop=TRUE]` returns a `CompressedList` of the entries.
*   **3D Subsetting**: `mat[, , "x"]` extracts the "x" column from every internal DataFrame, returning a `BumpyNumericMatrix`.
*   **Advanced Subsetting**: Use a `BumpyLogicalMatrix` to subset internal elements.
    ```r
    i <- mat[, , "x"] > 0
    pos_x_mat <- mat[i] # Subsets the internal DataFrames based on the logical mask
    ```

### Operations and Math
*   **Arithmetic**: Operations like `+`, `-`, `*`, and logic like `>`, `<` work element-wise on `BumpyNumericMatrix` objects.
*   **Aggregation**: Functions like `mean()`, `var()`, and `sd()` typically return a standard base R `matrix` where each cell is the calculated statistic for that entry.
*   **Distributional**: Functions like `quantile()` or `range()` return a 3D array.
*   **String Manipulation**: `BumpyCharacterMatrix` supports `grep()`, `tolower()`, etc., applied to internal strings.

### Subset Replacement
You can modify specific fields across the entire matrix:
```r
# Multiply all 'x' coordinates by 10
mat[, , "x"] <- mat[, , "x"] * 10
```

## Tips for AI Agents
*   **Subclass Awareness**: Note that `splitAsBumpyMatrix` automatically chooses the appropriate subclass (e.g., `BumpyNumericMatrix`, `BumpyCharacterMatrix`, or `BumpyDataFrameMatrix`) based on the input.
*   **The .dropk Argument**: When subsetting the 3rd dimension (columns of the internal DataFrames), use `.dropk=FALSE` if you want to prevent the result from dropping to a simpler BumpyMatrix type (e.g., keeping a 1-column `BumpyDataFrameMatrix` instead of a `BumpyNumericMatrix`).
*   **Memory Efficiency**: Always suggest `sparse=TRUE` when the mapping between rows and columns is expected to be incomplete.

## Reference documentation
- [Using BumpyMatrix objects](./references/BumpyMatrix.Rmd)
- [Using BumpyMatrix objects](./references/BumpyMatrix.md)