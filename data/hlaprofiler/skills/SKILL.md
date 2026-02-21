---
name: hlaprofiler
description: HLAProfiler is a k-mer based computational tool for high-resolution HLA typing from RNA-seq data.
homepage: https://github.com/ExpressionAnalysis/HLAProfiler
---

# hlaprofiler

## Overview

HLAProfiler is a k-mer based computational tool for high-resolution HLA typing from RNA-seq data. Instead of traditional alignment-based methods, it analyzes the k-mer content of sequencing reads to assign them to specific HLA genes. It then compares the aggregate k-mer profile of the sample against a reference database to determine the most likely HLA alleles. This skill provides the necessary command-line patterns for building custom HLA databases and executing the prediction workflow on paired-end samples.

## Installation

The most efficient way to install HLAProfiler is via Bioconda:

```bash
conda install bioconda::hlaprofiler
```

Alternatively, it can be installed by cloning the GitHub repository and running the provided `install.pl` script to manage dependencies like Kraken.

## Core Workflows

### 1. Database Creation
Before calling alleles, you must build a reference database. This requires transcript sequences, annotations, and IMGT reference data.

```bash
perl HLAProfiler.pl build \
    -t path/to/transcript.fa.gz \
    -g /path/to/transcript_annotations.gtf.gz \
    -e /path/to/hla_exclude_regions.bed \
    -r /path/to/IMGT_reference.fasta \
    -cwd /path/to/hla_cwd_alleles.txt \
    -o /path/to/output_directory/ \
    -db database_name \
    -kp /path/to/kraken/ \
    -c 12
```

### 2. HLA Allele Prediction
To predict HLA types from a sample, provide the paired-end FASTQ files and point to the directory containing the built database.

```bash
perl HLAProfiler.pl predict \
    -fastq1 sample_R1.fastq.gz \
    -fastq2 sample_R2.fastq.gz \
    -database_name database \
    -database_dir /path/to/HLAProfiler_db \
    -reference /path/to/HLAProfiler_db/data/reference/hla.ref.merged.fa \
    -threads 8 \
    -output_dir /path/to/results \
    -allele_refinement all \
    -kraken_path /path/to/kraken/ \
    -l sample_run.log
```

## Command-Line Best Practices

- **Paired-End Requirement**: HLAProfiler currently only supports paired-end RNA-seq data. Ensure both `-fastq1` and `-fastq2` are provided.
- **Kraken Dependency**: The tool relies on Kraken for k-mer processing. Always verify the `-kraken_path` points to the executable directory. If using the automated installer, this is typically found in `bin/kraken-version/` within the HLAProfiler directory.
- **Allele Refinement**: Use `-allele_refinement all` to ensure the tool performs the most exhaustive search for the best-fitting alleles.
- **Resource Management**: Use the `-threads` (predict) or `-c` (build) flags to match your system's CPU capacity, as k-mer profiling is computationally intensive.
- **Database Consistency**: Ensure the `-reference` path provided during the `predict` step matches the merged reference file generated during the `build` step.

## Troubleshooting Common Issues

- **"Not enough reads to make call"**: This error typically occurs if the input RNA-seq data has low coverage over the HLA loci or if the Kraken database filtering was too aggressive.
- **Module Path Errors**: If Perl cannot locate Kraken modules, ensure the environment variables are set correctly or that you are running the script from the root of the HLAProfiler installation.

## Reference documentation
- [HLAProfiler Overview](./references/anaconda_org_channels_bioconda_packages_hlaprofiler_overview.md)
- [HLAProfiler GitHub Repository](./references/github_com_ExpressionAnalysis_HLAProfiler.md)