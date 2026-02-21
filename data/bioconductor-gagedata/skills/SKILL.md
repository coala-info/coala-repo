---
name: bioconductor-gagedata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/gageData.html
---

# bioconductor-gagedata

name: bioconductor-gagedata
description: Access and use auxiliary datasets for gene set enrichment analysis (GSEA) and pathway analysis. Use this skill when performing pathway analysis with the 'gage' package or general microarray/RNA-seq analysis requiring KEGG pathways, GO terms, or BioCarta gene sets for human, mouse, rat, and yeast. It provides demo datasets (GSE16873, BMP6, HNRNPC) and pre-compiled gene set collections.

## Overview
The `gageData` package is a primary data support package for the `gage` (Generally Applicable Gene-set Enrichment) framework. It contains pre-processed expression datasets and curated gene set collections (KEGG, GO, BioCarta) mapped to Entrez Gene IDs. While designed for `gage`, these resources are compatible with any R-based gene set analysis workflow.

## Loading Gene Sets
Gene sets are provided as named lists where each element is a character vector of Entrez Gene IDs.

```R
library(gageData)

# KEGG pathways for different species
data(kegg.sets.hs) # Human
data(kegg.sets.mm) # Mouse
data(kegg.sets.rn) # Rat
data(kegg.sets.sc) # Yeast
data(kegg.sets.ko) # KEGG Orthology (metagenomics)

# Gene Ontology (GO) terms
data(go.sets.hs)
data(go.subs.hs) # Subsets: go.subs.hs$BP, $CC, $MF

# BioCarta pathways
data(carta.hs)
```

### Filtering KEGG Pathways
KEGG collections often include "Global Map" or "Disease" categories that may confound results. Use the provided index to extract only signaling and metabolic pathways:
```R
data(kegg.sets.hs)
data(sigmet.idx.hs)
kegg.sigmet.hs <- kegg.sets.hs[sigmet.idx.hs]
```

## Demo Datasets
The package includes several datasets for testing and benchmarking:

### Microarray Data (BMP6)
A small dataset (2 samples per condition) used for matched-pair analysis.
```R
data(bmp6)
# Columns 1 & 3 are controls, 2 & 4 are BMP6 treated
```

### Breast Cancer Data (GSE16873)
A larger dataset covering progression from normal (HN) to ductal carcinoma in situ (DCIS).
```R
data(gse16873.full)
# Contains HN, ADH, and DCIS samples for 12 patients
```

### RNA-Seq Data (HNRNPC)
Count data for HNRNPC knockdown in HeLa cells.
```R
data(hnrnp.cnts)
# Requires normalization (e.g., log2 transformation) before GAGE analysis
```

## Yeast ID Mapping
For Saccharomyces cerevisiae, the package provides mapping between Entrez, Symbols, and ORF IDs.
```R
data(sc.gene) # 3-column matrix
data(orf2eg)  # Named vector mapping ORF to Entrez
```

## Typical Workflow with GAGE
```R
library(gage)
library(gageData)

# 1. Prepare Gene Sets
data(kegg.sets.hs)
data(sigmet.idx.hs)
kegg.gs <- kegg.sets.hs[sigmet.idx.hs]

# 2. Load and Prepare Data
data(gse16873.full)
cn <- colnames(gse16873.full)
ref.idx <- grep('HN', cn)
samp.idx <- grep('DCIS', cn)

# 3. Run Analysis
res <- gage(gse16873.full, gsets = kegg.gs, ref = ref.idx, samp = samp.idx)
```

## Reference documentation
- [gageData Reference Manual](./references/reference_manual.md)