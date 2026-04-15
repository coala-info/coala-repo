---
name: bioconductor-rsweep
description: This tool converts biological sequences into low-dimensional numerical vectors using alignment-free k-mer projection. Use when user asks to represent sequences as vectors, perform alignment-free phylogenetic analysis, cluster large sequence datasets, or evaluate taxonomic consistency.
homepage: https://bioconductor.org/packages/release/bioc/html/rSWeeP.html
---

# bioconductor-rsweep

## Overview

The `rSWeeP` package implements the Spaced Words Projection (SWeeP) method for representing biological sequences as compact, low-dimensional numerical vectors (LDVs). It bypasses the computational bottlenecks of traditional sequence alignment by using k-mer counting followed by random projection. This approach is highly scalable, with processing time growing linearly with the number of sequences. It is particularly useful for large-scale phylogenetics, RNA-seq dimensionality reduction, and sequence clustering.

## Core Functions

- `SWeePlite()`: The recommended entry point for most users. It features a built-in orthonormal basis, making it memory-efficient and easy to use for large datasets or long sequences.
- `SWeeP()`: The conventional implementation requiring a manually generated or loaded orthonormal basis.
- `orthBase()`: Generates the orthonormal matrix required for the standard `SWeeP` function.
- `extractHDV()`: Extracts the raw High Dimensional Vector (k-mer counts) without the projection step.
- `PCCI()`: Calculates the PhyloTaxonomic Consistency Cophenetic Index to estimate how well taxa group together in a tree.
- `PMPG()`: Calculates the percentage of Monophyletic and Paraphyletic taxa to validate phylogenetic consistency.

## Typical Workflow

### 1. Sequence Vectorization
To convert a directory of FASTA files into vectors, use `SWeePlite`.

```r
library(rSWeeP)

# path: directory containing FASTA files
# seqtype: 'AA' for amino acids, 'NT' for nucleotides
# mask: k-mer size/mask (e.g., 4)
# psz: Projection size (length of the output vector, e.g., 1000)
sw <- SWeePlite(path = "path/to/fasta/files/", seqtype = "AA", mask = c(4), psz = 1000)

# Access the resulting matrix (rows = samples, columns = coordinates)
vector_matrix <- sw$proj
```

### 2. Phylogenetic Analysis
The output matrix can be used directly with standard R distance metrics and tree-building packages like `ape`.

```r
library(ape)

# Calculate Euclidean distance between SWeeP vectors
mdist <- dist(sw$proj, method = "euclidean")

# Build a Neighbor-Joining tree
tr <- nj(mdist)

# Plot the tree
plot(tr)
```

### 3. Evaluating Taxonomic Consistency
If you have metadata (e.g., family or genus labels), you can evaluate the quality of the generated tree.

```r
# data: data.frame with columns for sample names and taxonomic classes
taxa_data <- data.frame(sp = metadata$fileName, family = metadata$family)

# Calculate consistency indices
pcci_results <- PCCI(tr, taxa_data)
pmpg_results <- PMPG(tr, taxa_data)

# View percentage of monophyletic groups
print(pmpg_results$percMono)
```

### 4. Dimensionality Reduction (PCA)
SWeeP vectors are ideal for visualization via PCA.

```r
pca_out <- prcomp(sw$proj, scale = FALSE)
plot(pca_out$x[,1], pca_out$x[,2], xlab = "PC1", ylab = "PC2")
```

## Tips for Usage

- **Memory Management**: Use `SWeePlite` for large datasets. While slightly slower than the standard `SWeeP` function, it significantly reduces RAM overhead by not requiring the full orthonormal basis to be held in memory.
- **Mask Selection**: The `mask` parameter determines the k-mer length. Larger masks capture more specific sequence information but may require larger projection sizes (`psz`) to maintain information density.
- **Normalization**: The `sw$info$norm` field indicates if normalization was applied. You can specify normalization types (e.g., 'log') within the SWeeP functions to handle high-variance count data.

## Reference documentation

- [rSWeeP](./references/rSWeeP.md)