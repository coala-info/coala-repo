---
name: dnmtools
description: dnmtools is a suite of command-line utilities for analyzing large-scale DNA methylation data from bisulfite and Nanopore sequencing. Use when user asks to identify highly methylated regions, detect partially methylated domains, find allelically methylated regions, perform differential methylation analysis, or aggregate methylation levels across genomic features.
homepage: https://github.com/smithlabcode/dnmtools
---


# dnmtools

## Overview
dnmtools is a specialized suite of command-line utilities designed to handle the computational challenges of large-scale DNA methylation data. It supports traditional bisulfite sequencing workflows (WGBS and RRBS) and, as of version 1.5.0, includes functionality for analyzing Nanopore sequencing data with 5mC and 5hmC calls. The toolset covers the entire downstream analysis pipeline, from processing raw counts and symmetrizing CpG sites to statistical modeling of methylation states across the genome.

## Command-Line Usage Patterns

The suite uses a single entry point with various subcommands:
`dnmtools <subcommand> [options] <input_files>`

### Core Analysis Subcommands
- **hmr**: Identifies Highly Methylated Regions (HMRs) using a Hidden Markov Model.
- **pmd**: Detects Partially Methylated Domains (PMDs), typically found in specific cell types or cancer genomes.
- **amrfinder**: Identifies Allelically Methylated Regions (AMRs).
- **radmeth**: Performs differential methylation analysis (DMR finding) using a regression-based approach.
- **sym**: Symmetrizes methylation counts by combining data from CpG sites on opposite strands.
- **metagene**: Aggregates methylation levels across genomic features (e.g., TSS, gene bodies) for visualization.

### Utility Subcommands
- **merge-methcounts**: Combines multiple methylation count files into a single table.
- **roi**: Calculates methylation statistics for specific Regions of Interest (ROI).
- **guessprotocol**: Analyzes input data to determine the sequencing protocol used.
- **xcounts / unxcounts**: Utilities for handling compressed or internal count formats.

## Expert Tips and Best Practices

### Data Preparation
- **Input Sorting**: Ensure your input SAM/BAM files are coordinate-sorted before processing. A common error in `dnmtools` is triggered by unsorted input files, even if the header claims they are sorted.
- **Reference Consistency**: Always use the same reference genome version for mapping and for any genomic coordinates provided to `dnmtools` subcommands (like `roi`).

### Nanopore Integration
- **Version Requirement**: Ensure you are using version 1.5.0 or later for Nanopore support.
- **Input Format**: Nanopore analysis starts with a BAM file containing 5mC and 5hmC tags. Use the `nanopore` specific workflows within the tool to extract these modifications at CpG sites.

### Troubleshooting Common Issues
- **Empty Chromosomes**: Be cautious when working with assemblies containing many small scaffolds; the tool may encounter issues if a chromosome or scaffold contains zero CpG sites.
- **Extreme Methylation Levels**: The `hmr` command can occasionally fail if methylation levels are at absolute extremes (0 or 1) across large regions. If this occurs, check for data artifacts or extremely low coverage.
- **Symmetrization**: When using `sym`, remember that it is intended for CpG context only. If you need to preserve non-CpG site information, verify the specific flags for your version as some default behaviors may filter them out.

## Reference documentation
- [DNMTools GitHub Repository](./references/github_com_smithlabcode_dnmtools.md)
- [DNMTools Issues and Bug Reports](./references/github_com_smithlabcode_dnmtools_issues.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dnmtools_overview.md)