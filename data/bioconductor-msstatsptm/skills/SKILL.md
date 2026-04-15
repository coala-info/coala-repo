---
name: bioconductor-msstatsptm
description: MSstatsPTM performs statistical analysis of post-translational modifications by integrating PTM-enriched and global protein abundance data. Use when user asks to analyze differential PTM site occupancy, adjust PTM abundance for global protein changes, or summarize PTM-level mass spectrometry data.
homepage: https://bioconductor.org/packages/release/bioc/html/MSstatsPTM.html
---

# bioconductor-msstatsptm

## Overview

`MSstatsPTM` is an R package designed for the statistical analysis of PTMs. It extends the `MSstats` framework to handle the unique challenges of PTM data, specifically the need to distinguish between changes in PTM site occupancy and changes in the underlying global protein abundance. The package provides automated data converters, protein/PTM summarization, and a linear mixed-effects model for differential analysis.

## Typical Workflow

### 1. Data Preparation and Conversion
`MSstatsPTM` requires two datasets: a PTM-enriched dataset and a global profiling (un-enriched) dataset. Use dedicated converters to format data from common processing tools.

```r
library(MSstatsPTM)

# Example for MaxQuant Label-Free data
# Note: mod_id is a regex matching the modification in the evidence file
raw_data <- MaxQtoMSstatsPTMFormat(
  evidence = maxq_evidence,
  annotation = maxq_annotation,
  fasta = "path/to/fasta.fasta",
  mod_id = "\\(Phospho \\(STY\\)\\)",
  labeling_type = "LF",
  which_proteinid_ptm = "Proteins"
)

# Access formatted tables
ptm_data <- raw_data$PTM
protein_data <- raw_data$PROTEIN
```

### 2. Data Summarization
Summarize feature-level data into PTM-site and protein-level abundances.

```r
# For Label-Free data
summarized_data <- dataSummarizationPTM(
  raw_data, 
  verbose = FALSE
)

# For TMT data
summarized_data_tmt <- dataSummarizationPTM_TMT(
  raw_data_tmt,
  method = "msstats" # or "MedianPolish"
)
```

### 3. Differential Abundance Analysis
The `groupComparisonPTM` function performs three tests:
1. **PTM**: Changes in PTM site abundance (not adjusted).
2. **PROTEIN**: Changes in global protein abundance.
3. **ADJUSTED PTM**: Changes in PTM site abundance adjusted for global protein changes.

```r
# Define comparison matrix
comparison <- matrix(c(-1, 1), nrow = 1)
rownames(comparison) <- "Condition2-Condition1"

results <- groupComparisonPTM(
  summarized_data, 
  contrast.matrix = comparison
)

# View adjusted PTM results
head(results$ADJUSTED.Model)
```

### 4. Visualization
Visualize the results using standard MSstats-style plots.

```r
# Volcano plot for adjusted PTM results
dataProcessPlotsPTM(
  summarized_data, 
  type = "VOLCANOPLOT", 
  address = "PTM_Volcano_"
)
```

## Key Tips
- **ProteinName Column**: In the PTM dataset, the `ProteinName` column must contain both the protein ID and the modification site (e.g., `ProteinA_S105`) to ensure site-specific summarization.
- **Missing Global Data**: If a global profiling run was not performed, you can still use the package by passing `NULL` for the protein data, though you will not be able to calculate "Adjusted PTM" values.
- **Localization**: When using FragPipe or Proteome Discoverer converters, use the `localization_cutoff` parameter (typically 0.75) to filter for high-confidence site assignments.
- **Normalization**: By default, the package performs global standards normalization. Ensure your `annotation` file correctly identifies `Runs` and `Conditions`.

## Reference documentation
- [MSstatsPTM LabelFree Workflow](./references/MSstatsPTM_LabelFree_Workflow.md)
- [MSstatsPTM TMT Workflow](./references/MSstatsPTM_TMT_Workflow.md)