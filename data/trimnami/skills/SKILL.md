---
name: trimnami
description: Trimnami is a Snaketool designed to streamline the preprocessing of metagenomics samples by automating read trimming and host sequence removal. Use when user asks to preprocess metagenomics data, remove host-derived sequences, or apply specific read-trimming algorithms like Fastp, Prinseq++, and BBtools.
homepage: https://github.com/beardymcjohnface/Trimnami
---

# trimnami

## Overview

Trimnami is a specialized Snaketool designed to streamline the preprocessing of metagenomics samples. It eliminates the need for manual pipeline scripting by providing a unified interface to collect sample data, remove host-derived sequences, and apply various read-trimming algorithms. It is particularly useful for high-throughput environments where consistency across many samples is required.

## Common CLI Patterns

### Basic Trimming
By default, trimnami uses Fastp for read trimming.
```bash
trimnami run --reads path/to/reads/
```

### Using Specific Trimmers
Specify one or more trimming methods (e.g., Prinseq++ or BBtools for viral metagenomics).
```bash
# Use Prinseq++
trimnami run --reads path/to/reads/ prinseq

# Run both Fastp and Prinseq++ simultaneously
trimnami run --reads path/to/reads/ fastp prinseq

# Use BBtools for Round A/B viral metagenomics
trimnami run --reads path/to/reads/ roundAB
```

### Host Removal
To filter out host reads, provide a reference genome in FASTA format.
```bash
trimnami run --reads path/to/reads/ --host host_genome.fasta
```

### Longread (Nanopore) Processing
For longreads, use the `nanopore` target and specify a minimap2 preset.
```bash
trimnami run --reads path/to/reads/ --host host_genome.fasta --minimap map-ont nanopore
```

## Input Handling

Trimnami accepts two types of input for the `--reads` flag:

1.  **Directory**: The tool automatically infers sample names and identifies R1/R2 pairs based on common naming conventions.
2.  **TSV File**: For complex naming or specific file locations, provide a tab-separated file.
    *   Column 1: Sample Name
    *   Column 2: Path to R1 (or single-end) file
    *   Column 3: Path to R2 file (optional)

## Expert Tips and Best Practices

*   **Configuration Customization**: To modify internal parameters of the trimmers, first generate a default configuration file using `trimnami config`. Edit the resulting `trimnami.out/trimnami.config.yaml` and then run the tool with `--configfile path/to/edited_config.yaml`.
*   **Validation**: Always run `trimnami test` or `trimnami testnp` after installation to ensure the environment and dependencies are correctly configured.
*   **Output Organization**: Results are organized by method within the output directory (default: `trimnami.out/`). For example, Fastp results will be in `trimnami.out/fastp/`.
*   **Quality Reports**: Check `trimnami.out/reports/` for MultiQC and FastQC reports to evaluate the effectiveness of the trimming parameters.
*   **Subsampling**: If subsampling is enabled in the config, look for `.subsampled.fastq.gz` files in the method-specific output folders.



## Subcommands

| Command | Description |
|---------|-------------|
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |
| trimnami config | Copy the system default config file |
| trimnami run | Run Trimnami |
| trimnami testnp | Test Trimnami with the test LR dataset and test host |

## Reference documentation
- [Trimnami README](./references/github_com_beardymcjohnface_Trimnami_blob_main_README.md)
- [Trimnami Repository Overview](./references/github_com_beardymcjohnface_Trimnami.md)