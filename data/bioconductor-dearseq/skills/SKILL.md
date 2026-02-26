---
name: bioconductor-dearseq
description: This tool performs differential expression and gene set analysis on RNA-seq data using variance component score tests. Use when user asks to identify differentially expressed genes, perform gene set enrichment analysis, or analyze RNA-seq data with complex experimental designs like longitudinal studies and repeated measurements.
homepage: https://bioconductor.org/packages/release/bioc/html/dearseq.html
---


# bioconductor-dearseq

name: bioconductor-dearseq
description: Perform differential expression analysis (DEA) and gene set analysis (GSA) on RNA-seq data using the dearseq package. Use when analyzing RNA-seq datasets with complex experimental designs, such as longitudinal studies, repeated measurements, or multiple biological conditions, where robust control of the false discovery rate (FDR) is required. The skill supports gene-wise testing and gene set enrichment using variance component score tests.

## Overview

`dearseq` (Differential Expression Analysis of RNA-seq) is a Bioconductor package designed for robust differential expression analysis. It uses a variance component score test that accounts for data heteroscedasticity through precision weights. It is particularly effective at controlling false positives and can handle complex experimental designs that traditional linear models might struggle with, including longitudinal data.

Key capabilities:
- **Gene-wise analysis**: Identifying individual differentially expressed genes (DEGs).
- **Gene set analysis (GSA)**: Testing for enrichment in predefined sets of genes.
- **Complex Designs**: Handling multiple conditions and repeated measures.
- **Flexible Testing**: Offers both asymptotic tests (for large samples) and permutation tests (for small samples).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("dearseq")
```

## Gene-wise Differential Expression

The primary function for gene-wise analysis is `dear_seq()`.

### Input Requirements
- **Expression Data**: A numeric matrix of counts or a `SummarizedExperiment` object.
- **Variables to Test**: The main condition or factor of interest.
- **Covariates**: (Optional) Variables to adjust for (e.g., age, sex, batch).

### Typical Workflow

1. **Prepare Data**: Organize expression data and metadata into a `SummarizedExperiment`.
2. **Run Analysis**:
   ```r
   library(dearseq)
   library(SummarizedExperiment)

   # Example using a SummarizedExperiment 'se'
   # variables2test can be a column name in colData(se)
   res <- dear_seq(object = se, 
                   variables2test = "Status", 
                   which_test = "asymptotic", 
                   preprocessed = FALSE)
   ```
3. **Parameters**:
   - `preprocessed`: Set to `FALSE` if providing raw counts (the function will perform log-cpm normalization). Set to `TRUE` if data is already normalized/log-transformed.
   - `which_test`: Use `"permutation"` for small sample sizes (e.g., n < 30) or `"asymptotic"` for larger datasets.
4. **Inspect Results**:
   ```r
   summary(res)
   plot(res) # Visualizes p-value distribution and significance
   ```

## Gene Set Analysis (GSA)

The `dgsa_seq()` function performs gene set analysis using the same variance component score test framework.

### Workflow
```r
# genesets should be a list of gene identifiers or a BiocSet object
res_gsa <- dgsa_seq(object = se,
                    genesets = my_genesets,
                    variables2test = "Condition",
                    covariates = "Batch",
                    which_test = "permutation",
                    n_perm = 1000,
                    preprocessed = TRUE)

# View p-values for gene sets
res_gsa$pvals
```

## Longitudinal Data Visualization

For longitudinal or time-course gene set data, `dearseq` provides specialized plotting to visualize expression trends over time.

```r
# Visualize a specific gene set (index 3 in the gmt)
spaghettiPlot1GS(gs_index = 3, 
                 gmt = my_gmt, 
                 expr_mat = assay(se), 
                 design = colData(se),
                 var_time = AgeWeeks, 
                 var_indiv = SubjectID, 
                 var_group = Treatment)
```

## Usage Tips
- **Filtering**: For raw counts, it is recommended to filter out lowly expressed genes (e.g., using `edgeR::filterByExpr` or a CPM threshold) before running `dear_seq`.
- **Parallel Computation**: For permutation tests, use the `parallel_comp` argument to speed up execution if the environment supports it.
- **Normalization**: If `preprocessed = FALSE`, `dearseq` uses a `voom`-like approach to estimate precision weights.

## Reference documentation

- [User guide to the dearseq R package](./references/dearseqUserguide.md)