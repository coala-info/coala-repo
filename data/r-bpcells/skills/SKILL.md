---
name: r-bpcells
description: BPCells performs high-performance, memory-efficient single-cell analysis of large RNA-seq and ATAC-seq datasets using bitpacking compression and streaming. Use when user asks to import 10x data, perform disk-backed normalization, call ATAC-seq peaks, or conduct PCA and clustering on millions of cells.
homepage: https://cran.r-project.org/web/packages/bpcells/index.html
---

# r-bpcells

name: r-bpcells
description: High-performance single-cell analysis of large RNA-seq and ATAC-seq datasets using the bpcells R package. Use this skill when needing to perform memory-efficient, disk-backed operations including bitpacking compression, normalization, PCA, clustering, and ATAC-seq peak calling/footprinting on datasets ranging from thousands to millions of cells.

# r-bpcells

## Overview
BPCells is an R package designed for high-performance single-cell analysis. It utilizes bitpacking compression and C++ powered streaming/lazy evaluation to process massive datasets (up to 44M cells) on standard hardware with minimal RAM usage.

## Installation
To install the R package:
```R
remotes::install_github("bnprks/BPCells/r")
```
*Note: Requires HDF5 library installed on the system (e.g., `libhdf5-dev` on Linux or `brew install hdf5` on macOS).*

## Core Principles
- **Streaming:** Only minimal data is stored in memory during computation.
- **Lazy Evaluation:** Operations are queued and only executed when writing to disk or converting to an R object (e.g., `as(mat, "dgCMatrix")`).
- **Bitpacking:** Specialized compression that allows faster-than-gzip read/write speeds while maintaining small file sizes.

## Common Workflows

### Data Import and Storage
Convert 10x formats to BPCells bitpacked format for maximum performance.
```R
# RNA
mat <- open_matrix_10x_hdf5("data.h5") %>% write_matrix_dir("rna_counts")
# ATAC
frags <- open_fragments_10x("fragments.tsv.gz") %>% write_fragments_dir("atac_frags")
```

### RNA-seq Pipeline
```R
mat <- open_matrix_dir("rna_counts")
# 1. Normalization (Lazy)
mat_norm <- mat %>% 
  multiply_cols(1/Matrix::colSums(mat)) %>% 
  log1p(10000 * .)
# 2. Stats and Variable Gene Selection
stats <- matrix_stats(mat_norm, row_stats="variance")
v_genes <- order(stats$row_stats["variance",], decreasing=TRUE)[1:2000]
# 3. PCA (Write to memory/disk first for speed during iterations)
pca_input <- mat_norm[v_genes,] %>% write_matrix_memory()
svd <- BPCells::svds(pca_input, k=50)
pca_embeddings <- svd$v %*% diag(svd$d)
```

### ATAC-seq Pipeline
```R
frags <- open_fragments_dir("atac_frags")
# 1. QC Metrics
qc <- qc_scATAC(frags, genes_gr, blacklist_gr)
# 2. Peak Calling (Tile-based)
peaks <- call_peaks_tile(frags, chrom_sizes, cell_groups=clusters)
# 3. Peak Matrix and LSI
pm <- peak_matrix(frags, peaks)
mat_lsi <- pm %>% 
  multiply_cols(1/Matrix::colSums(pm)) %>% 
  multiply_rows(1/Matrix::rowMeans(pm)) %>% 
  log1p(10000 * .)
```

### Visualization
- **Embeddings:** `plot_embedding(cell_clusters, umap_coords)`
- **Tracks:** Use `trackplot_combine()` to stack `trackplot_coverage()`, `trackplot_gene()`, and `trackplot_scalebar()`.
- **Footprinting:** `plot_tf_footprint(frags, motif_positions, cell_groups)`

## Efficiency Tips
- **Avoid Densification:** Keep sparsity-breaking operations (like adding a mean vector) as the very last step in a lazy chain.
- **Storage Order:** Use `transpose_storage_order()` if an operation requires row-major vs column-major (e.g., marker gene detection usually prefers gene-indexed).
- **PCA Caching:** Always use `write_matrix_dir()` or `write_matrix_memory()` before PCA to avoid re-calculating lazy operations hundreds of times.

## Reference documentation
- [Performance Benchmarks](./references/benchmarks.html.md)
- [BPCells Home](./references/home_page.md)
- [How BPCells Works](./references/how-it-works.html.md)
- [Package Index](./references/index.html.md)
- [PBMC 3k Tutorial](./references/pbmc3k.html.md)
- [Programming Efficiency](./references/programming-efficiency.html.md)