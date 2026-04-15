---
name: bioconductor-pfamanalyzer
description: pfamAnalyzeR identifies and classifies protein domain isotypes from Pfam results to detect variations like truncations, insertions, and deletions. Use when user asks to identify protein domain isotypes, classify Pfam hits, or analyze domain variations caused by alternative splicing.
homepage: https://bioconductor.org/packages/release/bioc/html/pfamAnalyzeR.html
---

# bioconductor-pfamanalyzer

## Overview

The `pfamAnalyzeR` package is designed to identify and classify **protein domain isotypes**. While protein domains are often treated as static entities, they frequently exist as variants (isotypes) due to alternative splicing or other transcript variations. This package categorizes Pfam hits into five specific isotypes:
1. **Reference**: The full, standard domain.
2. **Truncation**: A shortened version of the domain.
3. **Insertion**: A domain containing additional amino acids.
4. **Deletion**: A domain missing internal segments.
5. **Complex**: A combination of the above variations.

## Installation

To install the package via Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("pfamAnalyzeR")
```

## Workflow

The primary workflow involves reading a Pfam result file (typically a text file from the Pfam webserver or a local HMMER run) and running the classification algorithm.

### 1. Load the Library
```r
library(pfamAnalyzeR)
```

### 2. Run the Analysis
The core function is `pfamAnalyzeR()`. It accepts the path to your Pfam result file.

```r
# Path to your Pfam results (e.g., "pfam_results.txt")
pfamResultFile <- "path/to/your/pfam_results.txt"

# Run classification
pfamRes <- pfamAnalyzeR(pfamResultFile)
```

### 3. Inspect Results
The output is a `tibble` containing the original Pfam data plus additional columns:
* `domain_isotype`: The specific classification (Reference, Truncation, etc.).
* `domain_isotype_simple`: A binary classification (Reference vs. Non-reference).

```r
# View the first few rows
head(pfamRes)

# Summarize the distribution of isotypes
table(pfamRes$domain_isotype)

# Summarize simple classification
table(pfamRes$domain_isotype_simple)
```

### 4. Filtering by Annotation Type
Pfam results often include different types of hits (Domain, Family, Repeat). You can subset the results based on your research focus:

```r
library(dplyr)

# Filter for only "Domain" types
domains_only <- pfamRes %>% 
  filter(type == "Domain")
```

## Tips for Success

* **Input Format**: The package is optimized for the standard output format provided by the Pfam webserver and HMMER-based Pfam searches.
* **Data Interpretation**: A high frequency of "Non-reference" isotypes is common in transcriptomic data and often indicates functional modulation of the protein.
* **Integration**: The output is a standard data frame/tibble, making it compatible with `tidyverse` workflows for downstream visualization or integration with transcript-level expression data.

## Reference documentation

- [Vignette for pfamAnalyzeR](./references/pfamAnalyzeR.Rmd)
- [pfamAnalyzeR Workflow Guide](./references/pfamAnalyzeR.md)