---
name: bioconductor-tcgabiolinks
description: TCGAbiolinks provides a comprehensive pipeline for searching, downloading, and analyzing cancer genomic data from the GDC portal. Use when user asks to download TCGA datasets, perform differential expression or methylation analysis, conduct survival analysis, or integrate multi-omics data using starburst plots.
homepage: https://bioconductor.org/packages/release/bioc/html/TCGAbiolinks.html
---


# bioconductor-tcgabiolinks

name: bioconductor-tcgabiolinks
description: Expert guidance for using the TCGAbiolinks R package to search, download, and analyze TCGA data from the GDC portal. Use this skill when performing genomic data analysis including differential expression (DEA), differential methylation (DMR), survival analysis, and multi-omics integration (starburst plots) using Bioconductor.

# bioconductor-tcgabiolinks

## Overview
`TCGAbiolinks` is a Bioconductor package designed to facilitate the analysis of Cancer Genome Atlas (TCGA) data. It provides a complete pipeline for data acquisition from the Genomic Data Commons (GDC), preprocessing, normalization, and downstream analysis. Key capabilities include identifying differentially expressed genes, differentially methylated regions, performing functional enrichment, and visualizing results through heatmaps, volcano plots, and survival curves.

## Core Workflow

### 1. Data Acquisition
The standard workflow begins with querying, downloading, and preparing data into a `SummarizedExperiment` object.

```r
library(TCGAbiolinks)

# Query for RNA-Seq data
query <- GDCquery(
    project = "TCGA-BRCA",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts",
    sample.type = c("Primary Tumor", "Solid Tissue Normal")
)

# Download and Prepare
GDCdownload(query)
data <- GDCprepare(query)
```

### 2. Preprocessing and Normalization
Before analysis, data must be filtered for outliers and normalized for GC content or sequencing depth.

```r
# Preprocessing to find outliers
dataPrep <- TCGAanalyze_Preprocessing(object = data, cor.cut = 0.6)

# Normalization (e.g., gcContent)
dataNorm <- TCGAanalyze_Normalization(tabDF = dataPrep, geneInfo = geneInfoHT, method = "gcContent")

# Filtering low signal genes
dataFilt <- TCGAanalyze_Filtering(tabDF = dataNorm, method = "quantile", qnt.cut = 0.25)
```

### 3. Differential Expression Analysis (DEA)
Identify genes with significant changes between conditions (e.g., Tumor vs. Normal).

```r
# Define sample groups
samplesNT <- TCGAquery_SampleTypes(barcode = colnames(dataFilt), typesample = "NT")
samplesTP <- TCGAquery_SampleTypes(barcode = colnames(dataFilt), typesample = "TP")

# Perform DEA
dataDEGs <- TCGAanalyze_DEA(
    mat1 = dataFilt[,samplesNT],
    mat2 = dataFilt[,samplesTP],
    Cond1type = "Normal",
    Cond2type = "Tumor",
    fdr.cut = 0.01,
    logFC.cut = 1,
    method = "glmLRT"
)
```

### 4. Survival Analysis
Correlate clinical data with genomic features or clusters.

```r
clinical <- GDCquery_clinic(project = "TCGA-BRCA", type = "clinical")

TCGAanalyze_survival(
    data = clinical,
    clusterCol = "gender", # Column for grouping
    main = "Survival Analysis",
    pvalue = TRUE
)
```

### 5. Integration: Starburst Plots
Combine DNA methylation and gene expression data to identify biologically significant genes.

```r
starburst <- TCGAvisualize_starburst(
    met = dataMet, # SummarizedExperiment from methylation query
    exp = dataDEGs, # Result from DEA
    genome = "hg38",
    met.platform = "450K",
    met.p.cut = 10^-5,
    exp.p.cut = 10^-5,
    names = TRUE
)
```

## Key Functions Reference
- `GDCquery()`: Search GDC data by project, category, and platform.
- `GDCdownload()`: Download the queried data to local storage.
- `GDCprepare()`: Transform downloaded data into a `SummarizedExperiment` object.
- `TCGAanalyze_DEA()`: Perform differential expression using edgeR.
- `TCGAanalyze_DMC()`: Identify differentially methylated CpGs.
- `TCGAanalyze_EAcomplete()`: Perform Gene Ontology and Pathway enrichment.
- `TCGAvisualize_Heatmap()`: Generate complex heatmaps with metadata bars.

## Reference documentation
- [Analysis functions](./references/analysis.md)
- [Case Studies](./references/casestudy.md)
- [Glioma classifier](./references/classifiers.md)
- [Clinical data](./references/clinical.md)
- [Download and Prepare](./references/download_prepare.md)
- [Other functions](./references/extension.md)
- [Introduction](./references/index.md)
- [Mutation data](./references/mutation.md)
- [Query data](./references/query.md)
- [Stemness score](./references/stemness_score.md)
- [Molecular subtypes](./references/subtypes.md)