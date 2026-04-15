---
name: bioconductor-kinswingr
description: KinSwingR predicts kinase activity by integrating kinase-substrate motifs with experimental phosphoproteomics data using a swing score. Use when user asks to predict kinase activation or inhibition, build position weight matrices for kinases, score phosphopeptide sequences, or analyze phosphoproteomic fold-change data.
homepage: https://bioconductor.org/packages/release/bioc/html/KinSwingR.html
---

# bioconductor-kinswingr

## Overview

KinSwingR is a Bioconductor package designed to predict kinase activity by integrating kinase-substrate motifs with experimental phosphoproteomics data. It uses Position Weight Matrices (PWMs) to score potential kinase-substrate interactions and then calculates a "Swing" score that accounts for the directionality (fold change) and significance of phosphopeptide changes. The final output provides normalized Z-scores and p-values to identify significantly activated or inhibited kinases.

## Core Workflow

### 1. Data Preparation
KinSwingR requires two main inputs:
- **Phosphoproteome Data**: A data frame with columns for `annotation`, `peptide` (centered sequences), `fc` (fold change), and `pval` (p-value).
- **Kinase-Substrate Data**: A table with `kinase` and `substrate` (peptide sequence) columns.

If your peptide sequences are embedded in annotation strings, use `cleanAnnotation()`:

```r
library(KinSwingR)

# Extract peptides from annotation (e.g., 4th element separated by '|')
annotated_data <- cleanAnnotation(
  input_data = my_phospho_data,
  annotation_delimiter = "|",
  seq_number = 4,
  replace = TRUE,
  replace_search = "X",
  replace_with = "_"
)
```

### 2. Building PWMs
Generate Position Weight Matrices from known kinase-substrate relationships.

```r
# Build PWMs
pwms <- buildPWM(kinase_substrate_table)

# Visualize a specific kinase motif (e.g., CAMK2A)
viewPWM(pwms, which_pwm = "CAMK2A")
```

### 3. Scoring Sequences
Score the experimental phosphopeptides against the generated PWMs. This step determines the likelihood of a peptide being a substrate for a specific kinase.

```r
library(BiocParallel)
register(SnowParam(workers = 4)) # Optional parallel processing

set.seed(1234)
scores <- scoreSequences(
  input_data = annotated_data,
  pwm_in = pwms,
  n = 1000 # Background size for p-value calculation
)
```

### 4. Predicting Kinase Activity (Swing)
Integrate the PWM scores with fold-change data to calculate the Swing score.

```r
set.seed(1234)
swing_results <- swing(
  input_data = annotated_data,
  pwm_in = pwms,
  pwm_scores = scores,
  permutations = 1000
)

# View top predicted kinases
head(swing_results$scores)
```

## Interpreting Results

The `swing()` function returns a list containing a network and a scores table. Key columns in `swing_results$scores` include:
- **swing**: The normalized Z-score. Positive values indicate activation; negative values indicate inhibition.
- **p_greater**: Probability of observing a swing score greater than the observed (activation significance).
- **p_less**: Probability of observing a swing score less than the observed (inhibition significance).
- **pos/neg**: Number of positively or negatively regulated substrates contributing to the score.

## Tips for Success
- **Seed Setting**: Always use `set.seed()` before `scoreSequences` and `swing` to ensure reproducibility of the permutation-based p-values.
- **Sequence Length**: Ensure all peptide sequences (both in PWM building and experimental data) are centered on the phosphosite and have consistent lengths.
- **Parallelization**: For large datasets, use `BiocParallel` to significantly speed up the scoring and permutation steps.

## Reference documentation
- [KinSwingR: Predicting kinase activity from phosphoproteomics data](./references/KinSwingR.md)