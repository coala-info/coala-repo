---
name: bioconductor-ggmanh
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ggmanh.html
---

# bioconductor-ggmanh

## Overview

The `ggmanh` package is a specialized R tool for generating Manhattan plots from Genome-Wide Association Study (GWAS) or Proteome-Wide Association Study (PWAS) results. It extends standard visualization by offering y-axis rescaling to handle extreme p-values, "thinning" of data points to improve performance, and "binned" Manhattan plots for extremely large datasets. It integrates with `ggrepel` for non-overlapping labels and `SeqArray` for variant annotation.

## Core Workflow

### 1. Data Preparation
The input should be a `data.frame` or `GRanges` object. At minimum, it requires columns for chromosome, position, and p-value.

```r
library(ggmanh)

# Ensure chromosome is a factor for correct ordering
df$chromosome <- factor(df$chromosome, levels = c(1:22, "X", "Y"))
```

### 2. Basic Manhattan Plot
Use `manhattan_plot()` for a quick visualization. By default, it includes significance thresholds at `5e-8` and `5e-7`.

```r
manhattan_plot(x = df, 
               pval.colname = "P.value", 
               chr.colname = "chromosome", 
               pos.colname = "position",
               plot.title = "GWAS Results")
```

### 3. Advanced Visualization Features

#### Y-axis Rescaling
When p-values are extremely small (e.g., < 1e-20), they can "squish" other significant signals. Set `rescale = TRUE` to introduce a visual break (indicated by "=" on the axis) that preserves detail for less extreme signals.

```r
manhattan_plot(df, pval.colname = "P", rescale = TRUE)
```

#### Annotation and Labeling
To label specific points, create a column where only the target SNPs have text and others are `""` or `NA`.
*   Use `""`: Labels avoid both other labels and data points.
*   Use `NA`: Labels avoid other labels but may overlap points (faster for many labels).

```r
df$label <- ifelse(df$P < 5e-8, df$SNP_ID, "")
manhattan_plot(df, label.colname = "label", max.overlaps = Inf)
```

#### Highlighting
Color specific points by providing a category column and a named color vector.

```r
df$group <- ifelse(df$P < 5e-8, "Sig", "NonSig")
colors <- c("Sig" = "red", "NonSig" = "grey")

manhattan_plot(df, highlight.colname = "group", highlight.col = colors, color.by.highlight = TRUE)
```

### 4. Binned Manhattan Plots
For massive datasets where plotting individual points is slow, use `binned_manhattan_plot()`. This grids the data into bins.

```r
binned_manhattan_plot(df, 
                      bins.x = 10, 
                      bins.y = 100, 
                      bin.palette = "viridis::plasma")
```

### 5. Automated Annotation with GDS
The package can annotate variants using a Genomic Data Structure (GDS) file.

```r
# Annotate based on position and alleles
df$annotation <- gds_annotate(df, 
                              annot.method = "position", 
                              chr = "chromosome", 
                              pos = "position", 
                              ref = "Ref", 
                              alt = "Alt")
```

## Performance Optimization
For large datasets, separate the preprocessing from the plotting to allow for rapid iteration on plot aesthetics without re-calculating coordinates.

```r
# 1. Preprocess once
mpdata <- manhattan_data_preprocess(df, pval.colname = "P")

# 2. Plot multiple times with different settings
manhattan_plot(mpdata, plot.title = "Version A")
manhattan_plot(mpdata, plot.title = "Version B", rescale = TRUE)
```

## Reference documentation
- [Guide to ggmanh Package](./references/ggmanh.md)