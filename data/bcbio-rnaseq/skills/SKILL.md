---
name: bcbio-rnaseq
description: bcbioRNASeq processes and validates output from the bcbio-nextgen bioinformatics pipeline for downstream analysis in R. Use when user asks to import bcbio RNA-seq data, perform quality control visualization, or convert pipeline results into DESeq2 and edgeR objects.
homepage: https://github.com/hbc/bcbioRNASeq
metadata:
  docker_image: "quay.io/biocontainers/bcbio-rnaseq:1.2.0--r3.3.2_3"
---

# bcbio-rnaseq

## Overview

The bcbioRNASeq package provides a specialized interface for handling the output of the bcbio-nextgen bioinformatics pipeline. It automates the import of transcript-level and gene-level counts, sample metadata, and alignment metrics into a single RangedSummarizedExperiment object. This skill facilitates the transition from raw pipeline output to downstream statistical analysis, offering robust tools for data validation, quality assessment, and format conversion for Bioconductor-standard differential expression workflows.

## Installation and Setup

Install the package using the Acid Genomics repository to ensure all dependencies are resolved:

```R
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
install.packages("bcbioRNASeq", repos = c("https://r.acidgenomics.com", BiocManager::repositories()))
```

## Data Import Patterns

The primary entry point is the `bcbioRNASeq()` constructor. It requires the path to the bcbio "final" upload directory.

### Standard Import
```R
library(bcbioRNASeq)
object <- bcbioRNASeq(
    uploadDir = "bcbio_output/final",
    interestingGroups = c("genotype", "treatment"),
    organism = "Homo sapiens"
)
```

### Custom Metadata
If the `project-summary.yaml` in the upload directory contains errors or lacks specific experimental factors, provide an external metadata file. The `description` column must match the bcbio sample names.

```R
object <- bcbioRNASeq(
    uploadDir = "bcbio_output/final",
    sampleMetadataFile = "metadata.csv",
    organism = "Mus musculus"
)
```

## Quality Control and Visualization

Use these functions to assess the technical quality of the run before proceeding to differential expression.

- **Global QC Summary**: `plotQC(object)` generates a comprehensive suite of plots.
- **Sample Clustering**: `plotPCA(object, label = TRUE)` or `plotCorrelationHeatmap(object)` to identify outliers or batch effects.
- **Mapping Metrics**:
    - `plotMappingRate(object)`: Overall alignment quality.
    - `plotExonicMappingRate(object)`: Check for genomic DNA contamination.
    - `plotRrnaMappingRate(object)`: Verify rRNA depletion efficiency.
- **Quantitation Metrics**:
    - `plotGenesDetected(object)`: Sensitivity check.
    - `plotCountsPerGene(object)`: Distribution of counts across samples.

## Differential Expression Handoff

bcbioRNASeq objects are designed to be easily coerced into formats required by major statistical packages.

### DESeq2
```R
dds <- as.DESeqDataSet(object)
# Proceed with standard DESeq2 workflow
```

### edgeR or limma-voom
```R
dge <- as.DGEList(object)
# Proceed with edgeR or limma-voom workflow
```

## Expert Tips

- **Legacy Data**: If loading an object saved with an older version of the package, always run `object <- updateObject(object)` to ensure compatibility with current plotting and analysis functions.
- **Gene Symbol Mapping**: The package handles Ensembl ID to Gene Symbol mapping automatically if the `organism` is correctly specified during import.
- **Reporting**: Use `prepareRNASeqTemplate()` to generate a boilerplate R Markdown file that includes standard QC and differential expression code blocks.
- **Sanitization**: Sample names are automatically sanitized into syntactically valid R names. The original names are preserved in the `sampleName` column of the metadata.



## Subcommands

| Command | Description |
|---------|-------------|
| bcbio-rnaseq compare | Compare RNA-seq experiments |
| bcbio-rnaseq simulate | Simulate RNA-Seq data |
| bcbio-rnaseq summarize | Summarize RNA-Seq analysis results from a bcbio project. |

## Reference documentation
- [bcbioRNASeq README](./references/github_com_hbc_bcbioRNASeq_blob_master_README.md)
- [Package Description and Dependencies](./references/github_com_hbc_bcbioRNASeq_blob_master_DESCRIPTION.md)
- [Exported Functions and Methods](./references/github_com_hbc_bcbioRNASeq_blob_master_NAMESPACE.md)