---
name: qimba
description: Qimba is a bioinformatics toolkit for managing and processing metabarcoding sequencing workflows. Use when user asks to generate sample mapping files, merge paired-end reads, dereplicate sequences, or convert DADA2 outputs.
homepage: https://github.com/quadram-institute-bioscience/qimba
---


# qimba

## Overview
Qimba is a specialized bioinformatics toolkit developed by the Quadram Institute for managing metabarcoding workflows. It provides a modular command-line interface to handle the transition from raw sequencing data to processed, analysis-ready formats. The tool is particularly effective for researchers needing to automate the creation of sample sheets, perform quality control through read merging, and manage sequence redundancy via dereplication.

## Command Line Usage

### Sample Management
The foundation of a Qimba workflow is the mapping file, which tracks Sample IDs and their associated read files.

*   **Generate a mapping file**: Automatically scan a directory for FASTQ files to create a sample sheet.
    `qimba make-mapping <data_directory> -o mapping.tsv`
*   **Inspect samples**: Verify the contents and structure of an existing mapping file.
    `qimba show-samples -i mapping.tsv`

### Sequence Processing
*   **Merge paired-end reads**: Combine forward and reverse reads based on the mapping file.
    `qimba merge -i mapping.tsv -o merged.fastq --threads 8`
*   **Dereplicate sequences**: Reduce data size by collapsing identical sequences while maintaining abundance information.
    `qimba derep -i merged.fasta -o unique.fasta`

### Format Conversions and Validation
*   **DADA2 Integration**: Convert DADA2-formatted outputs into standard FASTA and simplified TSV files for downstream tools.
    `qimba dada2-split -i dada2_output.rds -o output_prefix`
*   **Validate TSV files**: Ensure metadata or mapping files are correctly formatted.
    `qimba check-tab -i file.tsv`

## Best Practices and Configuration

### Global Configuration
Qimba looks for a configuration file at `~/.config/qimba.ini`. You can set persistent defaults here to simplify CLI commands:
```ini
[qimba]
default_output_dir = .
threads = 4
```
To override these settings for a specific run, use the `--config` flag:
`qimba --config custom_settings.ini [command]`

### Workflow Optimization
*   **Threading**: Always specify `--threads` for `merge` and `derep` operations to significantly reduce processing time on multi-core systems.
*   **Mapping Files**: Ensure your mapping files contain the required columns: `Sample ID`, `Forward`, and `Reverse`. Qimba uses these as the primary keys for all batch processing.
*   **Validation**: Run `check-tab` before starting long-running merge or dereplication jobs to catch formatting errors in your sample sheets early.



## Subcommands

| Command | Description |
|---------|-------------|
| check-tab | Check TSV files for their dimensions and consistency. |
| dada2-split | Split DADA2 TSV file into FASTA and simplified TSV. |
| make-mapping | Generate a sample mapping file from a directory of sequence files. |
| merge | Merge paired end into a single file using USEARCH |
| qimba_derep | Dereplicate FASTA sequences using USEARCH. |
| show-samples | Display sample information from a mapping file. |

## Reference documentation
- [Qimba Main Repository](./references/github_com_quadram-institute-bioscience_qimba.md)
- [CLI Concepts and Structure](./references/github_com_quadram-institute-bioscience_qimba_wiki_CLI_concepts.md)
- [Common Functions and Core Components](./references/github_com_quadram-institute-bioscience_qimba_wiki_Common_functions.md)