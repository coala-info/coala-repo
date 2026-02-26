---
name: bioconductor-elmer
description: ELMER reconstructs gene regulatory networks by integrating DNA methylation and gene expression data to identify distal regulatory elements and their target genes. Use when user asks to identify enhancers from methylation arrays, link distal probes to target genes via expression correlation, perform motif enrichment analysis, or identify master regulator transcription factors.
homepage: https://bioconductor.org/packages/release/bioc/html/ELMER.html
---


# bioconductor-elmer

name: bioconductor-elmer
description: Reconstruct gene regulatory networks (GRNs) by combining DNA methylation and gene expression data. Use when Claude needs to: (1) Identify distal regulatory elements (enhancers) from HM450K or EPIC arrays, (2) Link distal probes to target genes via expression correlation, (3) Perform motif enrichment analysis on methylated probes, (4) Identify master regulator transcription factors (MR TFs), or (5) Execute the full ELMER pipeline on TCGA or custom multi-omics datasets.

# bioconductor-elmer

## Overview
ELMER (Enhancer Linking by Methylation/Expression Relationships) is a Bioconductor package designed to infer regulatory element landscapes and transcription factor networks. It uses DNA methylation at cis-regulatory modules (CRMs) as a central hub, associating them with upstream master regulator TFs and downstream target genes through correlation analysis.

The package supports both **Unsupervised** mode (detecting changes in a subset of samples, ideal for heterogeneous tumor subtypes) and **Supervised** mode (comparing pre-defined groups).

## Core Workflow

### 1. Data Preparation
ELMER uses the `MultiAssayExperiment` (MAE) format. You must provide a DNA methylation matrix (beta values), a gene expression matrix, and sample metadata.

```r
library(ELMER)
library(MultiAssayExperiment)

# Create MAE object
mae <- createMAE(
  exp = GeneExp_matrix,
  met = Meth_matrix,
  met.platform = "450K", # or "EPIC"
  genome = "hg38",       # or "hg19"
  TCGA = TRUE            # Set TRUE for automatic TCGA metadata mapping
)
```

### 2. Identify Distal Probes
Filter for probes located far from Transcription Start Sites (TSS), typically >2kb.

```r
distal.probes <- get.feature.probe(
  genome = "hg38",
  met.platform = "450K",
  rm.chr = paste0("chr", c("X", "Y"))
)
```

### 3. Differential Methylation Analysis
Identify probes with significant differences between groups using `get.diff.meth`.

```r
sig.diff <- get.diff.meth(
  data = mae,
  group.col = "definition",
  group1 = "Primary solid Tumor",
  group2 = "Solid Tissue Normal",
  diff.dir = "hypo", # "hypo" or "hyper"
  sig.dif = 0.3,
  pvalue = 0.01,
  mode = "unsupervised" # or "supervised"
)
```

### 4. Identify Putative Probe-Gene Pairs
Link distal probes to the nearest genes (default 10 upstream/downstream) based on inverse correlation between methylation and expression.

```r
nearGenes <- GetNearGenes(data = mae, probes = sig.diff$probe, numFlankingGenes = 20)

pairs <- get.pair(
  data = mae,
  nearGenes = nearGenes,
  mode = "unsupervised",
  permu.size = 10000, # Use high permutation for publication
  Pe = 0.001          # Empirical p-value cutoff
)
```

### 5. Motif Enrichment and Regulatory TFs
Identify enriched motifs in the significant probes and find TFs whose expression correlates with the average methylation of those motifs.

```r
# Motif enrichment
enriched.motif <- get.enriched.motif(data = mae, probes = pairs$Probe)

# Identify Master Regulator TFs
TFs <- get.TFs(
  data = mae,
  enriched.motif = enriched.motif,
  group.col = "definition",
  group1 = "Primary solid Tumor",
  group2 = "Solid Tissue Normal",
  mode = "unsupervised"
)
```

## The TCGA Pipeline
For TCGA data, `TCGA.pipe` automates the entire workflow, including data downloading via TCGAbiolinks.

```r
TCGA.pipe(
  disease = "LUSC",
  wd = "./results",
  mode = "unsupervised",
  analysis = c("distal.probes", "diffMeth", "pair", "motif", "TF.search"),
  diff.dir = "hypo"
)
```

## Visualization Functions
ELMER provides several plotting functions to interpret results:
- `scatter.plot`: Correlation between probe methylation and gene expression.
- `schematic.plot`: Genomic context of probe-gene pairs.
- `motif.enrichment.plot`: Odds ratio and significance of enriched motifs.
- `TF.rank.plot`: Ranking of TFs for a specific motif.

## Reference documentation
- [Creating MAE with distal probes](./references/analysis_data_input.md)
- [Identifying differentially methylated probes](./references/analysis_diff_meth.md)
- [Identifying putative probe-gene pairs](./references/analysis_get_pair.md)
- [Motif enrichment analysis](./references/analysis_motif_enrichment.md)
- [Identifying regulatory TFs](./references/analysis_regulatory_tf.md)
- [TCGA Pipeline wrapper](./references/pipe.md)
- [Input data requirements](./references/input.md)
- [Graphical User Interface](./references/analysis_gui.md)
- [Scatter plots](./references/plots_scatter.md)
- [Schematic plots](./references/plots_schematic.md)
- [Motif enrichment plots](./references/plots_motif_enrichment.md)
- [Regulatory TF plots](./references/plots_TF.md)
- [Heatmap plots](./references/plots_heatmap.md)
- [Package Introduction](./references/index.md)
- [Use Case Example](./references/usecase.md)