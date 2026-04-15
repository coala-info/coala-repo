---
name: bactopia-gather
description: The bactopia-gather tool standardizes the gathering and organization of genomic input data into a uniform directory structure. Use when user asks to gather local FASTQ files, download public datasets from the SRA using accession numbers, or process large-scale projects using a sample sheet.
homepage: https://bactopia.github.io/
metadata:
  docker_image: "quay.io/biocontainers/bactopia-gather:1.0.4--hdfd78af_0"
---

# bactopia-gather

## Overview
The `bactopia-gather` tool is the entry point for the Bactopia ecosystem. Its primary function is to standardize the "gathering" phase of genomic analysis by creating a uniform directory structure for all input samples, regardless of their source. Whether you are starting with local sequencing data or pulling public datasets from NCBI, this tool ensures that sample metadata and file paths are correctly formatted for the QC, assembly, and annotation steps that follow.

## Usage Patterns

### Gathering Local Samples
To process local FASTQ files, use the `--fastq` flag. It is best practice to provide a directory containing your paired-end or single-end reads.
```bash
bactopia gather --fastq /path/to/fastqs/ --outdir my-samples
```

### Downloading Public Data
You can gather samples directly from the Sequence Read Archive (SRA) using Accession numbers. This automates the download and organization process.
```bash
bactopia gather --accessions SRR1234567 --outdir sra-samples
```

### Using a Sample Sheet
For large-scale projects, provide a tab-delimited sample sheet containing sample names and file paths. This is the most reliable method for complex datasets.
```bash
bactopia gather --samplesheet my_samples.tsv --outdir project-results
```

## Expert Tips
- **Directory Structure**: Always specify an `--outdir`. Bactopia creates a specific sub-folder for each sample within this directory, which is required for the `bactopia-run` command to function correctly.
- **Validation**: Before running the full pipeline, use `bactopia-gather` to ensure all FASTQ headers are valid and that paired-end files are properly matched.
- **Resource Management**: When gathering hundreds of SRA accessions, ensure you have sufficient disk space and a stable internet connection, as the tool will perform multiple download streams.

## Reference documentation
- [Bactopia Introduction](./references/bactopia_github_io_index.md)
- [Bactopia Gather Overview](./references/anaconda_org_channels_bioconda_packages_bactopia-gather_overview.md)