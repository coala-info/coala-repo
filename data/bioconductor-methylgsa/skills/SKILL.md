---
name: bioconductor-methylgsa
description: This tool performs gene set analysis on DNA methylation data while adjusting for the bias of varying CpG density per gene. Use when user asks to identify enriched pathways from 450K or EPIC array data, perform logistic regression for methylation gene sets, or aggregate CpG p-values into gene-level scores.
homepage: https://bioconductor.org/packages/release/bioc/html/methylGSA.html
---


# bioconductor-methylgsa

name: bioconductor-methylgsa
description: Perform gene set analysis (GSA) on DNA methylation data using the methylGSA R package. This skill adjusts for the inherent bias caused by varying numbers of CpGs per gene. Use this skill when analyzing 450K or EPIC array data to identify enriched pathways (GO, KEGG, Reactome) or user-defined gene sets while controlling for CpG density.

# bioconductor-methylgsa

## Overview
The methylGSA package provides methods for gene set analysis of DNA methylation data that account for the bias introduced by the varying number of CpG sites per gene. Genes with more CpGs are more likely to be identified as differentially methylated by chance; methylGSA corrects this using three primary statistical frameworks: logistic regression (methylglm), robust rank aggregation (methylRRA), and weighted resampling (methylgometh).

## Installation and Setup
Install the package via BiocManager and load the required annotation for your array type:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("methylGSA")

library(methylGSA)

# For 450K arrays
library(IlluminaHumanMethylation450kanno.ilmn12.hg19)

# For EPIC arrays
library(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)
```

## Data Preparation
The primary input for all methylGSA functions is a named numeric vector of p-values from a differential methylation analysis. The names must be CpG IDs (e.g., cg00050873).

```r
# Example input structure
# cpg.pval <- c(cg00050873 = 0.2876, cg00212031 = 0.7883, ...)
```

## Core Analysis Methods

### 1. Logistic Regression (methylglm)
Adjusts for CpG density by incorporating the number of CpGs as a covariate in a logistic regression model.

```r
res_glm = methylglm(cpg.pval = cpg.pval, 
                    minsize = 100, 
                    maxsize = 500, 
                    GS.type = "KEGG")
head(res_glm)
```

### 2. Robust Rank Aggregation (methylRRA)
Aggregates CpG-level p-values into gene-level scores. Supports Over-Representation Analysis (ORA) and Gene Set Enrichment Analysis (GSEA).

```r
# ORA approach (default)
res_ora = methylRRA(cpg.pval = cpg.pval, method = "ORA", GS.type = "GO")

# GSEA approach
res_gsea = methylRRA(cpg.pval = cpg.pval, method = "GSEA", GS.type = "Reactome")
```

### 3. Weighted Resampling (methylgometh)
Interfaces with the missMethyl package to use Wallenius non-central hypergeometric approximation.

```r
res_gometh = methylgometh(cpg.pval = cpg.pval, 
                          sig.cut = 0.001, 
                          GS.type = "KEGG")
```

## Customization and Advanced Options

### User-Supplied Gene Sets
Provide a list where names are gene set IDs and elements are vectors of gene symbols.

```r
res_custom = methylglm(cpg.pval = cpg.pval, 
                       GS.list = my_gene_sets, 
                       GS.idtype = "SYMBOL")
```

### Custom CpG-to-Gene Mapping
If using non-standard arrays or custom annotations, use `prepareAnnot`.

```r
# mapping: 1st col CpG ID, 2nd col Gene Name
my_annot = prepareAnnot(mapping_dataframe)
res_custom_map = methylRRA(cpg.pval = cpg.pval, FullAnnot = my_annot)
```

### Filtering by Genomic Region
Use the `group` argument to restrict analysis to specific gene regions:
- "all": All CpGs (default).
- "body": CpGs in the gene body or 1st exon.
- "promoter1": TSS1500 or TSS200.
- "promoter2": TSS1500, TSS200, 1stExon, or 5'UTR.

## Visualization
Visualize results using the built-in barplot function, which is compatible with outputs from all three main analysis functions.

```r
barplot(res_glm, num = 10, colorby = "padj", xaxis = "Size")
```

## Interpreting Results
The output is a data frame containing:
- **ID**: Gene set identifier.
- **Description**: Description of the pathway.
- **Size**: Total genes in the set.
- **Count/Overlap**: (ORA only) Number of significant genes.
- **pvalue**: Raw p-value for the gene set.
- **padj**: Adjusted p-value (FDR).

## Reference documentation
- [methylGSA: Gene Set Analysis for DNA Methylation Datasets](./references/methylGSA-vignette.md)
- [methylGSA Source Vignette](./references/methylGSA-vignette.Rmd)