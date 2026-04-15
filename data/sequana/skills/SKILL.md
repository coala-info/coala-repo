---
name: sequana
description: Sequana is a Python-based framework and suite of Snakemake pipelines designed for the analysis and processing of high-throughput sequencing data. Use when user asks to analyze genome coverage, perform differential expression analysis, identify species taxonomy, or manage bioinformatics workflows for raw FASTQ files.
homepage: https://sequana.readthedocs.io
metadata:
  docker_image: "quay.io/biocontainers/sequana:0.19.6--pyhdfd78af_0"
---

# sequana

## Overview
Sequana is a specialized Python-based framework designed to streamline the analysis of high-throughput sequencing data. It provides a dual-layered approach: a library of modular bioinformatics functions for developers and a suite of high-level standalone applications and Snakemake pipelines for researchers. It is particularly effective for processing raw FASTQ files, assessing genome coverage, and performing differential expression analysis.

## Installation and Setup
The preferred method for installing Sequana and its associated pipelines is via `pip` within a dedicated Conda environment to manage non-Python dependencies.

```bash
# Create and activate environment
conda create --name sequana_env python=3.10
conda activate sequana_env

# Install core library
pip install sequana --upgrade

# Install specific pipelines as needed
pip install sequana_rnaseq sequana_fastqc sequana_variant_calling
```

## Common CLI Patterns

### Pipeline Management
Sequana pipelines are installed as independent packages. They typically follow a standard initialization and execution workflow.

```bash
# Initialize a pipeline (e.g., RNA-seq)
sequana_rnaseq --input-directory ./fastq_files --genome-directory ./reference

# Execute the generated Snakemake workflow
cd rnaseq
sh sequana_normalization.sh  # Or run snakemake directly
```

### Genome Coverage Analysis
The `sequana_coverage` tool is a standalone application for detecting genomic variations and characterizing coverage.

```bash
# Basic coverage analysis on a BAM file
sequana_coverage --input sample.bam --window-size 1001 --reference reference.fasta

# Generate a HTML report for a specific chromosome
sequana_coverage --input sample.bam --chromosome chr1
```

### Taxonomy Identification
Use `sequana_taxonomy` to identify the species present in a sequencing sample using Kraken.

```bash
# Run taxonomy analysis
sequana_taxonomy --input sample.fastq.gz --databases /path/to/kraken_db --output-directory taxonomy_results
```

### Utility Commands
Sequana provides several subcommands for common file manipulations:

- **Reverse Complement**: `sequana revcomp --input sample.fastq`
- **Downsampling**: `sequana downsampling --input sample.fastq --fraction 0.1`
- **FASTQ Splitting**: `sequana fastq_split --input sample.fastq --nfiles 4`
- **GFF Manipulation**: `sequana gff --input file.gff --add-cds`

## Expert Tips
- **Apptainer/Singularity**: Most Sequana pipelines support Apptainer. If you have Apptainer installed, you can run pipelines without manually installing third-party bioinformatics tools by using the `--use-apptainer` flag during pipeline initialization.
- **Sequanix**: For users who prefer a graphical interface, `sequanix` provides a GUI to manage and run any Snakemake pipeline, including those from the Sequana project.
- **Memory Efficiency**: When running `sequana_coverage` on large eukaryotic genomes, ensure you use the latest version (0.16.0+) which includes optimizations for memory-efficient processing.

## Reference documentation
- [Sequana Overview](./references/sequana_readthedocs_io_en_main.md)
- [Installation Guide](./references/sequana_readthedocs_io_en_main_installation.html.md)
- [General Index of Functions](./references/sequana_readthedocs_io_en_main_genindex.html.md)