---
name: bioconductor-rmelting
description: This tool computes melting temperatures and thermodynamic parameters for various nucleic acid duplexes using nearest-neighbor methods or approximative formulas. Use when user asks to calculate Tm for DNA or RNA sequences, predict duplex stability under specific salt and denaturant conditions, or perform batch melting temperature analysis for multiple oligonucleotides.
homepage: https://bioconductor.org/packages/release/bioc/html/rmelting.html
---

# bioconductor-rmelting

name: bioconductor-rmelting
description: Compute melting temperatures (Tm) and thermodynamic parameters (enthalpy, entropy) for nucleic acid duplexes (DNA/DNA, DNA/RNA, RNA/RNA, 2'-O-MeRNA/RNA). Use this skill to calculate Tm for short oligonucleotides (Nearest-neighbor methods) or long sequences (Approximative formulas), including corrections for cations (Na, Mg, Tris, K) and denaturing agents (DMSO, formamide).

## Overview

The `rmelting` package provides an R interface to the MELTING 5 program. It is used to predict the melting temperature of nucleic acid duplexes based on sequence composition, concentration, and environmental conditions (salts and denaturants). It supports various structural features including mismatches, GU wobbles, inosine bases, dangling ends, loops, and locked nucleic acids (LNA).

## Basic Workflow

The primary function is `melting()`. For multiple sequences, use `meltingBatch()`.

### 1. Essential Arguments
To perform a basic calculation, you must provide:
- `sequence`: 5' to 3' sequence of one strand.
- `nucleic.acid.conc`: Molar concentration (e.g., `2e-06`).
- `hybridisation.type`: One of `"dnadna"`, `"rnarna"`, `"dnarna"`, `"rnadna"`, `"mrnarna"`, or `"rnamrna"`.
- `Na.conc` (or other cations): At least one cation concentration is mandatory.

```r
library(rmelting)

# Basic DNA/DNA calculation
res <- melting(sequence = "CAGTGAGACAGCAATGGTCG", 
               nucleic.acid.conc = 2e-06,
               hybridisation.type = "dnadna", 
               Na.conc = 1)

# View the Tm directly
print(res)
```

### 2. Handling Mismatches and Special Bases
If the duplex is not perfectly complementary, you must provide the `comp.sequence`.
- **Inosine**: Use `I` in the sequence.
- **Hydroxyadenine**: Use `A*`.
- **Azobenzenes**: Use `X_C` (cis) or `X_T` (trans).
- **Locked Nucleic Acids**: Use `AL`, `TL`, `GL`, `CL`.

```r
# Single mismatch example
melting(sequence = "CAACTTGATATTAATA", 
        comp.sequence = "GTTGAACTCTAATTAT",
        nucleic.acid.conc = 0.0004, 
        hybridisation.type = "dnadna", 
        Na.conc = 1)
```

### 3. Interpreting Results
The output of `melting()` is a list containing three main components:
- `out$Environment`: Input parameters and detected features (e.g., self-complementarity).
- `out$Options`: The specific models and correction methods used.
- `out$Results`: Thermodynamic values (Enthalpy, Entropy) and the calculated Melting Temperature in Celsius.

### 4. Batch Processing
Use `meltingBatch()` to process a vector of sequences efficiently.

```r
sequences <- c("CAAAAAG", "CAAAAAAG", "TTTTATAATAAA")
results_df <- meltingBatch(sequences, 
                           nucleic.acid.conc = 0.0004,
                           hybridisation.type = "dnadna", 
                           Na.conc = 1)
```

## Advanced Method Selection

The package automatically chooses methods based on sequence length (threshold 60 bp), but you can override these:

- **Approximative (Long sequences)**: Use `method.approx` (e.g., `"ahs01"`, `"san98"`, `"wetdna91"`).
- **Nearest Neighbor (Short sequences)**: Use `method.nn` (e.g., `"all97"`, `"san04"`, `"xia98"`).
- **Ion Corrections**: Use `correction.ion` (e.g., `"owc2204"`, `"san04"`, `"tanmg06"`).
- **Denaturants**: Use `DMSO.conc` with `correction.DMSO` or `formamide.conc` with `correction.formamide`.

## Tips for Accuracy
- **Self-Complementarity**: The package usually detects this automatically, but you can force it using `force.self = TRUE`.
- **Dangling Ends**: Represent dangling ends using dashes (e.g., `"-GTAGCTACA"`).
- **Salt Ratios**: If using mixed salts, `rmelting` uses the ratio of Mg to Monovalent cations to determine the best correction method automatically.

## Reference documentation
- [Computation of melting temperature of nucleic acid duplexes with rmelting](./references/Tutorial.md)