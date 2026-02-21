---
name: bioconductor-abaenrichment
description: The package ABAEnrichment is designed to test for enrichment of user defined candidate genes in the set of expressed genes in different human brain regions. The core function 'aba_enrich' integrates the expression of the candidate gene set (averaged across donors) and the structural information of the brain using an ontology, both provided by the Allen Brain Atlas project. 'aba_enrich' interfaces the ontology enrichment software FUNC to perform the statistical analyses. Additional functions provided in this package like 'get_expression' and 'plot_expression' facilitate exploring the expression data. From version 1.3.5 onwards genomic regions can be provided as input, too; and from version 1.5.9 onwards the function 'get_annotated_genes' offers an easy way to obtain annotations of genes to enriched or user-defined brain regions.
homepage: https://bioconductor.org/packages/3.6/bioc/html/ABAEnrichment.html
---

# bioconductor-abaenrichment

name: bioconductor-abaenrichment
description: Perform gene expression enrichment analysis in human brain regions using the Allen Brain Atlas. Use this skill when you need to test if a set of candidate genes (or genomic regions) is specifically expressed in certain brain structures across different developmental stages or in the adult brain.

## Overview

The `ABAEnrichment` package tests for the enrichment of user-defined genes in specific human brain regions. It integrates expression data from the Allen Brain Atlas with structural ontologies. The package supports various statistical tests (hypergeometric, Wilcoxon, binomial, contingency) and allows for analysis across five developmental stages or in adult brains.

## Core Workflow

### 1. Prepare Input Data
The primary input is a `data.frame` where the first column contains gene identifiers (Entrez, Ensembl, or Symbols). The second column depends on the test type:
- **Hypergeometric (`test='hyper'`)**: 1 for candidate genes, 0 for background.
- **Wilcoxon (`test='wilcoxon'`)**: A numeric score for each gene.
- **Genomic Regions**: For `test='hyper'`, the first column can be 'chr:start-stop'.

### 2. Run Enrichment Analysis
Use `aba_enrich()` to perform the statistical analysis.

```r
library(ABAEnrichment)

# Example: Hypergeometric test on developmental stages
gene_df <- data.frame(
  genes = c('PENK', 'COCH', 'PDYN', 'CA12', 'SYNDIG1L', 'MME', 'ANO3'),
  is_candidate = c(1, 1, 1, 0, 0, 0, 0)
)

res <- aba_enrich(
  genes = gene_df,
  dataset = '5_stages', # Options: 'adult', '5_stages', 'dev_effect'
  test = 'hyper',
  n_randsets = 1000     # Number of random sets for FWER calculation
)
```

### 3. Explore Results
The output is a list containing:
1. `results`: A dataframe with Family-Wise Error Rates (FWER) per brain region.
2. `genes`: The genes used in the analysis (filtered for availability).
3. `cutoffs`: Expression values corresponding to the quantiles used.

```r
# View top enriched regions for a specific age category
fwers <- res[[1]]
head(fwers[order(fwers$min_FWER), ])
```

## Data Exploration and Visualization

### Identify Brain Regions
Use `get_id()` to find structure IDs by name and `get_name()` to retrieve full names from IDs.

```r
# Find ID for 'thalamus'
get_id('thalamus')

# Get full name for an ID
get_name('Allen:4010')
```

### Retrieve Annotated Genes
To find which specific genes are driving the enrichment in a significant region:

```r
# Get genes expressed in a region at a specific FWER threshold
anno_genes <- get_annotated_genes(res, fwer_threshold = 0.05)
```

### Expression Data and Plotting
Retrieve raw expression matrices or visualize them with heatmaps.

```r
# Get expression matrix
exp_matrix <- get_expression(
  structure_ids = c('Allen:10657', 'Allen:10208'),
  gene_ids = c('PENK', 'PDYN'),
  dataset = '5_stages'
)

# Plot heatmap
plot_expression(
  structure_ids = c('Allen:10657', 'Allen:10208'),
  dataset = '5_stages',
  age_category = 3 # 1=prenatal, 5=adult
)
```

## Tips and Best Practices
- **Ontology Inheritance**: Brain regions inherit expression data from their substructures. Use `get_sampled_substructures()` to see the source of data for a specific region.
- **Developmental Stages**: When using `dataset='5_stages'`, results are grouped into 5 categories (1: prenatal, 2: infant, 3: child, 4: adolescent, 5: adult).
- **Gene Length Bias**: For hypergeometric tests, set `gene_len = TRUE` to account for the fact that longer genes are more likely to be picked by chance.
- **Genomic Regions**: If providing coordinates, ensure `ref_genome` matches your data ('grch37' or 'grch38').

## Reference documentation
- [ABAEnrichment Reference Manual](./references/reference_manual.md)