---
name: bioconductor-crisprscore
description: The crisprScore package provides a unified R interface for calculating on-target and off-target activity scores for CRISPR gRNAs using various state-of-the-art algorithms. Use when user asks to score gRNA activity, predict off-target effects, calculate CFD or MIT specificity scores, or estimate frameshift probabilities for different nucleases like Cas9, Cas12a, and Cas13d.
homepage: https://bioconductor.org/packages/release/bioc/html/crisprScore.html
---

# bioconductor-crisprscore

## Overview

The `crisprScore` package provides a unified R interface for state-of-the-art CRISPR gRNA scoring algorithms. It supports multiple nucleases including SpCas9, AsCas12a (Cpf1), enAsCas12a, and RfxCas13d (CasRx). The package is essential for prioritizing gRNAs based on predicted activity and minimizing potential off-target effects.

## Core Workflow

### 1. Identify Required Input Sequences
Each algorithm requires a specific "context" (nucleotides upstream and downstream of the PAM). You can check requirements using the built-in metadata:

```r
library(crisprScore)
data(scoringMethodsInfo)
# View required 'left' and 'right' offsets relative to the PAM
print(scoringMethodsInfo)
```

### 2. On-Target Scoring (Cas9)
Most Cas9 methods (Azimuth, RuleSet3, DeepSpCas9) require a 30bp input: [4bp flank] + [20bp spacer] + [3bp PAM] + [3bp flank].

```r
# Example for Azimuth/RuleSet3
input_seq <- "ACCTATCGATGCTGATGCTAGATAAGGTTG" 

# Azimuth (Rule Set 2 improved)
az_scores <- getAzimuthScores(input_seq)

# Rule Set 3 (requires tracrRNA type: "Hsu2013" or "Chen2013")
rs3_scores <- getRuleSet3Scores(input_seq, tracrRNA="Hsu2013")

# DeepHF (Only needs 23bp: spacer + PAM)
deephf_input <- "ATCGATGCTGATGCTAGATAAGG"
hf_scores <- getDeepHFScores(deephf_input, enzyme="WT", promoter="U6")
```

### 3. On-Target Scoring (Cas12a)
Cas12a methods typically require 34bp: [4bp flank] + [4bp PAM] + [23bp spacer] + [3bp flank].

```r
cas12_input <- "ACCA" %p% "TTTT" %p% "AATCGATGCTGATGCTAGATATT" %p% "AAG"
# DeepCpf1
cpf1_scores <- getDeepCpf1Scores(cas12_input)
# enPAM+GB (for enhanced Cas12a)
enpam_scores <- getEnPAMGBScores(cas12_input)
```

### 4. Off-Target Specificity (CFD and MIT)
These functions compare a spacer against potential off-target protospacers.

```r
spacer <- "ATCGATGCTGATGCTAGATA"
protospacers <- c("ACCGATGCTGATGCTAGATA", "ATCGATGCTGATGCTAGATT")
pams <- c("AGG", "AGG")

# CFD is generally preferred over MIT
cfd_results <- getCFDScores(spacers=spacer, protospacers=protospacers, pams=pams)
mit_results <- getMITScores(spacers=spacer, protospacers=protospacers, pams=pams)
```

### 5. Indel/Frameshift Prediction (Lindel)
Predicts the probability of a gRNA inducing a frameshift mutation (Cas9). Requires 65bp: [13bp flank] + [23bp protospacer] + [29bp flank].

```r
lindel_input <- "ACCTTTTAATCGATGCTGATGCTAGATATTAAGTGGCTTTTAATCGATGCTGATGCTAGATATTA"
lindel_scores <- getLindelScores(lindel_input)
```

## Implementation Tips

- **First-time Setup**: On first use, `crisprScore` will automatically download necessary Python modules via `reticulate`. This is a one-time process.
- **Windows Limitations**: `DeepHF`, `DeepCpf1`, and `enPAM+GB` are not available on Windows.
- **Integration**: For large-scale genomic design, use this package in conjunction with `crisprDesign`, which automates the sequence extraction required for these functions.
- **Cas13d (CasRx)**: Use `getCasRxRFScores` with a `DNAStringSet` of the target mRNA sequence. It requires external binaries (RNAfold, RNAplfold, RNAhybrid) to be in the system PATH.

## Reference documentation

- [On-target and off-target scoring for CRISPR gRNAs](./references/crisprScore.md)
- [crisprScore Vignette Source](./references/crisprScore.Rmd)