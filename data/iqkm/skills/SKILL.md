---
name: iqkm
description: iqKM is a bioinformatics pipeline that performs gene prediction, protein annotation, and quantification of KEGG modules from genomic or metagenomic sequences. Use when user asks to identify KEGG modules, perform functional profiling of metagenomes, or quantify the abundance of metabolic pathways from raw reads.
homepage: https://github.com/lijingdi/iqKM
---


# iqkm

## Overview
iqKM is a bioinformatics pipeline designed to bridge the gap between raw sequence data and functional KEGG module insights. It automates the process of gene prediction via Prodigal, HMM-based protein annotation using HMMER against the Kofam database, and the subsequent mapping of these annotations to KEGG Modules. When provided with raw reads, the tool can also quantify the abundance of these modules, providing a comprehensive functional profile of a sample.

## Installation and Setup
The recommended installation method is via Conda to ensure all third-party dependencies (HMMER, Prodigal, BWA, and Samtools) are correctly configured.

```bash
conda create -n iqKM -c bioconda iqkm
conda activate iqKM
```

**Critical Requirement**: You must download the Kofam HMM database and help files (the `help_dir`) before running the pipeline. This directory contains the essential HMM profiles and mapping files.

## Common CLI Patterns

### 1. Basic KM Assignment (Genomes)
To identify KEGG modules in a single genome without quantification:
```bash
iqKM -i genome.fna -o output_directory --help_dir /path/to/help_dir
```

### 2. Metagenome Functional Profiling
When working with metagenomic assemblies, use the `--meta` flag to adjust the gene prediction parameters:
```bash
iqKM -i metagenome.fna -o output_directory --help_dir /path/to/help_dir --meta
```

### 3. Quantification Workflow
To calculate the abundance of KOs and KMs, you must provide the raw reads used for the assembly and include the `--quantify` flag:
```bash
iqKM -i assembly.fna -o output_directory --help_dir /path/to/help_dir \
     --fq reads_1.fastq.gz --rq reads_2.fastq.gz \
     --meta --quantify
```

## Expert Tips and Best Practices

*   **Completeness Thresholds**: By default, iqKM uses a completeness threshold of 66.67% (`--com 66.67`) to define if a KEGG module is present on a contig. For high-quality genomes, you may want to increase this to 80 or 90 to reduce false positives.
*   **Performance**: Use the `-n` or `--threads` argument to speed up the HMMER search and BWA mapping steps.
*   **Resuming Runs**: If a run is interrupted, iqKM can skip already completed steps using the `--skip` flag. Conversely, use `-f` or `--force` to overwrite an existing output directory and start fresh.
*   **Normalization**: The pipeline enables KO weight normalization by default (`-w`). If you are providing your own genome equivalent counts (e.g., from MicrobeCensus), use the `-g` flag to perform library-size normalization.
*   **Output Interpretation**: 
    *   `[prefix]_km_on_contig.tsv`: Contains the final filtered KM assignments.
    *   `[prefix]_km_sample_abd.tsv`: (Quantification mode only) Provides the abundance matrix for modules across the sample.

## Reference documentation
- [iqKM Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_iqkm_overview.md)
- [iqKM GitHub Repository and Usage Guide](./references/github_com_lijingdi_iqKM.md)