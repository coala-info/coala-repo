---
name: bioconductor-scate
description: SCATE is a statistical framework that enhances sparse single-cell ATAC-seq data by integrating information from co-activated regulatory elements and public databases. Use when user asks to preprocess scATAC-seq BAM files, cluster cells based on chromatin accessibility, reconstruct high-resolution regulatory signals, or call peaks from enhanced single-cell data.
homepage: https://bioconductor.org/packages/3.12/bioc/html/SCATE.html
---

# bioconductor-scate

## Overview

SCATE (Single-cell ATAC-seq Signal Extraction and Enhancement) is a statistical framework designed to overcome the extreme sparsity of scATAC-seq data. It integrates information across co-activated cis-regulatory elements (CREs), similar cells, and public regulome databases to accurately estimate the activity of individual genomic bins. This allows for high-resolution regulatory analysis even in small cell subpopulations.

## Data Preparation and Preprocessing

SCATE accepts aligned BAM files (one per cell), GRanges objects, or peak call data frames.

```r
library(SCATE)

# 1. Identify BAM files
bam_files <- list.files("path/to/bams", full.names = TRUE, pattern = ".bam$")

# 2. Preprocess: Convert to midpoints and filter by library size
# type can be 'bam', 'gr' (GRanges), or 'peak'
satac <- satacprocess(input = bam_files, type = 'bam', libsizefilter = 1000)
```

## Cell Clustering

If cell types are unknown, use the built-in clustering function which utilizes averaged signals of CRE clusters.

```r
# genome: "hg19" or "mm10"
# clunum: Number of clusters (NULL for automatic detection)
cluster_res <- cellcluster(satac, genome = "hg19", clunum = NULL, perplexity = 30)

# Extract results
tsne_coords <- cluster_res[[1]]
cell_clusters <- cluster_res[[2]]
```

## Signal Reconstruction (SCATE)

The core function reconstructs signals for individual CREs based on the defined clusters.

```r
# cluster: A named vector of cluster assignments
# clunum: Number of CRE clusters (NULL for automatic)
# ncores: Parallel processing (Note: forced to 1 on Windows)
scate_results <- SCATE(satac, 
                       genome = "hg19", 
                       cluster = cell_clusters, 
                       clunum = NULL, 
                       ncores = 3)
```

The output is a matrix where rows are genomic bins and columns are clusters.

## Downstream Analysis

### Feature Extraction
Extract signals for specific genomic regions of interest.

```r
regions <- data.frame(chr = c('chr1', 'chr5'), 
                      start = c(100000, 50000), 
                      end = c(100500, 50500))

# mode: 'overlap' (all bins in region) or 'nearest' (closest bin)
extracted <- extractfeature(scate_results, regions, mode = 'overlap')

# Optional: Save to BED files for genome browsers
extractfeature(scate_results, regions, mode = 'overlap', folder = "output_bed")
```

### Peak Calling
Identify significant peaks from the enhanced SCATE signals.

```r
peaks <- peakcall(scate_results)
# Returns a list of data frames (one per cluster) with columns: chr, start, end, FDR, Signal
```

## Pipeline Wrapper

For a streamlined execution of the entire workflow:

```r
pipeline_res <- SCATEpipeline(bam_files, genome = "hg19", cellclunum = 2)
# Access components: pipeline_res[['cellcluster']], pipeline_res[['SCATE']], pipeline_res[['peak']]
```

## Custom Databases

To use your own bulk DNase-seq data or specific CRE sets:

1. **Build/Update Database**: Use `makedatabase()`. This requires downloading the base hg19/mm10 data packages from the SCATE website.
2. **Apply Database**: Pass the path to the generated `.rds` file to the `datapath` argument in `cellcluster`, `SCATE`, or `SCATEpipeline`.

```r
# Example using custom database
res <- SCATE(satac, datapath = "path/to/my_database.rds", cluster = cell_clusters)
```

## Reference documentation

- [Single-cell ATAC-seq Signal Extraction and Enhancement with SCATE](./references/SCATE.Rmd)
- [Single-cell ATAC-seq Signal Extraction and Enhancement with SCATE](./references/SCATE.md)