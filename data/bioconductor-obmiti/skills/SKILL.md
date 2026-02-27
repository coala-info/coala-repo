---
name: bioconductor-obmiti
description: This tool provides access to and analysis of RNA-seq data and physiological measurements from Wild Type and Ob/Ob mice across seven tissues and two diet types. Use when user asks to load the ObMiTi dataset, perform differential expression analysis on obesity-related mouse transcriptomes, or correlate gene expression with metabolic traits like glucose levels and body weight.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ObMiTi.html
---


# bioconductor-obmiti

name: bioconductor-obmiti
description: Access and analyze RNA-seq data from the ObMiTi Bioconductor package. This dataset includes transcriptomic profiles of Wild Type (WT) and Ob/Ob mice across 7 tissues (Aorta, Epididymis, Heart, Hippocampus, Hypothalamus, Liver, Skeletal Muscle) under Normal Diet (ND) and High Fat Diet (HFD). Use this skill to load the RangedSummarizedExperiment object, perform differential expression analysis, or explore physiological measurements (metadata) associated with the mice.

# bioconductor-obmiti

## Overview

The `ObMiTi` package provides a comprehensive RNA-seq dataset for studying obesity and metabolism in a mouse model. It features a 2x2 factorial design (Genotype: WT vs. Ob/Ob; Diet: ND vs. HFD) across 7 distinct tissues. The data is distributed as a `RangedSummarizedExperiment` object via `ExperimentHub`, containing gene counts, genomic ranges, and extensive phenotypic metadata including physiological measurements like blood volume, glucose levels, and organ weights.

## Loading the Data

The dataset is retrieved using `ExperimentHub`.

```r
library(ExperimentHub)
library(SummarizedExperiment)

# Query and load the dataset
eh <- ExperimentHub()
ob_counts <- query(eh, "ObMiTi")[[1]]
```

## Data Exploration

### Accessing Counts and Metadata
The object follows standard `SummarizedExperiment` conventions:

```r
# Gene counts matrix
counts_matrix <- assay(ob_counts)

# Sample metadata (Genotype, Diet, Tissue)
sample_info <- colData(ob_counts)

# Physiological measurements (Weight, Glucose, etc.)
physio_data <- metadata(ob_counts)$measures

# Gene annotations (Symbol, Biotype, Entrez ID)
gene_info <- rowRanges(ob_counts)
```

### Key Metadata Columns
- `genotype.ch1`: "ob_ob" or "WT"
- `diet.ch1`: "HFD" (High Fat Diet) or "ND" (Normal Diet)
- `tissue.ch1`: "Ao", "Ep", "He", "Hi", "Hy", "Li", "Sk"

## Common Workflows

### Filtering by Gene Biotype
To focus on protein-coding genes for downstream analysis:

```r
se_coding <- ob_counts[rowRanges(ob_counts)$biotype == "protein_coding", ]
```

### Subsetting by Tissue or Condition
To analyze a specific tissue (e.g., Liver):

```r
liver_se <- ob_counts[, ob_counts$tissue.ch1 == "Li"]
```

### Correlating Expression with Physiological Traits
You can merge the `measures` metadata with sample information for correlation studies:

```r
# Example: Accessing weight for the first few samples
weights <- metadata(ob_counts)$measures$weight
```

## Tips for Analysis
- **Normalization**: The `counts` assay contains raw counts. Use `DESeq2` or `edgeR` for normalization and differential expression.
- **Gene IDs**: Row names are Ensembl IDs. Use `rowRanges(ob_counts)$symbol` to map to common gene symbols.
- **Factor Levels**: When setting up design matrices, ensure "WT" and "ND" are set as reference levels.

## Reference documentation
- [Using ObMiTi](./references/ObMiTi.md)
- [ObMiTi Vignette Source](./references/ObMiTi.Rmd)