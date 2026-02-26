---
name: bioconductor-epimix
description: EpiMix performs integrative analysis of DNA methylation and gene expression data using beta mixture models to identify functional epigenetic changes. Use when user asks to identify methylation-driven gene expression, analyze TCGA data, find survival-associated epigenetic biomarkers, or investigate methylation states in enhancers, miRNAs, and lncRNAs.
homepage: https://bioconductor.org/packages/release/bioc/html/EpiMix.html
---


# bioconductor-epimix

name: bioconductor-epimix
description: Integrative analysis of DNA methylation and gene expression data using beta mixture models. Use this skill to identify functional DNA methylation changes (hypo- or hypermethylation) associated with gene expression across different genetic elements (protein-coding genes, enhancers, miRNAs, and lncRNAs). It is particularly useful for processing TCGA data, performing pathway enrichment, and identifying survival-associated epigenetic biomarkers.

# bioconductor-epimix

## Overview

EpiMix is an R package designed for population-level analysis of DNA methylation. It uses beta mixture models to identify methylation states of CpG sites and correlates these states with gene expression to identify functional epigenetic changes. The package supports four distinct analytic modes:
- **Regular**: Proximal cis-regulatory elements for protein-coding genes.
- **Enhancer**: Distal enhancers (requires Roadmap Epigenomics tissue/cell type IDs).
- **miRNA**: miRNA-coding genes.
- **lncRNA**: lncRNA-coding genes.

## Data Input Requirements

The core `EpiMix` function requires three primary inputs:
1. **DNA Methylation Matrix**: Beta values with CpG sites in rows and samples in columns.
2. **Gene Expression Matrix**: Matched expression data (TPM, RPKM, etc.) with genes in rows and samples in columns.
3. **Sample Annotation**: A dataframe with columns `primary` (sample IDs) and `sample.type` (e.g., "Cancer" vs "Normal").

## Core Workflow

### 1. Standard Analysis (Regular Mode)
To run a standard integrative analysis:
```r
library(EpiMix)
results <- EpiMix(
  methylation.data = MET.data,
  gene.expression.data = mRNA.data,
  sample.info = LUAD.sample.annotation,
  group.1 = "Cancer",
  group.2 = "Normal",
  met.platform = "HM450",
  OutputRoot = tempdir()
)
# Access functional pairs (CpG-gene associations)
head(results$FunctionalPairs)
```

### 2. Enhancer Mode
Requires a Roadmap Epigenome ID (e.g., "E096" for Lung) to filter for tissue-specific enhancers.
```r
results_enhancer <- EpiMix(
  methylation.data = MET.data,
  gene.expression.data = mRNA.data,
  mode = "Enhancer",
  roadmap.epigenome.ids = "E096",
  sample.info = LUAD.sample.annotation,
  group.1 = "Cancer",
  group.2 = "Normal",
  met.platform = "HM450"
)
```

### 3. TCGA Automated Workflow
EpiMix provides a one-step function for TCGA data:
```r
results_tcga <- TCGA_GetData(
  CancerSite = "OV",
  mode = "Regular",
  outputDirectory = tempdir(),
  cores = 10
)
```
Alternatively, use step-by-step functions: `TCGA_Download_DNAmethylation`, `TCGA_Preprocess_DNAmethylation`, `TCGA_Download_GeneExpression`, and `TCGA_GetSampleInfo`.

## Visualization

EpiMix provides several plotting functions to interpret results:
- `EpiMix_PlotModel()`: Shows the mixture model distribution, violin plots of expression by methylation state, and correlation plots.
- `EpiMix_PlotGene()`: Genome-browser style view of chromatin state, DM values, and transcript structure.
- `EpiMix_PlotProbe()`: Visualizes chromatin states of a CpG and nearby genes (useful for enhancers).
- `EpiMix_PlotSurvival()`: Kaplan-Meier curves comparing survival between different methylation states.

## Downstream Analysis

### Pathway Enrichment
Integrates with `clusterProfiler` to analyze differentially methylated genes:
```r
enrich_res <- functionEnrich(
  EpiMixResults = results,
  methylation.state = "all", # or "hypo"/"hyper"
  enrich.method = "GO",      # or "KEGG"
  ont = "BP"
)
```

### Survival Analysis
Identify CpGs where methylation state significantly impacts patient survival:
```r
survival_probes <- GetSurvivalProbe(
  EpiMixResults = results,
  TCGA_CancerSite = "LUAD"
)
```

### miRNA Target Identification
For miRNA mode, find targets whose expression is inversely associated with miRNA methylation:
```r
miRNA_targets <- find_miRNA_targets(
  EpiMixResults = results_miRNA,
  geneExprData = mRNA.data
)
```

## Reference documentation

- [Methylation Modeling](./references/Methylation_Modeling.md)
- [Methylation Modeling RMarkdown](./references/Methylation_Modeling.Rmd)