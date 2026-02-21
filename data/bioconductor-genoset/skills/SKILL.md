---
name: bioconductor-genoset
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/genoset.html
---

# bioconductor-genoset

name: bioconductor-genoset
description: Specialized for genomic analysis using the Bioconductor 'genoset' package. Use this skill when working with GenoSet objects, which extend eSet to include genomic location metadata. It is ideal for processing copy number data, B-Allele Frequency (BAF) data, performing segmentation (CBS), and visualizing data along genomic coordinates.

# bioconductor-genoset

## Overview
The `genoset` package provides the `GenoSet` class, an extension of the Bioconductor `eSet` that integrates genomic location metadata (`locData`) with feature and phenotype data. This allows for seamless subsetting, querying, and plotting of genomic assays by genomic position. It is particularly useful for copy number analysis, handling Run-Length-Encoded (Rle) data for memory efficiency, and performing Circular Binary Segmentation (CBS).

## Core Workflows

### 1. Object Creation
Create a `GenoSet` object by providing location data (as `GRanges` or `RangedData`) and assay data (matrices or `RleDataFrame`).

```r
library(genoset)
# locData.gr is a GRanges object; fake.cn is a matrix of copy number values
gs <- GenoSet(locData = locData.gr, cn = fake.cn, pData = fake.pData, annotation = "SNP6")

# Using RleDataFrame for memory efficiency (ideal for segmented data)
rle.ds <- GenoSet(locData = locData.gr, cn.segments = RleDataFrame(sample1 = Rle(values), ...))
```

### 2. Accessing Genomic Information
Use specialized accessors to retrieve coordinates and chromosome info.

*   `locData(gs)`: Get the genomic ranges.
*   `chr(gs)`, `pos(gs)`: Get chromosome and midpoint positions for each feature.
*   `genoPos(gs)`: Get absolute genomic positions (cumulative across chromosomes).
*   `chrInfo(gs)`: Get chromosome boundaries and offsets for plotting.
*   `chrIndices(gs, "chr1")`: Get row indices for a specific chromosome.

### 3. Subsetting and Genome Order
`GenoSet` supports standard array notation and range-based subsetting.

```r
# Subset by chromosome
chr12.ds <- gs[chrIndices(gs, "chr12"), ]

# Subset by GRanges (e.g., specific genes)
gene.gr <- GRanges(seqnames = "chr17", ranges = IRanges(35e6, 35.5e6))
gene.ds <- gs[gene.gr, ]

# Ensure genome order (required for many operations)
gs <- toGenomeOrder(gs, strict = TRUE)
isGenomeOrder(gs)
```

### 4. Data Processing and Segmentation
The package includes tools for GC correction and a wrapper for the CBS algorithm.

```r
# GC Correction
gs[, , "cn"] <- gcCorrect(gs[, , "cn"], gc_content_vector)

# Segmentation using CBS (requires DNAcopy)
# runCBS returns an RleDataFrame which is memory efficient
gs[, , "cn.segs"] <- runCBS(gs[, , "cn"], locData(gs))

# Parallel processing
library(parallel)
gs[, , "cn.segs"] <- runCBS(gs[, , "cn"], locData(gs), n.cores = 4)
```

### 5. Converting Between Tables and Rle
Switch between segment tables (for reporting) and Rle objects (for storage/plotting).

```r
# Get a table of segments for one sample
segs <- segTable(gs[, 1, "cn.segs"], locData(gs))

# Convert table back to Rle
rle_vec <- segs2Rle(segs, locData(gs))
```

### 6. Gene-Level Summaries
Summarize probe-level data over genomic ranges (e.g., genes).

```r
# Calculate mean segmented value per gene
gene_means <- rangeSampleMeans(gene.gr, gs, "cn.segs")
```

### 7. Visualization
`genoPlot` is the primary function for plotting data along the genome.

```r
# Plot whole genome
genoPlot(gs, gs[, 1, "cn"])
genoPlot(gs, gs[, 1, "cn.segs"], add = TRUE, col = "red")

# Plot specific chromosome
genoPlot(gs, gs[, 1, "cn"], chr = "chr12")
```

## Tips for Large Data
*   **RleDataFrame**: Always store segmented data as `RleDataFrame` to save RAM.
*   **BigMatrix**: For extremely large datasets, use `BigMatrix` from the `bigmemoryExtras` package as an `assayDataElement`.
*   **k-argument**: Use the third index in brackets `gs[i, j, "element_name"]` to quickly access specific assay data.

## Reference documentation
- [An Introduction to the genoset Package](./references/genoset.Rmd)