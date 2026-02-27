---
name: bioconductor-tenxio
description: This tool imports 10X Genomics pipeline files into standard Bioconductor data structures like SingleCellExperiment and GRanges. Use when user asks to import Cell Ranger outputs, read HDF5 or MTX files, or load 10X Genomics peak annotations and fragment files into R.
homepage: https://bioconductor.org/packages/release/bioc/html/TENxIO.html
---


# bioconductor-tenxio

name: bioconductor-tenxio
description: Import 10X Genomics pipeline files (Cell Ranger outputs) into Bioconductor classes like SingleCellExperiment, SummarizedExperiment, and GRanges. Use when working with .h5, .mtx, .tar.gz (matrix tarballs), peak annotations, or fragment files from 10X Genomics platforms.

# bioconductor-tenxio

## Overview

The `TENxIO` package provides a standardized interface for importing data from 10X Genomics pipelines into common Bioconductor data structures. It simplifies the process of reading complex outputs (like HDF5 files or compressed matrix tarballs) by providing specialized file classes that dispatch to the appropriate `import` methods.

## Core Workflow

Loading data is a two-step process:
1.  **Identify the file**: Use the `TENxFile()` constructor or a specific subclass constructor (e.g., `TENxH5()`) to create a file representation.
2.  **Import the data**: Call the `import()` method on that object to return a Bioconductor class (e.g., `SingleCellExperiment`).

```r
library(TENxIO)

# Step 1: Create the file object
con <- TENxFile("path/to/data.h5")

# Step 2: Import into a Bioconductor object
sce <- import(con)
```

## Supported File Types and Classes

| Extension | TENxIO Class | Resulting Bioconductor Class |
|-----------|--------------|------------------------------|
| .h5 | `TENxH5` | `SingleCellExperiment` |
| .mtx / .mtx.gz | `TENxMTX` | `SummarizedExperiment` |
| .tar.gz | `TENxFileList` | `SingleCellExperiment` |
| peak_annotation.tsv | `TENxPeaks` | `GRanges` |
| fragments.tsv.gz | `TENxFragments` | `RaggedExperiment` |
| .tsv / .tsv.gz | `TENxTSV` | `tibble` |

## Usage Examples

### HDF5 Files (.h5)
`TENxIO` supports both Version 2 (genes.tsv) and Version 3 (features.tsv) HDF5 formats.
```r
# Explicitly use TENxH5 for .h5 files
h5_con <- TENxH5("filtered_feature_bc_matrix.h5")
sce <- import(h5_con)
```

### Matrix Tarballs (.tar.gz)
When Cell Ranger provides a compressed archive containing `matrix.mtx.gz`, `features.tsv.gz`, and `barcodes.tsv.gz`, use `TENxFileList`.
```r
# Import an integrated SingleCellExperiment from a tarball
tar_con <- TENxFileList("matrix_files.tar.gz")
sce <- import(tar_con)
```

### ATAC-Seq Peaks and Fragments
- **Peaks**: Imported as `GRanges` for genomic interval analysis.
- **Fragments**: Imported as `RaggedExperiment`. Note that fragment files are often large; use the `yieldSize` parameter to manage memory.

```r
# Peaks
peak_con <- TENxPeaks("peak_annotation.tsv")
gr <- import(peak_con)

# Fragments (default yieldSize is 200)
frag_con <- TENxFragments("fragments.tsv.gz", yieldSize = 500)
re <- import(frag_con)
```

### ExperimentHub Resources
To import 10X data from `ExperimentHub` that lacks a file extension, provide the extension manually to the constructor.
```r
library(ExperimentHub)
hub <- ExperimentHub()
fname <- hub[["EH1039"]] # Example ID
con <- TENxFile(fname, extension = "h5")
sce <- import(con)
```

## Tips and Best Practices

- **Automatic Dispatch**: `TENxFile()` is a "catch-all" constructor that attempts to detect the correct subclass based on the file extension.
- **Version Detection**: For HDF5 files, the package attempts to derive the version (v2 vs v3) automatically, but you can specify it in the constructor if needed.
- **Visium Data**: For Visium spatial datasets, prefer the `VisiumIO` package, as `TENxIO` focus is primarily on single-cell droplet-based outputs.
- **Memory Management**: When working with `TENxFragments`, always consider setting a `yieldSize` to avoid loading massive datasets into memory at once.

## Reference documentation

- [TENxIO: Import Single Cell Data Files](./references/TENxIO.md)