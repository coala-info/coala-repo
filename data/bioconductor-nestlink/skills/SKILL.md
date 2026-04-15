---
name: bioconductor-nestlink
description: This tool analyzes NestLink next-generation sequencing and mass spectrometry data to link nanobody sequences with peptide barcodes. Use when user asks to link nanobodies to flycodes, perform in-silico flycode simulations, or conduct quantitative proteomics analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/NestLink.html
---

# bioconductor-nestlink

name: bioconductor-nestlink
description: Analysis of NestLink next-generation sequencing (NGS) and mass spectrometry (MS) data. Use this skill to link nanobody sequences with peptide barcodes (flycodes), perform in-silico flycode simulations, and conduct quantitative proteomics analysis using the NestLink workflow.

## Overview

NestLink is a Bioconductor package designed for the analysis of binding protein ensembles (like nanobodies) using engineered peptide barcodes called "flycodes." The package provides a complete workflow to link high-throughput sequencing data (NGS) of nanobodies to mass spectrometry (MS) proteomics data. This allows for the identification and quantification of specific binders within complex mixtures.

## Core Workflows

### 1. NGS Data Processing (Linking Nanobodies to Flycodes)

The primary entry point for NGS data is the `runNGSAnalysis` function. It processes FASTQ files to identify the linkage between nanobodies (NB) and their associated flycodes (FC).

```R
library(NestLink)
library(Biostrings)

# Define parameters for the analysis
param <- list(
  nReads = 1000,             # Number of reads to process
  maxMismatch = 1,           # Allowed mismatches in pattern search
  NB_Linker1 = "GGCCggcggGGCC", 
  NB_Linker2 = "GCAGGAGGA",
  ProteaseSite = "TTAGTCCCAAGA",
  FC_Linker = "GGCCaaggaggcCGG",
  minNanobodyLength = 348,
  minFlycodeLength = 33,
  minRelBestHitFreq = 0.8    # Quality filter for consensus
)

# Run the analysis
NB2FC <- runNGSAnalysis(file = "path/to/data.fastq.gz", param = param)

# Export linkage as FASTA for proteomics search engines (e.g., Mascot)
fasta_output <- nanobodyFlycodeLinking.as.fasta(NB2FC)
cat(fasta_output[1:5], file = "linkage_database.fasta")
```

### 2. In-Silico Flycode Simulation

Before performing experiments, you can simulate flycode populations to assess mass distribution and hydrophobicity (detectability).

```R
# Define amino acid pools
aa_pool <- c(rep('A', 12), rep('G', 12), rep('P', 12), rep('T', 12))

# Compose random peptides
peptides <- replicate(100, compose_GPGx8cTerm(pool = aa_pool))

# Calculate theoretical properties
library(protViz)
masses <- sapply(peptides, parentIonMass)
hydrophobicity <- sapply(peptides, ssrc) # Sequence-specific retention calculator
```

### 3. Proteomics Data Integration

Once MS data is processed (e.g., via Mascot), NestLink helps analyze the results, focusing on flycode identification and retention time (RT) validation.

```R
# Load experiment data (often via ExperimentHub)
library(ExperimentHub)
eh <- ExperimentHub()
WU160118 <- eh[["EH2070"]] # Example Mascot search results

# Filter for valid flycode patterns
# Pattern: GS + 7 variable AAs + specific C-terminal suffix
PATTERN <- "^GS[ASTNQDEFVLYWGP]{7}(WR|WLTVR|WQEGGR|WLR|WQSR)$"
idx <- grepl(PATTERN, WU160118$pep_seq)
valid_PSMs <- WU160118[idx & WU160118$pep_score > 25, ]

# Compare predicted vs. measured Retention Time
valid_PSMs$ssrc <- sapply(as.character(valid_PSMs$pep_seq), ssrc)
cor(valid_PSMs$RTINSECONDS, valid_PSMs$ssrc, method = 'spearman')
```

### 4. Quantitative Analysis

NestLink supports both absolute and relative quantification of nanobodies based on flycode intensities.

```R
# Aggregate flycode intensities to nanobody level
# P is a data frame with 'Accession' (NB ID) and intensity columns
NB_summary <- aggregate(cbind(coli1, coli2) ~ Accession + ConcGr, 
                        data = P, FUN = sum)

# Calculate Coefficient of Variation (CV) to assess robustness
NB_summary$CV <- apply(NB_summary[, c("coli1", "coli2")], 1, 
                       function(x) 100 * sd(x) / mean(x))
```

## Tips and Best Practices

- **Pattern Matching**: Use the `PATTERN` variable to strictly filter for flycodes. The standard flycode starts with "GS" and ends with specific tryptic suffixes like "WR" or "WLR".
- **ExperimentHub**: Most reference datasets for NestLink (like `WU160118` or `F255744`) are hosted on ExperimentHub. Use `query(eh, "NestLink")` to find them.
- **ESP Prediction**: The package often references "ESP_Prediction" (Experimental Surface Probability). This is an external metric for LC-MS detectability often included in the metadata of provided datasets.
- **SSRC**: Use the `ssrc` function from the `protViz` package (automatically loaded with NestLink) to predict peptide hydrophobicity, which correlates strongly with HPLC retention time.

## Reference documentation

- [Analyze Flycode Detectability](./references/analyze-flycode-detectibilty.md)
- [Compare Predicted vs Observed Flycodes](./references/compare-predicted-observed-flycodes.md)
- [Link Nanobodies and Flycodes](./references/link-nanobodies-flycodes.md)
- [Make Data](./references/make-data.md)
- [Simulate Flycodes](./references/simulate-flycodes.md)
- [Supplement Note 1](./references/supplement-note1.md)