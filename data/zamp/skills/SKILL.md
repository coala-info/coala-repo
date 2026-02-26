---
name: zamp
description: zAMP is a bioinformatics pipeline for analyzing amplicon-based metagenomic data. Use when user asks to prepare a taxonomic database, run a metagenomics pipeline, process metagenomic samples, filter or trim reads, or generate citations.
homepage: https://github.com/metagenlab/zAMP/
---


# zamp

## Overview

zAMP is a bioinformatic pipeline built on Snakemake designed for the analysis of amplicon-based metagenomic data. It provides a streamlined workflow for processing 16S rRNA or ITS Illumina paired-end reads, covering everything from raw data quality control to Amplicon Sequence Variant (ASV) inference and taxonomic assignment. This skill should be used to guide the preparation of reference databases and the execution of the metagenomics pipeline, especially when high reproducibility and scalability are required.

## Core CLI Usage

The zAMP tool operates through a primary command-line interface with two main functional subcommands: `db` and `run`.

### 1. Database Preparation (`zamp db`)

Before running the analysis, you must prepare a taxonomic database. This step allows zAMP to train classifiers on specific primer-amplified regions, which significantly increases taxonomic sensitivity.

**Common Pattern:**
```bash
zamp db --fasta <database_fasta> \
        --taxonomy <taxonomy_tsv> \
        --name <database_name> \
        --fw-primer <forward_primer_sequence> \
        --rv-primer <reverse_primer_sequence> \
        -o <output_directory>
```

**Best Practices:**
- Ensure primers are provided without adapters or barcodes.
- Use standard databases like Greengenes2, SILVA, or UNITE as the source for fasta and taxonomy files.
- If using Qiime2 artifacts (.qza), they must be exported to standard formats (fasta/tsv) before using `zamp db`.

### 2. Executing the Pipeline (`zamp run`)

Once the database is prepared, use the `run` command to process your samples.

**Common Pattern:**
```bash
zamp run -i <samples_sheet.tsv> \
         -db <database_name> \
         --fw-primer <forward_primer_sequence> \
         --rv-primer <reverse_primer_sequence>
```

**Input Requirements:**
- The input file (`-i`) should be a tab-separated values (TSV) file containing sample identifiers and paths to local fastq files or SRA accessions.

## Expert Tips and Best Practices

- **Primer Consistency**: Always use the exact same primer sequences for both the `db` and `run` commands to ensure the trained classifier matches the experimental data.
- **Resource Management**: Since zAMP is a Snakemake-based tool, it inherently supports parallel execution. Ensure your environment (Conda/Mamba) is properly configured to allow the pipeline to manage dependencies via Apptainer or Docker if required for specific steps.
- **Troubleshooting**: Use `zamp [command] --help` to view all available parameters, including options for read filtering, trimming, and specific DADA2 parameters.
- **Citations**: Use `zamp citation` to generate a list of the specific tools and versions used within the pipeline for your methods section.

## Reference documentation

- [zAMP GitHub Repository](./references/github_com_metagenlab_zAMP.md)
- [zAMP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_zamp_overview.md)