---
name: bioconductor-topaseq
description: ToPASeq performs topology-based pathway analysis of RNA-seq data by incorporating gene-gene interactions and pathway structure into enrichment calculations. Use when user asks to perform topology-based pathway analysis, calculate Pathway Regulation Scores, or weight gene contributions based on their position within a pathway graph.
homepage: https://bioconductor.org/packages/3.8/bioc/html/ToPASeq.html
---

# bioconductor-topaseq

name: bioconductor-topaseq
description: Topology-based pathway analysis of RNA-seq data using methods like PRS, TAPPA, and PWEA. Use this skill when performing pathway enrichment analysis that incorporates pathway topology (gene-gene interactions) rather than just gene sets.

# bioconductor-topaseq

## Overview

The `ToPASeq` package provides methods for topology-based pathway analysis. Unlike standard enrichment methods that treat pathways as simple lists of genes, `ToPASeq` utilizes the graph structure (nodes and edges) of pathways to weight gene contributions. Key methods include the Pathway Regulation Score (PRS), which weights gene-level log2 fold changes by the number of downstream differentially expressed (DE) genes.

**Note:** The package is currently undergoing maintenance. For production workflows, consider using topology-based methods in `EnrichmentBrowser` or `graphite` if `ToPASeq` functions encounter compatibility issues.

## Typical Workflow

### 1. Data Preparation
`ToPASeq` works best with `SummarizedExperiment` objects. Data should be pre-processed and mapped to Entrez IDs to match pathway databases.

```r
library(ToPASeq)
library(airway)
library(EnrichmentBrowser)

# Load example data
data(airway)
airSE <- airway[grep("^ENSG", rownames(airway)),]

# Define groups (1 for treatment, 0 for control)
airSE$GROUP <- ifelse(airSE$dex == "trt", 1, 0)
airSE$BLOCK <- airSE$cell # Optional: account for batch/cell line
```

### 2. Differential Expression Analysis
Use `EnrichmentBrowser::deAna` to calculate fold changes and p-values, which are required for topology-based scoring.

```r
# Perform DE analysis (e.g., using edgeR)
airSE <- deAna(airSE, de.method="edgeR")

# Map IDs to Entrez (required for graphite pathways)
airSE <- idMap(airSE, org="hsa", from="ENSEMBL", to="ENTREZID")
```

### 3. Pathway Retrieval
Retrieve pathway topologies using the `graphite` package.

```r
library(graphite)
pwys <- pathways(species="hsapiens", database="kegg")
```

### 4. Pathway Regulation Score (PRS)
The PRS method calculates significance by summing weighted absolute fold changes across the pathway.

```r
# Prepare inputs
all_genes <- names(airSE)
de_ind <- rowData(airSE)$ADJ.PVAL < 0.01
de_genes <- rowData(airSE)$FC[de_ind]
names(de_genes) <- all_genes[de_ind]

# Run PRS
res <- prs(de_genes, all_genes, pwys[1:50], nperm=100)
head(res)
```

### 5. Inspecting Gene Weights
To understand which genes are driving the pathway score based on their topological position:

```r
# Get weights for a specific pathway
ind <- grep("Ras signaling pathway", names(pwys))
weights <- prsWeights(pwys[[ind]], de_genes, all_genes)

# Identify top regulators (genes with most downstream DE genes)
sort(weights, decreasing = TRUE)[1:10]
```

## Key Functions

- `prs(de, all, pwys, nperm)`: Calculates the Pathway Regulation Score.
- `prsWeights(pwy, de, all)`: Returns the topological weights (number of downstream DE genes) for a specific pathway.
- `tappa(...)`: Implements Topological Analysis of Pathway Phenotype Association.
- `pwea(...)`: Implements PathWay Enrichment Analysis.

## Tips for Success

- **ID Mapping**: Ensure your expression data and pathway nodes use the same ID type (usually Entrez ID). Use `EnrichmentBrowser::idMap` for conversion.
- **Permutations**: For publication-quality results, increase `nperm` (e.g., 1000 or more), though this increases computation time.
- **Filtering**: Filter out pathways with very few genes or no DE genes to reduce the multiple testing burden and computational load.

## Reference documentation

- [Topology-based pathway analysis of RNA-seq data](./references/ToPASeq.md)