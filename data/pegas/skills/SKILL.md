---
name: pegas
description: PeGAS is a bioinformatic pipeline that automates quality control, de novo assembly, and functional annotation for bacterial genomic data. Use when user asks to process raw Illumina reads into annotated assemblies, generate virulence or AMR gene profiles, or create pangenome reports.
homepage: https://github.com/liviurotiul/PeGAS
---


# pegas

## Overview

PeGAS (Pathogenic Bacterial Genomic Analysis Solution) is a comprehensive bioinformatic pipeline designed to streamline the processing of bacterial genomic data. It automates a multi-step workflow including quality control (FastQC), de novo assembly (Shovill/SPAdes), and functional annotation (Prokka/Abricate). 

Use this skill when you need to:
1. Process raw Illumina paired-end reads into annotated assemblies.
2. Generate pangenome reports and virulence/AMR gene profiles.
3. Choose between a high-throughput Snakemake-based execution or a resource-efficient "lite" version.
4. Configure parallel execution for specific pipeline stages like assembly or annotation.

## Installation and Environment Setup

PeGAS is distributed via Bioconda. It is recommended to use separate environments for the standard and lite versions to manage dependencies effectively.

**Standard Version (Snakemake-based)**
Best for high-throughput runs with many samples.
```bash
conda create -n pegas -c bioconda -c conda-forge pegas
conda activate pegas
```

**Lite Version (Standalone)**
Best for limited RAM/disk space or fewer samples.
```bash
conda create -n pegas-lite -c bioconda pegas-lite
conda activate pegas-lite
```

## Command Line Usage Patterns

The primary entry point for the pipeline is the `pegas` command (or `pegas-lite`).

### Basic Execution
Run the pipeline on a directory containing `fastq.gz` files:
```bash
pegas -d /path/to/reads -o /path/to/output --cores 16
```

### Advanced Resource Control
PeGAS allows fine-grained control over CPU allocation for specific sub-tools. This is critical when balancing heavy assembly tasks against lighter annotation tasks.
```bash
pegas -d ./data -o ./results \
  --cores 32 \
  --shovill-cpu-cores 16 \
  --prokka-cpu-cores 8 \
  --roary-cpu-cores 8
```

### Customizing Analysis
*   **Interactive Reports**: By default, PeGAS generates a static R HTML report. Use the `--interactive` flag to generate a dynamic HTML report for deeper data exploration.
*   **GC Content Filtering**: Provide a custom JSON file to define species-specific GC content limits.
    ```bash
    pegas -d ./data -o ./results --gc custom_limits.json
    ```
*   **Overwriting Results**: Use `--overwrite` to force the pipeline to run even if the output directory already exists.

## Expert Tips and Best Practices

1.  **Input Organization**: Ensure all input files are compressed (`.fastq.gz`) and stored in a single directory. PeGAS identifies pairs automatically.
2.  **GUI Mode**: If you prefer a visual interface for configuration, simply run `pegas` or `pegas-lite` without any arguments to launch the built-in GUI.
3.  **Output Inspection**:
    *   Check `report/report_r.html` for a clean summary of QC and assembly metrics.
    *   The `results/` folder contains the raw outputs from Shovill (contigs), Prokka (annotations), and Abricate (gene hits).
4.  **Platform Compatibility**: While PeGAS is native to Linux, use WSL2 or Docker when running on Windows or macOS to ensure all underlying bioinformatic dependencies (like Prokka and Roary) function correctly.
5.  **Pangenome Analysis**: The standard `pegas` version utilizes Roary for pangenome analysis. If your study focuses on comparative genomics across many isolates, the Snakemake-based version is mandatory as it handles the checkpointing required for Roary.

## Reference documentation
- [PeGAS GitHub Repository](./references/github_com_liviurotiul_PeGAS.md)
- [Bioconda PeGAS Package Overview](./references/anaconda_org_channels_bioconda_packages_pegas_overview.md)