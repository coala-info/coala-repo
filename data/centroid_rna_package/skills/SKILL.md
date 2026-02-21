---
name: centroid_rna_package
description: The `centroid_rna_package` is a specialized suite of tools designed for predicting RNA secondary structures.
homepage: https://github.com/satoken/centroid-rna-package
---

# centroid_rna_package

## Overview

The `centroid_rna_package` is a specialized suite of tools designed for predicting RNA secondary structures. Unlike traditional Minimum Free Energy (MFE) methods, it utilizes the gamma-centroid estimator, which often provides superior accuracy by balancing sensitivity and specificity. The package primarily consists of `centroid_fold` for analyzing individual sequences and `centroid_alifold` for predicting consensus structures from multiple sequence alignments. It is highly flexible, allowing users to swap underlying probability models (engines) and incorporate experimental structural constraints.

## Command Line Usage

### Single Sequence Prediction (centroid_fold)

The primary tool for single sequences accepts FASTA format.

```bash
# Basic prediction using the default McCaskill engine
centroid_fold sequence.fa

# Specify a different inference engine (e.g., CONTRAfold)
centroid_fold -e CONTRAfold sequence.fa

# Generate a PostScript file of the predicted structure
centroid_fold --postscript output.ps sequence.fa
```

### Multiple Alignment Prediction (centroid_alifold)

Use this tool when you have a CLUSTAL format alignment to find common structural motifs.

```bash
# Predict common secondary structure from an alignment
centroid_alifold alignment.aln
```

## Advanced Configuration and Best Practices

### Optimizing the Gamma Parameter
The `--gamma` (or `-g`) option controls the weight of base pairs. A higher gamma increases specificity (fewer base pairs), while a lower gamma increases sensitivity.

*   **Exploratory Analysis**: Use a negative value (e.g., `-g -1`) to have the tool automatically calculate and output structures for a wide range of gamma values simultaneously. This is the most efficient way to find the most robust structural features.
*   **Default**: If not specified, the tool typically defaults to a balanced estimation.

### Handling Long Sequences
For sequences where computational time or memory is a concern, use the distance constraint (available for the CONTRAfold engine):

```bash
# Restrict base-pairing to a maximum distance of 100 nucleotides
centroid_fold -e CONTRAfold -d 100 sequence.fa
```

### Incorporating Structural Constraints
You can force specific bases to be paired or unpaired using a modified FASTA format. Use `-C` or `--constraints` to enable this.

**Constraint Format:**
*   `(` and `)` : Forced base pair.
*   `.` : Forced unpaired.
*   `?` : No constraint (allow the algorithm to decide).

Example input file (`constrained.fa`):
```text
>RNA_Molecule
GGCUUCCUUCACAAGGAGUGUU
((((........)))).?????
```

### Stochastic Sampling and Clustering
Instead of using the standard probability matrix, you can use stochastic traceback to sample the structure space:

```bash
# Sample structures and build up to 10 clusters to find the centroids
centroid_fold --sampling --max-clusters 10 sequence.fa
```

## Expert Tips

*   **Engine Selection**: For the highest accuracy based on benchmarks, use the McCaskill engine with Boltzmann likelihood parameters (often the default when ViennaRNA is linked).
*   **Non-canonical Pairs**: By default, the tools focus on standard pairs. Use the `--noncanonical` flag if you suspect the presence of non-standard base interactions.
*   **Environment Variables**: If using the `pfold` engine, ensure `PFOLD_BIN_DIR`, `AWK_BIN`, and `SED_BIN` are correctly set in your environment, as these are required for the wrapper to function.

## Reference documentation
- [Centroid RNA package Overview](./references/github_com_satoken_centroid-rna-package.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_centroid_rna_package_overview.md)