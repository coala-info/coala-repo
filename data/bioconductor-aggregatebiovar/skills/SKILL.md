---
name: bioconductor-aggregatebiovar
description: This tool performs pseudo-bulk aggregation of single-cell RNA sequencing data by summing gene counts across subjects and cell types. Use when user asks to aggregate SingleCellExperiment objects into SummarizedExperiment objects, perform pseudo-bulk analysis for multi-subject studies, or prepare single-cell data for differential expression analysis using bulk RNA-seq tools.
homepage: https://bioconductor.org/packages/release/bioc/html/aggregateBioVar.html
---

# bioconductor-aggregatebiovar

name: bioconductor-aggregatebiovar
description: Use this skill to perform "pseudo-bulk" aggregation of single-cell RNA sequencing (scRNA-seq) data for multi-subject analysis. This skill is essential for organizing SingleCellExperiment objects into SummarizedExperiment objects stratified by cell type and subject, enabling the use of robust bulk RNA-seq tools (like DESeq2) for differential expression analysis while accounting for biological replication.

# bioconductor-aggregatebiovar

## Overview

The `aggregateBioVar` package addresses the challenge of biological replication in scRNA-seq data. While many tools compare cells within a single sample, `aggregateBioVar` facilitates comparisons between subjects and populations (e.g., healthy vs. diseased). It works by aggregating gene counts within subjects for specific cell types—a process often called "pseudo-bulk" analysis. This approach reduces false positives in differential expression (DGE) analysis by treating the subject, rather than the individual cell, as the unit of replication.

## Core Workflow

### 1. Data Preparation
The input must be a `SingleCellExperiment` (SCE) object. Ensure your metadata (`colData`) contains:
- A subject identifier (e.g., `orig.ident`, `SubjectID`).
- A cell type classification (e.g., `celltype`, `cluster`).

```r
library(aggregateBioVar)
library(SingleCellExperiment)

# Inspect your SCE object
# small_airway is a built-in example dataset
small_airway
```

### 2. Aggregating Counts and Metadata
The primary function is `aggregateBioVar()`. It performs two main tasks:
- Sums gene counts across all cells belonging to the same subject within a cell type.
- Collates metadata to retain only inter-subject variables (removing cell-specific variables like UMI counts).

```r
# subjectVar: column in colData identifying the biological replicate
# cellVar: column in colData identifying the cell type
aggregate_list <- aggregateBioVar(
    scExp = small_airway,
    subjectVar = "orig.ident", 
    cellVar = "celltype"
)

# The output is a list of SummarizedExperiment objects
# Element 1: "AllCells" (aggregated across all cells)
# Subsequent elements: One per cell type (e.g., aggregate_list$`Secretory cell`)
```

### 3. Differential Expression Analysis (DGE)
Once aggregated, the data is compatible with standard bulk RNA-seq tools like `DESeq2`.

```r
library(DESeq2)

# Extract the SummarizedExperiment for a specific cell type
se_secretory <- aggregate_list$`Secretory cell`

# Create DESeq2 object
dds <- DESeqDataSet(se_secretory, design = ~ Genotype)

# Run DGE
dds <- DESeq(dds)
res <- results(dds, contrast = c("Genotype", "WT", "CFTRKO"))
```

## Helper Functions

If you need to perform steps manually or on specific subsets:
- `countsBySubject(scExp, subjectVar)`: Returns a DataFrame of gene-by-subject counts.
- `subjectMetaData(scExp, subjectVar)`: Returns a DataFrame of summarized inter-subject metadata.
- `summarizedCounts(scExp, subjectVar)`: Returns a single `SummarizedExperiment` object for the provided SCE (without cell-type stratification).

## Tips for Success
- **Assay Selection**: `aggregateBioVar` uses the **first assay slot** by default. Ensure your raw counts are in the first slot or subset the SCE accordingly.
- **Factor Levels**: When running DGE after aggregation, ensure your design variables (like Genotype) are factors with the correct reference levels.
- **Filtering**: It is often beneficial to filter out lowly expressed genes at the SCE level before aggregation to improve computational efficiency.

## Reference documentation

- [Multi-subject scRNA-seq Analysis](./references/multi-subject-scRNA-seq.md)
- [Multi-subject scRNA-seq Analysis (RMarkdown Source)](./references/multi-subject-scRNA-seq.Rmd)