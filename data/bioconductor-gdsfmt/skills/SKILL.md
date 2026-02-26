---
name: bioconductor-gdsfmt
description: This tool provides a high-level R interface for managing large-scale genomic data using the hierarchical CoreArray Genomic Data Structure format. Use when user asks to create, read, or write GDS files, manage datasets that exceed system memory, perform bit-level data compression, or access genomic data using efficient random access and marginal application.
homepage: https://bioconductor.org/packages/release/bioc/html/gdsfmt.html
---


# bioconductor-gdsfmt

name: bioconductor-gdsfmt
description: High-level R interface for CoreArray Genomic Data Structure (GDS) files. Use this skill to create, read, write, and manage large-scale genomic datasets that exceed system memory. It supports hierarchical data storage, efficient bit-level operations (e.g., 2-bit SNPs), data compression (ZIP, LZ4, LZMA), and random access.

## Overview
The `gdsfmt` package provides a portable, hierarchical structure for storing scalable array-oriented data. It is particularly optimized for genomic data where variants often require fewer than 8 bits. It allows for efficient random access even within compressed files and supports sparse matrices.

## Core Workflow

### 1. File Management
*   **Create:** `gfile <- createfn.gds("filename.gds")`
*   **Open:** `gfile <- openfn.gds("filename.gds", readonly=TRUE)`
*   **Close:** `closefn.gds(gfile)`
*   **Cleanup:** `cleanup.gds("filename.gds")` (reclaims space after deletions)

### 2. Creating Nodes and Writing Data
Nodes (variables) are added to a GDS file handle.
*   **Basic Add:** `add.gdsn(gfile, "name", val=data, storage="int")`
*   **Hierarchical Folders:** `folder <- addfolder.gdsn(gfile, "folder_name")`
*   **Bit-level Storage:** Use `storage="bit2"` for genotypes (0-3) to save significant space.
*   **Compression:** Use `compress="ZIP"` or `"LZ4"`. For large datasets, use `append.gdsn()` to write sequentially.
*   **Large Datasets (Pre-allocated):**
    ```r
    n <- add.gdsn(gfile, "large", storage="int", valdim=c(100, 2000))
    write.gdsn(n, data_chunk, start=c(1, chunk_index), count=c(-1, 1))
    ```

### 3. Accessing and Reading Data
*   **Locate Node:** `n <- index.gdsn(gfile, "path/to/node")`
*   **Read All:** `read.gdsn(n)`
*   **Subset Read:** `read.gdsn(n, start=c(1,1), count=c(5,10))`
*   **Filtered Read:** `readex.gdsn(n, list(logic_vec1, logic_vec2))`
*   **Apply Marginally:** Apply functions to rows/columns without loading the whole matrix:
    `apply.gdsn(n, margin=1, FUN=function(x) sum(x))`

### 4. Advanced Features
*   **Sparse Matrices:** Use `storage="sp.int"`. Reading these returns a `dgCMatrix` (Matrix package).
*   **Packed Real Numbers:** Store floats as `int * scale + offset` to improve compression:
    `add.gdsn(gfile, "N", val=val, storage="packedreal16", scale=0.001, offset=0)`
*   **Data Integrity:** Add and verify checksums:
    `digest.gdsn(n, action="add")`
    `digest.gdsn(n, action="verify")`
*   **Transposing:** Use `permdim.gdsn(n, c(2,1))` to permute dimensions.

## Tips for Efficiency
*   **Random Access:** For compressed data, use `_ra` suffixes (e.g., `compress="ZIP_ra"`) to enable faster random access at the cost of a slightly lower compression ratio.
*   **Sequential Writing:** When using compression, always use `append.gdsn()` or ensure you write data in the order it is stored.
*   **Attributes:** Use `put.attr.gdsn(n, "attribute_name", value)` to store metadata directly on nodes.

## Reference documentation
- [Introduction to GDS Format](./references/gdsfmt.Rmd)
- [R Interface to CoreArray Genomic Data Structure (GDS) Files](./references/gdsfmt.md)