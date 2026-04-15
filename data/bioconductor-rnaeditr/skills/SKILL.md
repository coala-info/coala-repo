---
name: bioconductor-rnaeditr
description: Bioconductor-rnaeditr identifies differentially edited RNA genomic sites and regions in RNA-seq datasets. Use when user asks to analyze associations between RNA editing levels and phenotypes, identify co-edited genomic sub-regions, or perform site-specific and region-based statistical testing.
homepage: https://bioconductor.org/packages/release/bioc/html/rnaEditr.html
---

# bioconductor-rnaeditr

name: bioconductor-rnaeditr
description: Identify differentially edited RNA genomic sites and regions in RNA-seq data. Use this skill to analyze associations between RNA editing levels and continuous, binary, or survival phenotypes, including identifying co-edited sub-regions and performing site-specific or region-based statistical testing.

## Overview
`rnaEditr` is a Bioconductor package designed to identify genomic sites and regions that are differentially edited in RNA-seq datasets. It supports complex study designs including multiple covariates and interaction effects. The package is unique in its ability to identify "co-edited" regions—clusters of sites where editing levels are correlated—before testing for associations with phenotypes.

## Core Workflow

### 1. Data Preparation
The package requires two primary inputs:
- **RNA Editing Matrix**: Rows are sites (e.g., "chr1:28661572"), columns are samples. Values range from 0 to 1.
- **Phenotype Data**: A data frame with a `sample` column matching the column names of the editing matrix.

```r
library(rnaEditr)
data(rnaedit_df) # Example editing matrix

# Convert to the required rnaEdit_df class
rnaedit_table <- CreateEditingTable(rnaEditMatrix = rnaedit_df)
```

### 2. Site-Specific Analysis
Use this to test every individual editing site against a phenotype.

```r
results_site <- TestAssociations(
  rnaEdit_df = rnaedit_table,
  pheno_df = pheno_df,
  responses_char = "sample_type", # Phenotype column
  respType = "binary",            # "binary", "continuous", or "survival"
  orderByPval = TRUE
)

# Annotate with gene symbols
annotated_site <- AnnotateResults(
  results_df = results_site,
  genome = "hg19",
  analysis = "site-specific"
)
```

### 3. Region-Based Analysis
This multi-step process identifies clusters of sites that behave similarly.

1.  **Define Input Regions**: Create a GRanges object of genes or genomic ranges.
    ```r
    input_gr <- TransformToGR(genes_char = c("PHACTR4", "CCR5"), type = "symbol", genome = "hg19")
    ```
2.  **Find Close-by Regions**: Identify sub-regions with clusters of sites (default: $\ge 3$ sites within 50bp).
    ```r
    closeby_gr <- AllCloseByRegions(regions_gr = input_gr, rnaEditMatrix = rnaedit_df)
    ```
3.  **Identify Co-edited Regions**: Filter for regions where editing levels are correlated.
    ```r
    coedited_gr <- AllCoeditedRegions(regions_gr = closeby_gr, rnaEditMatrix = rnaedit_df)
    ```
4.  **Summarize and Test**: Calculate a single value (e.g., median) for the region and test association.
    ```r
    summarized_df <- SummarizeAllRegions(regions_gr = coedited_gr, rnaEditMatrix = rnaedit_df, selectMethod = MedianSites)
    
    results_region <- TestAssociations(
      rnaEdit_df = summarized_df,
      pheno_df = pheno_df,
      responses_char = "sample_type",
      respType = "binary"
    )
    ```

## Key Functions and Parameters

- `TestAssociations()`: The main engine for statistical testing.
    - `respType`: Set to "binary" (uses logistic regression), "continuous" (linear regression), or "survival" (Cox proportional hazards).
    - `covariates_char`: Character vector of column names in `pheno_df` to adjust for.
- `AllCoeditedRegions()`: Uses `rDropThresh_num` (default 0.4) to ensure each site correlates with the mean of others in the cluster.
- `AnnotateResults()`: Maps genomic coordinates to gene symbols using internal hg19 or hg38 references.

## Tips for Success
- **Sample Matching**: Ensure `identical(pheno_df$sample, colnames(rnaedit_df))` is TRUE before starting.
- **Binary Outcomes**: If a group has $< 10$ samples, the package automatically applies Firth corrected logistic regression to handle separation issues.
- **Survival Data**: For `respType = "survival"`, `responses_char` must be a vector of length 2: `c("time_column", "status_column")`.
- **Visualization**: Use `PlotEditingCorrelations(region_gr, rnaEditMatrix)` to visualize the correlation structure of a specific co-edited region.

## Reference documentation
- [Introduction to rnaEditr](./references/introduction_to_rnaEditr.md)
- [Introduction to rnaEditr (Rmd)](./references/introduction_to_rnaEditr.Rmd)