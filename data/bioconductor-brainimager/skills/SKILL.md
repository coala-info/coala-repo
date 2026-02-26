---
name: bioconductor-brainimager
description: "bioconductor-brainimager maps gene expression datasets to the Allen Brain Atlas to identify spatial tissue enrichments and estimate the developmental age of brain samples. Use when user asks to identify regional gene set enrichments in the human brain, visualize expression data on brain maps, or predict the transcriptomic age of a sample."
homepage: https://bioconductor.org/packages/3.8/bioc/html/brainImageR.html
---


# bioconductor-brainimager

## Overview
`brainImageR` is an R package designed to contextualize gene expression datasets within the spatial and temporal framework of human brain development. It maps gene sets to microdissected tissue profiles from the Allen Brain Atlas to identify regional enrichments and uses a predictive model to estimate the developmental age of a sample.

## Core Workflows

### 1. Spatial Gene Set Enrichment (SGSE)
This workflow identifies where a list of genes (e.g., differentially expressed genes) is significantly enriched in the brain.

**Step 1: Initialize Enrichment**
Compare your gene list (Human Gene Symbols) against a reference set.
```r
library(brainImageR)
# Load internal data
brainImageR:::loadworkspace()

# genes: vector of symbols; refset: "developing" or "adult"
composite <- SpatialEnrichment(genes = my_genes, reps = 20, refset = "developing")
```
*Note: For final analysis, increase `reps` to ~6540 (developing) or ~3680 (adult) for Bonferroni-corrected significance.*

**Step 2: Calculate Significance**
```r
# method can be "fisher" or "bootstrap"
res <- testEnrich(composite, method = "fisher")
# View top enriched tissues
res <- res[order(res$FC, decreasing = TRUE), ]
head(res)
```

**Step 3: Visualize on Brain Maps**
Map the microdissected tissue results onto general brain areas.
```r
# slice: 1-10; pcut: p-value threshold for coloring
composite <- CreateBrain(composite, res, slice = 5, pcut = 0.05)
PlotBrain(composite)
```

### 2. Developmental Time Prediction
Estimate the "transcriptomic age" of a sample in weeks post-conception.

```r
# dat: normalized expression matrix (rows=genes, cols=samples)
# minage/maxage: restrict the model window (e.g., 8 to 40 for prenatal)
time_pred <- predict_time(dat, minage = 8, maxage = 40)

# Visualize prediction against the Allen Brain Atlas (aba) reference
PlotPred(time_pred)

# Access predicted ages
head(time_pred$pred_age)
```

## Utility Functions

- `GetGenes(genes, composite, tissue_abrev)`: Retrieve the specific genes from your input list that overlap with a specific brain tissue.
- `tis_in_region(composite, "TissueAbrev")`: Find which brain slices contain a specific tissue.
- `available_areanames(composite, slice)`: List all general brain areas available for plotting in a specific slice.
- `tis_set(composite, area.name = "Pu", slice = 6)`: Identify which microdissected tissues contribute to a general brain area (e.g., Putamen).
- `whichtissues(gene_list, refset)`: Check the presence of specific genes across all reference tissues.

## Important Considerations
- **Gene Symbols**: Input must be Human Gene Symbols. Use `biomaRt` or similar tools to convert IDs before starting.
- **Data Loading**: Always run `brainImageR:::loadworkspace()` after loading the library to ensure reference datasets are available.
- **Resolution**: The "prenatal" dataset option in `predict_time` provides higher resolution for in-vitro samples (NPCs, neurons) which typically recapitulate early development.

## Reference documentation
- [brainImageR Vignette (Rmd)](./references/brainImageR.Rmd)
- [brainImageR Documentation (md)](./references/brainImageR.md)