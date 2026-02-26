---
name: haystac
description: Haystac provides a Bayesian framework for identifying species and estimating abundances in metagenomic sequencing libraries, with specific optimizations for ancient DNA. Use when user asks to build custom genomic databases from NCBI, pre-process sequencing reads, identify species in complex samples, or assess ancient DNA damage patterns.
homepage: https://github.com/antonisdim/haystac
---


# haystac

## Overview
The haystac skill provides a robust Bayesian framework for identifying species within complex sequencing libraries. It excels at distinguishing between closely related taxa and is optimized for the unique challenges of ancient DNA, such as fragmentation and deamination. The workflow is modular, allowing you to construct custom genomic databases based on NCBI queries, prepare raw sequencing reads (FASTQ or SRA), and perform detailed abundance analyses with integrated damage pattern assessment.

## Installation and Setup
The recommended installation method is via the mamba package manager to ensure fast dependency resolution:

```bash
mamba create -c conda-forge -c bioconda -n haystac haystac
conda activate haystac
```

## Core Workflows

### 1. Database Construction
Build a reference database using specific NCBI search queries or RefSeq representative sets.

*   **NCBI Query Mode**: Best for hypothesis-driven research (e.g., focusing on a specific genus).
    ```bash
    haystac database --mode build --query '"GenusName"[Organism] AND "complete genome"[All Fields]' --output genus_db
    ```
*   **RefSeq Representative Mode**: For broader, more exhaustive metagenomic screening.
    ```bash
    haystac database --mode build --refseq-rep prokaryote_rep --output refseq_db
    ```

### 2. Sample Pre-processing
Prepare sequencing data for analysis. This module handles adapter trimming and can fetch data directly from the Sequence Read Archive (SRA).

*   **From SRA**:
    ```bash
    haystac sample --sra ERR1018966 --output sample_dir
    ```
*   **From Local FASTQ (Paired-End)**:
    Use `--collapse True` for ancient DNA to merge overlapping mate pairs.
    ```bash
    haystac sample --fastq-r1 R1.fq.gz --fastq-r2 R2.fq.gz --collapse True --output sample_dir
    ```

### 3. Species Identification and Analysis
The `analyse` module calculates the mean posterior abundance of species in the sample relative to the database.

*   **Standard Abundance Analysis**:
    ```bash
    haystac analyse --mode abundances --database genus_db --sample sample_dir --output analysis_results
    ```
*   **Ancient DNA Analysis**:
    Include damage pattern analysis to authenticate ancient sequences.
    ```bash
    haystac analyse --mode abundances --database genus_db --sample sample_dir --output analysis_results --mapdamage True
    ```

## Expert Tips and Best Practices
*   **Database Specificity**: For prokaryotes, genus-specific databases are significantly faster and often provide more robust identifications than massive, non-specific databases.
*   **Interpreting Results**: Focus on the `_posterior_abundance.tsv` file located in the `probabilities/` sub-folder. Key metrics include:
    *   **Uniquely Assigned Reads**: Higher counts increase confidence.
    *   **Chi-squared Test**: Indicates if reads are spread evenly across the reference genome (low values suggest even coverage, high values may indicate mapping to repetitive regions or contaminants).
*   **NCBI Search Details**: To get the most accurate query string, use the "Search details" box on the NCBI Nucleotide website and paste that string into the `--query` parameter.
*   **Resource Management**: Building large databases (like the full RefSeq representative set) is computationally intensive and should be performed on high-performance computing (HPC) clusters rather than local laptops.

## Reference documentation
- [HAYSTAC GitHub Repository](./references/github_com_antonisdim_haystac.md)
- [Bioconda Haystac Package Overview](./references/anaconda_org_channels_bioconda_packages_haystac_overview.md)