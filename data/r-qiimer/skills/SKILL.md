---
name: r-qiimer
description: Skill for using the CRAN R package r-qiimer.
homepage: https://cran.r-project.org/web/packages/qiimer/index.html
---

# r-qiimer

name: r-qiimer
description: Use for importing, parsing, and analyzing microbiome data from the QIIME (Quantitative Insights Into Microbial Ecology) pipeline. This skill is essential when working with QIIME mapping files, OTU tables, distance matrices, and taxonomy summaries in R.

# r-qiimer

## Overview
The `qiimer` package provides a suite of tools to bridge the gap between QIIME output files and R's statistical and graphical capabilities. It specializes in parsing the specific tab-delimited formats produced by QIIME 1 and QIIME 2, allowing for seamless integration with standard R data structures and visualization packages like `ggplot2`.

## Installation
To install the package from CRAN:
```R
install.packages("qiimer")
```

## Core Functions and Workflows

### Importing Data
The primary utility of `qiimer` is reading QIIME-formatted files into R data frames or matrices.

*   **Mapping Files (Metadata):**
    ```R
    library(qiimer)
    map <- read_qiime_mapping_table("mapping_file.txt")
    ```
*   **OTU Tables:**
    Reads classic QIIME OTU tables (tab-separated).
    ```R
    otu_data <- read_qiime_otu_table("otu_table.txt")
    # Access components
    counts <- otu_data$counts
    taxonomy <- otu_data$taxonomy
    ```
*   **Distance Matrices:**
    ```R
    dist_mat <- read_qiime_distmat("unweighted_unifrac_dm.txt")
    ```
*   **Taxonomy Summaries:**
    ```R
    tax_sum <- read_qiime_taxa_summary("otu_table_L6.txt")
    ```

### Data Manipulation
*   **Melting OTU Tables:**
    Convert wide-format OTU tables into a long-format data frame suitable for `ggplot2`.
    ```R
    melted_otu <- melt_qiime_otu_table(otu_data)
    ```
*   **Filtering Mapping Tables:**
    Ensure the mapping table matches the samples present in your OTU table or distance matrix.
    ```R
    map <- map[map$SampleID %in% colnames(otu_data$counts), ]
    ```

### Analysis and Visualization Helpers
*   **Distance Groups:**
    Extract distances between specific groups of samples for statistical testing (e.g., within vs. between groups).
    ```R
    dg <- dist_groups(dist_mat, map$Treatment)
    ```
*   **Color Palettes:**
    Generate color schemes consistent with QIIME's default visualizations.
    ```R
    colors <- qiime_colors(n = 5)
    ```

## Tips for Success
1.  **Sample ID Consistency:** Always verify that `SampleID` strings match exactly between your mapping file and OTU table headers. `qiimer` functions generally expect the first column of the mapping file to be `#SampleID`.
2.  **QIIME 2 Compatibility:** While originally designed for QIIME 1, `qiimer` can read QIIME 2 artifacts if they have been exported to TSV format (e.g., using `qiime tools export`).
3.  **Downstream Integration:** Use `melt_qiime_otu_table` to quickly transition into `ggplot2` for creating bar plots of taxonomic abundance.

## Reference documentation
- [qiimer: Work with QIIME Output Files in R](https://cran.r-project.org/web/packages/qiimer/index.html)