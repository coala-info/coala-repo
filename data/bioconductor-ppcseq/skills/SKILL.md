---
name: bioconductor-ppcseq
description: This tool identifies outliers in RNA-seq data using a Bayesian framework to determine if transcript counts are consistent with a negative binomial model. Use when user asks to identify artefactual significance in differential expression results, perform posterior predictive checks on transcript abundance, or visualize credible intervals for RNA-seq counts.
homepage: https://bioconductor.org/packages/release/bioc/html/ppcseq.html
---


# bioconductor-ppcseq

## Overview

The `ppcseq` package provides a Bayesian framework for identifying outliers in RNA-seq data. It uses posterior predictive checks to determine if observed transcript counts are consistent with a negative binomial model. This is particularly useful for quality control after differential expression analysis, as it identifies "artefactual" significance driven by single extreme data points rather than consistent biological signals.

## Installation

For Linux systems, it is recommended to enable multi-threading for Stan before installation:

```r
fileConn <- file("~/.R/Makevars")
writeLines(c("CXX14FLAGS += -O3","CXX14FLAGS += -DSTAN_THREADS", "CXX14FLAGS += -pthread"), fileConn)
close(fileConn)

if(!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("ppcseq")
```

## Workflow: Identifying Outliers

The package expects a "tidy" data frame containing transcript abundance and differential expression statistics (P-values/FDR).

### 1. Prepare Data
The input should contain columns for samples, transcripts (symbols/IDs), abundance (counts), and significance metrics.

```r
library(dplyr)
library(ppcseq)

# Example using internal 'counts' data
data("counts")

# Define which transcripts to check (usually those marked as significant)
counts_to_check <- counts %>%
  mutate(is_significant = FDR < 0.01)
```

### 2. Run Outlier Identification
The `identify_outliers` function is the primary tool. It performs Bayesian inference to flag data points that fall outside the predicted credible intervals.

```r
counts.ppc <- counts_to_check %>%
  identify_outliers(
    formula = ~ Label,                # The design formula used in DE analysis
    .sample = sample,                 # Column name for samples
    .transcript = symbol,             # Column name for transcripts
    .abundance = value,               # Column name for read counts
    .significance = PValue,           # Column name for P-values
    .do_check = is_significant,       # Logical column: which rows to test
    percent_false_positive_genes = 5, # Global false positive rate threshold
    cores = 4                         # Parallel processing
  )
```

### 3. Interpret Results
The output is a tibble containing:
- `sample_wise_data`: Nested information about individual observations.
- `ppc_samples_failed`: Number of samples flagged as outliers for that transcript.
- `tot_deleterious_outliers`: Number of outliers that specifically inflated the significance.

## Visualization

You can visualize the credible intervals and the observed data points to manually inspect flagged outliers.

```r
# Generate plots for the analyzed transcripts
counts.ppc_plots <- counts.ppc %>% 
  plot_credible_intervals()

# View the plot for the first transcript
counts.ppc_plots %>%
  pull(plot) %>% 
  .[[1]]
```

## Key Parameters for `identify_outliers`

- `approximate_posterior_inference`: Set to `TRUE` to use Variational Bayes (faster) or `FALSE` for full Markov Chain Monte Carlo (more accurate).
- `percent_false_positive_genes`: Controls the stringency of outlier detection.
- `draws_after_tail`: Used to speed up execution by limiting samples in the distribution tail (useful for testing).

## Reference documentation

- [Overview of the ppcseq package](./references/introduction.Rmd)
- [Probabilistic Outlier Identification for RNA Sequencing Generalized Linear Models](./references/introduction.md)