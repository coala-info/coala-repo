---
name: wub
description: wub is a bioinformatics tool suite for analyzing and simulating nanopore sequencing data, providing utilities for quality control, alignment analysis, and sequence manipulation. Use when user asks to simulate nanopore errors, assess genome assembly accuracy, perform quality control on transcriptome alignments, extract metrics from aligned nanopore reads, process sequence files, summarize read length distributions, quantify transcripts, or compare expression data.
homepage: https://github.com/nanoporetech/wub
---

# wub

## Overview
The `wub` (Oxford Nanopore Technologies Applications group) library is a specialized suite of bioinformatics tools designed to handle the unique characteristics of nanopore sequencing data. It is particularly useful for researchers needing to simulate nanopore-like errors, assess the accuracy of genome assemblies, or perform detailed quality control on transcriptome alignments. The toolset bridges the gap between raw sequence data and downstream biological interpretation through a variety of BAM, Fastq, and Fasta utilities.

## Core Capabilities and CLI Tools

The `wub` package provides several standalone scripts located in the `scripts/` directory. Most tools follow a standard CLI pattern: `python [script_name].py [options]`.

### BAM and Alignment Analysis
Use these tools to extract metrics from aligned nanopore reads:
- **`bam_accuracy.py`**: Calculates read-level and assembly-level accuracy metrics.
- **`bam_cov.py`**: Gathers comprehensive reference and read coverage information.
- **`bam_frag_coverage.py`**: Analyzes coverage across specific intervals and generates length-interval distributions. Use the `--save_cov80` flag if available to track high-breadth coverage scores.
- **`bam_ref_tab`**: Generates tabular summaries of alignments, with options to preserve read strand information.

### Sequence Manipulation and Simulation
- **Simulation**: Generate synthetic sequences with realistic nanopore error profiles for testing pipelines.
- **Fastq/Fasta Utilities**: Basic processing, filtering, and property visualization for sequence files.
- **Length Tables**: Use the length table generation script to summarize read length distributions across large datasets.

### Transcriptome and Expression QC
- **Transcriptome QC**: Specialized tools for assessing the quality of cDNA or direct RNA alignments.
- **Read Counting**: Utilities for quantifying transcripts and correlating counts between samples.
- **`plot_counts_correlation`**: A visualization tool for comparing expression or count data across different experimental conditions.

## Best Practices
- **Help Discovery**: Since `wub` is a collection of scripts, always use the `--help` flag on individual scripts (e.g., `python scripts/bam_accuracy.py --help`) to discover specific parameter requirements, as many tools have unique filtering options for mapping quality or base quality.
- **Virtual Environments**: Always run `wub` within a dedicated virtual environment to avoid conflicts with Biopython or other dependencies.
- **Data Merging**: Use the provided tab-separated file merging utility for consolidating outputs from parallelized runs across multiple flow cells.
- **Developer Mode**: If modifying the source code or adding custom scripts, install in developer mode using `python setup.py develop` to ensure changes are reflected immediately in the CLI tools.



## Subcommands

| Command | Description |
|---------|-------------|
| bam_accuracy.py | Produce accuracy statistics of the input BAM file. Calculates global accuracy and identity and various per-read statistics. The input BAM file must be sorted by coordinates and indexed. |
| bam_cov.py | Produce refrence coverage table. |
| bam_frag_coverage.py | Produce aggregated and individual plots of fragment coverage. |

## Reference documentation
- [wub Overview](./references/anaconda_org_channels_bioconda_packages_wub_overview.md)
- [wub GitHub Repository](./references/github_com_nanoporetech_wub.md)
- [wub Commit History and Script List](./references/github_com_nanoporetech_wub_commits_master.md)