---
name: bioconductor-microbiomeprofiler
description: MicrobiomeProfiler performs functional enrichment analysis for microbiome data using databases such as KEGG, COG, Disbiome, and SMPDB. Use when user asks to perform over-representation analysis on microbial gene catalogs, identify microbe-disease associations, or analyze metabolite pathways.
homepage: https://bioconductor.org/packages/release/bioc/html/MicrobiomeProfiler.html
---


# bioconductor-microbiomeprofiler

name: bioconductor-microbiomeprofiler
description: Functional enrichment analysis for microbiome data using KEGG, COG, Microbe-Disease (Disbiome), and Metabo-Pathway (SMPDB) databases. Use this skill when performing over-representation analysis (ORA) on microbial gene catalogs or metabolite lists, specifically for KEGG Orthology (KO) terms or COG IDs.

# bioconductor-microbiomeprofiler

## Overview

`MicrobiomeProfiler` is an R/Bioconductor package built upon the `clusterProfiler` framework, specifically tailored for functional enrichment analysis of microbiome data. It supports multiple annotation sources including KEGG, COG, Disbiome (microbe-disease associations), and SMPDB (small molecule pathways). It provides both a programmatic R interface and a Shiny web application for interactive analysis.

## Installation

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MicrobiomeProfiler")
```

## Core Workflows

### 1. Interactive Analysis
The easiest way to use the package is through its built-in Shiny interface:

```R
library(MicrobiomeProfiler)
run_MicrobiomeProfiler()
```

### 2. KEGG Enrichment Analysis
Perform enrichment on a vector of KEGG Orthology (KO) identifiers.

```R
# Example: Enrichment of KO terms
# gene: a vector of KO IDs (e.g., "K00001", "K00002")
# pvalueCutoff: threshold for statistical significance
# pAdjustMethod: method for multiple testing correction ("BH", "bonferroni", etc.)

kegg_res <- enrichKO(gene = your_ko_list,
                     pvalueCutoff = 0.05,
                     pAdjustMethod = "BH")

# View results
head(kegg_res)
```

### 3. Using Reference Gene Catalogs
When performing KEGG analysis, you can specify a "universe" based on integrated non-redundant gene catalogs:

| Catalog Name | Description |
|--------------|-------------|
| `human_gut2014` | Human gut microbiome (Nature Biotech 2014) |
| `human_gut2016` | Human gut microbiome (Cell Systems 2016) |
| `human_skin` | Human skin microbial catalog |
| `human_vagina` | Human vaginal catalog (VIRGO) |

### 4. Other Enrichment Types
The package provides specialized functions for different databases:

*   **COG Enrichment**: `enrichCOG(gene = your_cog_list)`
*   **Microbe-Disease Enrichment**: `enrichMBID(gene = your_microbe_list)` (uses Disbiome)
*   **Metabolite Pathway Enrichment**: `enrichSMPDB(gene = your_metabolite_list)` (uses SMPDB)

## Visualization and Interpretation

Since `MicrobiomeProfiler` results are compatible with the `clusterProfiler` ecosystem, you can use standard visualization methods:

*   **Dot plots**: `dotplot(kegg_res)`
*   **Bar plots**: `barplot(kegg_res)`
*   **Result Table**: Access the underlying data frame using `as.data.frame(kegg_res)`.

## Tips for Success
*   **Input Format**: Ensure your input IDs match the expected format for the specific function (e.g., KO IDs for `enrichKO`, COG IDs for `enrichCOG`).
*   **Custom Universe**: For more accurate enrichment, provide a `universe` argument containing all genes/microbes detected in your specific study (the "background").
*   **Shiny App**: Use the Shiny app (`run_MicrobiomeProfiler()`) to quickly explore different p-value cutoffs and visualize top terms interactively before finalizing your R script.

## Reference documentation
- [Introduction to MicrobiomeProfiler](./references/MicrobiomeProfiler.md)