---
name: bcbio-rnaseq
description: bcbio-rnaseq processes bcbio-nextgen pipeline outputs into Bioconductor-compatible objects for downstream analysis in R. Use when user asks to load bcbio upload directories, construct a bcbioRNASeq object, or prepare RNA-seq data for differential expression analysis with DESeq2 or edgeR.
homepage: https://github.com/hbc/bcbioRNASeq
---


# bcbio-rnaseq

## Overview
bcbioRNASeq is an R package specifically designed to interface with the output of the bcbio-nextgen bioinformatics pipeline. It streamlines the transition from raw pipeline output (quantifications and metadata) into a Bioconductor-compatible `RangedSummarizedExperiment` object. Use this skill to automate the loading of "final" upload directories from bcbio, ensure metadata consistency, and prepare data for downstream statistical modeling.

## Installation
The package can be installed via BiocManager within R or through Conda for environment management.

**R Method:**
```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
install.packages(pkgs = "bcbioRNASeq", repos = c("https://r.acidgenomics.com", BiocManager::repositories()), dependencies = TRUE)
```

**Conda Method:**
```bash
conda create --name=r-bcbiornaseq r-bcbiornaseq
conda activate r-bcbiornaseq
```

## Data Loading and Object Construction
The primary entry point is the `bcbioRNASeq()` constructor. It requires the path to the bcbio "final" upload directory.

**Basic Pattern:**
```r
library(bcbioRNASeq)
object <- bcbioRNASeq(
    uploadDir = "path/to/bcbio/final",
    interestingGroups = c("genotype", "treatment"),
    organism = "Homo sapiens"
)
```

**Key Parameters:**
- `uploadDir`: Path to the directory containing the `project-summary.yaml` and quantification files.
- `interestingGroups`: Character vector specifying the metadata columns used for grouping and visualization.
- `sampleMetadataFile`: (Optional) Path to a CSV or Excel file if you wish to override the metadata found in the bcbio YAML.

## Metadata Requirements
- The package automatically maps samples using the `description` column.
- Values in the `description` column must be unique.
- These values are sanitized into syntactically valid names for R (column names), while original values are preserved in the `sampleName` column of `colData()`.

## Differential Expression Handoff
bcbioRNASeq objects are designed to be easily coerced into formats required by popular differential expression tools.

**For DESeq2:**
```r
dds <- as.DESeqDataSet(object)
```

**For edgeR or limma-voom:**
```r
dge <- as.DGEList(object)
```

## Maintenance and Troubleshooting
If working with objects saved from older versions of the package, you must update the object container to ensure compatibility with current plotting and analysis functions.

**Updating Legacy Objects:**
```r
object <- updateObject(object)
validObject(object)
```

## Best Practices
- **Metadata Cleanup**: If typos are discovered in sample metadata after the bcbio run, edit the `project-summary.yaml` in the upload directory before calling the R constructor, or provide an external metadata file.
- **RStudio Templates**: Utilize the built-in R Markdown templates for standardized QC and DE reports. Access these via `File -> New File -> R Markdown... -> From Template`.
- **Organism Specification**: Always provide the full Latin name for the `organism` parameter (e.g., "Mus musculus") to ensure correct functional annotation and gene symbol mapping.

## Reference documentation
- [bcbioRNASeq README](./references/github_com_hbc_bcbioRNASeq.md)