---
name: rsv-typer
description: rsv-typer automates the classification and genomic analysis of Respiratory Syncytial Virus (RSV) from Nanopore sequencing reads. Use when user asks to classify RSV subtypes, generate consensus sequences, or perform genomic surveillance using the rsv-typer pipeline.
homepage: https://github.com/DiltheyLab/RSVTyper
metadata:
  docker_image: "quay.io/biocontainers/rsv-typer:0.5.0--pyh7e72e81_0"
---

# rsv-typer

## Overview
The `rsv-typer` tool is a specialized bioinformatics pipeline designed to automate the classification and genomic analysis of RSV from Nanopore reads. It integrates several industry-standard tools—including Minimap2, Samtools, Nextclade, ARTIC, and Medaka—into a single workflow. Use this skill to guide users through the installation, command-line execution, and interpretation of results for RSV genomic surveillance.

## Installation
The recommended method for installation is via Bioconda to ensure all complex dependencies (like specific versions of ARTIC and Medaka) are correctly managed.

```bash
conda install -c bioconda rsv-typer
```

## Core CLI Usage
The primary command for processing a sample requires the path to reads, a sample identifier, an output location, and a specific Medaka model.

```bash
rsv-typer -i /path/to/reads -s <sample_name> -o /path/to/output -m <medaka_model>
```

### Key Arguments
- `-i`: Path to the directory containing basecalled and demultiplexed Nanopore reads.
- `-s`: Sample name used as a prefix for output files and directories.
- `-o`: The parent directory where results will be stored.
- `-m`: The Medaka model corresponding to the basecaller and flowcell used (e.g., `r941_min_high_g360`).
- `--threads`: (Optional) Specify the number of CPU threads to use for processing.

## Best Practices and Expert Tips
- **Medaka Model Selection**: Always match the `-m` parameter to the version of Guppy/Dorado used for basecalling. Using an incorrect model can significantly degrade the quality of the consensus sequence.
- **Input Quality**: Ensure reads have passed standard quality checks (QC) before running the pipeline. The tool expects "pass" reads that have already been demultiplexed.
- **Output Structure**: The pipeline generates five subdirectories. The most critical files are:
    - **Summary File**: Contains the determined subtype (A or B), the reference used, and the specific genotype.
    - **artic/**: Contains the final consensus FASTA sequence.
- **Resource Management**: For large batches of samples, utilize the `--threads` parameter to reduce processing time, especially during the Medaka polishing and Minimap2 alignment phases.

## Troubleshooting
- **Dependency Versioning**: If running outside of a Conda environment, ensure `artic` is version 1.2.4 and `medaka` is version 1.11.3, as the pipeline logic is specifically tuned to these versions.
- **Missing Outputs**: If the summary file is empty or missing, check the `artic` directory logs to ensure there was sufficient coverage across the RSV genome to support genotyping.

## Reference documentation
- [RSVTyper GitHub Repository](./references/github_com_DiltheyLab_RSVTyper.md)
- [Bioconda rsv-typer Overview](./references/anaconda_org_channels_bioconda_packages_rsv-typer_overview.md)