---
name: pacini_typing
description: The `pacini_typing` skill enables the automated detection of genes and SNPs within bacterial genomes.
homepage: https://github.com/RIVM-bioinformatics/Pacini-typing
---

# pacini_typing

## Overview

The `pacini_typing` skill enables the automated detection of genes and SNPs within bacterial genomes. The tool functions as a wrapper for high-performance alignment engines—specifically BLAST for assembled sequences and KMA for raw sequencing reads. It is designed for high-throughput genotyping workflows where consistency is maintained through external configuration files that define genetic thresholds and reference databases. Use this skill to characterize isolates, identify pandemic-related genetic patterns, and generate genotyping reports from raw or assembled sequence data.

## Command Line Usage

The primary entry point is the `pacini_typing` command. It requires a configuration file, input sequence files, and a designated search mode.

### Primary Search Modes
- **genes**: Focuses on identifying the presence or absence of specific gene sequences.
- **SNPs**: Identifies point mutations and variants relative to a reference.
- **both**: Executes both gene and SNP detection in a single pass.

### Common CLI Patterns

**Analyzing Assembled Contigs (FASTA)**
To search for genes in an assembly:
`pacini_typing --config path_to_config.yaml --input sample_contigs.fasta --search_mode genes`

**Analyzing Raw Reads (FASTQ)**
To detect SNPs from paired-end raw data:
`pacini_typing --config path_to_config.yaml --input forward_reads.fastq reverse_reads.fastq --search_mode SNPs`

**Comprehensive Genotyping**
To run a full analysis on an isolate:
`pacini_typing --config path_to_config.yaml --input sample.fasta --search_mode both`

### Database Management Subcommands
- **makedatabase**: Used to manually initialize or update the gene reference database.
- **query**: Allows for running manual, ad-hoc queries against an existing reference database without a full genotyping run.

## Best Practices and Expert Tips

### Environment and Dependencies
- **Path Verification**: Ensure that `makeblastdb` (from BLAST+) and `kma_index` (from KMA) are available in your system PATH. The tool relies on these subcommands for indexing reference sequences on the fly.
- **Conda Integration**: It is recommended to run the tool within its dedicated Conda environment to ensure version compatibility for `cgecore`, `pyyaml`, and alignment tools.

### Input Handling
- **File Extensions**: The tool accepts `.fa`, `.fasta`, `.fastq`, and `.fq` extensions. Ensure paired-end FASTQ files are provided together in the `--input` argument.
- **Search Mode Selection**: Use `SNPs` mode when working with raw reads (FASTQ) for better accuracy via KMA mapping. Use `genes` mode for rapid screening of assemblies via BLAST.

### Configuration Logic
- **Metadata**: The configuration file should contain a metadata section (filename, ID, type, description) which is used to populate the final output report.
- **Thresholds**: Genetic thresholds (identity and coverage) are defined within the configuration. If results are unexpectedly empty, verify that the thresholds in the config are not set too stringently for the quality of your input data.
- **PointFinder Integration**: When using SNP mode, the tool can automatically install or reference PointFinder scripts if the path is specified in the configuration.

## Reference documentation
- [Pacini-typing GitHub Repository](./references/github_com_RIVM-bioinformatics_Pacini-typing.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pacini_typing_overview.md)