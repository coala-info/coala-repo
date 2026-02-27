---
name: bioconductor-triform
description: Triform identifies transcription factor binding sites in ChIP-Seq data using a nonparametric approach based on the mean second derivative of read coverage profiles. Use when user asks to find peaks in ChIP-Seq enrichment profiles, identify transcription factor binding sites from BED files, or detect Poisson inhomogeneities using the Hoel test.
homepage: https://bioconductor.org/packages/3.5/bioc/html/triform.html
---


# bioconductor-triform

name: bioconductor-triform
description: Peak finding in ChIP-Seq enrichment profiles for transcription factors using the Triform algorithm. Use this skill to identify transcription factor binding sites from BED files, specifically when a model-free, nonparametric approach is required to handle noisy data, overlapping peaks, or to utilize the Hoel test for Poisson inhomogeneities.

# bioconductor-triform

## Overview

Triform is a Bioconductor package designed for identifying peaks in ChIP-Seq data. Unlike model-based peak finders, Triform uses a nonparametric approach based on the mean second derivative of the read coverage profile. It identifies "triangle-peak-like" shapes and utilizes the Hoel test to detect significant Poisson inhomogeneities. This makes it robust against varying background levels and effective at resolving overlapping peaks and rejecting noisy plateaus.

## Workflow

The Triform workflow consists of two primary steps: preprocessing BED files into coverage objects and running the peak-finding algorithm.

### 1. Configuration

Triform parameters can be managed via a YAML configuration file or a named list in R.

**Key Parameters:**
- `READ.PATH`: Directory containing input BED files.
- `COVER.PATH`: Directory where intermediate coverage RData files are stored.
- `OUTPUT.PATH`: Full path for the resulting CSV output.
- `TARGETS`: Vector of filenames for TF experiments (must include `_rep1`, `_rep2`, etc.).
- `CONTROLS`: Vector of filenames for control/input experiments.
- `READ.WIDTH`: Extended read width (w).
- `FLANK.DELTA`: Spacing between central and flanking locations (d), default 150bp.
- `MAX.P`: Maximum p-value for peak detection.
- `MIN.WIDTH`: Minimum peak width.
- `CHRS`: Vector of chromosomes to process (e.g., `c("chr1", "chr2")`).

### 2. Preprocessing

The `preprocess` function converts BED files into strand-specific tag counts and saves them as `.RData` files organized by chromosome.

```r
library(triform)

# Using a configuration file with overrides
config_path <- "config.yml"
preprocess(configPath = config_path, 
           params = list(READ.PATH = "./data", COVER.PATH = "./cache"))

# Or using only a list (no config file)
params_list <- list(READ.PATH = "./data", 
                    COVER.PATH = "./cache", 
                    READ.WIDTH = 100,
                    CHRS = c("chrY"))
preprocess(configPath = NULL, params = params_list)
```

### 3. Peak Finding

The `triform` function performs the statistical tests and identifies enriched regions based on the preprocessed coverage files.

```r
# Run triform using the same parameters/config
triform(configPath = config_path, 
        params = list(COVER.PATH = "./cache", 
                      OUTPUT.PATH = "results/peaks.csv"))
```

## Usage Tips

- **File Naming**: Input BED files must follow a specific naming convention including replicate identifiers (e.g., `sample_rep1.bed`) to be correctly parsed by the `TARGETS` and `CONTROLS` parameters.
- **Memory Management**: Triform processes data chromosome by chromosome. If memory is limited, process a subset of chromosomes at a time using the `CHRS` parameter.
- **Control Samples**: While Triform is model-free, providing `CONTROLS` is highly recommended for calculating enrichment ratios and improving specificity.
- **Output**: The output is a CSV file containing peak coordinates, p-values, and enrichment statistics.

## Reference documentation

- [Triform: peak finding in ChIP-Seq enrichment profiles for transcription factors](./references/triform.md)