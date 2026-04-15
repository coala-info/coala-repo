---
name: bioconductor-metabinr
description: This tool performs abundance-based and composition-based binning of metagenomic reads using k-mer frequency analysis. Use when user asks to cluster metagenomic sequences into taxonomic bins, perform abundance-based or composition-based binning, or execute hierarchical binning workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/metabinR.html
---

# bioconductor-metabinr

name: bioconductor-metabinr
description: Perform abundance-based and composition-based binning of metagenomic reads directly from FASTA/FASTQ files. Use this skill when you need to cluster metagenomic sequences into taxonomic bins using k-mer analysis, specifically for (1) Abundance-based binning (long k-mers, k>8), (2) Composition-based binning (short k-mers, k<8), or (3) Hierarchical binning (2-step ABxCB).

# bioconductor-metabinr

## Overview

The `metabinR` package provides tools for metagenomic binning, which is the process of grouping sequences (reads) that likely originate from the same organism. It utilizes k-mer frequency analysis to differentiate between taxa based on their abundance profiles or their genomic composition.

Key features:
- **Abundance-based Binning (AB):** Uses long k-mers (typically k=10+) to group reads based on the coverage/abundance of the source organism.
- **Composition-based Binning (CB):** Uses short k-mers (typically k=4 to 6) to group reads based on genomic signatures (e.g., tetranucleotide frequencies).
- **Hierarchical Binning:** A two-step approach (AB followed by CB) to refine clusters.

## Preparation

`metabinR` relies on `rJava`. You must allocate sufficient RAM to the Java Virtual Machine (JVM) before loading the library.

```r
# Allocate 4GB of RAM (adjust based on dataset size)
options(java.parameters="-Xmx4G")
library(metabinR)
```

## Core Workflows

### 1. Abundance-based Binning (AB)
Best for samples where taxa have distinct abundance levels.

```r
assignments.AB <- abundance_based_binning(
    fastaFile = "path/to/reads.fasta.gz",
    numOfClustersAB = 2,    # Expected number of abundance classes
    kMerSizeAB = 10,        # Long k-mers for abundance
    dryRun = FALSE,
    outputAB = "prefix"     # Prefix for generated fasta/histogram files
)
# Returns a dataframe with read_id and assigned AB cluster
```

### 2. Composition-based Binning (CB)
Best for separating taxa based on sequence signatures, often used when abundance is uniform or unknown.

```r
assignments.CB <- composition_based_binning(
    fastaFile = "path/to/reads.fasta.gz",
    numOfClustersCB = 10,   # Expected number of genomes/taxa
    kMerSizeCB = 4,         # Short k-mers for composition
    dryRun = FALSE,
    outputCB = "prefix"
)
```

### 3. Hierarchical Binning (ABxCB)
Combines both methods: first separates by abundance, then sub-clusters by composition.

```r
assignments.ABxCB <- hierarchical_binning(
    fastaFile = "path/to/reads.fasta.gz",
    numOfClustersAB = 2,
    kMerSizeAB = 10,
    kMerSizeCB = 4,
    dryRun = FALSE,
    outputC = "prefix"
)
# Returns a dataframe with 'ABxCB' column representing the final bins
```

## Interpreting Results

- **Return Value:** The functions return a `data.frame` containing `read_id` and the cluster assignment (e.g., `AB`, `CB`, or `ABxCB`).
- **Files Created:** If `dryRun = FALSE`, the package writes FASTA files for each bin and a k-mer count histogram (for AB binning) to the working directory.
- **Evaluation:** Use the `sabre` package (specifically `vmeasure`) to evaluate clustering quality if ground truth (mapping) is available.

## Tips
- **K-mer Selection:** Use $k \ge 10$ for abundance and $k \in [4, 6]$ for composition.
- **Memory:** If you encounter "Out of Memory" errors, increase the `-Xmx` parameter in `options(java.parameters)` and restart the R session.
- **Dry Run:** Set `dryRun = TRUE` to perform the clustering and return the dataframe without writing large FASTA files to disk.

## Reference documentation
- [metabinR Vignette](./references/metabinR_vignette.md)