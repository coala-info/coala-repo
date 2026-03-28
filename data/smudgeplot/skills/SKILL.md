---
name: smudgeplot
description: Smudgeplot is a bioinformatic tool that visualizes genome structure and ploidy levels by analyzing heterozygous k-mer pairs from genomic reads. Use when user asks to infer ploidy, identify genome structure, extract hetmers, or generate a smudgeplot to distinguish between autopolyploidy and allopolyploidy.
homepage: https://github.com/KamilSJaron/smudgeplot
---

# smudgeplot

## Overview

Smudgeplot is a bioinformatic tool designed for reference-free genome profiling. It works by extracting heterozygous k-mer pairs (hetmers) from k-mer count databases and analyzing the relationship between the sum of their coverages (CovA + CovB) and their relative coverage ratio (CovB / (CovA + CovB)). This approach allows for the visualization of genome structure, helping to identify ploidy levels and distinguish between different types of polyploidy (e.g., autopolyploidy vs. allopolyploidy) based on the "smudges" formed on a 2D histogram.

## Installation

Install the python package and C-backend via pip:

```bash
pip install smudgeplot
```

Note: Smudgeplot requires **FastK** to be installed for k-mer database generation.

## Core Workflow

The standard workflow involves generating a k-mer database, identifying k-mer pairs, and then generating the plot.

### 1. Generate K-mer Database (FastK)
Before using smudgeplot, create a k-mer table from your raw reads:
```bash
FastK -v -t4 -k31 -M16 -T4 reads_R[12].fastq.gz -NFastK_Table
```

### 2. Extract K-mer Pairs (hetmers)
Identify unique k-mer pairs from the FastK database.
```bash
smudgeplot hetmers -L 12 -t 4 -o kmerpairs --verbose FastK_Table
```
*   `-L`: Lower coverage cutoff (critical for filtering out sequencing errors).
*   `-o`: Output prefix (generates a `.smu` file).

### 3. Generate Smudgeplot and Infer Ploidy
Use the `.smu` file to perform the final analysis.
```bash
smudgeplot all -o my_sample_plot kmerpairs.smu
```
*   This command runs the inference and plotting steps together.
*   Outputs include 3 PDFs (log scale, linear scale, and a summary) and tabular data.

## Expert Tips and Best Practices

### Choosing Cutoffs (L and U)
The quality of a smudgeplot depends heavily on the lower (`-L`) and upper (`-U`) coverage cutoffs.
*   **Lower Cutoff (L):** Should be set to exclude the "error tail" in the k-mer distribution. A common rule of thumb is 0.5 times the haploid k-mer coverage.
*   **Upper Cutoff (U):** Should be set to exclude highly repetitive sequences. A common rule of thumb is 8.5 times the haploid k-mer coverage.
*   Use `smudgeplot cutoff` to help calculate meaningful values for these parameters.

### Joint Interpretation with GenomeScope
Always run **GenomeScope** alongside smudgeplot. GenomeScope provides estimates of genome size, heterozygosity, and repeat content, which help validate the 1n coverage estimate used by smudgeplot to label the smudges (e.g., AB, AAB, AAAB).

### Scaling the Plot
If the smudges are compressed at the bottom of the plot, adjust the y-axis:
```bash
smudgeplot all -o scaled_plot kmerpairs.smu -ylim 70
```

### Handling Large Datasets
Smudgeplot is designed to handle large WGS datasets. You can pool multiple libraries (single-end or paired-end) together during the k-mer counting phase to increase coverage, which improves smudge separation.

## Common CLI Tasks

| Task | Description |
| :--- | :--- |
| `smudgeplot cutoff` | Calculate suggested values for lower k-mer histogram cutoffs. |
| `smudgeplot hetmers` | Calculate unique k-mer pairs from a FastK database. |
| `smudgeplot plot` | Generate the 2D histogram and infer ploidy from an existing `.smu` file. |
| `smudgeplot all` | Executes the full pipeline (aggregation, inference, and plotting). |
| `smudgeplot extract` | Extract sequences of k-mer pairs for further analysis. |



## Subcommands

| Command | Description |
|---------|-------------|
| smudgeplot all | Runs all the steps (with default options). |
| smudgeplot cutoff | Calculate meaningful values for lower kmer histogram cutoff. |
| smudgeplot hetmers | Calculate unique kmer pairs from FastK k-mer database. |
| smudgeplot peak_aggregation | Aggregates smudges using local aggregation algorithm. |
| smudgeplot plot | Generate 2d histogram; infer ploidy and plot a smudgeplot. |
| smudgeplot_extract | Extract kmer pair sequences from a FastK k-mer database. |

## Reference documentation
- [Smudgeplot Main README](./references/github_com_KamilSJaron_smudgeplot.md)
- [Smudgeplot Wiki Home](./references/github_com_KamilSJaron_smudgeplot_wiki.md)
- [Choosing L and U Cutoffs](./references/github_com_KamilSJaron_smudgeplot_wiki_chosing-L-and-U.md)
- [Smudgeplot Hetmers Task](./references/github_com_KamilSJaron_smudgeplot_wiki_smudgeplot-hetmers.md)
- [Joint Interpretation with GenomeScope](./references/github_com_KamilSJaron_smudgeplot_wiki_joint-interpretation-of-smudgeplot-and-GenomeScope.md)