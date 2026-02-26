---
name: bioconductor-autonomics
description: The autonomics package provides a unified workflow for omics data analysis, including data ingestion, preprocessing, linear modeling, and visualization. Use when user asks to import and analyze RNAseq, proteomics, or metabolomics data, perform differential expression analysis with limma, or generate volcano and PCA plots.
homepage: https://bioconductor.org/packages/release/bioc/html/autonomics.html
---


# bioconductor-autonomics

## Overview

The `autonomics` package provides a unified, "one-liner" approach to omics data analysis. It wraps complex workflows—including data ingestion into `SummarizedExperiment` objects, normalization, imputation, linear modeling (via `limma`), and visualization—into high-level functions tailored to specific platforms. It is designed to handle complex experimental designs using a flexible formula interface and provides unique visualizations like contrastograms.

## Core Workflow

Most analyses in `autonomics` follow a standard four-step pattern:
1. **Read**: Import raw data (counts, intensities, or ratios) and metadata.
2. **Preprocess**: Log2 transformation, platform-aware imputation, and filtering.
3. **Analyze**: PCA, sample distribution plots, and linear modeling.
4. **Visualize**: Volcano plots and differential expression summaries.

## Platform-Specific Importers

### RNAseq
Use `read_rnaseq_counts()` for count matrices or `read_rnaseq_bams()` for BAM files.
- **Key features**: Automatic TMM scaling, CPM conversion, and `voom` precision weighting.
- **Example**:
  ```r
  object <- read_rnaseq_counts(file = 'counts.txt', fit = 'limma', plot = TRUE)
  ```

### MS Proteomics (MaxQuant)
Use `read_maxquant_proteingroups()` or `read_maxquant_phosphosites()`.
- **Key features**: Handles LFQ intensities or Normalized Ratios; automatically filters contaminants and reverse hits; performs half-normal distribution imputation for missing values.
- **Example**:
  ```r
  object <- read_maxquant_proteingroups(file = 'proteinGroups.txt', plot = TRUE)
  ```

### Metabolon
Use `read_metabolon()` for `.xlsx` files.
- **Key features**: Automatically identifies the "OrigScale" sheet and extracts feature/sample metadata.
- **Example**:
  ```r
  object <- read_metabolon(file = 'data.xlsx', block = 'Subject', plot = TRUE)
  ```

### Somascan
Use `read_somascan()` for `.adat` files.
- **Key features**: Handles the specific row/column orientation of Somascan data and filters for quality control.
- **Example**:
  ```r
  object <- read_somascan(file = 'data.adat', block = 'Subject', plot = TRUE)
  ```

## Advanced Modeling and Contrasts

`autonomics` leverages `limma` for statistical testing. You can define complex designs using the `formula` and `block` arguments:

- **Random Effects**: Use the `block` argument (e.g., `block = 'Subject'`) to account for repeated measures or batch effects via `duplicateCorrelation`.
- **Contrasts**: By default, it fits `~0+subgroup`. You can specify custom contrasts to compare specific levels.
- **Imputation Visualization**: In volcano plots, imputed values are automatically distinguished (typically as triangles) from measured values (circles).

## Tips for Success

- **Subgroup Extraction**: Ensure your sample IDs or sample file contain a "subgroup" column, as this is the default factor used for modeling.
- **Interactive Exploration**: Set `plot = TRUE` in the read functions to immediately generate a multi-panel summary including PCA, density plots, and volcano plots.
- **Feature Annotation**: The package automatically attempts to uncollapse and annotate protein IDs using internal databases or UniProt REST APIs when using MaxQuant importers.

## Reference documentation

- [autonomics: platform-aware analysis](./references/autonomics_platformaware_analysis.md)