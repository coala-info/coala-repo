---
name: bioconductor-mirnatap
description: This tool integrates and aggregates miRNA target predictions from multiple sources to provide consensus rankings for human, mouse, and rat. Use when user asks to predict miRNA targets, aggregate results from multiple prediction databases, or prepare ranked gene lists for enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/miRNAtap.html
---

# bioconductor-mirnatap

name: bioconductor-mirnatap
description: Facilitates miRNA target prediction by integrating and aggregating ranked results from multiple sources (DIANA, Miranda, PicTar, TargetScan, and miRDB). Use this skill to retrieve predicted targets for miRNAs in human, mouse, and rat, and to prepare ranked gene lists for downstream enrichment analysis (GO/KEGG).

## Overview
The `miRNAtap` package improves the reliability of miRNA target predictions by aggregating outputs from five major algorithms. It provides a unified interface to query these sources and uses aggregation methods like the geometric mean to produce a consensus ranking. While direct data is available for *Homo sapiens* (hsa) and *Mus musculus* (mmu), it supports *Rattus norvegicus* (rno) through homology translation.

## Installation
Ensure both the software and the database package are installed:
```R
if (!requireNamespace("BiocManager", quietly=TRUE)) install.packages("BiocManager")
BiocManager::install(c("miRNAtap", "miRNAtap.db"))
```

## Core Workflow

### 1. Predicting Targets
The primary function is `getPredictedTargets`. You must specify the miRNA name, the species, and the aggregation method.

```R
library(miRNAtap)

# Get targets for human miR-10b
# method = 'geom' (geometric mean) is generally recommended
# min_src = 2 ensures the target appears in at least two databases
predictions = getPredictedTargets('miR-10b', species = 'hsa', method = 'geom', min_src = 2)

# View top results (Entrez IDs are used as row names)
head(predictions)
```

### 2. Species Support
- **Human:** `species = 'hsa'`
- **Mouse:** `species = 'mmu'`
- **Rat:** `species = 'rno'` (Uses mouse data and translates via homology automatically)

### 3. Aggregation Methods
- `'geom'`: Geometric mean of ranks (recommended for performance).
- `'min'`: Minimum rank across sources.
- `'mean'`: Arithmetic mean of ranks.
- `'product'`: Product of ranks.

### 4. Downstream Enrichment Analysis
The output of `getPredictedTargets` includes a `rank_product` column, which is ideal for rank-based enrichment tests like the Kolmogorov-Smirnov (K-S) test in `topGO`.

```R
# Prepare ranked genes for topGO
rankedGenes = predictions[, 'rank_product']

# Example: GO enrichment using topGO
library(topGO)
# Note: selection function returns TRUE because we use the full ranked list
GOdata = new('topGOdata', 
             ontology = 'BP', 
             allGenes = rankedGenes,
             geneSel = function(x) TRUE, 
             annot = annFUN.org, 
             mapping = "org.Hs.eg.db", 
             ID = "entrez")

# Run K-S test to utilize rank information
results = runTest(GOdata, algorithm = "classic", statistic = "ks")
tab = GenTable(GOdata, KS = results, topNodes = 10)
```

## Tips and Best Practices
- **Input Format:** miRNA names should follow standard nomenclature (e.g., 'miR-10b').
- **Minimum Sources:** Use `min_src` (typically 2 or 3) to filter out low-confidence targets that only appear in a single database.
- **Entrez IDs:** The package returns Entrez Gene IDs. Use `org.Hs.eg.db` or `AnnotationDbi` if you need to convert these to Gene Symbols or Ensembl IDs.
- **Homology:** When working with Rat (`rno`), remember that the underlying data is mouse-derived; results are based on evolutionary conservation.

## Reference documentation
- [miRNAtap](./references/miRNAtap.md)