---
name: divvier
description: Divvier improves the quality of multiple sequence alignments by identifying and filtering regions of alignment uncertainty. Use when user asks to clean multiple sequence alignments, perform divvying or partial filtering, and prepare alignments for phylogenetic tree construction.
homepage: https://github.com/simonwhelan/Divvier
---


# divvier

## Overview
Divvier is a bioinformatic tool used to improve the quality of Multiple Sequence Alignments by addressing alignment uncertainty. It provides two primary methods for cleaning data: "divvying," which aims to retain as much information as possible by identifying confident homology, and "partial filtering," which evaluates and removes individual characters. This tool is essential when preparing alignments for phylogenetic tree construction, as it helps reduce the impact of poorly aligned regions that can lead to erroneous evolutionary inferences.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::divvier
```

## Common CLI Patterns

### Standard Divvying (Default)
The default mode identifies regions of high uncertainty and masks them.
```bash
divvier input.fas
```

### Preparing Alignments for Phylogeny
For immediate use in phylogenetic software (like RAxML or IQ-TREE), use the following recommended parameters to ensure the output format is compatible and contains sufficient data per column:
```bash
divvier -mincol 4 -divvygap input.fas
```
*   `-mincol 4`: Ensures every output column has at least 4 characters.
*   `-divvygap`: Outputs a standard gap character (`-`) instead of the internal `*` character, ensuring compatibility with most phylogeny programs.

### Partial Filtering
Use this mode to perform a more granular filtering by testing the removal of individual characters rather than entire columns:
```bash
divvier -partial -mincol 4 -divvygap input.fas
```

## Command Options

### Clustering and Filtering
*   `-divvy`: Performs standard divvying (Default).
*   `-partial`: Enables partial filtering of individual characters.
*   `-thresh X`: Sets the threshold for divvying (Default: 0.801). Increasing this value makes the filtering more stringent.
*   `-mincol X`: Minimum number of characters required in a column to be included in the output (Default: 2).

### Approximation and Performance
*   `-approx X`: Minimum number of characters tested in a split during divvying (Default: 10).
*   `-HMMapprox`: Uses the pairHMM bounding approximation for speed (Default).
*   `-HMMexact`: Performs the full pairHMM calculation, ignoring bounding (Slower but more precise).
*   `-checksplits`: Ensures there is a pair for every split. This can significantly slow down processing.

## Expert Tips
*   **Gap Handling**: Always use the `-divvygap` flag if you intend to pipe the output directly into a tree-builder. Without it, Divvier uses a `*` character to represent filtered data, which many tools will reject.
*   **Information Retention**: If your alignment is highly divergent, start with the default `-divvy` mode. If the resulting tree has low support values, try `-partial` filtering to see if retaining specific high-confidence characters improves the signal.
*   **Column Density**: For datasets with many taxa, consider increasing `-mincol` to a higher value (e.g., 10% of the total number of sequences) to ensure that the remaining columns are informative.

## Reference documentation
- [divvier - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_divvier_overview.md)
- [simonwhelan/Divvier: A program for divvying or partially filtering multiple sequence alignments](./references/github_com_simonwhelan_Divvier.md)