---
name: pacini_typing
description: Pacini-typing automates the detection of specific DNA sequences and Single Nucleotide Polymorphisms from raw sequencing reads or assembled genomes. Use when user asks to detect genes, identify SNPs, or perform genomic surveillance and pathogen characterization using FASTQ or FASTA files.
homepage: https://github.com/RIVM-bioinformatics/Pacini-typing
---


# pacini_typing

## Overview
Pacini-typing is a bioinformatics tool developed by the RIVM for the automated detection of specific DNA sequences and Single Nucleotide Polymorphisms (SNPs). It bridges the gap between raw sequencing data (FASTQ) or assembled genomes (FASTA) and actionable typing reports. By utilizing BLAST for assemblies and KMA for raw reads, it provides a unified interface for genomic surveillance and pathogen characterization.

## Core Workflows

### 1. Basic Execution
The tool requires a configuration file and input sequences. Use the `--search_mode` flag to define the scope of the analysis.

```bash
pacini_typing --config path/to/config.yaml --input sample1.fastq sample2.fastq --search_mode SNPs
```

### 2. Search Modes
Select the mode based on the biological question:
- **GENEs**: Detects presence/absence of specific gene sequences.
- **SNPs**: Identifies specific point mutations or variants.
- **Both**: Performs both gene and SNP detection simultaneously.

### 3. Handling Different Input Types
- **FASTQ (Raw Reads)**: Uses KMA (K-mer Alignment) to map reads directly against the reference database.
- **FASTA (Assemblies)**: Uses BLASTN to identify hits within assembled contigs.

## CLI Parameters & Best Practices

- **Input Specification**: You can provide multiple files to the `--input` flag. For paired-end FASTQ data, ensure files are correctly matched.
- **Output Management**: Use `--output` to specify the destination directory. The tool generates a `report.csv` by default, which is optimized for downstream analysis and pipeline compatibility.
- **Identity & Coverage**: While the tool uses defaults, pay attention to the identity thresholds in your configuration, as these significantly impact the sensitivity of SNP calling and gene detection.
- **Database Preparation**: Ensure that `makeblastdb` and `kma_index` are in your system PATH, as Pacini-typing calls these subcommands to prepare reference databases.

## Expert Tips
- **Species Flexibility**: Although validated on *Y. pestis* and *V. cholerae*, the tool is species-agnostic. You can adapt it to any organism by providing the appropriate reference sequences and SNP patterns in the configuration.
- **SNP Pattern Validation**: When creating custom configurations, ensure the SNP patterns follow the tool's expected schema to avoid parsing errors during the validation phase.
- **Snakemake Integration**: The tool is designed to be "Snakemake-friendly" by always producing a consistent `report.csv`, making it easy to wrap into larger automated workflows.



## Subcommands

| Command | Description |
|---------|-------------|
| Pacini-typing makedatabase | Builds a reference database for Pacini typing. |
| Pacini-typing query | Query the Pacini database with sequencing reads. |

## Reference documentation
- [Pacini-typing README](./references/github_com_RIVM-bioinformatics_Pacini-typing_blob_main_README.md)
- [Pacini-typing Overview](./references/anaconda_org_channels_bioconda_packages_pacini_typing_overview.md)
- [Changelog and Version History](./references/github_com_RIVM-bioinformatics_Pacini-typing_blob_main_CHANGELOG.md)