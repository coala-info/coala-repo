---
name: metawrap-classify-bins
description: This tool provides conservative taxonomic assignments for metagenomic bins using Kraken databases. Use when user asks to classify bins, assign taxonomy to draft genomes, or identify organisms in a refined bin set.
homepage: https://github.com/bxlab/metaWRAP
---


# metawrap-classify-bins

## Overview
The `metawrap-classify-bins` module is a specialized component of the MetaWRAP suite that provides high-confidence taxonomic assignments for metagenomic bins. Unlike general taxonomic profilers that might over-classify, this tool is designed to be conservative, ensuring that the assigned taxonomy is supported by the underlying genomic data. It is typically used as a downstream step after binning and refinement to characterize the recovered draft genomes.

## CLI Usage and Patterns

The primary way to interact with this tool is through the MetaWRAP wrapper. The module requires a directory of bins in FASTA format and an output directory.

### Basic Command Syntax
```bash
metawrap classify_bins -b BIN_FOLDER -o OUTPUT_DIR -t THREADS
```

### Key Arguments
- `-b`: Path to the folder containing the bins (files should end in `.fa` or `.fasta`).
- `-o`: Path to the output directory where results and taxonomic tables will be stored.
- `-t`: Number of CPU threads to use (default is 1).

### Workflow Integration
For optimal results, use this module in the following sequence:
1. **Binning**: Generate initial bins using the `binning` module.
2. **Refinement**: Consolidate bins using `bin_refinement`.
3. **Classification**: Run `classify_bins` on the refined bin set to identify the organisms.

## Expert Tips and Best Practices

### Database Configuration
The `classify_bins` module relies on Kraken or Kraken2 databases. Ensure your `config-metawrap` file is correctly edited to point to the location of these databases. If the databases are missing or the path is incorrect, the classification will fail.

### Resource Management
- **Memory**: Taxonomic classification using Kraken is memory-intensive. Ensure the system has at least 64GB of RAM available, especially when using the standard Kraken database.
- **Threads**: Increasing the thread count (`-t`) significantly speeds up the classification process as Kraken scales well with multiple cores.

### Input Requirements
- Ensure all bin files in the input folder have consistent extensions.
- Contig names within the bins should be unique to avoid issues during the classification step.

### Interpreting Results
The module produces a `taxonomy_results.txt` file. This file provides a tab-separated breakdown of the taxonomy for each bin from the Kingdom level down to the Species level. If a bin cannot be confidently classified at a lower rank, it will be left blank or marked as unclassified to maintain the "conservative" accuracy of the tool.

## Reference documentation
- [MetaWRAP - a flexible pipeline for genome-resolved metagenomic data analysis](./references/github_com_bxlab_metaWRAP.md)
- [MetaWRAP requirements for classify_bins step](./references/anaconda_org_channels_bioconda_packages_metawrap-classify-bins_overview.md)