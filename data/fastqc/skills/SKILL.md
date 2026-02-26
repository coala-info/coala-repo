---
name: fastqc
description: FastQC performs quality control checks on raw sequencing data to identify potential problems and visualize technical metrics. Use when user asks to assess sequencing quality, generate quality control reports, or inspect FASTQ files for errors and contaminants.
homepage: http://www.bioinformatics.babraham.ac.uk/projects/fastqc/
---


# fastqc

## Overview
FastQC provides a modular set of analyses which can give a quick impression of whether your data has any problems of which you should be aware before doing any further analysis. It is the industry standard for initial data inspection in bioinformatics pipelines, allowing users to visualize quality metrics across reads and ensure that the sequencing run met expected technical standards.

## Common CLI Patterns

### Basic Usage
Run FastQC on one or more files with default settings:
```bash
fastqc sample1.fastq.gz sample2.fastq.gz
```

### Specifying Output Directory
By default, FastQC creates output files in the same directory as the input. Use `-o` to redirect results:
```bash
mkdir -p qc_reports
fastqc -o qc_reports/ sample.fastq.gz
```

### Multi-threaded Execution
Speed up processing by using multiple CPU cores (one thread per file):
```bash
fastqc -t 4 sample1.fq sample2.fq sample3.fq sample4.fq
```

### Non-interactive/Batch Mode
For automated pipelines, use the `--noextract` flag to prevent the tool from unzipping the HTML report folders automatically, keeping the working directory clean:
```bash
fastqc --noextract sample.fastq.gz
```

## Expert Tips
- **Memory Management**: FastQC allocates approximately 250MB of memory per thread. Ensure your system has enough RAM when using high `-t` values.
- **Format Support**: While primarily used for FASTQ files, FastQC can also ingest BAM and SAM files to check quality post-alignment.
- **Contaminant Screening**: You can provide a custom list of adapter sequences using the `-a` flag if you are using non-standard adapters not included in the default configuration.
- **Large Datasets**: For extremely large files, consider sub-sampling your data before running FastQC if a quick representative snapshot is sufficient, though running on the full file is preferred for detecting rare contaminants.

## Reference documentation
- [FastQC Overview](./references/anaconda_org_channels_bioconda_packages_fastqc_overview.md)