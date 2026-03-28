---
name: metawrap-kraken
description: This tool performs taxonomic classification and visualization of metagenomic reads and assemblies using Kraken and Krona. Use when user asks to classify sequences taxonomically, profile the community composition of raw reads, or generate interactive Krona visualizations for metagenomic assemblies.
homepage: https://github.com/bxlab/metaWRAP
---


# metawrap-kraken

## Overview

The `metawrap kraken` module is a specialized wrapper designed to streamline taxonomic classification and visualization in metagenomic workflows. It integrates Kraken (or Kraken2) for sequence classification and KronaTools for interactive visualization. Unlike standalone Kraken runs, this module provides automated weighting for assembled contigs based on their length and coverage, ensuring that the resulting taxonomic profiles accurately reflect the abundance of organisms in the assembly. It is particularly useful for comparing the community composition of raw reads against the successfully assembled portion of a metagenome.

## Core CLI Usage

The basic syntax for the module is:
`metawrap kraken -o <output_directory> -t <threads> [options] <input_files>`

### Common Command Patterns

**1. Profiling Raw Reads**
To get a quick overview of the community composition from multiple samples:
```bash
metawrap kraken -o KRAKEN_READS -t 24 -s 1000000 sample_1.fastq sample_2.fastq
```
*Note: The `-s` flag subsets the reads to speed up the classification process without significantly sacrificing the profile's accuracy.*

**2. Profiling an Assembly**
When running on an assembly, the module automatically detects contig naming conventions (from metaWRAP's assembly module) to weight taxonomy:
```bash
metawrap kraken -o KRAKEN_ASSEMBLY -t 24 final_assembly.fasta
```

**3. Using Kraken2**
For improved speed and accuracy, use the Kraken2 module (available in metaWRAP v1.3.2+):
```bash
metawrap kraken2 -o KRAKEN2_OUT -t 24 sample_1.fastq sample_2.fastq
```

## Expert Tips and Best Practices

*   **Memory Management**: Kraken databases are large and typically loaded into RAM. If your system has limited memory, use the `--no-preload` option to run the database from the hard disk, though this will significantly slow down processing.
*   **Weighting Logic**: For assemblies, metaWRAP calculates taxonomy weight as `weight = coverage * length`. This prevents short, low-coverage contigs from skewing the visualization.
*   **Subsetting**: When processing large FASTQ files (e.g., >10GB), always use the `-s` flag (e.g., `-s 1000000` for 1 million reads). This provides a representative taxonomic snapshot in a fraction of the time.
*   **Database Configuration**: Ensure your `config-metawrap` file is correctly pointed to your Kraken/Kraken2 databases. You can check your current configuration using `metawrap --show-config`.
*   **Visualization**: The primary output is `kronagram.html`. This is a self-contained interactive file that can be opened in any web browser to explore the taxonomic hierarchy.



## Subcommands

| Command | Description |
|---------|-------------|
| kraken | Run on any number of fasta assembly files and/or or paired-end reads. |
| metawrap | Please select a proper module of metaWRAP. |

## Reference documentation
- [MetaWRAP README](./references/github_com_bxlab_metaWRAP_blob_master_README.md)
- [Module Descriptions](./references/github_com_bxlab_metaWRAP_blob_master_Module_descriptions.md)
- [Usage Tutorial](./references/github_com_bxlab_metaWRAP_blob_master_Usage_tutorial.md)
- [MetaWRAP Changelog](./references/github_com_bxlab_metaWRAP_blob_master_CHANGELOG.md)