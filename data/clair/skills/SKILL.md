---
name: clair
description: Clair is a genomic variant caller that uses deep neural networks to identify germline small variants from aligned sequencing reads. Use when user asks to call variants from pileup data, identify SNPs and indels from single-molecule sequencing, or generate VCF files from BAM files using pre-trained models.
homepage: https://github.com/HKU-BAL/Clair
metadata:
  docker_image: "quay.io/biocontainers/clair:2.1.1--hdfd78af_1"
---

# clair

## Overview
Clair is a genomic variant caller that utilizes deep neural networks to identify germline small variants from pileup data. While it supports multiple platforms, it is specifically optimized for the error profiles of single-molecule sequencing technologies. It operates by taking aligned reads (BAM format) and a reference genome to produce variant calls (VCF format). Note that for projects started after May 2021, the developer recommends its successor, Clair3, though Clair remains a robust choice for specific v2-based workflows.

## Installation and Setup
Clair is most efficiently managed via Bioconda.

```bash
# Environment setup
conda create -n clair-env -c bioconda clair
conda activate clair-env

# Critical: Install missing pypy3 dependency
pypy3 -m ensurepip
pypy3 -m pip install --no-cache-dir intervaltree==3.0.2

# Set the executable path
CLAIR=$(which clair.py)
```

## Core CLI Usage
The primary entry point is `clair.py`, but automated workflows often utilize `callVarBam.py` for script generation.

### Basic Variant Calling
To run variant calling, you must specify the input BAM, the reference FASTA, and the directory containing the pre-trained model.

```bash
python $CLAIR \
  --bam_fn input.bam \
  --ref_fn reference.fasta \
  --model_path /path/to/pretrained_model \
  --threads 4 \
  --call_fn output.vcf
```

### Model Selection
Clair requires platform-specific models. Ensure you have downloaded and extracted the correct model for your data:
- **ONT**: Optimized for Oxford Nanopore (e.g., model `122HD34`).
- **PacBio**: Optimized for CCS/HiFi reads (e.g., model `15`).
- **Illumina**: Optimized for short-read data (e.g., model `12345`).

## Expert Tips and Best Practices
- **Haploid Calling**: For haploid organisms or sex chromosomes, use the specific precision/sensitivity flags:
  - `--haploid_precision`: Prioritizes reducing false positives.
  - `--haploid_sensitive`: Prioritizes reducing false negatives.
- **Threading**: Clair uses 4 threads by default. Adjust this using `--threads` based on your available CPU cores to improve throughput.
- **Memory Management**: If encountering Out-of-Memory (OOM) errors on high-coverage data, ensure you are using version 2.0.4 or later, which includes optimized prediction batch sizes.
- **Alternative Alleles**: Version 2.1.1+ supports the asterisk (`*`) representation for VCF 4.2, which is important for representing overlapping deletions.
- **GPU Acceleration**: While CPUs are sufficient for calling, training new models requires a high-end GPU and `tensorflow-gpu==1.13.2`.

## Common Workflow Patterns
When processing large datasets, it is common to generate a series of commands for parallel execution across different genomic regions.

1. **Generate Commands**: Use `dataPrepScripts/` to split the genome into manageable chunks.
2. **Execute Calling**: Run `clair.py` on each chunk.
3. **Post-Processing**: Use the provided scripts to handle overlapped variants and merge VCFs.

## Reference documentation
- [Clair GitHub Repository](./references/github_com_HKU-BAL_Clair.md)
- [Bioconda Clair Overview](./references/anaconda_org_channels_bioconda_packages_clair_overview.md)