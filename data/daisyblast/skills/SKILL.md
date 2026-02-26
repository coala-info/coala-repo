---
name: daisyblast
description: daisyblast is a bioinformatics pipeline that performs all-vs-all BLAST searches and uses a Union-Find algorithm to identify and visualize syntenic groups across multiple genomes. Use when user asks to identify conserved genomic architecture, perform daisy-chaining synteny analysis, or generate linear and circular plots of shared sequence groups.
homepage: https://github.com/erinyoung/daisyblast
---


# daisyblast

## Overview

daisyblast is a bioinformatics pipeline designed to move beyond simple pairwise BLAST comparisons. It performs an all-vs-all BLAST search across multiple input genomes, "shatters" the resulting alignments into non-overlapping windows, and applies a Union-Find algorithm to identify syntenic groups shared across the entire dataset. This "daisy-chaining" logic ensures that if Sequence A aligns with B, and B aligns with C, all three are unified into a single synteny group. The tool is particularly useful for visualizing conserved genomic architecture through linear maps, Circos-style circular plots, and dotplots.

## Installation and Prerequisites

- **Dependencies**: Requires Python ≥ 3.8 and NCBI BLAST+ (`makeblastdb` and `blastn`) to be available in your system PATH.
- **Installation**:
  ```bash
  pip install daisyblast
  # OR
  conda install bioconda::daisyblast
  ```

## Command Line Usage

The primary interface is the `daisyblast` command.

### Basic Execution
To run a standard synteny analysis on multiple FASTA files:
```bash
daisyblast -i genome1.fasta genome2.fasta genome3.fasta -o output_directory
```

### Filtering and Sensitivity
Adjust the stringency of the synteny detection using identity and length thresholds:
- **Percent Identity**: Use `--min_pident` (default: 90.0) to filter out low-identity hits.
- **Alignment Length**: Use `--min_length` (default: 200) to set the minimum window size after shattering.
- **E-value**: Use `-e` (default: 1e-10) to control the statistical significance of the initial BLAST search.

### Managing Output Complexity
If dealing with many sequences or highly fragmented data:
- **Group Limit**: Use `-n` (default: 20) to limit the maximum number of synteny groups included in the final BED file and plots, focusing on the most significant conserved regions.

## Best Practices and Expert Tips

- **Unique Identifiers**: daisyblast automatically renames headers to `${filename}__${original_header}`. Ensure your input filenames are descriptive and unique to avoid confusion in the resulting plots.
- **Shattering Logic**: The tool handles overlapping BLAST hits by "shattering" them into discrete windows. If you see unexpected gaps in synteny, consider lowering the `--min_length` to capture smaller conserved segments.
- **Interpreting Visualizations**:
    - **Circular Plots**: The query sequence forms the outer ring; colored blocks indicate hits shared by two or more sequences.
    - **Dotplots**: Use these to identify structural variations. Downward diagonals indicate inversions, while gaps indicate insertions or deletions (indels).
    - **Coverage Summaries**: These NCBI-style charts use color coding (Red/Pink for bitscores >80, Blue/Black for lower) to show alignment depth.
- **Data Extraction**: For downstream custom analysis, refer to `final_groups.txt` for the specific coordinates of identified synteny groups and `divided.bed` for the shattered genomic windows.

## Reference documentation
- [DaisyBlast GitHub Repository](./references/github_com_erinyoung_daisyblast.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_daisyblast_overview.md)