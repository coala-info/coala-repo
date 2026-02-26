---
name: bioconductor-cbaf
description: The bioconductor-cbaf package automates the retrieval, statistical analysis, and visualization of genomic data from cBioPortal across multiple cancer studies. Use when user asks to identify available cancer studies, compare gene groups across clinical subgroups, perform cross-cancer genomic comparisons, or generate heatmaps and Excel reports from cBioPortal data.
homepage: https://bioconductor.org/packages/release/bioc/html/cbaf.html
---


# bioconductor-cbaf

## Overview
The `cbaf` package automates the retrieval and analysis of high-throughput genomic data from cBioPortal. It simplifies the complex multi-step process of querying the cBioPortal API, calculating statistics for specific gene lists across various cancer studies, and generating standardized outputs like heatmaps and Excel files. It is particularly useful for comparative oncology and identifying candidate genes across different cancer types or clinical subgroups.

## Core Workflows

### 1. Data Discovery
Before analysis, use `availableData()` to identify which cancer studies contain the specific high-throughput data types you need.

```r
library(cbaf)

# Generate an Excel file listing all available studies and their data types
availableData("my_study_list_2024")

# Or, find one representative study for a specific technique
rna_studies <- availableData("rna_list", oneOfEach = "RNA-Seq")
```

### 2. Analyzing a Single Study (Subgroup Comparison)
Use `processOneStudy()` to compare gene groups across different cohorts (e.g., different stages or subtypes) within a single cancer study.

```r
genes <- list(
  KDM_family = c("KDM1A", "KDM1B", "KDM2A"),
  Methyl_family = c("SUV39H1", "SUV39H2")
)

processOneStudy(
  genesList = genes,
  submissionName = "breast_subgroups",
  studyName = "Breast Invasive Carcinoma (TCGA, Cell 2015)",
  desiredTechnique = "RNA-Seq",
  desiredCaseList = c(2, 3, 4, 5), # Indices of subgroups
  calculate = c("frequencyPercentage", "meanValue")
)
```

### 3. Analyzing Multiple Studies (Cross-Cancer Comparison)
Use `processMultipleStudies()` to compare gene groups across a variety of different cancer types.

```r
studies <- c(
  "Acute Myeloid Leukemia (TCGA, Provisional)",
  "Adrenocortical Carcinoma (TCGA, Provisional)",
  "Breast Invasive Carcinoma (TCGA, Provisional)"
)

processMultipleStudies(
  genesList = genes,
  submissionName = "cross_cancer_analysis",
  studyName = studies,
  desiredTechnique = "RNA-Seq",
  calculate = c("frequencyPercentage", "frequencyRatio"),
  heatmapFileFormat = "PDF"
)
```

## Key Parameters and Tips

### Statistical Calculations (`calculate`)
- `frequencyPercentage`: % of samples exceeding the `cutoff`.
- `frequencyRatio`: Number of samples exceeding cutoff / total samples.
- `meanValue` / `medianValue`: Average/median of samples exceeding the cutoff.

### Cutoff Values
- **Gene Expression (RNA-Seq/Microarray)**: Default is `2.0` (log z-score).
- **Methylation**: Default is `0.8` (observed/expected ratio).

### Visualization Options
- **Ranking**: Use `rankingMethod = "variation"` to highlight genes that differ most between studies, or `"highValue"` for genes consistently high across studies.
- **Gene Limits**: If your gene list is large, use `geneLimit = 50` to prevent cluttered heatmaps.
- **Formatting**: Adjust `RowCex` and `ColCex` for label sizes, and `heatmapColor` (e.g., "RdBu" or "RdGr") for aesthetics.

### Maintenance
If you need to refresh data or clear local caches to ensure you are getting the latest information from cBioPortal, use:
```r
cleanDatabase("my_submission_name")
```

## Reference documentation
- [cbaf: an automated, easy-to-use R package for comparing omic data across multiple cancers](./references/cbaf.md)