---
name: bioconductor-anamir
description: This tool identifies miRNA-target gene interactions by integrating and analyzing paired miRNA and mRNA expression data. Use when user asks to perform differential expression analysis of miRNA and mRNA, calculate negative correlations between miRNA and target genes, convert miRNA annotations between miRBase versions, or validate interactions against prediction databases.
homepage: https://bioconductor.org/packages/3.8/bioc/html/anamiR.html
---

# bioconductor-anamir

name: bioconductor-anamir
description: Analysis of miRNA-target gene interactions using paired expression data. Use this skill to perform integrated analysis of miRNA and mRNA expression matrices, including normalization, differential expression analysis (discrete or continuous), miRNA annotation conversion (miRBase versions), correlation analysis, database intersection (8 prediction and 2 validation databases), and functional enrichment analysis.

# bioconductor-anamir

## Overview
The `anamiR` package is designed to identify reliable miRNA-target gene interactions by integrating miRNA and mRNA expression data. Unlike methods relying solely on computational predictions, `anamiR` uses experimental expression profiles to filter interactions based on negative correlation, then validates these findings against established databases. It supports two primary workflows: a step-by-step general analysis and a function-driven GSEA-based analysis.

## Installation and Setup
To use the package, ensure it is installed via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("anamiR")
library(anamiR)
```

## Data Preparation
The package requires three main components:
1. **mRNA Expression**: Matrix with genes as rows and samples as columns.
2. **miRNA Expression**: Matrix with miRNAs as rows and samples as columns.
3. **Phenotype Data**: Matrix/DataFrame with samples as rows and features (e.g., "case" vs "control") as columns.

Data should be wrapped in `SummarizedExperiment` objects:
```r
mrna_se <- SummarizedExperiment::SummarizedExperiment(
    assays = list(counts = mrna_matrix),
    colData = pheno_data)
```

## General Workflow (Step-by-Step)

### 1. Normalization (Optional)
If data is not pre-normalized, use `normalization`:
```r
se <- normalization(data = mirna_matrix, method = "quantile") # methods: quantile, rank.invariant, normal
```

### 2. Differential Expression Analysis
Identify significant features for discrete groups:
```r
mrna_d <- differExp_discrete(se = mrna_se, class = "GroupColumn", method = "t.test", p_value.cutoff = 0.05, logratio = 0.5)
```
For continuous data, use `differExp_continuous`. For more than two groups, use `multi_Differ`.

### 3. miRNA Annotation Conversion
Ensure miRNAs are in miRBase 21 format for database intersection:
```r
mirna_21 <- miR_converter(data = mirna_d, original_version = 17, latest_version = 21)
```

### 4. Correlation Analysis
Find pairs with negative correlation (miRNAs typically downregulate targets):
```r
cor_result <- negative_cor(mrna_data = mrna_d, mirna_data = mirna_21, method = "pearson", cut.off = -0.5)
```

### 5. Database Intersection
Validate potential interactions against 8 prediction and 2 validation databases:
```r
supported_inter <- database_support(cor_data = cor_result, org = "hsa", Sum.cutoff = 3)
```

### 6. Functional Enrichment
Identify pathways enriched by the target genes:
```r
pathways <- enrichment(data_support = supported_inter, org = "hsa", per_time = 5000)
```

## Function-Driven Workflow (GSEA)
This alternative workflow identifies interactions within enriched pathways:
1. **GSEA Analysis**: Find pathways enriched in the expression data.
   ```r
   table <- GSEA_ana(mrna_se = mrna_se, mirna_se = mirna_se, class = "GroupColumn", pathway_num = 10)
   ```
2. **GSEA Results**: Calculate statistics for miRNA-gene pairs within those pathways.
   ```r
   final_res <- GSEA_res(table = table, pheno.data = pheno_data, class = "GroupColumn", DE_method = "limma")
   ```

## Visualization
Visualize the expression patterns of identified interactions:
```r
heat_vis(cor_result, mrna_d, mirna_21)
```

## Reference documentation
- [Introduction to anamiR](./references/IntroductionToanamiR.md)
- [Introduction to anamiR (RMarkdown)](./references/IntroductionToanamiR.Rmd)