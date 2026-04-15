---
name: bioconductor-migsa
description: bioconductor-migsa performs massive and integrative gene set analysis by combining singular enrichment and gene set enrichment methods across multiple experiments. Use when user asks to perform integrative functional analysis, run GSEA or SEA on multiple datasets simultaneously, or visualize gene set enrichment results across different omics experiments.
homepage: https://bioconductor.org/packages/3.8/bioc/html/MIGSA.html
---

# bioconductor-migsa

name: bioconductor-migsa
description: Massive and Integrative Gene Set Analysis (MIGSA) for R. Use this skill to perform integrative functional analysis (IFA) combining Singular Enrichment Analysis (SEA) and Gene Set Enrichment Analysis (GSEA) across multiple experiments and gene sets simultaneously. Supports microarray and RNA-seq data, provides optimized mGSZ performance, and includes visualization tools for multi-dataset comparison.

# bioconductor-migsa

## Overview
MIGSA is a Bioconductor package designed for massive and integrative gene set analysis. It allows researchers to evaluate multiple datasets (experiments) against large collections of gene sets (e.g., GO, KEGG) in a single, coherent framework. It integrates enhanced versions of SEA (dEnricher) and GSEA (mGSZ) to provide a comprehensive biological perspective. A key feature is its ability to handle "big omics data" by utilizing multicore architectures for speed and providing specialized visualization methods for exploring results across many experiments.

## Core Workflow

### 1. Gene Set Preparation
MIGSA uses `GeneSetCollection` objects from the `GSEABase` package. You can create your own or use MIGSA's helper functions.

```r
library(MIGSA)
library(GSEABase)

# Load GO terms (CC, BP, or MF)
ccGsets <- loadGo("CC")

# Download from Enrichr (e.g., KEGG, Reactome)
keggReact <- downloadEnrichrGeneSets(c("KEGG_2015", "Reactome_2015"))
# Note: downloadEnrichrGeneSets returns a list of GeneSetCollections
```

### 2. Defining Experiments (IGSAinput)
Each experiment (e.g., a microarray study or RNA-seq dataset) must be wrapped in an `IGSAinput` object.

```r
# For Microarray (MAList or matrix)
# fitOpts defines the experimental design (e.g., Basal vs Luminal A)
fitOpts <- FitOptions(subtypes_vector) 
igsaInputMA <- IGSAinput(
  name = "Microarray_Exp",
  expr_data = myMAList,
  fit_options = fitOpts,
  sea_params = SEAparams(treat_lfc = 1.05) # Optional: set LFC threshold
)

# For RNA-seq (DGEList)
igsaInputRNA <- IGSAinput(
  name = "RNAseq_Exp",
  expr_data = myDGEList,
  fit_options = fitOpts
)
```

### 3. Running the Analysis
The `MIGSA` function executes the integrative analysis across all provided experiments.

```r
# Run analysis on a list of experiments
experiments <- list(igsaInputMA, igsaInputRNA)
migsaRes <- MIGSA(experiments, geneSets = ccGsets)

# To use multiple cores (highly recommended for large datasets)
library(BiocParallel)
# MIGSA uses the registered BiocParallel backend
register(MulticoreParam(workers = 4))
migsaRes <- MIGSA(experiments, geneSets = ccGsets)
```

### 4. Fast GSEA with MIGSAmGSZ
If you only need the optimized GSEA component (mGSZ) without the full MIGSA integration:

```r
# geneExpr: matrix, gSets: list of gene sets, subtypes: factor/vector
res <- MIGSAmGSZ(geneExpr, gSets, subtypes)
```

## Exploring and Visualizing Results

MIGSA provides a `MIGSAres` object that acts like a data table but contains specialized methods.

### Filtering and Summarizing
```r
# Set a p-value cutoff for enrichment (default is 0.01)
bcMigsaRes <- setEnrCutoff(bcMigsaRes, 0.01)

# Summary shows consensus across experiments
summary(bcMigsaRes)

# Filter by specific genes of interest
filteredRes <- filterByGenes(bcMigsaRes, c("652", "2099"))
```

### Visualization
```r
# Heatmap of enriched/not enriched gene sets across experiments
migsaHeatmap(bcMigsaRes)

# Heatmap showing gene contribution to enrichment
genesHeatmap(bcMigsaRes, enrFilter = 6.4, gsFilter = 70)

# Plot GO tree for specific results
migsaGoTree(tcgaExclusive, ont = "BP")

# Barplot of genes that contribute most to enrichment
mostEnrichedGenes <- genesBarplot(tcgaExclusive, gsFilter = 12.45)
```

## Tips for Success
- **Gene IDs**: Ensure your expression data and gene sets use the same ID type (Entrez IDs are recommended and used by `loadGo`).
- **Memory/Speed**: For large-scale analyses (e.g., 20k+ gene sets), always use `BiocParallel` to distribute the load.
- **RNA-seq Pre-processing**: Filter low-count genes (e.g., mean < 15 counts per condition) before creating the `IGSAinput` to improve statistical power and speed.
- **SEA Parameters**: Adjust `treat_lfc` in `SEAparams` to control the stringency of the Singular Enrichment Analysis component.

## Reference documentation
- [MIGSA: Massive and Integrative Gene Set Analysis](./references/MIGSA.md)
- [MIGSA: Getting pbcmc datasets](./references/gettingPbcmcData.md)
- [MIGSA: Getting TCGA datasets](./references/gettingTcgaData.md)