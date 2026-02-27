---
name: bioconductor-pairedgsea
description: pairedGSEA provides a unified framework for analyzing and comparing differential gene expression and differential gene splicing from RNA-seq datasets. Use when user asks to perform paired differential analysis, aggregate expression and splicing results using the Lancaster method, or conduct over-representation analysis to compare pathway enrichment between expression and splicing.
homepage: https://bioconductor.org/packages/release/bioc/html/pairedGSEA.html
---


# bioconductor-pairedgsea

## Overview
`pairedGSEA` is a Bioconductor package designed to provide a unified framework for analyzing both differential gene expression (DGE) and differential gene splicing (DGS) from the same RNA-seq dataset. It wraps established tools like `DESeq2`, `DEXSeq`, and `limma`, aggregating results to the gene level using the Lancaster method. This allows for a direct comparison of how a condition affects a gene's total abundance versus its isoform composition.

## Core Workflow

### 1. Data Preparation
Input data must be a `SummarizedExperiment`, `DESeqDataSet`, or a count matrix. 
**Critical Requirement:** Row names must follow the `gene:transcript` format (e.g., "ENSG000001:ENST000001").

```r
library(pairedGSEA)

# Example using internal data
data("example_se")

# Define experiment parameters
group_col <- "group_nr"   # Metadata column for comparison
sample_col <- "id"         # Metadata column for sample IDs
baseline <- 1              # Control group level
case <- 2                  # Treatment group level
experiment_title <- "My_Experiment"
```

### 2. Paired Differential Analysis
The `paired_diff` function executes both DGE and DGS analyses. By default, it uses `DESeq2` for expression and `DEXSeq` for splicing.

```r
diff_results <- paired_diff(
    object = example_se,
    group_col = group_col,
    sample_col = sample_col,
    baseline = baseline,
    case = case,
    experiment_title = experiment_title,
    store_results = TRUE, # Recommended to save transcript-level RDS files
    run_sva = TRUE        # Accounts for surrogate variables automatically
)
```
*Note: `DEXSeq` can be computationally intensive (20-30 minutes for typical datasets).*

### 3. Over-Representation Analysis (ORA)
Compare the biological pathways enriched in DGE versus DGS.

```r
# 1. Prepare gene sets (e.g., MSigDB)
gene_sets <- prepare_msigdb(
    species = "Homo sapiens", 
    collection = "C5", 
    gene_id_type = "ensembl_gene"
)

# 2. Run ORA
ora_results <- paired_ora(
    paired_diff_result = diff_results,
    gene_sets = gene_sets,
    cutoff = 0.05
)
```

### 4. Visualization
Visualize the relationship between expression and splicing enrichment scores.

```r
plot_ora(
    ora_results,
    pattern = "Cell Cycle", # Highlight specific pathways
    plotly = FALSE,         # Set to TRUE for interactive exploration
    cutoff = 0.05
)
```

## Advanced Options
- **Alternative Backend:** Use `use_limma = TRUE` in `paired_diff` to utilize `limma::eBayes` and `limma::diffSplice` for faster execution.
- **Covariates:** Pass a character vector to the `covariates` argument to include batch effects or other metadata in the model.
- **IsoformSwitchAnalyzeR:** Use `importPairedGSEA()` and `exportToPairedGSEA()` to move data between these packages for functional isoform analysis.

## Reference documentation
- [User Guide](./references/User-Guide.md)
- [User Guide RMarkdown](./references/User-Guide.Rmd)