---
name: bioconductor-bigmemoryextras
description: the package provides a "BigMatrixFactor" class, a file-backed matrix with factor properties.
homepage: https://bioconductor.org/packages/3.8/bioc/html/bigmemoryExtras.html
---

# bioconductor-bigmemoryextras

name: bioconductor-bigmemoryextras
description: Use this skill when working with the Bioconductor package bigmemoryExtras in R. This is specifically for managing large, file-backed matrices using the BigMatrix and BigMatrixFactor classes. Use this skill to create, access, and manage persistent matrix data that exceeds available RAM, or when integrating these file-backed structures into Biobase (eSet) or GenomicRanges (SummarizedExperiment) objects.

## Overview

The `bigmemoryExtras` package provides a `BigMatrix` ReferenceClass that extends the `filebacked.big.matrix` from the `bigmemory` package. Its primary advantages are safety and convenience: it automatically handles re-attaching to on-disk data (preventing segfaults when loading saved R sessions) and provides a `BigMatrixFactor` class for memory-efficient storage of character data as factors.

## Core Workflows

### Creating and Accessing BigMatrix Objects

To create a `BigMatrix`, you provide an existing matrix and a path for the backing file.

```r
library(bigmemoryExtras)

# Create a BigMatrix
data_file <- file.path(tempdir(), "my_bigmat")
x <- matrix(1:9, ncol=3, dimnames=list(letters[1:3], LETTERS[1:3]))
bm <- BigMatrix(x, data_file)

# Standard matrix indexing works
bm[1, 1] <- 10
bm[, 2]

# BigMatrix objects are Reference Classes; use $ for internal methods
bm$nrow()
bm$backingfile
```

### Working with BigMatrixFactor

Use `BigMatrixFactor` to store large matrices of categorical/character data. These are stored on disk as integers (8 or 32 bit) to save space.

```r
# Create a BigMatrixFactor
fs_file <- file.path(tempdir(), "my_factor_mat")
y <- matrix(c("A", "B", "A", "B"), ncol=2)
bmf <- BigMatrixFactor(y, fs_file, levels=c("A", "B"))

# Subsetting returns factors
bmf[1, ]
levels(bmf)
```

### Persistence and Re-attachment

Unlike standard `big.matrix` objects, `BigMatrix` objects can be saved using `saveRDS` and reloaded in a new session. They will automatically re-attach to the backing file on disk when accessed.

```r
saveRDS(bm, "my_matrix.rds")
new_bm <- readRDS("my_matrix.rds")
# Accessing data triggers automatic re-attachment
print(new_bm[1, 1])
```

### Integration with Bioconductor Containers

`BigMatrix` objects can be used as assays in `SummarizedExperiment` or `eSet` objects. If the backing files are moved to a new directory, use `updateBackingfiles` to repair the links.

```r
library(GenomicRanges)
se <- SummarizedExperiment(assays=list(counts=bm))

# If files move to a new directory
new_dir <- "/path/to/new/location"
assays(se) <- updateBackingfiles(assays(se), new_dir)
```

## Key Functions

- `BigMatrix(x, backingfile)`: Constructor for file-backed numeric matrices.
- `BigMatrixFactor(x, backingfile, levels)`: Constructor for file-backed factor matrices.
- `updateBackingfiles(object, dir)`: Updates the path to backing files for all BigMatrix objects within a list, AssayData, or Assays object.
- `as(object, "matrix")`: Coerces a BigMatrix or BigMatrixFactor back to a standard R matrix.

## Tips and Best Practices

- **Memory Safety**: Always use `BigMatrix` instead of `bigmemory::filebacked.big.matrix` if you plan to save your R workspace or objects, as it prevents "nil pointer" crashes.
- **File Management**: Remember that a `BigMatrix` consists of both the R object and the files on disk (.bin and .desc). Both are required to read the data.
- **Reference Class Semantics**: Modifications to a `BigMatrix` happen in-place on disk. You do not need to re-assign the object (e.g., `bm[1,1] <- 5` updates the file immediately).

## Reference documentation

- [An Introduction to the bigmemoryExtras Package](./references/bigmemoryExtras.Rmd)