---
name: bioconductor-bumhmm
description: This tool performs statistical modeling of RNA structure probing data using a Beta-Uniform Mixture hidden Markov model to identify modified nucleotides. Use when user asks to process per-nucleotide coverage and drop-off counts, stabilize variance in log-drop-off rate ratios, or compute posterior probabilities of RNA modification.
homepage: https://bioconductor.org/packages/release/bioc/html/BUMHMM.html
---


# bioconductor-bumhmm

name: bioconductor-bumhmm
description: Statistical modeling of RNA structure probing data (SHAPE, ChemModSeq, DMS) using the Beta-Uniform Mixture hidden Markov model (BUM-HMM). Use this skill to process per-nucleotide coverage and drop-off counts into posterior probabilities of modification, including variance stabilization and sequence bias correction.

## Overview
BUMHMM is a probabilistic pipeline for analyzing RNA structure probing data. It compares drop-off rates (RT stop counts divided by coverage) between treatment and control replicates. By modeling the null distribution of variability between control replicates, it identifies positions where treatment drop-off rates are significantly higher than expected by chance. The final output is a transcriptome-wide probability of modification for each nucleotide.

## Core Workflow

### 1. Data Preparation
Data must be stored in a `SummarizedExperiment` object with three assays: `coverage`, `dropoff_count`, and `dropoff_rate`.

```R
library(BUMHMM)
library(SummarizedExperiment)

# se is a SummarizedExperiment with 3 assays and colData indicating 'replicate' (control/treatment)
# Example: 3 controls (C1-C3), 3 treatments (T1-T3)
Nc <- 3
Nt <- 3
t <- 1 # Coverage threshold
```

### 2. Nucleotide Selection and Scaling
Identify valid nucleotides (coverage $\ge t$ and drop-off $> 0$) and scale rates to a common median to ensure inter-replicate comparability.

```R
# Select positions for pairwise comparisons
nuclSelection <- selectNuclPos(se, Nc, Nt, t)

# Scale drop-off rates
assay(se, "dropoff_rate") <- scaleDOR(se, nuclSelection, Nc, Nt)
```

### 3. Bias Correction (Variance Stabilization)
Correct for coverage-dependent bias in the log-drop-off rate ratios (LDRs).

```R
varStab <- stabiliseVariance(se, nuclSelection, Nc, Nt)
LDR_C <- varStab$LDR_C   # Control-control LDRs (null distribution)
LDR_CT <- varStab$LDR_CT # Treatment-control LDRs
```

### 4. Defining Stretches and Sequence Patterns
The HMM requires continuous stretches of nucleotides. For large datasets, you can also correct for sequence-specific bias.

```R
# Compute uninterrupted stretches for HMM
stretches <- computeStretches(se, t)

# Optional: Sequence bias correction (recommended for transcriptome-wide)
# sequence <- subject(rowData(se)$nucl)
# patterns <- nuclPerm(3) # 3-mer patterns
# nuclPosition <- findPatternPos(patterns, sequence, '+')

# For single molecules or small datasets, use a single null distribution:
nuclPosition <- list(1:nrow(se))
```

### 5. Computing Posterior Probabilities
Run the HMM to calculate the probability of modification.

```R
posteriors <- computeProbs(LDR_C, LDR_CT, Nc, Nt, '+', nuclPosition,
                           nuclSelection$analysedC, 
                           nuclSelection$analysedCT,
                           stretches)

# posteriors[, 1] is Unmodified probability
# posteriors[, 2] is Modified probability
```

## Interpreting Results
The HMM identifies the nucleotide where the RT dropped off. Because the RT stops *before* the modified base, you must shift the probabilities up by one position to align them with the actual modified nucleotide.

```R
# Shift probabilities to align with modified sites
shifted_probs <- matrix(NA, nrow=nrow(posteriors), ncol=1)
shifted_probs[1:(nrow(posteriors) - 1)] <- posteriors[2:nrow(posteriors), 2]
```

## Tips
- **Replicates:** BUMHMM requires at least 2 control replicates to build a null distribution of variability.
- **Coverage:** Low coverage regions are noisy; ensure the threshold `t` is appropriate for your sequencing depth.
- **Optimization:** The `computeProbs` function has an `optimise` parameter for EM-based parameter estimation, but it is often stable with default settings (NULL).

## Reference documentation
- [BUMHMM: Probabilistic computational pipeline for modelling RNA structure probing data](./references/BUMHMM.md)