---
name: metaphor
description: Metaphor is a Snakemake-based bioinformatics pipeline that automates the transition from raw metagenomic reads to annotated genomic bins. Use when user asks to process metagenomic reads, perform de novo assembly, bin contigs into metagenome-assembled genomes, or generate functional annotations.
homepage: https://github.com/vinisalazar/metaphor
---


# metaphor

## Overview

Metaphor is a Snakemake-based bioinformatics pipeline designed to automate the complex transition from raw metagenomic reads to annotated genomic bins. It integrates several industry-standard tools into a single, portable workflow, covering read preprocessing, de novo assembly, read mapping, contig binning, and functional annotation. While the project is now in an archived state, it remains a robust option for researchers who require its specific implementation of assembly-evaluation and bin-refinement strategies.

## Usage Instructions

### 1. Environment Setup
Metaphor is distributed via Bioconda. It is highly recommended to use `mamba` for faster dependency resolution.

```bash
mamba create -n metaphor metaphor -c conda-forge -c bioconda
conda activate metaphor
```

### 2. Verification
Before running on production data, verify the installation and dependencies. Note that the full test suite can take several hours as it downloads and installs specific tool environments.

```bash
# Check basic help
metaphor -h

# Run the automated test suite
metaphor test
```

### 3. Configuration Workflow
Metaphor requires two primary configuration components: a settings file and a sample input file.

**Generate Settings:**
Create the `metaphor_settings.yaml` file to define tool parameters and resource allocation.
```bash
metaphor config settings
```

**Generate Input Table:**
Create the `samples.csv` file by pointing the tool to your directory containing FASTQ files.
```bash
metaphor config input -i <DIRECTORY_WITH_FASTQ_FILES>
```

### 4. Execution
Once the configuration files are present in the working directory, Metaphor will automatically detect them.

```bash
metaphor execute
```

## Expert Tips and Best Practices

- **Resource Management**: Metaphor uses Snakemake under the hood. If running on a high-performance computing (HPC) cluster, ensure your `metaphor_settings.yaml` reflects the available cores and memory to prevent job failures during memory-intensive assembly steps (Megahit).
- **Assembly Evaluation**: The workflow includes MetaQUAST for assembly evaluation. Review these reports in the output directory to ensure the assembly quality meets your research requirements before proceeding to binning.
- **Binning Refinement**: Metaphor utilizes DAS Tool to integrate results from multiple binners (Vamb, MetaBAT, CONCOCT). This consensus approach generally yields higher quality MAGs than any single binner alone.
- **Archival Note**: As the project is no longer under active maintenance, users encountering modern library incompatibilities should consider transitioning to `nf-core/mag` for long-term projects.



## Subcommands

| Command | Description |
|---------|-------------|
| metaphor config | Metaphor configuration commands. |
| metaphor execute | Execute a Metaphor workflow. |
| metaphor_test | Run Metaphor tests. |

## Reference documentation
- [Metaphor GitHub Repository](./references/github_com_vinisalazar_metaphor.md)
- [Metaphor README](./references/github_com_vinisalazar_metaphor_blob_main_README.md)
- [Metaphor ReadTheDocs Documentation](./references/metaphor-workflow_readthedocs_io_en_latest.md)