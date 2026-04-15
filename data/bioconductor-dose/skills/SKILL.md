---
name: bioconductor-dose
description: The DOSE package performs disease-centric enrichment analysis and calculates semantic similarity between genes or Disease Ontology terms. Use when user asks to perform over-representation analysis, conduct gene set enrichment analysis for diseases, or calculate semantic similarity between genes and disease terms.
homepage: https://bioconductor.org/packages/release/bioc/html/DOSE.html
---

# bioconductor-dose

## Overview
The `DOSE` package provides a framework for analyzing the biological meaning of gene sets through the lens of human diseases. It implements several enrichment analysis methods and semantic similarity measures based on the Disease Ontology (DO). It serves as a foundational dependency for other Bioconductor packages like `clusterProfiler`.

## Main Functions

### Enrichment Analysis
- `enrichDO()`: Over-representation analysis (ORA) for Disease Ontology.
- `enrichNCG()`: ORA for the Network of Cancer Genes.
- `enrichDGN()`: ORA for DisGeNET (gene-disease associations).
- `gseDO()`: Gene Set Enrichment Analysis (GSEA) for Disease Ontology.
- `gseNCG()`: GSEA for the Network of Cancer Genes.
- `gseDGN()`: GSEA for DisGeNET.

### Semantic Similarity
- `doSim()`: Calculate semantic similarity between two DO terms.
- `geneSim()`: Calculate semantic similarity between two genes based on DO annotation.
- `clusterSim()`: Calculate semantic similarity between two gene clusters.
- `mclusterSim()`: Calculate semantic similarity among multiple gene clusters.

## Typical Workflow

### 1. Over-Representation Analysis (ORA)
Input is a vector of Entrez gene IDs.
```r
library(DOSE)
data(geneList) # Example dataset
de <- names(geneList)[abs(geneList) > 2]

edo <- enrichDO(gene = de,
                ont = "DO",
                pvalueCutoff = 0.05,
                pAdjustMethod = "BH",
                universe = names(geneList),
                minGSSize = 5,
                maxGSSize = 500,
                readable = TRUE)
head(edo)
```

### 2. Gene Set Enrichment Analysis (GSEA)
Input is a sorted, named numeric vector (e.g., fold changes).
```r
# geneList must be sorted in decreasing order
edo2 <- gseDO(geneList,
              nPerm = 1000,
              minGSSize = 10,
              pvalueCutoff = 0.05,
              verbose = FALSE)
head(edo2)
```

### 3. Semantic Similarity Calculation
```r
# Similarity between genes
geneSim("216", "217", measure = "Wang")

# Similarity between DO terms
doSim("DOID:14095", "DOID:5844", measure = "Lin")
```

## Tips and Interpretation
- **Gene IDs**: `DOSE` primarily uses Entrez IDs. Use `clusterProfiler::bitr` or similar tools to convert symbols to Entrez IDs before analysis.
- **Readable**: Setting `readable = TRUE` in enrichment functions maps Entrez IDs back to Gene Symbols in the output table.
- **Visualization**: Results from `DOSE` are compatible with the `enrichplot` package for generating dotplots, barplots, and enrichment maps.
- **Methods**: Supported similarity measures include "Resnik", "Lin", "Rel", "Jiang", and "Wang".

## Reference documentation
- [DOSE](./references/DOSE.md)