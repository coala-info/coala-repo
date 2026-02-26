---
name: bioconductor-fission
description: The bioconductor-fission package provides a RangedSummarizedExperiment object containing RNA-seq data from a fission yeast osmotic stress time course experiment. Use when user asks to access fission yeast transcriptomic data, analyze time-course RNA-seq datasets, or demonstrate differential expression workflows using strain and time interactions.
homepage: https://bioconductor.org/packages/release/data/experiment/html/fission.html
---


# bioconductor-fission

## Overview

The `fission` package provides a high-quality RNA-seq dataset from a study on fission yeast (*Schizosaccharomyces pombe*). The experiment tracks global transcription profiles of wild-type (WT) and *atf21del* (mutant) strains over an osmotic stress time course (0, 15, 30, 60, 120, and 180 minutes) following treatment with 1M sorbitol. The data is stored as a `RangedSummarizedExperiment` object, making it compatible with standard Bioconductor workflows like `DESeq2`, `edgeR`, and `limma`.

## Loading the Data

To use the dataset, load the library and the `fission` object:

```R
library(fission)
data("fission")

# Inspect the object
fission
```

## Data Structure

The `fission` object contains:
- **Assays**: A count matrix (`counts`) of uniquely mapped reads.
- **RowData (rowRanges)**: Genomic coordinates (GRanges) for each gene, including PomBase IDs and gene symbols.
- **ColData**: Phenotypic metadata including:
    - `strain`: "wt" (wild type) or "mut" (atf21del).
    - `minute`: Time points as a factor (0, 15, 30, 60, 120, 180).
    - `replicate`: Biological triplicate identifiers (r1, r2, r3).

## Typical Workflows

### 1. Differential Expression with DESeq2
The dataset is frequently used to demonstrate complex experimental designs (strain + time + interaction).

```R
library(DESeq2)

# Create DESeqDataSet from the fission object
dds <- DESeqDataSet(fission, design = ~ strain + minute + strain:minute)

# Run differential expression analysis
dds <- DESeq(dds)

# Extract results for a specific time point comparison
res <- results(dds, name="strainmut.minute15")
```

### 2. Accessing Metadata and Counts
You can extract specific components for custom plotting or analysis:

```R
# Get sample metadata
sample_info <- colData(fission)

# Get gene annotations
gene_info <- rowRanges(fission)

# Get raw counts for the first 5 genes
count_matrix <- assay(fission, "counts")
head(count_matrix)
```

### 3. Filtering and Subsetting
Subset the experiment to focus on specific conditions:

```R
# Subset to only include wild-type samples
fission_wt <- fission[, fission$strain == "wt"]

# Subset to only include the 0 and 180 minute time points
fission_endpoints <- fission[, fission$minute %in% c("0", "180")]
```

## Tips for Analysis
- **Factor Levels**: The `minute` variable is already stored as a factor with correctly ordered levels (0 to 180).
- **Reference Level**: The `strain` variable has "wt" set as the reference level.
- **Gene IDs**: The primary identifiers are PomBase IDs (e.g., SPAC11D3.01c). Use the `symbol` column in `mcols(fission)` for common gene names.

## Reference documentation

- [Fission yeast time course](./references/fission.md)