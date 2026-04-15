---
name: bioconductor-brain
description: This tool calculates isotopic distributions, monoisotopic masses, and average masses for large biological molecules using the BRAIN algorithm. Use when user asks to predict mass spectrometry patterns, determine atomic compositions from amino acid sequences, or perform high-throughput isotopic calculations for proteins.
homepage: https://bioconductor.org/packages/release/bioc/html/BRAIN.html
---

# bioconductor-brain

name: bioconductor-brain
description: Calculate aggregated isotopic distributions, monoisotopic masses, and average masses for biological molecules (peptides/proteins) using the BRAIN algorithm. Use this skill when you need to predict mass spectrometry patterns, determine atomic compositions from amino acid sequences, or perform high-throughput isotopic calculations for large biomolecules.

## Overview

The BRAIN (Baffling Recursive Algorithm for Isotopic distri-butioN) package provides a memory-efficient method for calculating the isotopic distribution of molecules. It is particularly optimized for large molecules like proteins where traditional combinatorial methods fail. It supports molecules composed of Carbon (C), Hydrogen (H), Nitrogen (N), Oxygen (O), and Sulfur (S).

## Core Functions

- `useBRAIN()`: The primary wrapper function. Returns probabilities, center-masses, and average mass.
- `getAtomsFromSeq()`: Converts an amino acid sequence (e.g., "ACDEF") into an atomic composition list.
- `calculateMonoisotopicMass()`: Computes the theoretical monoisotopic mass.
- `calculateAverageMass()`: Computes the theoretical average mass.
- `calculateIsotopicProbabilities()`: Returns only the probabilities of the isotopic variants.
- `calculateNrPeaks()`: Heuristically determines the number of peaks needed to capture the distribution.
- `useBRAIN2()`: An optimized version supporting heuristics for faster computation on very large molecules.

## Typical Workflows

### 1. Basic Isotopic Distribution for a Chemical Formula
Define the atomic composition as a named list and pass it to `useBRAIN`.

```r
library(BRAIN)
# Define Angiotensin II: C50 H71 N13 O12
atoms <- list(C=50, H=71, N=13, O=12)

# Calculate distribution
res <- useBRAIN(aC = atoms)

# Access results
res$monoisotopicMass
res$avgMass
res$isoDistr  # Probabilities
res$masses    # Center-masses
```

### 2. Working with Protein Sequences
Use `getAtomsFromSeq` to handle amino acid strings directly.

```r
seq <- "MSGRGKGGKGLGKGGAKRHRKVLRDNIQGITKPAIRRLARRGGVKRISGLIYEETRGVLK"
atoms <- getAtomsFromSeq(seq)
res <- useBRAIN(aC = atoms)

# Plotting the distribution
plot(res$masses, res$isoDistr, type="h", main="Isotopic Distribution")
```

### 3. High-Throughput Heuristics (BRAIN 2.0)
For extremely large molecules or large datasets, use `useBRAIN2` with approximation parameters.

- **RCL (Recurrence of Constant Length)**: Use `approxParam` (suggested value >= 5) to limit multiplications.
- **LSP (Late Starting Point)**: Use `approxStart` to focus on the most abundant peaks, skipping the near-zero probabilities at the start of the distribution for heavy molecules.

```r
# Example with RCL heuristic
res_fast <- useBRAIN2(aC = atoms, nrPeaks = 1000, approxParam = 10)
```

## Usage Tips

- **Stopping Criteria**: In `calculateIsotopicProbabilities` or `useBRAIN`, you can stop calculations based on `nrPeaks`, `coverage` (e.g., 0.99), or `abundantEstim`.
- **Memory Efficiency**: BRAIN is designed to avoid combinatorial explosion, making it suitable for proteins with tens of thousands of atoms.
- **Natural Amino Acids**: `getAtomsFromSeq` expects standard 1-letter codes for the 20 natural amino acids.

## Reference documentation

- [Bioconductor BRAIN Package Vignette](./references/BRAIN-vignette.md)