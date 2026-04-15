---
name: dropest
description: The dropest tool processes raw droplet-based single-cell RNA-seq data to generate high-quality gene expression matrices. Use when user asks to extract cell barcodes and UMIs, estimate molecular count matrices from aligned BAM files, or perform UMI error correction and quality reporting.
homepage: https://github.com/hms-dbmi/dropEst/
metadata:
  docker_image: "quay.io/biocontainers/dropest:0.8.6--r42h05d83d2_6"
---

# dropest

## Overview
The `dropest` skill provides a specialized workflow for the initial analysis of droplet-based single-cell RNA-seq (scRNA-seq) data. It transforms raw sequencing reads into high-quality gene expression matrices by handling the specific nuances of droplet protocols, such as barcode/UMI extraction and error correction. The pipeline is designed to be efficient, primarily written in C++, and integrates with R for downstream statistical corrections and reporting.

## Workflow and Best Practices

### 1. Barcode and UMI Extraction (dropTag)
The first step is to demultiplex the library and extract cellular metadata.
- **Purpose**: Identifies cell barcodes (CB) and Unique Molecular Identifiers (UMI) from the raw fastq files.
- **Output**: Generates demultiplexed `.fastq.gz` files ready for genomic alignment.
- **Supported Protocols**: 
  - 10x (v1-v3)
  - Drop-seq
  - inDrop (v1-v3)
  - CEL-Seq2
  - Seq-Well, SPLiT-seq, and iCLIP

### 2. Alignment
After extraction, you must align the demultiplexed reads to a reference genome.
- **Requirement**: Use a standard aligner (like STAR or Bowtie2).
- **Output**: A `.bam` file containing the alignments. Ensure the aligner preserves the barcode/UMI tags in the BAM records.

### 3. Count Matrix Estimation (dropEst)
This is the core component that processes the aligned BAM files.
- **Functionality**: 
  - Groups reads by cell barcode and UMI.
  - Performs UMI collision correction.
  - Estimates molecular counts per gene per cell.
- **Output**: An `.rds` file containing the count matrix and diagnostic statistics. It can also export in MatrixMarket format for compatibility with other tools.
- **Optimization**: Use the `-p` flag (if available in your version) to specify the number of threads for parallel processing to manage high-memory demands.

### 4. Quality Control and Correction
- **dropReport**: Use this tool to generate an HTML report on library quality, including saturation curves and barcode distribution.
- **dropEstR**: Utilize this R package for advanced UMI count corrections and to classify cell quality (distinguishing real cells from empty droplets).

## Installation and Environment
The most reliable way to deploy dropest is via Conda:
```bash
conda install -c bioconda dropest
```

If building from source, ensure the following dependencies are met:
- **C++**: GCC >= 4.8.5 or Clang >= 3.9.1 (C++11 support required).
- **Libraries**: Boost (>= 1.54), BamTools (>= 2.5.0), Zlib, and Bzip2.
- **R Integration**: R (>= 3.2.2) with `Rcpp`, `RcppEigen`, `RInside`, and `Matrix` packages.
- **Shared Libraries**: R must be compiled with the `--enable-R-shlib` flag to produce `libR.so`.

## Expert Tips
- **Memory Management**: Processing large scRNA-seq datasets is RAM-intensive. Monitor memory usage during the `dropEst` phase, especially when dealing with millions of droplets.
- **Barcode Validation**: When working with Drop-seq or 10x, providing a list of "real" known barcodes can significantly improve the accuracy of the cell calling process.
- **Path Configuration**: If the build fails to find R, manually set `R_ROOT` (from `R.home()`) and `R_PACKAGES` (from `.libPaths()`) environment variables before running `cmake`.

## Reference documentation
- [dropEst GitHub Repository](./references/github_com_kharchenkolab_dropEst.md)
- [Installing dropEst and R issues](./references/github_com_kharchenkolab_dropEst_wiki_Installing-dropEst_-R-issues.md)
- [Bioconda dropest Overview](./references/anaconda_org_channels_bioconda_packages_dropest_overview.md)