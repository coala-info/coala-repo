---
name: bioconductor-parathyroidse
description: This package provides RNA-Seq experiment data from parathyroid adenoma cultures stored as RangedSummarizedExperiment objects. Use when user asks to perform differential expression analysis, investigate gene-level or exon-level counts, or access the GSE37211 dataset.
homepage: https://bioconductor.org/packages/release/data/experiment/html/parathyroidSE.html
---


# bioconductor-parathyroidse

name: bioconductor-parathyroidse
description: Provides access and usage instructions for the parathyroidSE Bioconductor experiment data package. Use this skill when a user needs to perform differential expression analysis, gene-level or exon-level investigations using the RangedSummarizedExperiment object derived from the GSE37211 RNA-Seq dataset (parathyroid adenoma cultures).

# bioconductor-parathyroidse

## Overview
The `parathyroidSE` package is a Bioconductor data package containing a `RangedSummarizedExperiment` object. This object represents an RNA-Seq experiment on primary cultures of parathyroid adenoma cells from 27 patients. The cells were treated with control, Vitamin D (1,25-dihydroxyvitamin D3), or Calcium to study their effects on gene expression. The data includes both gene-level and exon-level counts, mapped to the GRCh37 Ensembl annotations.

## Loading the Data
To use the dataset, load the library and the specific data object:

```r
library(parathyroidSE)
data("parathyroidGenesSE") # For gene-level counts
data("parathyroidExonsSE") # For exon-level counts
```

## Typical Workflow

### 1. Inspecting the Object
The data is stored as a `SummarizedExperiment` object. You can inspect the metadata, row ranges (genomic coordinates), and experimental design:

```r
# View the object summary
parathyroidGenesSE

# Access sample metadata (colData)
colData(parathyroidGenesSE)

# Access assay data (counts)
head(assay(parathyroidGenesSE))

# Access row metadata (GRanges)
rowRanges(parathyroidGenesSE)
```

### 2. Experimental Design
The `colData` contains several important variables for differential expression analysis:
- `patient`: The ID of the individual patient (27 total).
- `treatment`: The treatment applied (Control, DPN, OHT, Vitamin D, or Calcium).
- `time`: The duration of treatment (24h or 48h).

### 3. Differential Expression Analysis
The object is ready for use with packages like `DESeq2`. A common workflow involves modeling treatment while controlling for patient-specific effects:

```r
library(DESeq2)

# Create DESeqDataSet from the SummarizedExperiment
dds <- DESeqDataSet(parathyroidGenesSE, design = ~ patient + treatment)

# Run the analysis
dds <- DESeq(dds)

# Extract results for Vitamin D treatment vs Control
res <- results(dds, contrast=c("treatment", "VitaminD", "Control"))
```

## Tips for Usage
- **Annotation**: The features are based on Ensembl GRCh37. If you need to map to Gene Symbols or other identifiers, use `biomaRt` or `org.Hs.eg.db`.
- **Filtering**: Before running differential expression, it is often beneficial to filter out genes with very low counts across all samples to improve power.
- **Exon-level**: Use `parathyroidExonsSE` if you are interested in alternative splicing or differential exon usage (e.g., using the `DEXSeq` package).

## Reference documentation
- [parathyroidSE Bioconductor Page](https://bioconductor.org/packages/release/data/experiment/html/parathyroidSE.html)