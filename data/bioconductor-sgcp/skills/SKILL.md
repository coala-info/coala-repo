---
name: bioconductor-sgcp
description: This tool constructs and analyzes gene co-expression networks by integrating unsupervised clustering with Gene Ontology information. Use when user asks to group genes into modules, perform semi-supervised gene clustering, or conduct Gene Ontology enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/SGCP.html
---


# bioconductor-sgcp

name: bioconductor-sgcp
description: Self-training Gene Clustering Pipeline (SGCP) for constructing and analyzing gene co-expression networks. Use this skill to group genes into cohesive, biologically relevant modules using unsupervised and semi-supervised clustering integrated with Gene Ontology (GO) information.

# bioconductor-sgcp

## Overview

The `SGCP` package provides a robust framework for gene co-expression network analysis. It distinguishes itself by using a semi-supervised approach that leverages Gene Ontology (GO) information to refine clusters into highly enriched modules. The pipeline handles network construction, automated determination of cluster numbers, GO enrichment, and semi-supervised classification to reassign "unremarkable" genes to more biologically significant clusters.

## Core Workflow

The pipeline can be executed either as a single automated call or through a step-by-step manual process.

### 1. Data Preparation
`SGCP` requires three primary inputs:
- `expData`: A matrix/dataframe (genes as rows, samples as columns). Data should be pre-normalized.
- `geneID`: A vector of gene identifiers (e.g., Entrez IDs) corresponding to the rows of `expData`.
- `annotation_db`: A string naming the Bioconductor annotation package (e.g., `"org.Hs.eg.db"`).

### 2. Automated Execution (`ezSGCP`)
The fastest way to run the full pipeline is using `ezSGCP`.

```r
library(SGCP)
library(org.Hs.eg.db)

# Run the full pipeline
results <- ezSGCP(
  expData = my_matrix, 
  geneID = my_entrez_ids, 
  annotation_db = "org.Hs.eg.db",
  sil = TRUE # Calculate silhouette index
)

# View summary
summary(results, show.data = TRUE)

# Generate plots and export results (Excel/PDF)
SGCP_ezPLOT(sgcp = results, expreData = my_matrix, silhouette_index = TRUE)
```

### 3. Step-by-Step Execution
For finer control, execute the functions sequentially:

1.  **Network Construction**: `adjacencyMatrix(expData, tom = TRUE)`
2.  **Clustering**: `clustering(adjaMat, geneID, annotation_db)`
    - Determines optimal $k$ using methods like `relativeGap`, `secondOrderGap`, or `additiveGap`.
3.  **Initial GO Enrichment**: `geneOntology(geneUniv, clusLab, annotation_db)`
4.  **Semi-labeling**: `semiLabeling(geneID, df_GO, GOgenes)`
    - Identifies "remarkable" genes based on GO significance.
5.  **Semi-supervised Classification**: `semiSupervised(specExp, geneLab, model = "knn")`
    - Reassigns genes to final modules.
6.  **Final GO Enrichment**: Run `geneOntology` again on the final labels to validate module quality.

## Visualization Functions

`SGCP` provides several specialized plotting functions to evaluate cluster quality:

- **PCA**: `SGCP_plot_pca(m, clusLabs)` - Visualize gene distribution.
- **Conductance**: `SGCP_plot_conductance(conduct)` - Lower conductance usually indicates better enrichment.
- **Silhouette**: `SGCP_plot_silhouette(df)` - Measures how well genes fit their assigned clusters.
- **GO Enrichment**:
    - `SGCP_plot_jitter(df)`: View p-value distributions.
    - `SGCP_plot_bar(df)`: Compare mean enrichment across modules.
    - `SGCP_plot_density(df)`: Distribution of GO term significance.

## Key Parameters and Tips

- **Cluster Selection**: If you don't know $k$, leave `kopt = NULL`. `SGCP` will automatically test multiple gap-statistic methods and select the one with the highest GO enrichment.
- **TOM**: The Topological Overlap Matrix (`tom = TRUE`) is enabled by default in `adjacencyMatrix` to capture second-order neighborhood information.
- **Noisy Genes**: The `clustering` function identifies and removes noisy genes; check `results$dropped.indices` to see which genes were excluded.
- **Organism Support**: Ensure the `annotation_db` matches your `geneID` type (e.g., `org.Mm.eg.db` for Mouse Entrez IDs).

## Reference documentation

- [SGCP package manual](./references/SGCP.Rmd)