---
name: baczy
description: Baczy is a Snakemake-based workflow for the automated assembly, annotation, and functional characterization of bacterial genomes. Use when user asks to assemble bacterial genomes from short or long reads, identify antimicrobial resistance and virulence factors, or perform pangenome and comparative genomics analyses.
homepage: https://github.com/npbhavya/baczy/
---


# baczy

## Overview
Baczy is an end-to-end Snakemake-based workflow designed for the assembly and functional characterization of bacterial host genomes. It automates the transition from raw sequencing data to high-quality annotated genomes, providing specialized modules for identifying antimicrobial resistance (AMR), defense systems, virulence factors, and prophage regions. It is an ideal tool for comparative genomics and pangenome analysis across multiple bacterial isolates.

## Installation and Setup
Install the toolkit via pip (recommended for the current version):
```bash
pip install baczy
```

### Database Configuration
Baczy requires external databases (CheckM2, GTDB-Tk, and CapsuleDB). You must set the database path environment variable before execution:
```bash
export BACZY_DATABASE_PATH=/path/to/your/database_directory
```

## Command Line Usage

### Standard Run (Short Reads)
For paired-end Illumina data, use the following pattern:
```bash
baczy run --input sample-data/illumina --cores 32 --use-singularity --sdm apptainer --output results_dir -k --use-conda
```

### Long Read Assembly
When working with Nanopore or other long-read data, specify the sequencing type to trigger the Hybracter assembly module:
```bash
baczy run --input sample-data/nanopore --sequencing longread --cores 32 --output results_dir -k --use-singularity --sdm apptainer --use-conda
```

### Key CLI Arguments
- `--input`: Directory containing raw fastq files.
- `--sequencing`: Set to `longread` for Nanopore; defaults to short-read processing.
- `--use-singularity`: Enables containerized execution of sub-tools (highly recommended for GTDB-Tk and Bakta).
- `--sdm`: Specifies the software deployment manager (e.g., `apptainer`).
- `-k`: Continues the workflow even if individual jobs fail.

## Expert Tips and Best Practices
- **Taxonomic Filtering**: Before running, customize the GTDB-Tk parameters if you are working with specific genera to improve tree resolution. You can modify the `outgroup` and `taxa_filter` settings within the workflow configuration to target specific groups like "g__Escherichia".
- **Resource Management**: GTDB-Tk and Panaroo are memory-intensive. Ensure the `--cores` value aligns with available system RAM (typically 4GB+ per core for bacterial genomics).
- **Output Locations**: 
    - Final summaries are consolidated in `RESULT-short` or `RESULTS-long`.
    - Check `amrfinder_summary.tsv` and `defensefinder_summary.tsv` for a high-level view of resistance and immunity across all samples.
    - Use the `.decorated.tree` files from the GTDB-Tk output for immediate visualization in tools like iTOL.
- **Intermediate Files**: If a run is interrupted, check `baczy.out/PROCESSING` to resume or troubleshoot specific assembly stages.

## Reference documentation
- [GitHub Repository - npbhavya/baczy](./references/github_com_npbhavya_baczy.md)
- [baczy - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_baczy_overview.md)