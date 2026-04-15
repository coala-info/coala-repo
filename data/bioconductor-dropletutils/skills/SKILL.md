---
name: bioconductor-dropletutils
description: This tool provides utilities for processing and analyzing droplet-based single-cell RNA-seq data. Use when user asks to load 10X Genomics data, distinguish cells from empty droplets, demultiplex hashed libraries, or remove barcode swapping effects.
homepage: https://bioconductor.org/packages/release/bioc/html/DropletUtils.html
---

# bioconductor-dropletutils

name: bioconductor-dropletutils
description: Utilities for handling droplet-based single-cell RNA-seq data (e.g., 10X Genomics). Use this skill to read CellRanger outputs, distinguish cells from empty droplets using emptyDrops, perform downsampling, demultiplex hashed libraries (HTOs), and remove barcode swapping or chimeric effects.

# bioconductor-dropletutils

## Overview

The `DropletUtils` package provides specialized tools for the analysis of droplet-based single-cell RNA-seq data. It is primarily used for the initial processing steps after quantification, such as importing 10X Genomics data into `SingleCellExperiment` objects, performing quality control on droplets, and mitigating technical artifacts like barcode swapping or ambient RNA contamination.

## Core Workflows

### 1. Loading 10X Genomics Data

The package provides two primary ways to load data depending on the source format.

**From UMI Count Matrices:**
Use `read10xCounts()` to load the standard output directory from CellRanger (containing `matrix.mtx`, `barcodes.tsv`, and `genes.tsv`).
```r
library(DropletUtils)
# Single sample
sce <- read10xCounts("path/to/outs/filtered_gene_bc_matrices/hg19")

# Multiple samples (merges into one SCE object)
sce_mult <- read10xCounts(c("sample1" = "path1", "sample2" = "path2"))
```

**From Molecule Information Files:**
Use `read10xMolInfo()` to extract raw molecule-level data from `molecule_info.h5`.
```r
mol_info <- read10xMolInfo("molecule_info.h5")
# Access data with mol_info$data
```

### 2. Distinguishing Cells from Empty Droplets

A critical step is identifying which barcodes represent real cells versus empty droplets containing only ambient RNA.

**Barcode Rank Plots:**
Visualize the "knee" and "inflection" points to assess the distribution of UMI counts.
```r
br_out <- barcodeRanks(counts(sce))
plot(br_out$rank, br_out$total, log="xy", xlab="Rank", ylab="Total")
abline(h=metadata(br_out)$knee, col="dodgerblue")
abline(h=metadata(br_out)$inflection, col="forestgreen")
```

**Testing for Empty Droplets:**
Use `emptyDrops()` to statistically test if a droplet's profile differs from the ambient pool.
```r
set.seed(100)
# Use the 'raw' (unfiltered) matrix for this step
e_out <- emptyDrops(counts(sce_raw))

# Filter for cells at 1% FDR
is_cell <- e_out$FDR <= 0.01
sce_filtered <- sce_raw[, which(is_cell)]
```

### 3. Demultiplexing Hashed Libraries (HTOs)

For experiments using Hash Tag Oligos (HTOs) to multiplex samples:
```r
# y is a matrix of HTO counts
# ambient is the ambient profile (often from emptyDrops metadata)
demux <- hashedDrops(y, ambient = ambient_profile)

# Identify confident singlets
confident_singlets <- demux[demux$Confident, ]
```

### 4. Removing Technical Artifacts

**Barcode Swapping:**
If multiple samples were sequenced on an Illumina 4000/HiSeq X, use `swappedDrops()` to remove molecules appearing in multiple samples with the same barcode/UMI/gene combination.
```r
s_out <- swappedDrops(c("sample1.h5", "sample2.h5"), min.frac=0.9)
# Returns cleaned sparse matrices
```

**Chimeric Reads:**
Remove chimeric molecules (same UMI/barcode but different genes) within a single sample.
```r
cleaned_counts <- chimericDrops("molecule_info.h5")
```

## Tips and Best Practices

- **Sparse Matrices:** `DropletUtils` uses `dgCMatrix` (sparse) formats. Ensure downstream tools are compatible or convert using `as.matrix()` only if the dataset is small.
- **Seed Setting:** Functions like `emptyDrops()` use permutation testing; always `set.seed()` for reproducibility.
- **Downsampling:** Use `downsampleReads()` on molecule info files to simulate lower coverage while preserving the UMI/read relationship, or `downsampleMatrix()` for simple count-based reduction.
- **Ambient Profile:** When running `emptyDrops()`, the "ambient" profile is estimated from barcodes with low total counts (default `lower=100`). Adjust this parameter if your dataset has extremely low or high sequencing depth.

## Reference documentation

- [DropletUtils](./references/DropletUtils.md)