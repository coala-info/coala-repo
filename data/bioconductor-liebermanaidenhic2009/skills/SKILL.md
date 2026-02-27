---
name: bioconductor-liebermanaidenhic2009
description: This package provides access to and analysis workflows for the landmark 2009 Lieberman-Aiden Hi-C dataset. Use when user asks to load chromosome 14 interaction data, generate smoothed interaction matrices, normalize for genomic distance, perform PCA to identify chromatin compartments, or correlate Hi-C data with epigenetic markers.
homepage: https://bioconductor.org/packages/release/data/experiment/html/LiebermanAidenHiC2009.html
---


# bioconductor-liebermanaidenhic2009

name: bioconductor-liebermanaidenhic2009
description: Provides access to and analysis workflows for the landmark 2009 Hi-C dataset by Lieberman-Aiden et al. Use this skill to load chromosome 14 interaction data, generate smoothed interaction matrices, normalize for genomic distance, perform PCA to identify chromatin compartments, and correlate Hi-C data with epigenetic markers (ChIP-seq).

# bioconductor-liebermanaidenhic2009

## Overview
The `LiebermanAidenHiC2009` package is a Bioconductor experiment data package containing Hi-C interaction data for the GM06990 cell line. It specifically provides processed paired-end reads for chromosome 14 and associated ChIP-seq data (H3K27me3, H3K36me3, and DNAse1). This skill guides the user through reproducing the analysis that identified A/B chromatin compartments using interaction matrices, normalization, and Principal Component Analysis (PCA).

## Data Loading
The package contains two primary datasets: the Hi-C interaction data and the comparative ChIP-seq data.

```r
library(LiebermanAidenHiC2009)

# Load Hi-C paired-end read data for Chromosome 14
data("HiC_GM_chr14")

# Load ChIP-seq and DNAse1 data frames
data("ChipSeqData")
```

The `HiC_GM_chr14` data frame includes columns for read names, chromosome, position, strand, and restriction fragments for both ends of the paired-end reads.

## Generating Interaction Matrices
To visualize and analyze interactions, the raw point data must be smoothed into a 2D density matrix.

1. **Smoothing**: Use the `KernSmooth` package to create a 2D kernel density estimate.
2. **Symmetrization**: Since Hi-C interactions are undirected, the matrix must be made symmetric.

```r
library(KernSmooth)
pos = with(HiC_GM_chr14, cbind(position1, position2))
gridsize = ceiling(max(pos)/2e5)
bandwidth = 3e5

# Create density estimate
den = bkde2D(pos, bandwidth=c(1,1)*bandwidth, gridsize=c(1,1)*gridsize)

# Symmetrize the matrix
den$fhat <- den$fhat + t(den$fhat)

# Visualize with exponentiation to enhance contrast
image(x=den$x1, y=den$x2, z=den$fhat^0.3, col=colorRampPalette(c("white","blue"))(256))
```

## Normalization and Correlation
Hi-C data is dominated by the "diagonal effect" where interaction frequency decays with genomic distance.

1. **Distance Normalization**: Calculate the mean number of interactions at each genomic distance and divide the observed matrix by these expected values.
2. **Correlation Matrix**: Calculate the Pearson correlation between rows of the normalized matrix to highlight the "plaid" pattern of compartments.

```r
# Calculate correlation matrix from normalized data (fhatNorm)
cm <- cor(fhatNorm)

# Visualize compartments (Red/Blue indicates different compartments)
image(x=den$x1, y=den$x2, z=cm, zlim=c(-1,1),
      col=colorRampPalette(c("red", "white","blue"))(256))
```

## Compartment Identification (PCA)
The first principal component (PC1) of the correlation matrix typically corresponds to the A/B compartment structure.

```r
# Perform PCA
princp = princomp(cm)

# Extract PC1 (the first eigenvector)
pc1_loadings = princp$loadings[,1]

# Plot PC1 against genomic position
plot(den$x1, pc1_loadings, type="l")
```

## Comparison with Chromatin States
To validate compartments, compare the PC1 vector with epigenetic marks using Run-Length Encoding (`Rle`) from the `IRanges` package.

```r
library(IRanges)

# Convert PC1 to an Rle object for efficient genomic comparison
pc1Vec = Rle(values = princp$loadings[,1], lengths = c(den$x1[1], diff(den$x1)))

# Calculate correlation between Hi-C PC1 and ChIP-seq signal
# Note: Vectors must be aligned to the same genomic length/scale
cor(H3K36me3[x], pc1Vec[x])
```

## Reference documentation
- [Exploration of HiC data](./references/LiebermanAidenHiC2009.md)