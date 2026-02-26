---
name: bioconductor-decoupler
description: This tool performs biological activity inference from omics data by integrating gene expression matrices with prior knowledge networks. Use when user asks to infer transcription factor or pathway activities, access curated regulatory networks via OmniPath, run consensus enrichment analysis, or visualize activity scores.
homepage: https://bioconductor.org/packages/release/bioc/html/decoupleR.html
---


# bioconductor-decoupler

name: bioconductor-decoupler
description: Use this skill to perform biological activity inference from omics data (bulk RNA-seq, scRNA-seq) using the decoupleR R package. It supports various statistical methods (MLM, ULM, GSEA, etc.) and integrates with prior knowledge networks like CollecTRI (TFs) and PROGENy (Pathways). Use this skill when you need to: (1) Infer transcription factor or pathway activities from gene expression matrices or differential expression results, (2) Access curated regulatory networks via OmniPath, (3) Run consensus analysis across multiple enrichment methods, or (4) Visualize activity scores in heatmaps or volcano plots.

# bioconductor-decoupler

## Overview
The `decoupleR` package provides a unified framework for inferring biological activities (e.g., transcription factor or pathway activity) from omics data using prior knowledge. It decouples the statistical method from the biological resource, allowing users to apply various algorithms (Univariate Linear Models, Multivariate Linear Models, GSEA, etc.) to the same data and network.

## Installation
Install the package via BiocManager:
```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("decoupleR")
```

## Core Workflow

### 1. Prepare Input Data
`decoupleR` requires two main inputs:
- **Matrix (`mat`)**: A matrix of molecular readouts (e.g., normalized counts, logFC, or t-statistics). Rows are features (genes) and columns are samples/conditions.
- **Network (`net`)**: A data frame relating "sources" (TFs, pathways) to "targets" (genes). It must contain columns for `.source` and `.target`, and optionally `.mor` (mode of regulation/weights).

### 2. Retrieve Prior Knowledge
Use built-in functions to fetch curated networks:
```r
# Get Transcription Factor network (CollecTRI)
net_tf <- get_collectri(organism = 'human')

# Get Pathway network (PROGENy)
net_pw <- get_progeny(organism = 'human', top = 500)
```

### 3. Run Inference Methods
Methods follow a consistent naming convention: `run_[method]`.

**Univariate Linear Model (ULM):**
Best for networks with weights (MoR). Fits a linear model for each source.
```r
res_ulm <- run_ulm(mat = mat, net = net_tf, .source = 'source', .target = 'target', .mor = 'mor')
```

**Multivariate Linear Model (MLM):**
Fits one model per sample using all sources simultaneously. Effective for pathways with overlapping targets.
```r
res_mlm <- run_mlm(mat = mat, net = net_pw, .source = 'source', .target = 'target', .mor = 'weight')
```

**Consensus Score:**
Runs the top-performing methods (`mlm`, `ulm`, `wsum`) and calculates a consensus.
```r
res_consensus <- decouple(mat = mat, network = net_tf, .source = 'source', .target = 'target', .mor = 'mor')
```

### 4. Process and Visualize Results
Results are returned in a long-format tibble. Use `pivot_wider_profile` to convert to a matrix for heatmaps.

```r
# Convert to matrix for pheatmap
act_mat <- res_ulm %>%
  filter(statistic == 'ulm') %>%
  pivot_wider_profile(id_cols = source, names_from = condition, values_from = score) %>%
  as.matrix()

pheatmap::pheatmap(act_mat)
```

## Integration with Single-Cell (Seurat)
For scRNA-seq, extract the data from the assay and store results back as a new assay.
```r
# Extract counts
mat <- as.matrix(seurat_obj@assays$RNA@data)

# Run method
acts <- run_mlm(mat = mat, net = net_pw, .source = 'source', .target = 'target', .mor = 'weight')

# Add back to Seurat
seurat_obj[['pathways']] <- acts %>%
  pivot_wider(id_cols = 'source', names_from = 'condition', values_from = 'score') %>%
  column_to_rownames('source') %>%
  CreateAssayObject()
```

## Tips for Success
- **Statistic Selection**: For differential expression, use t-values or a weighted statistic like `-log10(p-value) * logFC`.
- **minsize**: Use the `minsize` argument (default 5) to filter out sources with too few targets, which prevents noisy activity estimates.
- **Directionality**: Positive scores indicate activation; negative scores indicate inhibition (provided the network has correct `.mor` weights).

## Reference documentation
- [Introduction](./references/decoupleR.md)
- [Pathway activity inference in bulk RNA-seq](./references/pw_bk.md)
- [Pathway activity inference from scRNA-seq](./references/pw_sc.md)
- [Transcription factor activity inference in bulk RNA-seq](./references/tf_bk.md)