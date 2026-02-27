---
name: bioconductor-moma
description: Bioconductor-moma identifies master regulator proteins that act as checkpoints for genomic driver events in cancer by integrating protein activity with multi-omic data. Use when user asks to infer connections between protein activity and genomic alterations, rank candidate master regulators, or identify genomic checkpoints and saturation points in cancer datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/MOMA.html
---


# bioconductor-moma

name: bioconductor-moma
description: Multi Omic Master Regulator Analysis (MOMA) for inferring connections between Master Regulator proteins and genomic driver events in cancer. Use this skill to integrate VIPER protein activity with SNP, CNV, and fusion data to identify candidate master regulators and genomic checkpoints.

# bioconductor-moma

## Overview
MOMA (Multi Omic Master Regulator Analysis) is a computational framework designed to identify Master Regulators (MRs) that act as "checkpoints" for genomic alterations in cancer. It integrates protein activity (inferred via VIPER) with genomic data (mutations, copy number variations, and fusions) and biological pathways (CINDy and PrePPI) to rank regulators based on their statistical and functional connection to genomic drivers.

## Core Workflow

### 1. Data Preparation
MOMA requires a `MultiAssayExperiment` object or a named list containing the following matrices (samples in columns, features in rows):
- `viper`: Protein activity scores (from the `viper` package).
- `mut`: Binary mutation matrix (0/1).
- `cnv`: Copy number variation matrix.
- `fusion`: (Optional) Binary fusion matrix.

### 2. Initialization
Create the MOMA object using the constructor. You must provide the assays and a pathway list (containing `cindy` and `preppi` interactions).

```r
library(MOMA)
# assays can be a MultiAssayExperiment or a list of matrices
momaObj <- MomaConstructor(assays = example.gbm.mae, pathways = gbm.pathways)
```

### 3. Analysis Pipeline
The analysis follows a sequential execution of methods stored within the MOMA object:

```r
# 1. Run DIGGIT to find statistical interactions between proteins and genomic events
momaObj$runDIGGIT()

# 2. Integrate pathway data (CINDy/PrePPI) to refine interactions
momaObj$makeInteractions()

# 3. Rank candidate Master Regulators
momaObj$Rank()

# 4. Cluster samples based on protein ranks
momaObj$Cluster()
# Optional: Manually set a specific cluster solution (e.g., 3 clusters)
momaObj$sample.clustering <- momaObj$clustering.results$`3clusters`$clustering

# 5. Calculate genomic saturation to identify the 'checkpoint' for each cluster
momaObj$saturationCalculation()
```

### 4. Interpreting Results
Key results are stored in the following fields:
- `momaObj$checkpoints`: List of regulators making up the checkpoint for each cluster.
- `momaObj$genomic.saturation`: Data regarding how many regulators are needed to "cover" genomic events.
- `momaObj$ranks`: Final ranking of regulators.

### 5. Visualization
Use the `makeSaturationPlots` function to generate Oncoprint-style plots and saturation curves.

```r
plots <- makeSaturationPlots(momaObj)

# Draw Oncoprint for a specific cluster (e.g., cluster 3)
library(grid)
grid.draw(plots$oncoprint.plots[[3]])

# Plot Saturation Curve
library(ggplot2)
plots$curve.plots[[3]] + ggtitle("Saturation Curve: Subtype 3")
```

## Tips and Best Practices
- **Pathway Data**: CINDy values are tissue-specific. Ensure you use a network appropriate for your cancer type. PrePPI values are generally context-independent.
- **Gene Blacklist**: By default, MOMA excludes highly mutated genes (e.g., TTN) that often act as noise. You can provide a custom list to `MomaConstructor`.
- **Saving**: Use `momaObj$saveData(output.folder = "path", ...)` to export specific result fields like "checkpoints" or "hypotheses" to disk.

## Reference documentation
- [MOMA - Multi Omic Master Regulator Analysis](./references/moma.Rmd)
- [MOMA - Multi Omic Master Regulator Analysis](./references/moma.md)