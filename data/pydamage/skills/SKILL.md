---
name: pydamage
description: PyDamage automates the identification and estimation of DNA damage patterns in metagenomic contigs to authenticate ancient DNA. Use when user asks to analyze BAM files for DNA damage, estimate C-to-T transitions, or filter contigs based on damage model statistical significance.
homepage: https://github.com/maxibor/pydamage
---

# pydamage

## Overview

PyDamage is a specialized bioinformatics tool designed to automate the identification and estimation of DNA damage in metagenomic contigs. It models ancient DNA damage patterns, specifically C-to-T transitions resulting from cytosine deamination, to provide a statistical framework for authentication. By using a likelihood ratio test, it helps researchers discriminate between sequences originating from ancient sources and those introduced by modern contamination.

## Installation

Install pydamage using one of the following methods:

- **Conda (Recommended)**: `conda install -c bioconda pydamage`
- **Pip**: `pip install pydamage`

## Command Line Usage

### Core Workflow

The primary workflow involves analyzing an aligned BAM file to estimate damage parameters for each contig.

1. **Analyze a BAM file**:
   ```bash
   pydamage analyze aligned.bam
   ```

2. **Specify an output directory**:
   Note that global options like `--outdir` must be placed **before** the subcommand.
   ```bash
   pydamage --outdir my_results analyze aligned.bam
   ```

3. **Filter results**:
   After analysis, use the filter subcommand on the generated CSV to isolate high-confidence ancient contigs.
   ```bash
   pydamage --outdir filtered_results filter pydamage_results.csv
   ```

### CLI Reference

- `pydamage --help`: Show the main help message and global options.
- `pydamage analyze --help`: Show options specific to the analysis module.
- `pydamage filter --help`: Show options specific to the filtering module.

## Expert Tips and Best Practices

- **Command Ordering**: Always place global flags (like `--outdir` or `--verbose`) before the subcommand (`analyze`, `filter`). Placing them after the subcommand may result in an error or the flag being ignored.
- **Input Preparation**: Ensure your BAM file is sorted and indexed. PyDamage relies on the alignments to calculate the frequency of C-to-T transitions at the ends of reads.
- **Interpreting Results**: The primary output is `pydamage_results.csv`. Focus on the `p-value` and `damage` estimates. A low p-value in the likelihood ratio test indicates that the ancient damage model fits the data significantly better than a null (modern) model.
- **Metagenomics Context**: PyDamage is particularly powerful for de novo assembled metagenomes where traditional map-based authentication (which requires a reference genome) is not possible for all contigs.



## Subcommands

| Command | Description |
|---------|-------------|
| pydamage analyze | Analyze BAM files for DNA damage. |
| pydamage binplot | Plot Damage patterns for a given bin fasta file |
| pydamage filter | Filter PyDamage results on predicted accuracy and qvalue thresholds. |

## Reference documentation

- [PyDamage GitHub Repository](./references/github_com_maxibor_pydamage_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pydamage_overview.md)