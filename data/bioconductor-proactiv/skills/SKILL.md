---
name: bioconductor-proactiv
description: proActiv identifies and quantifies promoter activity from RNA-Seq data to analyze alternative promoter usage. Use when user asks to prepare promoter annotations, quantify promoter activity from BAM or junction files, or identify alternative promoter switching between conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/proActiv.html
---

# bioconductor-proactiv

## Overview
`proActiv` is a Bioconductor package designed to identify and quantify promoter activity using RNA-Seq data. It maps reads to annotated promoters and calculates "promoter activity" based on the total transcription initiated at each site. This allows for the discovery of alternative promoter usage (promoter switching) even when total gene expression remains constant. It supports input from BAM files or junction files (STAR/TopHat2) and provides a streamlined workflow for differential promoter analysis.

## Core Workflow

### 1. Prepare Promoter Annotations
Before quantifying activity, you must create a `PromoterAnnotation` object. This can be done from a GTF file or a `TxDb` object.

```r
library(proActiv)

# From a GTF file
gtf.file <- "path/to/annotation.gtf"
promoterAnnotation <- preparePromoterAnnotation(file = gtf.file, 
                                                 species = "Homo_sapiens")

# From a TxDb object
library(AnnotationDbi)
txdb <- loadDb("path/to/txdb.sqlite")
promoterAnnotation <- preparePromoterAnnotation(txdb = txdb, 
                                                 species = "Homo_sapiens")
```

### 2. Quantify Promoter Activity
The main function `proActiv` processes alignment files and returns a `SummarizedExperiment`.

```r
# Input files (BAM or STAR junction files)
files <- c("sample1.SJ.out.tab", "sample2.SJ.out.tab", ...)

# Define experimental conditions
condition <- c("Control", "Control", "Treated", "Treated")

# Run quantification
result <- proActiv(files = files, 
                   promoterAnnotation = promoterAnnotation,
                   condition = condition)
```

### 3. Accessing Results
The `result` object contains several assays:
- `promoterCounts`: Raw junction counts.
- `absolutePromoterActivity`: Log2-normalized promoter expression.
- `relativePromoterActivity`: Proportion of gene expression contributed by a specific promoter.
- `geneExpression`: Total expression for the gene.

```r
# Access assays
absActivity <- assays(result)$absolutePromoterActivity

# Access metadata and classifications (Major, Minor, Inactive)
row_info <- rowData(result)
```

### 4. Identifying Alternative Promoters
To find promoters that switch between conditions, use `getAlternativePromoters`. This identifies promoters with significant changes in both absolute and relative activity.

```r
alternativePromoters <- getAlternativePromoters(result = result, 
                                                referenceCondition = "Control")

# View up-regulated and down-regulated alternative promoters
alternativePromoters$upReg
alternativePromoters$downReg
```

## Visualization
`proActiv` provides built-in plotting for gene-level promoter analysis.

```r
# Boxplot of absolute/relative activity and gene expression
plots <- boxplotPromoters(result, geneId = "ENSG00000076864")

# Display absolute activity (slot 1) and gene expression (slot 3)
library(gridExtra)
grid.arrange(plots[[1]], plots[[3]], ncol = 2)
```

## Key Parameters for `getAlternativePromoters`
- `minAbs`: Minimum absolute activity to be considered "active" (default 0.25).
- `minRel`: Minimum relative activity (default 0.05).
- `maxPval`: Adjusted p-value threshold (default 0.05).
- `promoterFC`: Minimum fold change for the promoter (default 2.0).
- `geneFC`: Maximum fold change for the gene (default 1.5). Setting this low ensures you find promoter switches independent of total gene expression changes.

## Reference documentation
- [Identifying Active and Alternative Promoters from RNA-Seq data with proActiv](./references/proActiv.md)
- [proActiv Vignette Source](./references/proActiv.Rmd)