---
name: paml
description: PAML is a suite of programs used for phylogenetic analysis of DNA or protein sequences using maximum likelihood. Use when user asks to detect positive selection, estimate synonymous and nonsynonymous substitution rates, or simulate sequences under evolutionary models.
homepage: https://evomics.org/resources/software/molecular-evolution-software/paml
---


# paml

## Overview
PAML (Phylogenetic Analysis by Maximum Likelihood) is a specialized suite of programs for molecular evolution research. It is the industry standard for detecting positive selection at the molecular level and estimating synonymous and nonsynonymous substitution rates. This skill provides guidance on configuring control files and executing the core programs to perform robust evolutionary tests.

## Core Programs
- **codeml**: The most versatile program; used for codon-based models (selection analysis) and amino acid sequences.
- **baseml**: Used for nucleotide-based models and estimating branch lengths or substitution parameters.
- **yn00**: Implements the Yang and Nielsen (2000) method for estimating dN and dS.
- **evolver**: Used for simulating DNA or protein sequences under specific evolutionary models.

## Workflow and Best Practices

### 1. Input Requirements
PAML requires three primary components for most analyses:
- **Sequence Data**: Typically in PHYLIP format (interleaved or sequential).
- **Tree File**: A Newick-formatted tree. Note that for many tests (like branch-site models), you must label "foreground" branches using symbols like `$1` or `#1`.
- **Control File (.ctl)**: A text file containing parameters and file paths.

### 2. Running the Tools
Execute the programs by passing the control file as the first argument:
```bash
codeml codeml.ctl
baseml baseml.ctl
yn00 yn00.ctl
```

### 3. Control File Configuration
The `.ctl` file is sensitive to formatting. Key parameters include:
- `seqfile`: Path to the alignment.
- `treefile`: Path to the Newick tree.
- `outfile`: Path where results will be written.
- `noisy`: Set to `3` or `9` for detailed output during debugging.
- `verbose`: Set to `1` or `2` to see more detail in the output file.
- `runmode`: `0` uses the user-provided tree; `-2` performs pairwise comparisons.

### 4. Testing for Selection (codeml)
To test for positive selection, you must typically run two models and compare them using a Likelihood Ratio Test (LRT):
- **Site Models**: Compare M1a (nearly neutral) vs. M2a (positive selection) or M7 (beta) vs. M8 (beta & omega).
- **Branch-Site Models**: Compare "Model A" against a null model where omega for the foreground branch is fixed at 1 (`fix_omega = 1`).

### 5. Common Pitfalls
- **Convergence**: ML optimization can get stuck in local optima. Always run the same analysis multiple times with different `small_diff` or `method` values, or varying initial `omega` values (`omega = 0.5`, `omega = 1.5`).
- **Sequence Naming**: Ensure sequence names in the PHYLIP file match the tree file exactly and do not exceed 30 characters (depending on the version).
- **Data Type**: Ensure `seqtype` is set correctly: `1` for codons, `2` for amino acids, `3` for translations.

## Reference documentation
- [PAML Overview and Installation](./references/anaconda_org_channels_bioconda_packages_paml_overview.md)
- [PAML Program Descriptions and Usage](./references/evomics_org_resources_software_molecular-evolution-software_paml.md)