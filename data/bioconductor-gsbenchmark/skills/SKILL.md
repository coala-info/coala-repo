---
name: bioconductor-gsbenchmark
description: The GSBenchMark package provides curated gene expression datasets and pathway information for benchmarking the Differential Rank Conservation algorithm. Use when user asks to access standardized disease datasets, load DIRAC pathway lists, or prune gene sets for expression analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/GSBenchMark.html
---


# bioconductor-gsbenchmark

## Overview

The `GSBenchMark` package is a data experiment package containing curated gene expression datasets and pathway information used to benchmark the "Differential Rank Conservation" (DIRAC) algorithm. It provides a unified interface to 11 distinct datasets representing various diseases (cancers, neurological disorders, etc.) along with a comprehensive list of pathways and their associated gene targets.

## Loading Pathway Data

The package includes a standardized list of pathways derived from the DIRAC study.

```R
library(GSBenchMark)

# Load the pathway list
data(diracpathways)

# diracpathways is a list where names are pathway IDs 
# and elements are character vectors of gene symbols
names(diracpathways)[1:5]
diracpathways[["DEATHPATHWAY"]]
```

## Accessing Gene Expression Datasets

The package contains 11 specific datasets. You must first identify the dataset name and then load it using `data()`.

### List Available Datasets
```R
data(GSBenchMarkDatasets)
print(GSBenchMark.Dataset.names)
```

### Load a Specific Dataset
When you load a dataset by name, it populates the global environment with three specific variables: `exprsdata`, `phenotypes`, and `phenotypesLevels`.

```R
# Example: Loading the Parkinson's dataset
data(parkinsons_GDS2519)

# 1. Gene expression matrix (genes as rows, samples as columns)
head(exprsdata)

# 2. Sample labels (Factor with levels "0" and "1")
# "0" usually indicates the control/less dangerous phenotype
# "1" indicates the disease/more dangerous phenotype
table(phenotypes)

# 3. Mapping of 0/1 to actual condition names
print(phenotypesLevels)
```

## Common Workflow: Pruning Pathways

Because not all genes in a pathway are necessarily measured in every expression dataset, you must prune the pathways to match the available data before analysis.

```R
# 1. Get genes present in the expression data
genenames <- rownames(exprsdata)

# 2. Intersect pathway genes with dataset genes
prunedpathways <- lapply(diracpathways, function(x) intersect(x, genenames))

# 3. Remove pathways that become too small (e.g., < 2 genes) after pruning
pathway_lengths <- sapply(prunedpathways, length)
diracpathwayPruned <- prunedpathways[pathway_lengths >= 2]

cat("Pathways remaining:", length(diracpathwayPruned), "\n")
```

## Dataset Summary Table

| Dataset Name | Disease/Study | Phenotype 0 | Phenotype 1 |
|--------------|---------------|-------------|-------------|
| `leukemia_GSEA` | Leukemia | ALL | AML |
| `parkinsons_GDS2519` | Parkinson's | Normal | Parkinson's |
| `melanoma_GDS2735` | Melanoma | Normal | Metastasis |
| `sarcoma_data` | Sarcoma | LMS | GIST |
| `bipolar_GDS2190` | Bipolar Disorder | Normal | Bipolar |
| `breast_GDS807` | Breast Cancer | Responsive | Non-responsive |
| `squamous_GDS2520` | Head/Neck Cancer | Normal | HNSCC |
| `prostate_GDS2545_m_nf` | Prostate | Normal | Metastasis |
| `prostate_GDS2545_p_nf` | Prostate | Normal | Primary |
| `prostate_GDS2545_m_p` | Prostate | Primary | Metastasis |
| `marfan_GDS2960` | Marfan Syndrome | non-MFS | MFS |

## Tips for Usage
- **Gene Identifiers**: The package uses Gene Symbols. Ensure your own pathway lists or downstream analysis tools are compatible with symbols if you are mixing this data with external resources.
- **Binary Classification**: The datasets are specifically structured for binary classification benchmarking (Control vs. Disease or Primary vs. Metastasis).
- **Data Origin**: Most datasets were converted from Matlab formats used in the original DIRAC publication (Eddy et al., 2010).

## Reference documentation
- [GSBenchMark](./references/GSBenchMark.md)