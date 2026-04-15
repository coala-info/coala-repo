---
name: bioconductor-metaseqr2
description: bioconductor-metaseqr2 is a modular RNA-Seq analysis pipeline that performs normalization, differential expression, and meta-analysis using multiple statistical algorithms. Use when user asks to perform gene, transcript, or exon-level differential expression analysis, combine results from multiple statistical tests using the PANDORA algorithm, or build local annotation databases for genomic analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/metaseqR2.html
---

# bioconductor-metaseqr2

name: bioconductor-metaseqr2
description: Comprehensive RNA-Seq data analysis pipeline for normalization, differential expression, and meta-analysis using multiple statistical algorithms (PANDORA). Use when performing gene, transcript, or exon-level differential expression analysis, combining p-values from multiple statistical tests, or building local annotation databases for genomic analysis.

# bioconductor-metaseqr2

## Overview
The `metaseqR2` package is a modular pipeline for RNA-Seq data analysis. Its primary strength is the PANDORA algorithm, which combines results from multiple statistical tests (e.g., DESeq2, edgeR, limma, ABSSeq, DSS) by weighting them based on performance with simulated data. It supports various sequencing protocols, including total RNA-Seq, polyA RNA-Seq, and 3' UTR sequencing (Lexogen Quant-Seq).

## Core Workflow

### 1. Annotation Management
`metaseqR2` uses a local SQLite database to manage genomic annotations, which improves reproducibility and speed.

```r
library(metaseqR2)

# Build a local database for specific organisms and sources
# Supported: hg38, mm10, rn6, dm6, etc.
my_db <- file.path(tempdir(), "annotation.sqlite")
buildAnnotationDatabase(
    organisms = list(mm10 = 100), # mm10 Ensembl version 100
    sources = c("ensembl", "refseq"),
    db = my_db
)

# Load annotation as GRanges
genes <- loadAnnotation(genome="mm10", refdb="ensembl", level="gene", type="gene", db=my_db)
```

### 2. Running the Pipeline
The main function `metaseqr2` handles filtering, normalization, statistical testing, and report generation.

```r
# Basic setup
sample_list <- list(control = c("C1", "C2"), treated = c("T1", "T2"))
contrasts <- c("treated_vs_control")

result <- metaseqr2(
    counts = count_matrix,
    sampleList = sample_list,
    contrast = contrasts,
    org = "mm10",
    countType = "gene",      # gene, exon, or utr
    transLevel = "gene",     # gene, transcript, or exon
    normalization = "edger", # edger, deseq2, edaseq, etc.
    statistics = c("edger", "deseq2"),
    metaP = "fisher",        # p-value combination method
    exportWhere = "results_folder",
    qcPlots = c("mds", "boxplot", "volcano", "correl")
)
```

### 3. P-value Combination (PANDORA)
To use the PANDORA method, you must first estimate weights or use pre-calculated ones.

```r
# Estimate weights based on your specific dataset
weights <- estimateAufcWeights(
    counts = count_matrix,
    normalization = "edaseq",
    statistics = c("edger", "limma"),
    modelOrg = "mm10"
)

# Use weights in the main pipeline
result <- metaseqr2(
    ...,
    statistics = c("edger", "limma"),
    metaP = "pandora",
    pweight = weights
)
```

## Analysis Types
- **Total RNA-Seq**: `countType="gene"`, `transLevel="gene"`
- **Differential Exon Usage**: `countType="gene"`, `transLevel="exon"`
- **3' UTR Sequencing**: `countType="utr"`, `transLevel="transcript"`

## Key Parameters
- `annotation`: Set to `"embedded"` if counts contain annotation columns, or provide a list for custom GTF files.
- `whenApplyFilter`: `"prenorm"` (filter before normalization) or `"postnorm"` (default).
- `preset`: Use `"medium_normal"`, `"heavy_strict"`, etc., for quick configuration of filtering and statistical thresholds.

## Tips for Success
- **Seed Setting**: Always use `set.seed()` before running `metaseqr2` to ensure reproducibility of downsampled QC plots.
- **Custom Annotations**: Use `buildCustomAnnotation` to import GTF files for non-standard organisms.
- **Interactive Reports**: The pipeline produces a self-contained HTML report. Ensure an internet connection is available during the first run to download required JS libraries (Highcharts, Plotly).

## Reference documentation
- [Building an annotation database for metaseqR2](./references/metaseqr2-annotation.md)
- [RNA-Seq data analysis with metaseqR2](./references/metaseqr2-statistics.md)