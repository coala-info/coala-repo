---
name: bioconductor-ewce
description: This tool performs Expression Weighted Celltype Enrichment analysis to identify specific cell types enriched in a given gene list using single-cell RNA-seq reference data. Use when user asks to prepare CellTypeDatasets from single-cell data, run bootstrap enrichment tests on gene lists, control for transcript length or GC content, perform conditional enrichment analysis, or analyze bulk transcriptomic data for cell-type signatures.
homepage: https://bioconductor.org/packages/release/bioc/html/EWCE.html
---


# bioconductor-ewce

name: bioconductor-ewce
description: Expression Weighted Celltype Enrichment (EWCE) analysis for testing gene list enrichments in specific cell types using single-cell RNA-seq reference data. Use this skill when you need to: (1) Prepare CellTypeDatasets (CTD) from single-cell data, (2) Run bootstrap enrichment tests on gene lists (GWAS hits, differentially expressed genes), (3) Control for transcript length/GC content, (4) Perform conditional enrichment analysis, or (5) Analyze transcriptomic (bulk) data for cell-type signatures.

# bioconductor-ewce

## Overview
The `EWCE` package is used to determine which cell types are enriched in a given gene list. It works by comparing the average expression of genes in the target list to the expression of randomly sampled gene lists from a background set, weighted by cell-type specificity. It is particularly powerful for interpreting human disease-associated genes using mouse or human single-cell transcriptomic references.

## Core Workflow

### 1. Setup and Data Loading
Load the package and reference data. You can use pre-generated datasets from `ewceData`.

```R
library(EWCE)
library(ewceData)

# Load a standard CellTypeDataset (CTD)
ctd <- ewceData::ctd()

# Load an example gene list (e.g., Alzheimer's hits)
hits <- ewceData::example_genelist()
```

### 2. Prepare a CellTypeDataset (CTD)
If you have your own single-cell data (matrix or SingleCellExperiment), you must convert it to a CTD.

```R
# 1. Fix gene symbols
exp_fixed <- fix_bad_mgi_symbols(exp_matrix)

# 2. Drop uninformative genes (non-varying or non-orthologous)
exp_dropped <- drop_uninformative_genes(
  exp = exp_fixed, 
  input_species = "mouse", 
  output_species = "human", 
  level2annot = annot$level2
)

# 3. Generate the CTD
annotLevels <- list(level1 = annot$level1, level2 = annot$level2)
fNames <- generate_celltype_data(
  exp = exp_dropped, 
  annotLevels = annotLevels, 
  groupName = "MyProject"
)
ctd <- load_rdata(fNames)
```

### 3. Run Enrichment Tests
The primary function is `bootstrap_enrichment_test`.

```R
# Standard enrichment test
results <- bootstrap_enrichment_test(
  sct_data = ctd,
  hits = hits,
  sctSpecies = "mouse",
  genelistSpecies = "human",
  reps = 10000, # Use 100 for testing, 10000 for publication
  annotLevel = 1
)

# View results
print(results$results)
```

### 4. Advanced Enrichment Options
*   **Gene Size Control**: Control for GC content and transcript length (recommended for GWAS lists).
    ```R
    results <- bootstrap_enrichment_test(..., geneSizeControl = TRUE)
    ```
*   **Conditional Enrichment**: Test if enrichment in CellType A is independent of CellType B.
    ```R
    results <- bootstrap_enrichment_test(..., controlledCT = "microglia")
    ```
*   **Transcriptomic (Bulk) Data**: Analyze up/down-regulated genes from a differential expression table.
    ```R
    tt_results <- ewce_expression_data(sct_data = ctd, tt = my_tt_table)
    ```

### 5. Visualization
Visualize the standard deviations from the mean (enrichment magnitude).

```R
plot_list <- ewce_plot(total_res = results$results, mtc_method = "BH")
print(plot_list$plain)
```

## Tips for Success
*   **Species Mapping**: `EWCE` uses `orthogene` internally. Ensure `sctSpecies` (reference) and `genelistSpecies` (input list) are correctly defined.
*   **Annotation Levels**: Level 1 is usually broad (e.g., "Neurons"), Level 2 is specific (e.g., "CA1 Pyramidal").
*   **Parallelization**: Use the `no_cores` argument in `bootstrap_enrichment_test` or `drop_uninformative_genes` to speed up processing.
*   **Background Genes**: By default, the background is all 1:1 orthologs shared between species in the CTD. You can provide a custom background via the `bg` argument.

## Reference documentation
- [Getting started](./references/EWCE.md)
- [Extended examples](./references/extended.md)
- [Getting started (RMarkdown)](./references/EWCE.Rmd)
- [Extended examples (RMarkdown)](./references/extended.Rmd)