---
name: bioconductor-demuxsnp
description: The demuxSNP package provides a supervised approach to demultiplexing scRNA-seq data by combining cell hashing and SNP information. Use when user asks to demultiplex scRNA-seq data, recover unclassifiable cells using SNP signatures, or train a k-nearest neighbors classifier for donor assignment without prior genotyping.
homepage: https://bioconductor.org/packages/release/bioc/html/demuxSNP.html
---


# bioconductor-demuxsnp

## Overview

The `demuxSNP` package provides a supervised approach to demultiplexing multiplexed scRNA-seq data. It addresses the limitations of using cell hashing or SNPs alone by using high-confidence hashing assignments to "learn" the genetic signatures (SNPs) of each group. These signatures are then used to train a k-nearest neighbors (kNN) classifier to reassign cells that were previously unclassifiable due to poor tagging quality.

Key advantages:
- Recovers high-quality cells that hashing algorithms might label as "Negative" or "Uncertain".
- Does not require prior donor genotyping (unlike `demuxlet`).
- Reduces noise by focusing on SNPs within highly expressed genes.

## Core Workflow

### 1. Data Preparation and Preprocessing
Load the required libraries and your `SingleCellExperiment` (SCE) object containing RNA and HTO counts.

```r
library(demuxSNP)
library(SingleCellExperiment)
library(VariantAnnotation)
library(EnsDb.Hsapiens.v86)

# Identify genes expressed in the highest proportion of cells
top_genes <- common_genes(sce = multiplexed_sce, n = 100)

# Subset a VCF file to SNPs within these top genes
# Ensure the EnsDb version matches your VCF genome build
ensdb <- EnsDb.Hsapiens.v86
new_vcf <- subset_vcf(vcf = input_vcf, top_genes = top_genes, ensdb = ensdb)
```

### 2. Identifying High-Confidence Training Cells
Use `demuxmix` (via the `high_conf_calls` wrapper) to identify cells that can be confidently assigned to a group based on hashing data.

```r
# This adds 'train', 'predict', and 'labels' to colData
multiplexed_sce <- high_conf_calls(multiplexed_sce, assay = "HTO")

# 'train' (logical): High confidence singlets
# 'predict' (logical): All cells to be classified
# 'labels' (factor): Initial hashing-based assignments
```

### 3. Integrating SNP Data
After generating a SNP matrix (e.g., using VarTrix with the subsetted VCF), add it to the SCE object. The package recodes the matrix: 0 (no read), 1 (SNP present), -1 (SNP absent).

```r
# mat: SNP matrix where rows are SNPs and columns are cells
# thresh: Filter SNPs observed in less than 'thresh' proportion of cells
multiplexed_sce <- add_snps(multiplexed_sce, mat = snp_matrix, thresh = 0.95)
```

### 4. Supervised Reassignment
Train the centroid-based kNN classifier on the high-confidence cells and predict the identity of all cells.

```r
set.seed(1)
multiplexed_sce$knn <- reassign_centroid(
    multiplexed_sce,
    train_cells = multiplexed_sce$train,
    predict_cells = multiplexed_sce$predict,
    min_cells = 5 # Minimum cells required per group to simulate doublets
)

# View final assignments
table(multiplexed_sce$knn)
```

## Visualization and Evaluation

### Visualizing SNP Profiles
Use `ComplexHeatmap` to verify if SNP profiles align with the assignments.

```r
library(ComplexHeatmap)
colors <- structure(viridisLite::viridis(n = 3), names = c("-1", "0", "1"))

hm <- Heatmap(counts(altExp(multiplexed_sce, "SNP")),
    column_split = multiplexed_sce$knn,
    cluster_rows = FALSE,
    show_column_names = FALSE,
    col = colors
)
draw(hm)
```

### Performance Testing
You can validate the model by splitting high-confidence cells into a mock training and test set to check for agreement between hashing and SNP-based calls.

## Tips for Success
- **Genome Compatibility**: Ensure the `EnsDb` object used in `subset_vcf` matches the genome build of your VCF and BAM files (e.g., hg38 vs hg19).
- **SNP Matrix Generation**: The SNP matrix must be generated outside of R (e.g., using VarTrix) using the VCF produced by `subset_vcf`.
- **Doublet Simulation**: `reassign_centroid` automatically simulates doublets by combining SNP profiles of training singlets, allowing for robust doublet detection even without prior genotypes.

## Reference documentation
- [Supervised Demultiplexing using Cell Hashing and SNPs](./references/supervised_demultiplexing.Rmd)
- [Supervised Demultiplexing using Cell Hashing and SNPs](./references/supervised_demultiplexing.md)