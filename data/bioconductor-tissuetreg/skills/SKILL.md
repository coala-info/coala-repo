---
name: bioconductor-tissuetreg
description: This package provides multi-omic datasets, including WGBS and RNA-seq data, for studying the differentiation of specialized tissue Treg cells. Use when user asks to access methylation or expression data from tissue-specific Treg cells, visualize methylation levels at specific genomic regions, or analyze gene expression across different Treg cell types.
homepage: https://bioconductor.org/packages/release/data/experiment/html/tissueTreg.html
---

# bioconductor-tissuetreg

## Overview
The `tissueTreg` package is a Bioconductor ExperimentData package providing multi-omic datasets from the study by Delacher and Imbusch (2017). It contains Whole Genome Bisulfite Sequencing (TWGBS) and RNA-seq data characterizing the differentiation of specialized tissue Treg cells. Data is retrieved via `ExperimentHub` and provided in standard Bioconductor formats (`bsseq` for methylation and `SummarizedExperiment` for expression).

## Data Retrieval
Data is hosted on `ExperimentHub`. You must initialize the hub to access the specific resource IDs.

```r
library(ExperimentHub)
library(tissueTreg)

eh <- ExperimentHub()

# Resource IDs:
# EH1072: TWGBS data (bsseq object, per sample)
# EH1073: TWGBS data (bsseq object, collapsed by tissue/cell type)
# EH1074: RNA-seq data (SummarizedExperiment, RPKM values)
```

## Working with Methylation Data (TWGBS)
The methylation data uses the `bsseq` framework. Objects contain raw counts and precomputed smoothed values for the mm10 genome.

### Visualizing Specific Regions
Use `bsseq::plotRegion` to visualize methylation levels at specific genomic coordinates (e.g., the FoxP3 locus).

```r
library(bsseq)
BS.obj <- eh[["EH1072"]]

# Define region of interest (mm10)
regions <- GRanges(
  seqnames = "X",
  ranges = IRanges(start = 7579676, end = 7595243)
)

# Plot with smoothing
plotRegion(BS.obj, region = regions[1,], extend = 2000)
```

### Customizing Plots
You can modify the `pData` of the bsseq object to add colors based on tissue or cell type for better visualization.

```r
pData <- pData(BS.obj)
# Example: Assign colors to the 15 samples (5 groups of 3 replicates)
pData$col <- rep(c("red", "blue", "green", "yellow", "orange"), rep(3, 5))
pData(BS.obj) <- pData

plotRegion(BS.obj, region = regions[1,], extend = 2000)
```

## Working with RNA-seq Data
Expression data is provided as a `SummarizedExperiment` containing RPKM values and Ensembl-to-Symbol mappings.

### Extracting Gene Expression
Access expression values using `assay()` and filter by gene symbols found in `rowData()`.

```r
library(SummarizedExperiment)
se_rpkms <- eh[["EH1074"]]

# Find specific gene (e.g., Foxp3)
gene_idx <- rowData(se_rpkms)$id_symbol == "Foxp3"
foxp3_vals <- assay(se_rpkms)[gene_idx, ]
```

### Comparing Tissues
The `colData` contains the `tissue_cell` metadata used for grouping samples.

```r
library(ggplot2)
library(reshape2)

# Prepare data for plotting
df <- melt(foxp3_vals)
df$group <- colData(se_rpkms)$tissue_cell

ggplot(df, aes(x = Var1, y = value, fill = group)) +
    geom_bar(stat = "identity") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "FoxP3 Expression", x = "Sample", y = "RPKM")
```

## Key Metadata Values
The datasets include the following tissue and cell type identifiers:
- `Fat-Treg`: Treg cells from adipose tissue.
- `Liver-Treg`: Treg cells from the liver.
- `Skin-Treg`: Treg cells from the skin.
- `Lymph-N-Treg`: Treg cells from lymph nodes.
- `Lymph-N-Tcon`: Conventional T cells from lymph nodes (control).

## Reference documentation
- [tissueTreg](./references/tissueTreg.md)