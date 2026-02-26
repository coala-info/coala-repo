---
name: bioconductor-gse62944
description: This package provides access to uniformly re-processed TCGA RNA-Seq data for tumor and normal samples via ExperimentHub. Use when user asks to retrieve TCGA expression datasets, access cancer-specific RNA-Seq counts, or perform differential expression analysis on TCGA cohorts.
homepage: https://bioconductor.org/packages/release/data/experiment/html/GSE62944.html
---


# bioconductor-gse62944

name: bioconductor-gse62944
description: Access and analyze TCGA re-processed RNA-Seq data (9264 tumor and 741 normal samples) from GEO GSE62944. Use this skill to retrieve TCGA ExpressionSet or SummarizedExperiment objects via ExperimentHub for differential expression analysis and cancer subtype studies.

# bioconductor-gse62944

## Overview

The GSE62944 package provides access to a massive, uniformly re-processed TCGA RNA-Seq dataset. It includes data from 24 different cancer types, covering both tumor and normal samples. The data is primarily accessed through `ExperimentHub` as an `ExpressionSet` or `SummarizedExperiment`, making it ready for downstream Bioconductor workflows like `DESeq2` or `limma`.

## Data Retrieval

To access the data, use the `ExperimentHub` interface.

```r
library(ExperimentHub)
library(GSE62944)

# Initialize Hub and query for the dataset
eh <- ExperimentHub()
query(eh, "GSE62944")

# Retrieve specific records
# EH1: 7706 tumor samples (ExpressionSet)
# EH1043: 9246 tumor samples (SummarizedExperiment)
# EH1044: 741 normal samples (SummarizedExperiment)
tcga_data <- eh[["EH1"]]
```

## Common Workflows

### 1. Exploring Metadata
The `phenoData` (for ExpressionSet) or `colData` (for SummarizedExperiment) contains critical clinical and sample information, including `CancerType`.

```r
# View available cancer types
table(phenoData(tcga_data)$CancerType)

# Check for specific mutations (e.g., IDH1 in Glioma)
head(phenoData(tcga_data)$idh1_mutation_found)
```

### 2. Subsetting by Cancer Type
You can subset the large dataset to focus on specific cohorts (e.g., BRCA, LGG, LUAD).

```r
# Subset for Low Grade Glioma (LGG)
lgg_data <- tcga_data[, tcga_data$CancerType == "LGG"]
```

### 3. Differential Expression Analysis (DESeq2)
The raw counts provided in this package are suitable for `DESeq2`.

```r
library(DESeq2)

# 1. Prepare count matrix and metadata
# Example: Comparing IDH1 mutant vs wild type in LGG
mut_idx <- which(phenoData(lgg_data)$idh1_mutation_found == "YES")
wt_idx <- which(phenoData(lgg_data)$idh1_mutation_found == "NO")

countData <- exprs(lgg_data)[, c(mut_idx, wt_idx)]
colData <- data.frame(
  sampleName = colnames(countData),
  Group = factor(c(rep("mut", length(mut_idx)), rep("wt", length(wt_idx))))
)

# 2. Create DESeqDataSet
dds <- DESeqDataSetFromMatrix(countData = countData,
                              colData = colData,
                              design = ~ Group)

# 3. Run Analysis
dds <- dds[rowSums(counts(dds)) > 1, ]
dds <- DESeq(dds)
res <- results(dds)
```

## Tips
- **Memory Management**: The full dataset is large. Always subset to the specific cancer types or samples of interest early in your script to save memory.
- **Data Classes**: Depending on the ExperimentHub ID chosen, you may receive an `ExpressionSet` (older) or `SummarizedExperiment` (newer). Use `exprs()` for the former and `assay()` for the latter to access counts.
- **Normalization**: The data provided via `EH1` are raw counts. Ensure you use appropriate normalization (like `DESeq2`'s internal median-of-ratios) rather than using raw counts directly for visualization or clustering.

## Reference documentation
- [Raw TCGA data using Bioconductor’s ExperimentHub](./references/GSE62944.md)