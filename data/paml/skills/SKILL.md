---
name: paml
description: PAML is a suite of programs for the statistical analysis of DNA and protein sequences using maximum likelihood. Use when user asks to estimate synonymous and non-synonymous substitution rates, detect positive selection, perform Bayesian estimation of species divergence times, or simulate sequence data.
homepage: https://evomics.org/resources/software/molecular-evolution-software/paml
metadata:
  docker_image: "quay.io/biocontainers/paml:4.10.10--h7b50bb2_0"
---

# paml

## Overview

PAML (Phylogenetic Analysis by Maximum Likelihood) is a specialized suite of programs designed for the statistical analysis of DNA and protein sequences. While it is not primarily a tree-building tool, it is the industry standard for testing evolutionary hypotheses, estimating synonymous and non-synonymous substitution rates ($\omega = d_N/d_S$), and performing Bayesian estimation of species divergence times. The package relies heavily on text-based control files to define model parameters and analysis workflows.

## Core Programs and Usage

The PAML package consists of several distinct executables. Most programs look for a default control file in the current directory if no argument is provided.

- **`codeml`**: The most widely used program. It handles both codon-based models (to detect positive selection) and amino acid-based models.
- **`baseml`**: Used for nucleotide-based maximum likelihood analysis and testing various substitution models (JC69, HKY85, GTR, etc.).
- **`mcmctree`**: Performs Bayesian estimation of divergence times using relaxed-clock models and fossil calibrations.
- **`evolver`**: A multi-purpose tool for simulating sequence data, generating random trees, and calculating clade support.
- **`yn00`**: Implements the Yang and Nielsen (2000) method for estimating $d_N$ and $d_S$.

### Execution Patterns

Run programs from the terminal by calling the executable followed by the control file:

```bash
codeml my_analysis.ctl
baseml baseml.ctl
mcmctree mcmctree.ctl
```

For `evolver`, you can use the interactive menu or command-line arguments:
```bash
evolver 9 <MaintreeFile> <TreesFile>  # Calculate clade support
```

## Data Formatting Requirements

PAML is strict regarding input formats. Errors often stem from minor formatting issues.

### Sequence Data (PHYLIP format)
- **Native Format**: PAML uses a variation of the PHYLIP format.
- **Species Names**: Maximum 30 characters. Do not use special symbols like `:`, `(`, `)`, `#`, or `$`.
- **The Two-Space Rule**: PAML identifies the end of a species name by **two consecutive spaces**. Ensure your names do not contain double spaces, and separate the name from the sequence with at least two spaces.
- **Special Characters**: 
  - `.` (dot): Same character as the first sequence.
  - `-` (dash): Alignment gap.
  - `?` (question mark): Undetermined site.

### Tree Files (Newick format)
- Trees must be in Newick format.
- For `codeml` branch or branch-site models, use labels (e.g., `#1`) within the tree string to identify foreground branches.

## Control File (.ctl) Best Practices

Control files are plain text files containing `variable = value` pairs.

- **Mandatory Spaces**: You **must** include spaces on both sides of the equal sign (e.g., `seqfile = data.nuc`).
- **Comments**: Use `*` at the start of a line or after a value to add comments.
- **Paths**: Use absolute or relative paths. If a path contains spaces, escape them with a backslash (`\`).
- **Common Variables**:
  - `seqfile`: Path to sequence data.
  - `treefile`: Path to the Newick tree.
  - `outfile`: Path where results will be written.
  - `noisy`: Controls screen output (0-3).
  - `verbose`: Controls output file detail (0-2).
  - `cleandata`: Set to `1` to remove sites with gaps or ambiguity; `0` to treat them as missing data.

## Expert Tips for Analysis

### Detecting Positive Selection (`codeml`)
To test for positive selection, you typically perform a Likelihood Ratio Test (LRT) between a null model and an alternative model:
- **Site Models**: Compare M1a (Nearly Neutral) vs. M2a (Positive Selection) or M7 (beta) vs. M8 (beta & $\omega$).
- **Branch-Site Models**: Compare Model A (alternative) vs. Model A with $\omega_2 = 1$ fixed (null).

### Handling Large Datasets
- For `baseml`, use the discrete-gamma model (`baseml`) instead of the continuous-gamma model (`baseml1g`) for significantly faster computation.
- In `mcmctree`, use the **approximate likelihood calculation** (Hessian matrix) to speed up divergence time estimation on phylogenomic-scale data.

### Troubleshooting
- If a program aborts immediately, check for:
  - Missing spaces around `=` in the `.ctl` file.
  - Hidden special characters in the PHYLIP sequence names.
  - Mismatch between the number of species/sites declared in the first line of the PHYLIP file and the actual data.



## Subcommands

| Command | Description |
|---------|-------------|
| baseml | BASEML is a program for Maximum Likelihood analysis of nucleotide sequences, part of the PAML (Phylogenetic Analysis by Maximum Likelihood) package. It uses a control file to specify parameters for the analysis. |
| codeml | codeml is a program in the PAML (Phylogenetic Analysis by Maximum Likelihood) package that analyzes DNA or protein sequences using maximum likelihood. |
| evolver | A program from the PAML suite used for simulating DNA, codon, and amino acid sequences, as well as generating random trees and calculating tree distances. |
| yn00 | YN00 in paml version 4.10.10, 29 Jan 2026. Estimating synonymous and nonsynonymous substitution rates between two sequences. |

## Reference documentation

- [Data formatting](./references/github_com_abacus-gene_paml_wiki_Data-formatting.md)
- [BASEML Guide](./references/github_com_abacus-gene_paml_wiki_BASEML.md)
- [CODEML Guide](./references/github_com_abacus-gene_paml_wiki_CODEML.md)
- [Evolver Guide](./references/github_com_abacus-gene_paml_wiki_Evolver.md)
- [MCMCtree Guide](./references/github_com_abacus-gene_paml_wiki_MCMCtree.md)
- [Substitution Models](./references/github_com_abacus-gene_paml_wiki_Substitution-models.md)