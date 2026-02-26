---
name: bioconductor-gage
description: This tool performs Generally Applicable Gene-set Enrichment (GAGE) analysis to identify significantly perturbed pathways or functional groups in high-throughput expression data. Use when user asks to perform gene-set enrichment analysis, identify differentially regulated KEGG pathways or GO terms, handle various experimental designs for pathway analysis, or visualize gene expression changes on pathway maps.
homepage: https://bioconductor.org/packages/release/bioc/html/gage.html
---


# bioconductor-gage

name: bioconductor-gage
description: Perform Generally Applicable Gene-set Enrichment (GAGE) analysis for high-throughput data (RNA-Seq, microarray). Use this skill when you need to identify significantly perturbed pathways (KEGG) or functional groups (GO) from gene expression matrices, handle various experimental designs (paired/unpaired), or visualize pathway changes using Pathview integration.

# bioconductor-gage

## Overview
The `gage` package implements the Generally Applicable Gene-set Enrichment method. Unlike other GSEA methods, GAGE is independent of sample size and experimental design, making it applicable to datasets ranging from single-sample comparisons to large clinical studies. It works by comparing expression changes within a gene set to the background distribution of changes in the entire dataset.

## Core Workflow

### 1. Data Preparation
GAGE requires a gene expression matrix (rows as genes, columns as samples) and a gene set list.
*   **ID Matching:** Ensure the expression matrix row names match the ID type used in the gene sets (typically Entrez Gene IDs for KEGG).
*   **Normalization:** For RNA-Seq, use log2-transformed normalized counts (e.g., `log2(norm_counts + 8)`).

```R
library(gage)
# Load example data
data(gse16873)
# Define reference (control) and sample (experiment) indices
hn = (1:6)*2-1
dcis = (1:6)*2
```

### 2. Generating Gene Sets
Use helper functions to fetch up-to-date KEGG or GO data.
```R
# KEGG pathways for a species (e.g., "hsa" for human)
kg.hsa = kegg.gsets("hsa")
kegg.gs = kg.hsa$kg.sets[kg.hsa$sigmet.idx] # Signaling & Metabolic pathways

# GO terms
go.hs = go.gsets(species="human")
go.bp = go.hs$go.sets[go.hs$go.subs$BP] # Biological Process
```

### 3. Running GAGE
The main function is `gage()`.
*   **1-Directional:** Detects sets consistently up- or down-regulated.
*   **2-Directional:** Detects sets perturbed in both directions (use `same.dir = FALSE`).

```R
# Basic KEGG analysis
kegg.res <- gage(gse16873, gsets = kegg.gs, ref = hn, samp = dcis)

# Unpaired samples
kegg.unp <- gage(gse16873, gsets = kegg.gs, ref = hn, samp = dcis, compare = "unpaired")
```

### 4. Processing Results
Results are returned as a list with `greater` (up-regulated), `less` (down-regulated), and `stats` (individual sample statistics).

```R
# Extract significant pathways (q-value < 0.1)
sig.sets <- sigGeneSet(kegg.res, outname = "my_analysis")

# Get non-redundant essential gene sets (removes overlapping pathways)
ess.sets <- esset.grp(kegg.res$greater, gse16873, gsets = kegg.gs, ref = hn, samp = dcis, test4up = TRUE)
```

## Visualization
Integrate with `pathview` to render results on KEGG pathway maps.

```R
library(pathview)
# Calculate log2 fold changes
gse16873.d <- gse16873[, dcis] - gse16873[, hn]

# Visualize a specific pathway (e.g., Cell Cycle "04110")
pathview(gene.data = gse16873.d[, 1], pathway.id = "04110", species = "hsa")
```

## Advanced Usage
*   **Joint Workflows:** GAGE can take input from `DESeq2`, `edgeR`, or `limma`. Simply pass the vector of log2 fold changes to `gage()` with `ref = NULL` and `samp = NULL`.
*   **ID Conversion:** Use `pathview::id2eg()` or `gage::sym2eg()` to map Gene Symbols or RefSeq IDs to Entrez IDs.
*   **Heterogeneous Data:** Use `heter.gage()` to combine results from different studies or platforms.

## Reference documentation
- [RNA-Seq Data Pathway and Gene-set Analysis Workflows](./references/RNA-seqWorkflow.md)
- [Gene set and data preparation](./references/dataPrep.md)
- [Generally Applicable Gene-set/Pathway Analysis](./references/gage.md)