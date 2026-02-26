---
name: foldmason
description: FoldMason performs large-scale multiple protein structure alignment by leveraging the 3Di structural alphabet for high speed and accuracy. Use when user asks to perform multiple structure alignments, generate structural trees, visualize structural conservation in HTML reports, or calculate LDDT scores for existing alignments.
homepage: https://github.com/steineggerlab/foldmason
---


# foldmason

## Overview
FoldMason is a high-performance tool designed for large-scale multiple protein structure alignment. Unlike traditional sequence-only aligners, it leverages structural information—specifically the 3Di alphabet developed for Foldseek—to produce accurate alignments even for distantly related proteins. It is optimized for speed and scalability, allowing for the alignment of thousands of structures by utilizing pre-clustering techniques. The tool outputs standard FASTA alignments, Newick-format trees, and interactive HTML reports for visual inspection of structural conservation.

## Core Workflows

### Basic Multiple Structure Alignment
The `easy-msa` module is the primary entry point for most users. It handles database creation, alignment, and tree generation in a single command.

```bash
foldmason easy-msa <PDB/mmCIF files> result tmpFolder
```
*   **Inputs**: Path to structure files (supports wildcards and gzipped files).
*   **Outputs**: 
    *   `result_aa.fa`: Amino acid alignment.
    *   `result_3di.fa`: 3Di alphabet alignment.
    *   `result.nw`: Newick format guide tree.

### Generating Visual Reports
To generate an interactive HTML visualization and calculate LDDT scores, use `--report-mode 1`.

```bash
foldmason easy-msa <PDB/mmCIF files> result tmpFolder --report-mode 1
```

### Aligning Large Datasets
For very large sets of proteins, use the `--precluster` flag. This utilizes Foldseek's clustering capabilities to group similar structures before alignment, significantly reducing computational overhead.

```bash
foldmason easy-msa <PDB/mmCIF files> result tmpFolder --precluster
```

## Advanced Modules and Refinement

### Iterative Refinement
If the initial alignment quality is insufficient, use `refinemsa` to iteratively split and re-align the sequences to maximize the average LDDT score.

```bash
foldmason refinemsa structureDB input.fasta refined.fasta --refine-iters 1000
```
*   Note: This can also be triggered within `easy-msa` using the `--refine-iters` parameter.

### Structure-Based Scoring (LDDT)
To calculate the Local Distance Difference Test (LDDT) score for an existing MSA (even one created by other tools), use the `msa2lddt` module.

```bash
foldmason msa2lddt structureDB alignment.fasta
```
*   **Requirement**: The structures referenced in the FASTA must exist in the provided `structureDB`.

## Important Parameters

| Parameter | Category | Description |
| :--- | :--- | :--- |
| `--gap-open` | Alignment | Gap opening penalty (default: 10). |
| `--gap-extend` | Alignment | Gap extension penalty (default: 1). |
| `--refine-iters` | Alignment | Number of refinement iterations (default: 0). |
| `--output-mode` | Alignment | 0: Amino acids, 1: 3Di alphabet (default: 0). |
| `--pair-threshold` | Scoring | Max proportion of gaps in a column for LDDT calculation (default: 0.0). |

## Expert Tips
*   **3Di vs. AA**: Always check the `_3di.fa` output when dealing with highly divergent proteins; the structural alphabet often reveals conservation that amino acid sequences hide.
*   **Database Reuse**: If you plan to align the same set of structures multiple times with different parameters, use `createdb` first to save time on preprocessing.
*   **Webserver Compatibility**: Use `--report-mode 2` in `easy-msa` to generate a JSON file that can be uploaded to the FoldMason webserver for sharing and remote visualization.

## Reference documentation
- [FoldMason GitHub Repository](./references/github_com_steineggerlab_foldmason.md)
- [FoldMason Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_foldmason_overview.md)