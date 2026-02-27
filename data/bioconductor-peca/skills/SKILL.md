---
name: bioconductor-peca
description: PECA performs differential expression analysis by averaging probe-level or peptide-level expression changes to determine gene or protein-level significance. Use when user asks to perform differential expression analysis on Affymetrix microarray data, analyze peptide-level proteomics datasets, or calculate gene-level changes from probe-level t-statistics.
homepage: https://bioconductor.org/packages/release/bioc/html/PECA.html
---


# bioconductor-peca

name: bioconductor-peca
description: Differential expression analysis using Probe-level Expression Change Averaging (PECA). Use this skill to determine gene or protein-level expression changes directly from probe-level (microarray) or peptide-level (proteomics) measurements. It is particularly useful when you have AffyBatch objects or tab-separated proteomics data and want to calculate significance based on the median of probe-level t-statistics.

## Overview

PECA is an R package that shifts differential expression analysis from the gene/protein level to the probe/peptide level. Instead of summarizing probes into a single gene value before testing, PECA calculates a t-statistic for every individual probe/peptide and then determines the gene/protein-level change as the median of these values. This approach often provides increased sensitivity and more accurate p-values by accounting for the number of measurements per entity via a beta distribution.

## Core Workflows

### 1. Proteomics Data (TSV Input)
For proteomics datasets provided as text files, use `PECA_tsv`. The input file must have a header where the first column is the ID (e.g., UniProt Accession) and subsequent columns contain intensity values.

```r
library(PECA)

# Define sample groups matching column names in the file
group1 <- c("A1", "A2", "A3")
group2 <- c("B1", "B2", "B3")

# Run PECA directly on the file path
# results will contain: slr (log-ratio), t (t-statistic), score, n (count), p, and p.fdr
results <- PECA_tsv("path/to/peptides.tsv", group1, group2)
head(results)
```

### 2. Affymetrix Microarray Data
For microarray data stored in an `AffyBatch` object, use `PECA_AffyBatch`. This function handles the mapping of probes to probe sets automatically.

```r
library(PECA)
library(affy)

# Assuming 'data' is an AffyBatch object
# normalize="true" performs internal normalization
results <- PECA_AffyBatch(affy=data, normalize="true")

# For specific group comparisons, subset the AffyBatch first
sub_data <- data[, c(1, 2, 3, 4, 5, 6)]
results_sub <- PECA_AffyBatch(affy=sub_data, normalize="true")
```

## Key Functions and Parameters

- `PECA_tsv(file, group1, group2, ...)`: Main interface for peptide-level text files.
- `PECA_AffyBatch(affy, normalize, ...)`: Main interface for Affymetrix probe-level data.
- `test`: Specifies the statistic to use. Options include `"t"` (ordinary t-statistic) or `"limma"` (modified t-statistic using the limma package).
- `paired`: A logical value (TRUE/FALSE) indicating whether to perform a paired test.

## Interpreting Results

The output is a data frame where each row represents a gene or protein:
- **slr**: The median of probe-level signal log-ratios.
- **t**: The median of probe-level t-statistics.
- **n**: The number of probes or peptides associated with that ID.
- **p**: The p-value derived from the beta distribution based on the probe-level statistics.
- **p.fdr**: False Discovery Rate adjusted p-values.

## Tips for Success
- **Column Naming**: Ensure input column names in TSV files do not start with numbers and do not contain special characters.
- **Data Quality**: PECA does not perform automated quality control or filtering of low-intensity probes; perform these steps prior to running the PECA functions.
- **Memory**: Because PECA operates on probe-level data, it can be memory-intensive for very large microarray experiments.

## Reference documentation

- [PECA](./references/PECA.md)