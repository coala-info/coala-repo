---
name: r-bcbiornaseq
description: R package bcbiornaseq (documentation from project home).
homepage: https://cran.r-project.org/web/packages/bcbiornaseq/index.html
---

# r-bcbiornaseq

## Overview

The `bcbioRNASeq` package is designed for the analysis of RNA-seq data processed with the [bcbio-nextgen](https://github.com/bcbio/bcbio-nextgen/) pipeline. It provides a streamlined workflow to import pipeline results into R, perform automated quality control (QC), and prepare data for differential expression analysis. The primary data container is the `bcbioRNASeq` object, which extends the Bioconductor `RangedSummarizedExperiment` class.

## Installation

To install the package and its dependencies:

```R
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "bcbioRNASeq",
    repos = c(
        "https://r.acidgenomics.com",
        BiocManager::repositories()
    ),
    dependencies = TRUE
)
```

## Core Workflow

### 1. Loading Data
Import the bcbio final upload directory. The function automatically parses the `project-summary.yaml` for metadata.

```R
library(bcbioRNASeq)

object <- bcbioRNASeq(
    uploadDir = "path/to/bcbio/final",
    interestingGroups = c("genotype", "treatment"),
    organism = "Homo sapiens"
)
```

### 2. Sample Metadata
If the YAML metadata is incorrect, you can provide a custom CSV/Excel file. The `description` column must match the bcbio sample names.

```R
object <- bcbioRNASeq(
    uploadDir = "path/to/bcbio/final",
    sampleMetadataFile = "metadata.csv"
)
```

### 3. Quality Control
The package includes several plotting functions for QC:
- `plotQC()`: General QC summary.
- `plotMappedReads()`: Check sequencing depth.
- `plotPCA()`: Principal Component Analysis.
- `plotCorrelationHeatmap()`: Sample-to-sample correlation.

### 4. Differential Expression Handoff
Coerce the `bcbioRNASeq` object into formats required by popular DE tools:

**DESeq2:**
```R
dds <- as.DESeqDataSet(object)
```

**edgeR / limma-voom:**
```R
dge <- as.DGEList(object)
```

## Tips and Troubleshooting

- **Object Updates:** If loading an object from an older version of the package, use `object <- updateObject(object)` to ensure compatibility.
- **RStudio Templates:** Use `File -> New File -> R Markdown... -> From Template` to access pre-built bcbioRNASeq templates for QC and DE analysis.
- **Sanitization:** Sample names are automatically sanitized to be syntactically valid in R. The original names are preserved in the `sampleName` column of `colData(object)`.

## Reference documentation

- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)