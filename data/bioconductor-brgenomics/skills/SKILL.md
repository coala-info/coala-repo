---
name: bioconductor-brgenomics
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.11/bioc/html/BRGenomics.html
---

# bioconductor-brgenomics

name: bioconductor-brgenomics
description: Expert guidance for using the BRGenomics R package for analyzing basepair-resolution genomics data (e.g., PRO-seq, PRO-cap, ATAC-seq). Use this skill when the user needs to import BAM/bigWig/bedGraph files into R, manipulate GRanges annotations, calculate signal counts over regions, perform spike-in normalization, or conduct differential expression analysis using DESeq2 with global perturbations.

# bioconductor-brgenomics

## Overview
BRGenomics is a Bioconductor package designed for the efficient analysis of high-resolution genomics data. It centers on the "Basepair-Resolution GRanges" (BRG) object—a GRanges where each range is 1 bp wide and contains a score representing signal. This structure allows for fast, vectorized operations across multiple datasets, simplifying workflows that previously required command-line tools like `bedtools` or `deeptools`.

## Core Workflows

### 1. Data Import and BRG Creation
The package provides specialized functions to convert raw files into basepair-resolution GRanges.

```r
library(BRGenomics)

# Import PRO-seq BAM (automatically handles revcomp, shift -1, and 3' end extraction)
ps <- import_bam_PROseq("path/to/file.bam", mapq = 30)

# Import unstranded bigWigs as a single stranded GRanges
bw_data <- import_bigWig("plus.bw", "minus.bw", genome = "dm6")

# Check if an object is basepair-resolution
isBRG(ps)
```

### 2. Annotation Manipulation
Use `genebodies()` for flexible region definition and `reduceByGene()` to handle isoforms.

```r
data("txs_dm6_chr4")

# Get regions from 300bp downstream of TSS to 300bp upstream of CPS
bodies <- genebodies(txs_dm6_chr4, start = 300, end = -300)

# Get promoters (-50 to +100 around TSS)
promoters <- genebodies(txs_dm6_chr4, -50, 100, fix.end = "start")

# Combine isoforms into a single consensus representation per gene
collapsed_genes <- reduceByGene(txs_dm6_chr4, gene_names = txs_dm6_chr4$gene_id)
```

### 3. Signal Counting
Functions like `getCountsByRegions` and `getCountsByPositions` are optimized for speed and support multi-core processing via the `ncores` argument.

```r
# Count total signal in regions
counts <- getCountsByRegions(ps, bodies)

# Get a matrix of signal at every position (for heatmaps/profiles)
# Use 'binsize' to group bases
pos_matrix <- getCountsByPositions(ps, promoters, binsize = 1)
```

### 4. Analyzing Multiple Datasets
Store multiple GRanges in a named list to process them simultaneously.

```r
ps_list <- list(rep1 = ps1, rep2 = ps2)

# Returns a melted dataframe ready for ggplot2
multi_counts <- getCountsByRegions(ps_list, bodies, melt = TRUE)

# Merge replicates into a single BRG
merged <- mergeGRangesData(ps_list)
```

### 5. Differential Expression (DESeq2)
BRGenomics provides wrappers for DESeq2 that are robust to global signal perturbations by avoiding "blind" dispersion estimation across all samples.

```r
# 1. Create DESeqDataSet (handles replicate grouping via "repX" naming convention)
dds <- getDESeqDataSet(ps_list, txs_dm6_chr4, gene_names = txs_dm6_chr4$gene_id)

# 2. Run pairwise results
# Note: sizeFactors in DESeq2 are 1 / BRGenomics normalization factors
res <- getDESeqResults(dds, contrast.numer = "ConditionB", contrast.denom = "ConditionA")
```

## Tips and Best Practices
- **Parallelization**: Most functions use `ncores`. Set `options(mc.cores = 4)` to set a global default. Note: Parallel processing is not available on Windows.
- **Memory**: For large datasets, use `saveRDS()` and `readRDS()` to store processed GRanges objects as binary files to avoid re-importing from bigWig/BAM.
- **Multiplexed GRanges**: While `mergeGRangesData(..., multiplex = TRUE)` creates a single object with multiple metadata columns, a standard `list` of GRanges often performs better for sparse data.
- **Normalization**: When using spike-ins, calculate factors using `getSpikeInNFs()`. Remember to use the inverse ($1/NF$) when passing to DESeq2 as `sizeFactors`.

## Reference documentation
- [Analyzing Multiple Datasets](./references/AnalyzingMultipleDatasets.md)
- [DESeq2 with Global Perturbations](./references/DESeq2WithGlobalPerturbations.md)
- [Getting Started](./references/GettingStarted.md)
- [Importing and Modifying Annotations](./references/ImportingModifyingAnnotations.md)
- [Importing and Processing Data](./references/ImportingProcessingData.md)
- [Overview](./references/Overview.md)
- [Profile Plots and Bootstrapping](./references/ProfilePlotsAndBootstrapping.md)
- [Sequence Extraction](./references/SequenceExtraction.md)
- [Signal Counting](./references/SignalCounting.md)
- [Spike-In Normalization](./references/SpikeInNormalization.md)