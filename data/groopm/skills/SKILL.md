---
name: groopm
description: Groopm performs metagenomic binning to assemble and analyze microbial communities. Use when user asks to perform metagenomic binning, analyze assembled genomes from metagenomic data, or work with microbial community structures.
homepage: https://ecogenomics.github.io/GroopM/
---


# groopm

yaml
name: groopm
description: |
  Metagenomic binning suite for assembling and analyzing microbial communities.
  Use when Claude needs to perform metagenomic binning, analyze assembled genomes from metagenomic data, or work with microbial community structures.
```
## Overview
The groopm skill is designed for metagenomic binning, a crucial step in analyzing complex microbial communities. It helps in assembling and organizing genomes from mixed DNA samples, allowing for the study of individual microbial populations within a larger ecosystem. This skill is useful when you need to identify and characterize the distinct microbial genomes present in a metagenomic dataset.

## Usage Instructions

groopm is a command-line tool. The primary workflow involves providing assembled contigs and coverage information to generate bins.

### Core Command Structure

The general structure for running groopm is:

```bash
groopm -o <output_directory> -c <contigs.fasta> -b <coverage_file>
```

### Key Parameters

*   `-o, --output <output_directory>`: Specifies the directory where the output bins will be saved. This is a required parameter.
*   `-c, --contigs <contigs.fasta>`: Path to the FASTA file containing the assembled contigs. This is a required parameter.
*   `-b, --coverage <coverage_file>`: Path to the coverage file. This file typically contains per-contig coverage information derived from mapping sequencing reads back to the contigs. This is a required parameter.

### Coverage File Format

The coverage file is crucial for groopm to differentiate between contigs belonging to different genomes. It should be a tab-separated file with at least two columns:

1.  **Contig ID**: Must exactly match the contig IDs in your contigs FASTA file.
2.  **Coverage Value**: A numerical value representing the average coverage for that contig.

Example coverage file (`coverage.tsv`):

```
contig_1   15.7
contig_2   22.1
contig_3   14.9
contig_4   55.3
```

### Example Workflow

1.  **Prepare your data**: Ensure you have your assembled contigs in a FASTA file (e.g., `assembly.fasta`) and a corresponding coverage file (e.g., `coverage.tsv`).
2.  **Run groopm**: Execute the command, specifying an output directory.

    ```bash
    groopm -o ./groopm_bins -c assembly.fasta -b coverage.tsv
    ```

This command will create a directory named `groopm_bins` and populate it with the generated bins, which are typically FASTA files representing individual microbial genomes.

### Expert Tips

*   **Coverage is Key**: The quality of your bins heavily relies on the accuracy and completeness of your coverage file. Ensure reads are mapped appropriately to generate reliable coverage values.
*   **Contig Quality**: Longer and more complete contigs generally lead to better binning results. Pre-processing your assembly for quality can improve groopm's performance.
*   **Output Interpretation**: The output bins are heuristic. Always validate the resulting bins using other tools (e.g., CheckM) to assess their completeness and contamination.

## Reference documentation
- [groopm Overview](./references/anaconda_org_channels_bioconda_packages_groopm_overview.md)