---
name: bioconductor-microbiotaprocess
description: "MicrobiotaProcess is a Bioconductor package for tidy microbiome data analysis, integration, and visualization. Use when user asks to import data from QIIME2 or DADA2, calculate alpha and beta diversity, perform taxonomic abundance analysis, or conduct biomarker discovery."
homepage: https://bioconductor.org/packages/release/bioc/html/MicrobiotaProcess.html
---


# bioconductor-microbiotaprocess

## Overview

MicrobiotaProcess is a Bioconductor package designed for tidy microbiome data analysis. It introduces the `MPSE` (Microbiome Process SummarizedExperiment) class, which integrates abundance matrices, sample metadata, taxonomic hierarchies, and phylogenetic trees into a single object. The package bridges upstream bioinformatics tools with the `tidyverse` and `ggtree` ecosystem, providing a unified grammar for ecological analysis and high-quality visualization.

## Core Workflow

### 1. Data Import and Conversion
MicrobiotaProcess can import results from major upstream pipelines or convert existing R objects.

```r
library(MicrobiotaProcess)

# Import from DADA2
mpse <- mp_import_dada2(seqtab = seqtab, taxatab = taxa, sampleda = metadata)

# Import from QIIME2
mpse <- mp_import_qiime2(otuqza = "table.qza", taxaqza = "taxa.qza", mapfilename = "metadata.txt")

# Import from MetaPhlAn
mpse <- mp_import_metaphlan(profile = "metaphlan_table.txt", mapfilename = "metadata.txt")

# Convert from phyloseq
mpse <- as.MPSE(phyloseq_obj)
```

### 2. Alpha Diversity and Rarefaction
Calculate richness and evenness indices and generate rarefaction curves.

```r
# Rarefaction and curve calculation
mpse %<>% mp_rrarefy() %>%
         mp_cal_rarecurve(.abundance = RareAbundance, chunks = 400)

# Plot rarefaction
mp_plot_rarecurve(mpse, .rare = RareAbundanceRarecurve, .alpha = Observe, .group = GroupVar)

# Calculate alpha indices (Observe, Chao1, Shannon, etc.)
mpse %<>% mp_cal_alpha(.abundance = RareAbundance)

# Visualize alpha diversity
mp_plot_alpha(mpse, .group = GroupVar, .alpha = c(Observe, Shannon))
```

### 3. Taxonomic Abundance Analysis
Calculate and visualize community composition at different taxonomic levels.

```r
# Calculate abundance for samples and groups
mpse %<>% mp_cal_abundance(.abundance = RareAbundance) %>%
         mp_cal_abundance(.abundance = RareAbundance, .group = GroupVar)

# Stacked bar plot
mp_plot_abundance(mpse, .abundance = RareAbundance, .group = GroupVar, taxa.class = Phylum, topn = 10)

# Heatmap visualization
mp_plot_abundance(mpse, .abundance = RareAbundance, .group = GroupVar, taxa.class = Genus, geom = 'heatmap')
```

### 4. Beta Diversity and Ordination
Perform distance-based analysis and statistical testing.

```r
# Normalization (e.g., Hellinger)
mpse %<>% mp_decostand(.abundance = Abundance)

# Calculate distance (Bray-Curtis, Unifrac, etc.)
mpse %<>% mp_cal_dist(.abundance = hellinger, distmethod = "bray")

# PCoA Ordination
mpse %<>% mp_cal_pcoa(.abundance = hellinger, distmethod = "bray")
mp_plot_ord(mpse, .ord = pcoa, .group = GroupVar, .color = GroupVar, ellipse = TRUE)

# Statistical testing (Adonis/PERMANOVA)
mpse %<>% mp_adonis(.abundance = hellinger, .formula = ~GroupVar, distmethod = "bray")
```

### 5. Biomarker Discovery (Differential Analysis)
Identify significant taxa using a multi-step approach (Kruskal-Wallis, Wilcoxon, and LDA/Random Forest).

```r
# Perform differential analysis
mpse %<>% mp_diff_analysis(
    .abundance = RelRareAbundanceBySample, 
    .group = GroupVar, 
    first.test.alpha = 0.05
)

# Visualize results: Cladogram
mp_plot_diff_cladogram(mpse)

# Visualize results: LDA Barplot/Boxplot
mp_plot_diff_res(mpse)
mp_plot_diff_boxplot(mpse, .group = GroupVar)
```

## Key Tips
- **The %<>% Operator**: MicrobiotaProcess heavily uses the compound assignment pipe from `magrittr` to update the `MPSE` object in place.
- **Extraction**: Use `mp_extract_sample()`, `mp_extract_abundance()`, or `mp_extract_tree()` to pull specific data frames or tree objects for custom `ggplot2` or `ggtree` plotting.
- **Tidy Compatibility**: Most `mp_` functions return an object that behaves like a tibble, allowing the use of `dplyr` verbs like `filter`, `select`, and `mutate` directly on the `MPSE` object.

## Reference documentation
- [Introduction to MicrobiotaProcess](./references/MicrobiotaProcess.md)
- [MicrobiotaProcess Vignette](./references/MicrobiotaProcess.Rmd)