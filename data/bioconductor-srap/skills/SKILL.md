---
name: bioconductor-srap
description: This tool provides a simplified pipeline for end-to-end RNA-Seq gene expression analysis, including normalization, quality control, and differential expression. Use when user asks to normalize RPKM values, perform PCA or clustering for quality control, identify differentially expressed genes, or calculate functional enrichment using the BD-Func algorithm.
homepage: https://bioconductor.org/packages/3.6/bioc/html/sRAP.html
---


# bioconductor-srap

name: bioconductor-srap
description: Simplified RNA-Seq Analysis Pipeline (sRAP) for gene expression analysis. Use this skill to perform end-to-end RNA-Seq workflows including RPKM normalization, quality control (PCA, clustering), differential expression analysis (ANOVA/Linear regression), and functional enrichment using the BD-Func algorithm.

## Overview

The `sRAP` package provides a streamlined pipeline for analyzing gene expression data, specifically optimized for RNA-Seq RPKM values. It automates the creation of project folders and subdirectories (Raw Data, QC, DEG, BD-Func) to organize analysis outputs. While normalization is RNA-Seq specific, the downstream QC, differential expression, and functional enrichment functions can be applied to any gene expression matrix.

## Core Workflow

### 1. Data Preparation and Normalization
The pipeline typically starts with a table of RPKM/FPKM values.

```R
library(sRAP)

# Define project parameters
project.name <- "MyProject"
project.folder <- getwd()
expression.table <- "path/to/RPKM_table.txt"

# Normalize: Rounds values (default < 0.1) and performs log2 transformation
expression.mat <- RNA.norm(expression.table, project.name, project.folder)
```

If you do not have an RPKM table, use `RNA.prepare.input()` to generate one from raw counts or similar inputs.

### 2. Quality Control
Generate PCA plots, dendrograms, histograms, and box-plots to identify outliers and assess data distribution.

```R
sample.table <- "path/to/Sample_Description.txt"

RNA.qc(sample.table, expression.mat, project.name, project.folder, 
       plot.legend = FALSE, 
       color.palette = c("blue", "red"))
```

### 3. Differential Expression Analysis (DEG)
Identify genes with significant changes between groups. This function generates Excel lists and heatmaps.

```R
# method can be "aov" (ANOVA) or "lm" (Linear Regression)
stat.table <- RNA.deg(sample.table, expression.mat, project.name, project.folder,
                      box.plot = FALSE, 
                      ref.group = TRUE, 
                      ref = "control_group_name",
                      method = "aov")
```

### 4. Functional Enrichment (BD-Func)
Calculate enrichment for pathways or Gene Ontology categories using the Bi-Directional FUNCtional enrichment algorithm.

**Option A: Based on Fold-Change**
```R
RNA.bdfunc.fc(stat.table, project.name, project.folder, 
              species = "human", plot.flag = TRUE)
```

**Option B: Based on Signal Intensity**
```R
RNA.bdfunc.signal(expression.mat, sample.table, project.name, project.folder, 
                  species = "human", plot.flag = TRUE)
```

## Key Functions and Parameters

- `RNA.norm()`: Normalizes RNA-Seq data. Output is a matrix with samples in rows and genes in columns.
- `RNA.deg()`: Performs statistical testing. Requires a sample description table where the second column defines the primary variable/grouping.
- `species`: Supported values are "human" (GO + MSigDB) and "mouse" (GO). Custom lists can be provided via the `enrichment.file` parameter.
- `color.palette`: A character vector of colors used for groups in plots.

## Tips for Success
- **File Paths**: Ensure `project.folder` exists; the package will create subfolders within it automatically.
- **Sample Table**: The sample description file should be a tab-delimited text file. The first column must match sample names in the expression matrix, and the second column should contain group assignments.
- **Log Scale**: `RNA.deg` and `RNA.bdfunc` functions assume data is on a log2 scale. If using `RNA.norm`, this is handled automatically.

## Reference documentation
- [sRAP: Simplified RNA-Seq Analysis Pipeline](./references/sRAP.md)