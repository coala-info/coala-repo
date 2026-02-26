---
name: qimba
description: Qimba is a modular bioinformatics toolkit for processing raw sequencing data into amplicon sets for metabarcoding workflows. Use when user asks to generate sample sheets, merge paired-end reads, dereplicate sequences, split DADA2 output, or validate TSV files.
homepage: https://github.com/quadram-institute-bioscience/qimba
---


# qimba

## Overview
Qimba (Quadram Institute MetaBarcoding Analysis) is a modular bioinformatics toolkit designed to streamline the transition from raw sequencing data to processed amplicon sets. It provides a standardized command-line interface for common tasks in metabarcoding workflows, including quality control, sequence merging, and data management. Use this skill to execute precise bioinformatics operations without manually constructing complex shell pipelines.

## Core CLI Workflows

### 1. Sample Management
Before processing sequences, use Qimba to organize your dataset.

*   **Generate a sample sheet**: Automatically scan a directory for FASTQ files and create a mapping file.
    `qimba make-mapping <data_directory> -o mapping.tsv`
*   **Inspect samples**: Verify the contents of an existing mapping file.
    `qimba show-samples -i mapping.tsv`

### 2. Sequence Processing
Qimba handles the heavy lifting of read manipulation.

*   **Merge paired-end reads**: Use the mapping file to merge R1 and R2 reads.
    `qimba merge -i mapping.tsv -o merged.fastq --threads 8`
*   **Dereplicate sequences**: Reduce computational load by collapsing identical sequences while maintaining abundance information.
    `qimba derep -i merged.fasta -o unique.fasta`

### 3. Format Conversion and Validation
Ensure your data is compatible with downstream tools like DADA2 or custom R scripts.

*   **DADA2 Integration**: Split DADA2 output into a FASTA file of sequences and a simplified TSV table.
    `qimba dada2-split -i dada2_output.rds -o output_prefix`
*   **Validate TSV files**: Check the structural integrity of tab-separated files to prevent pipeline failures.
    `qimba check-tab -i data.tsv`

## Configuration and Best Practices

### Global Options
Most commands support the following global flags:
*   `--threads <int>`: Set the number of CPU cores (default is 4).
*   `--config <file>`: Use a custom configuration file instead of the default `~/.config/qimba.ini`.

### Expert Tips
*   **Persistent Settings**: Edit `~/.config/qimba.ini` to set a `default_output_dir` and standard thread count to avoid repetitive typing in long-running projects.
*   **Workflow Order**: Always run `qimba check-tab` on manually edited mapping files before starting a `merge` or `derep` operation to catch formatting errors early.
*   **Resource Management**: When working on high-performance computing (HPC) clusters, explicitly set `--threads` to match your job allocation to ensure optimal performance.

## Reference documentation
- [Qimba GitHub Repository](./references/github_com_quadram-institute-bioscience_qimba.md)
- [Qimba Wiki](./references/github_com_quadram-institute-bioscience_qimba_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_qimba_overview.md)