---
name: bioconductor-curatedtbdata
description: This tool provides access to a standardized collection of curated tuberculosis transcriptomic studies and clinical metadata from the Bioconductor curatedTBData package. Use when user asks to browse available TB datasets, download gene expression profiles, subset data by clinical annotations, or integrate multiple studies with batch correction and gene symbol updates.
homepage: https://bioconductor.org/packages/release/data/experiment/html/curatedTBData.html
---


# bioconductor-curatedtbdata

name: bioconductor-curatedtbdata
description: Access, integrate, and analyze curated tuberculosis (TB) transcriptomic studies from the Bioconductor curatedTBData package. Use this skill when a user needs to: (1) Browse available TB transcriptomic datasets, (2) Download curated gene expression profiles and clinical metadata, (3) Merge multiple TB studies while handling gene symbol updates, (4) Perform batch correction across integrated datasets, or (5) Subset TB data based on clinical annotations like TB status, HIV status, or diabetes.

# bioconductor-curatedtbdata

## Overview
The `curatedTBData` package provides access to a standardized collection of tuberculosis (TB) transcriptomic studies (49 studies in the initial release). It streamlines the process of downloading, subsetting, and integrating gene expression data from different cohorts, facilitating the comparison of TB gene signatures across multiple datasets. Data is typically returned as `MultiAssayExperiment` or `SummarizedExperiment` objects.

## Core Workflow

### 1. Exploring Available Studies
Before downloading, use the `DataSummary` table to identify relevant studies based on technology (Microarray/RNA-seq), tissue, or clinical variables.

```r
library(curatedTBData)
data("DataSummary", package = "curatedTBData")

# View available studies
head(DataSummary[, c("Study", "Resources", "Disease", "Organism")])
```

### 2. Accessing Data
The `curatedTBData()` function retrieves data from ExperimentHub.

*   `study_name`: A character vector of study IDs (e.g., "GSE19439").
*   `dry.run`: Set to `TRUE` to see what will be downloaded without actually downloading.
*   `curated.only`: Set to `TRUE` to download only the curated, ready-to-use gene expression and clinical data. Set to `FALSE` to include raw data and reprocessed RNA-seq assays.

```r
# Download curated data for specific studies
my_studies <- c("GSE19435", "GSE19439")
object_list <- curatedTBData(my_studies, dry.run = FALSE, curated.only = TRUE)
```

### 3. Subsetting Data
You can subset `MultiAssayExperiment` objects using standard bracket notation or the specialized `subset_curatedTBData()` function.

```r
# Subset for Active TB (PTB) and Latent TB (LTBI)
# annotationColName refers to columns in colData(object)
multi_set <- lapply(object_list, function(x) {
  subset_curatedTBData(x, 
                       annotationColName = "TBStatus",
                       annotationCondition = c("LTBI", "PTB"), 
                       assayName = "assay_curated")
})

# Remove NULLs (studies that didn't meet the condition)
multi_set <- multi_set[!sapply(multi_set, is.null)]
```

### 4. Integrating Multiple Studies
Use `combine_objects()` to merge different studies into a single `SummarizedExperiment` based on common gene symbols.

```r
# Combine studies using the curated assay
# update_genes = TRUE ensures gene symbols are mapped correctly
merged_tb <- combine_objects(object_list, 
                             experiment_name = "assay_curated",
                             update_genes = TRUE)

# Check the source studies in the merged object
table(colData(merged_tb)$Study)
```

### 5. Batch Correction
When merging studies, it is highly recommended to remove batch effects (where each study is treated as a batch).

```r
library(sva)
batch_info <- colData(merged_tb)$Study
combat_data <- ComBat(dat = assay(merged_tb), batch = batch_info)

# Add corrected data back to the object
assays(merged_tb)[["Batch_corrected"]] <- combat_data
```

## Tips and Best Practices
*   **Assay Types**: 
    *   `assay_curated`: Normalized, curated gene expression matrix.
    *   `assay_raw`: Raw expression data (often a `SummarizedExperiment`).
    *   `assay_reprocess`: RNA-seq data reprocessed from FASTQ files (available when `curated.only = FALSE`).
*   **Study Exclusion**: Studies like `GSE74092` (qPCR) are often excluded from large-scale integration because they lack the genome-wide coverage of Microarray or RNA-seq.
*   **Gene Symbols**: Always set `update_genes = TRUE` in `combine_objects()` to handle varying gene nomenclature across older and newer studies.

## Reference documentation
- [curatedTBData](./references/curatedTBData.md)
- [curatedTBData Vignette](./references/curatedTBData.Rmd)