---
name: metaphor
description: Metaphor is a Snakemake-based pipeline designed to automate genome-resolved metagenomics from raw short reads to refined metagenome-assembled genomes. Use when user asks to process metagenomic data, assemble and bin genomes, or generate reproducible metagenomic workflows.
homepage: https://github.com/vinisalazar/metaphor
---


# metaphor

## Overview
Metaphor is a Snakemake-based pipeline designed to simplify genome-resolved metagenomics. It provides a structured workflow that takes raw short reads through a series of processing steps—including assembly with Megahit and binning with tools like MetaBAT and Vamb—to produce refined metagenome-assembled genomes (MAGs). It is best suited for researchers needing a reproducible, "all-in-one" command-line interface for standard metagenomic processing.

## Installation and Setup
Metaphor is distributed via Bioconda. It is highly recommended to use `mamba` for faster dependency resolution.

```bash
# Create and activate the environment
mamba create -n metaphor metaphor -c conda-forge -c bioconda
conda activate metaphor
```

## Core Workflow Patterns

### 1. Verification
Before running on production data, verify the installation and environment setup using the built-in test suite.
```bash
metaphor test
```

### 2. Configuration
Metaphor operates based on a configuration profile and a sample metadata file. Generate these templates using the `config` subcommands.

*   **Generate Settings**: Create the default configuration profile.
    ```bash
    metaphor config settings
    ```
*   **Generate Input Table**: Create the `samples.csv` file by pointing the tool to your directory of FASTQ files.
    ```bash
    metaphor config input -i <DIRECTORY_WITH_FASTQ_FILES>
    ```

### 3. Execution
Once the configuration files are generated and edited if necessary, execute the full pipeline. Metaphor automatically detects `metaphor_settings.yaml` and `samples.csv` in the current working directory.
```bash
metaphor execute
```

## Pipeline Components
Metaphor integrates the following tools into its automated steps:
*   **QC**: FastQC and fastp.
*   **Assembly**: Megahit (evaluated via MetaQUAST).
*   **Mapping**: Minimap2 and Samtools.
*   **Binning**: Vamb, MetaBAT, and CONCOCT.
*   **Refinement**: DAS Tool.
*   **Annotation**: Prodigal, Diamond, and NCBI COG database.

## Best Practices
*   **Environment Management**: Always run Metaphor within its dedicated Conda/Mamba environment to avoid dependency conflicts with other bioinformatics tools.
*   **Resource Allocation**: Metaphor is a Snakemake-based tool; ensure your environment has sufficient disk space for intermediate assembly and mapping files, which can be quite large.
*   **Archival Status**: Be aware that the project is archived. While functional for the versions specified, for the most up-to-date metagenomic standards, the author recommends transitioning to `nf-core/mag`.

## Reference documentation
- [Metaphor - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_metaphor_overview.md)
- [GitHub - vinisalazar/metaphor: Metaphor: a general-purpose workflow for assembly and binning of metagenomes](./references/github_com_vinisalazar_metaphor.md)