---
name: bioconductor-regenrich
description: This tool identifies key transcriptional regulators by integrating differential expression analysis with regulatory network inference and enrichment testing. Use when user asks to identify key regulators, perform gene regulator enrichment analysis, infer gene regulatory networks, or rank transcription factors from gene expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/RegEnrich.html
---


# bioconductor-regenrich

name: bioconductor-regenrich
description: Gene regulator enrichment analysis using the RegEnrich Bioconductor package. Use this skill to identify key transcriptional regulators from gene expression data (RNA-seq, microarray, or proteomics) by integrating differential expression analysis with data-driven regulatory network inference (COEN/WGCNA or GRN/Random Forest) and enrichment testing (FET or GSEA).

# bioconductor-regenrich

## Overview
RegEnrich is a pipeline for identifying key gene regulators (e.g., transcription factors) that govern biological states. It transforms gene expression data into mechanistic insights through a four-step workflow:
1. **Differential Expression Analysis (DEA)**: Identifying genes changing between conditions.
2. **Network Inference**: Building regulator-target relationships using Co-expression (COEN) or Gene Regulatory Networks (GRN).
3. **Enrichment Analysis**: Testing if regulator targets are enriched among differentially expressed genes.
4. **Regulator Ranking**: Scoring regulators based on both their differential expression and their enrichment significance.

## Core Workflow

### 1. Initialization
The `RegenrichSet` object is the central data structure. It requires expression data, sample metadata, and a list of regulators.

```r
library(RegEnrich)
data(TFs) # Default human TFs

object <- RegenrichSet(
  expr = expressionMatrix,   # matrix: genes (rows) x samples (cols)
  colData = sampleInfo,      # data.frame: sample metadata
  reg = unique(TFs$TF_name), # vector: regulator IDs
  method = "limma",          # DEA method: "limma", "LRT_LM", "Wald_DESeq2", "LRT_DESeq2"
  design = ~condition,       # formula for the model
  networkConstruction = "COEN", # "COEN" (WGCNA) or "GRN" (Random Forest)
  enrichTest = "FET"         # "FET" (Fisher's) or "GSEA"
)
```

### 2. Execution Pipeline
The analysis can be run step-by-step or using pipes (`%>%`).

```r
# Step-by-step execution
object <- regenrich_diffExpr(object)
object <- regenrich_network(object)
object <- regenrich_enrich(object)
object <- regenrich_rankScore(object)

# Extract final ranked results
res <- results_score(object)
```

## Key Functions and Parameters

### Differential Expression (`regenrich_diffExpr`)
- **Methods**: `limma` (microarray/log-transformed), `LRT_LM` (linear models), `Wald_DESeq2` or `LRT_DESeq2` (raw counts).
- **Parameters**: `design`, `reduced` (for LRT), `contrast`, or `coef`.

### Network Inference (`regenrich_network`)
- **COEN**: Based on WGCNA. Fast and robust for co-expression.
- **GRN**: Based on Random Forest (GENIE3). Computationally intensive; use `BPPARAM` for parallelization.
- **User-defined**: You can manually assign a network using `regenrich_network(object) <- your_network_df`.

### Enrichment Testing (`regenrich_enrich`)
- **FET**: Fisher's Exact Test. Fast, uses a p-value cutoff from DEA.
- **GSEA**: Gene Set Enrichment Analysis. Slower, uses the full distribution of DEA results.

### Visualization
- `plotRegTarExpr(object, reg = "GENE_NAME")`: Visualize the expression of a regulator and its predicted targets across samples.
- `plotOrders(list1, list2)`: Compare regulator rankings between different methods (e.g., FET vs GSEA).

## Tips for Success
- **ID Matching**: Ensure the IDs in your `reg` vector match the rownames of your `expr` matrix (e.g., both ENSEMBL or both Gene Symbols).
- **Data Scaling**: For RNA-seq, use raw counts with `DESeq2` methods or log2(FPKM + 1) with `limma`/`LRT_LM`.
- **Filtering**: Use `minMeanExpr` in `RegenrichSet` to remove lowly expressed genes, which improves network inference speed and reliability.
- **Parallelization**: For GRN methods, always register a backend:
  ```r
  library(BiocParallel)
  register(MulticoreParam(workers = 4)) 
  ```

## Reference documentation
- [RegEnrich: an R package for gene regulator enrichment analysis](./references/RegEnrich.md)