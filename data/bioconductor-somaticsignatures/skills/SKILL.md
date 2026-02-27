---
name: bioconductor-somaticsignatures
description: This tool identifies mutational signatures from somatic single nucleotide variants by analyzing sequence contexts and performing matrix decomposition. Use when user asks to extract mutational motifs, construct motif matrices, identify mutational signatures using NMF or PCA, or visualize signature contributions across samples.
homepage: https://bioconductor.org/packages/release/bioc/html/SomaticSignatures.html
---


# bioconductor-somaticsignatures

name: bioconductor-somaticsignatures
description: Use this skill when analyzing somatic mutational signatures from single nucleotide variants (SNVs) in R. It provides workflows for extracting sequence motifs (trinucleotide contexts), constructing motif matrices, and performing matrix decomposition (NMF or PCA) to identify mutational signatures and their contributions across samples.

# bioconductor-somaticsignatures

## Overview

The `SomaticSignatures` package identifies mutational signatures from cancer sequencing studies. It relates somatically occurring SNVs to their surrounding sequence context (somatic motifs) and decomposes the resulting frequency matrix into signatures (composition of motifs) and sample contributions (exposure of signatures).

## Core Workflow

### 1. Prepare Input Data
Variants must be in a `VRanges` object. You can convert a `VCF` or data frame to `VRanges` using `VariantAnnotation`.

```r
library(SomaticSignatures)
library(VariantAnnotation)

# Example: Constructing from scratch
vr = VRanges(
    seqnames = "chr1",
    ranges = IRanges(start = 1000, width = 1),
    ref = "A",
    alt = "C",
    sampleNames = "Sample1")
```

### 2. Extract Mutational Context
Use `mutationContext` to retrieve the sequence surrounding the SNV. This requires a reference genome (e.g., `BSgenome.Hsapiens.UCSC.hg19`).

```r
library(BSgenome.Hsapiens.UCSC.hg19)
# Extracts trinucleotide context and shifts to pyrimidine-base reference
sca_motifs = mutationContext(vr, BSgenome.Hsapiens.UCSC.hg19)
```

### 3. Construct Motif Matrix
Create a matrix $M$ where rows are motifs and columns are samples or groups.

```r
# normalize = TRUE returns frequencies; FALSE returns counts
sca_mm = motifMatrix(sca_motifs, group = "sampleNames", normalize = TRUE)
```

### 4. Determine Number of Signatures
If the number of signatures ($r$) is unknown, use `assessNumberSignatures` to evaluate different values based on Residual Sum of Squares (RSS) and explained variance.

```r
n_sigs = 2:10
gof_nmf = assessNumberSignatures(sca_mm, n_sigs, nReplicates = 5)
plotNumberSignatures(gof_nmf)
```

### 5. Identify Signatures
Decompose the matrix using Non-negative Matrix Factorization (NMF) or Principal Component Analysis (PCA).

```r
# Using NMF
sigs_nmf = identifySignatures(sca_mm, 5, nmfDecomposition)

# Using PCA
sigs_pca = identifySignatures(sca_mm, 5, pcaDecomposition)
```

### 6. Visualization
Explore the results using built-in plotting functions (based on `ggplot2`).

```r
# Plot the composition of signatures
plotSignatures(sigs_nmf)

# Plot the contribution of signatures to each sample
plotSamples(sigs_nmf)

# Plot the original mutation spectrum
plotMutationSpectrum(sca_motifs, "sampleNames")
```

## Advanced Operations

### Normalization for Capture Targets
When comparing WES to WGS, normalize for the different k-mer frequencies in the target regions.

```r
# norms is a vector of ratios (e.g., genome-frequency / exome-frequency)
sca_mm_norm = normalizeMotifs(sca_mm, norms)
```

### Batch Effect Correction
Use `ComBat` from the `sva` package on the motif matrix if technical covariates (e.g., sequencing center) are present.

```r
library(sva)
sca_mm_corrected = ComBat(sca_mm, batch = batch_labels, mod = model.matrix(~1, metadata))
```

### Clustering
Group samples or motifs based on their mutational profiles.

```r
clu_motif = clusterSpectrum(sca_mm, "motif")
library(ggdendro)
ggdendrogram(clu_motif, rotate = TRUE)
```

## Tips for Success
- **Object Accessors:** Use `signatures(sigs)`, `samples(sigs)`, `observed(sigs)`, and `fitted(sigs)` to extract the underlying matrices from the result object.
- **Reference Genomes:** `mutationContext` works with any object providing a `getSeq` method, including `FaFile` (FASTA) and `TwoBitFile`.
- **Custom Decompositions:** You can pass custom functions to the `decomposition` argument of `identifySignatures`.

## Reference documentation
- [Inferring Somatic Signatures from Single Nucleotide Variant Calls](./references/SomaticSignatures-vignette.md)