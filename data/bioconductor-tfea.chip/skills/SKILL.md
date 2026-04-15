---
name: bioconductor-tfea.chip
description: This tool identifies transcription factors enriched in gene sets by leveraging experimentally derived ChIP-seq data. Use when user asks to identify transcription factors regulating a set of genes, perform overrepresentation analysis, or run gene set enrichment analysis using ChIP-seq evidence.
homepage: https://bioconductor.org/packages/release/bioc/html/TFEA.ChIP.html
---

# bioconductor-tfea.chip

name: bioconductor-tfea.chip
description: Transcription Factor Enrichment Analysis (TFEA) using ChIP-seq data. Use this skill to identify transcription factors responsible for the co-regulation of a set of genes by leveraging experimentally derived TFBS from the ReMap 2022 repository. Supports Overrepresentation Analysis (ORA) and Gene Set Enrichment Analysis (GSEA), with native support for DESeq2 and edgeR outputs.

## Overview
TFEA.ChIP is a toolkit for identifying transcription factors (TFs) enriched in a set of genes (e.g., differentially expressed genes). Unlike sequence-based motif analysis, it uses high-quality, experimentally derived ChIP-seq data (defaulting to ReMap 2022 integrated with ENCODE-rE2G) to link TFs to target genes. It is primarily designed for human data but supports mouse-to-human ortholog translation.

## Core Workflow

### 1. Data Preprocessing
The package requires gene identifiers (Entrez IDs preferred), Log2 Fold Change (LFC), and p-values.

```r
library(TFEA.ChIP)

# Preprocess DESeq2 or edgeR output
# mode = "h2h" (human, default) or "m2h" (mouse-to-human)
hypoxia_df <- preprocessInputData(hypoxia_DESeq, mode = "h2h")
```

### 2. Overrepresentation Analysis (ORA)
ORA compares a set of "genes of interest" (e.g., upregulated) against a "control" set (non-responsive genes).

```r
# 1. Select gene sets
up_genes <- Select_genes(hypoxia_df, min_LFC = 1, max_pval = 0.05)
control_genes <- Select_genes(hypoxia_df, min_pval = 0.5, max_pval = 1, min_LFC = -0.25, max_LFC = 0.25)

# 2. Run analysis (returns p-values and Odds Ratios)
cm_list <- contingency_matrix(up_genes, control_genes)
stats <- getCMstats(cm_list)

# 3. Visualize results
plot_CM(stats, specialTF = c("HIF1A", "EPAS1", "ARNT"))
```

### 3. Gene Set Enrichment Analysis (GSEA)
GSEA uses a ranked list of genes (usually ranked by LFC).

```r
# 1. (Optional) Filter for specific TFs to speed up analysis
chip_index <- get_chip_index(TFfilter = c("HIF1A", "EPAS1", "ARNT"))

# 2. Run GSEA
gsea_res <- GSEA_run(hypoxia_df$Genes, hypoxia_df$log2FoldChange, chip_index, get.RES = TRUE)

# 3. Visualize
plot_ES(gsea_res$result, LFC = hypoxia_df$log2FoldChange)
```

### 4. Integrated Analysis
The `analysis_from_table` function combines preprocessing, filtering for expressed TFs, and enrichment in one step.

```r
# ORA method
res_ora <- analysis_from_table(hypoxia_df, method = "ora", expressed = TRUE)

# GSEA method
res_gsea <- analysis_from_table(hypoxia_df, method = "gsea", expressed = TRUE)
```

## Advanced Usage

### Using the Full Database
By default, a minimal internal database is used. For full analysis, load the complete database from `ExperimentHub`.

```r
library(ExperimentHub)
eh <- ExperimentHub()
ChIPDB <- eh[['EH9854']] # Overrides default internal database
```

### Meta-analysis
To aggregate results across multiple ChIP-seq datasets for the same TF:

```r
library(meta)
meta_res <- metaanalysis_fx(stats)
# Access summary table
head(meta_res$summary)
```

## Key Functions
- `preprocessInputData()`: Standardizes input tables and converts IDs to Entrez.
- `Select_genes()`: Filters genes based on LFC and p-value thresholds.
- `GeneID2entrez()`: Manual conversion of Gene Symbols/Ensembl to Entrez IDs.
- `get_chip_index()`: Creates a subset index of the ChIP-seq database.
- `rankTFs()`: Summarizes enrichment results by TF using Wilcoxon or GSEA.
- `set_user_data()`: Allows using a custom TFBS binary matrix and metadata.

## Reference documentation
- [TFEA.ChIP: a tool kit for transcription factor enrichment](./references/TFEA.ChIP.Rmd)
- [TFEA.ChIP Package Vignette](./references/TFEA.ChIP.md)