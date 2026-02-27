---
name: bioconductor-rnaseqr
description: This tool provides an automated six-step pipeline for conducting end-to-end RNA-Seq analysis and two-group comparisons in R. Use when user asks to set up an RNA-Seq environment, perform read alignment and quantification, identify differentially expressed genes, or conduct GO and KEGG functional enrichment analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/RNASeqR.html
---


# bioconductor-rnaseqr

name: bioconductor-rnaseqr
description: Automated RNA-Seq analysis pipeline for two-group comparisons. Use this skill to perform end-to-end transcriptomic analysis in R, including environment setup, quality assessment, read alignment (HISAT2/STAR), quantification (StringTie), differential expression (DESeq2, edgeR, ballgown), and functional enrichment (GO/KEGG).

# bioconductor-rnaseqr

## Overview
The `RNASeqR` package provides an automated, six-step workflow for conducting RNA-Seq analysis based on a single independent variable (case vs. control). It integrates popular bioinformatics tools into a unified R interface, generating comprehensive reports and visualizations. The pipeline is designed for Linux and macOS environments.

## Core Workflow

### 1. Parameter Initialization
Create an `RNASeqRParam` object to define the experimental design and file paths. This object is required for all subsequent functions.

```r
library(RNASeqR)

# Define paths
input_path <- "path/to/input_files"
output_path <- "path/to/results"

# Create parameter object
exp <- RNASeqRParam(
  path.prefix = output_path,
  input.path.prefix = input_path,
  genome.name = "Saccharomyces_cerevisiae",
  sample.pattern = "SRR[0-9]*",
  independent.variable = "treatment",
  case.group = "treated",
  control.group = "untreated",
  fastq.gz.type = "PE" # "PE" for paired-end, "SE" for single-end
)
```

### 2. Environment Setup
Install necessary binaries (HISAT2, StringTie, Gffcompare) and create the directory structure.

```r
# Run in R shell
RNASeqEnvironmentSet(exp)

# Or run in background (creates .R script and .Rout log)
RNASeqEnvironmentSet_CMD(exp)
```

### 3. Quality Assessment (Optional)
Generate a quality report for raw FASTQ files using `systemPipeR`.

```r
RNASeqQualityAssessment(exp)
```

### 4. Read Alignment and Quantification
Processes raw reads through alignment, assembly, and quantification. Supports HISAT2 (default) or STAR.

```r
# Default HISAT2 workflow
RNASeqReadProcess(exp)

# Using STAR instead of HISAT2
RNASeqReadProcess(exp, 
                  STAR.Alignment.run = TRUE, 
                  Hisat2.Index.run = FALSE, 
                  Hisat2.Alignment.run = FALSE)
```

### 5. Differential Expression Analysis
Performs statistical testing using `DESeq2`, `edgeR`, and `ballgown`. Results include volcano plots, heatmaps, and PCA.

```r
RNASeqDifferentialAnalysis(exp)
```

### 6. Functional Analysis
Performs GO and KEGG enrichment analysis on identified DEGs using `clusterProfiler`.

```r
RNASeqGoKegg(exp, 
             OrgDb.species = "org.Sc.sgd.db", 
             go.level = 3, 
             input.TYPE.ID = "GENENAME",
             KEGG.organism = "sce")
```

## Input File Requirements
The `input.path.prefix` directory must contain:
- **genome.name.fa**: Reference genome.
- **genome.name.gtf**: Gene annotations.
- **raw_fastq.gz/**: Folder containing `.fastq.gz` files.
- **phenodata.csv**: A CSV with three columns: `ids` (matching sample patterns), `independent.variable` (group names), and `color` (HEX codes for visualization).
- **indices/**: (Optional) Pre-built HISAT2 indices.

## Tips for Success
- **Operating System**: This package does not support Windows due to dependencies on HISAT2 and StringTie.
- **Python Dependency**: Ensure Python (2 or 3) is available for the `prepDE.py` step to generate count matrices for DESeq2 and edgeR.
- **Memory**: Indexing large genomes (like Human) requires significant RAM (>160GB). Use pre-built indices if possible.
- **Background Execution**: Use the `_CMD` suffix versions of functions for long-running tasks to prevent R session timeouts.

## Reference documentation
- [RNA-Seq analysis based on one independent variable](./references/RNASeqR.Rmd)
- [RNASeqR Vignette](./references/RNASeqR.md)