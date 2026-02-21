---
name: bioconductor-busparse
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BUSpaRse.html
---

# bioconductor-busparse

name: bioconductor-busparse
description: Processing and converting Barcode, UMI, Set (BUS) format data into sparse matrices for single-cell RNA-seq analysis. Use when needing to map transcripts to genes, generate gene count or Transcript Compatibility Count (TCC) matrices from kallisto bus output, and perform quality control filtering (knee plots) on single-cell data.

## Overview
The `BUSpaRse` package provides tools to bridge the gap between the efficient `kallisto bus` pseudoalignment format and standard R/Bioconductor sparse matrix objects used in downstream single-cell analysis (e.g., Seurat or SingleCellExperiment). Its primary utilities include generating transcript-to-gene (tr2g) mapping files from various sources and converting BUS output files into count matrices.

## Core Workflows

### 1. Generating Transcript-to-Gene (tr2g) Mappings
Before creating a matrix, you must map transcripts to genes. `BUSpaRse` supports multiple sources:

*   **From Ensembl (Biomart):**
    ```r
    tr2g <- tr2g_ensembl(species = "Mus musculus", ensembl_version = 105, gene_biotype_use = "cellranger")
    ```
*   **From Genome Annotation Files:**
    ```r
    # GTF
    tr2g <- tr2g_gtf("path/to/annotation.gtf", Genome = BSgenome.Hsapiens.UCSC.hg38, out_path = "output_dir")
    # FASTA (Ensembl format)
    tr2g <- tr2g_fasta("path/to/transcriptome.fa")
    ```
*   **From Bioconductor Objects:**
    ```r
    tr2g <- tr2g_EnsDb(EnsDb.Hsapiens.v86)
    tr2g <- tr2g_TxDb(TxDb.Hsapiens.UCSC.hg38.knownGene)
    ```

### 2. Converting BUS to Sparse Matrix
Use `make_sparse_matrix` to process the sorted BUS output file. This function can return both a gene count matrix and a TCC matrix.

```r
library(zeallot)
# output.sorted.txt is the result of 'bustools sort'
c(gene_count, tcc) %<-% make_sparse_matrix("output.sorted.txt", 
                                           tr2g = tr2g, 
                                           est_ncells = 1e5, 
                                           est_ngenes = nrow(tr2g))
```

### 3. Filtering Empty Droplets
Single-cell datasets often contain many empty droplets (barcodes with very low UMI counts). `BUSpaRse` provides "knee plot" tools to identify the inflection point for filtering.

```r
# Calculate knee plot data
df <- get_knee_df(gene_count)
# Identify the inflection point
infl <- get_inflection(df)
# Visualize
knee_plot(df, infl)

# Filter the matrix
gene_count_filtered <- gene_count[, Matrix::colSums(gene_count) > infl]
```

## Key Functions
*   `dl_transcriptome()`: Downloads and filters a transcriptome from Ensembl, producing a `tr2g` file and a filtered FASTA.
*   `transcript2gene()`: A legacy wrapper for mapping; prefer specific `tr2g_*` functions for finer control.
*   `make_sparse_matrix()`: The main engine for BUS to Matrix conversion.
*   `get_knee_df()` / `get_inflection()`: Utilities for barcode rank plots and automated filtering.

## Tips
*   **Biotypes:** Use `gene_biotype_use = "cellranger"` in `tr2g` functions to match the standard filtering criteria used by 10x Genomics.
*   **Sorting:** Ensure the BUS file is sorted (usually via `bustools sort`) before calling `make_sparse_matrix`.
*   **Memory:** For very large datasets, ensure `est_ncells` is a reasonable upper bound to help with memory allocation.

## Reference documentation
- [Converting BUS format into sparse matrix](./references/sparse-matrix.md)
- [Generate transcript to gene file for bustools](./references/tr2g.md)