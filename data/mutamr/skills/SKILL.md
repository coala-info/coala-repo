---
name: mutamr
description: mutamr identifies antimicrobial resistance variants by processing raw paired-end fastq files into annotated VCF files. Use when user asks to identify AMR-associated variants, process paired-end reads against a reference genome, or detect mutations in Mycobacterium tuberculosis.
homepage: https://github.com/MDU-PHL/mutamr
metadata:
  docker_image: "quay.io/biocontainers/mutamr:0.0.2--pyhdfd78af_0"
---

# mutamr

## Overview

mutamr is a specialized, lightweight tool designed for clinical and public health laboratories to identify variants associated with AMR. It streamlines the process of moving from raw paired-end fastq files to an annotated VCF by integrating bwa-mem, freebayes, delly, and snpEff. Unlike comprehensive phylogenetic pipelines like snippy, mutamr focuses specifically on generating the necessary variant data for resistance interpretation, making it easier to integrate into existing laboratory workflows.

## Installation

The recommended way to install mutamr is via Conda to ensure all dependencies (samtools, bcftools, freebayes, bwa, delly, and snpEff) are correctly versioned.

```bash
conda install -c bioconda mutamr
```

## Command Line Usage

The primary function of mutamr is to process paired-end reads against a reference genome.

### Basic Command Structure
```bash
mutamr --read1 R1.fastq.gz --read2 R2.fastq.gz --seq_id SAMPLE_NAME --reference ref.fasta --annotation species_name
```

### Optimized for M. tuberculosis
If working with TB, use the `--mtb` flag to automatically set the reference and annotation parameters.
```bash
mutamr --read1 R1.fastq.gz --read2 R2.fastq.gz --seq_id SAMPLE_NAME --mtb
```

### Key Arguments
- `--read1 / --read2`: Paths to the paired-end fastq files.
- `--seq_id`: The name for the output directory and sample prefix.
- `--reference`: Path to the reference genome in FASTA format (required unless `--mtb` is used).
- `--annotation`: The species name for snpEff annotation (required unless `--mtb` is used).
- `--threads`: Number of CPU threads (default: 8).
- `--mindepth`: Minimum depth for base calling (default: 20).
- `--minfrac`: Minimum allele frequency to call a SNP (default: 0.1).
- `--keep`: Set to `True` to retain intermediary files like .bam files (default: False).
- `--force`: Overwrite the output folder if it already exists.

## Expert Tips and Best Practices

- **AMR Specificity**: mutamr uses a default `mindepth` of 20 and `minfrac` of 0.1. These settings are specifically tuned to reduce false positives in AMR detection, especially for low-frequency mutations that might otherwise be missed or miscalled by general-purpose variant callers.
- **Large Deletions**: Ensure `delly` is installed and in your path if you need to detect large structural deletions. If `delly` is missing, the tool will fall back to `freebayes`, which is generally limited to deletions under 50-75 bp.
- **Annotation Requirements**: For annotation to function, `snpEff` must be installed with the appropriate configurations for your target species.
- **Batch Processing**: mutamr is designed to run on a per-sample basis. For high-throughput needs, wrap the command in a shell `for` loop or use a tool like `parallel`.
- **Temporary Files**: Use the `--tmp` flag to point to a high-speed directory (like a RAM disk or local SSD) for samtools operations to significantly improve performance.

## Reference documentation
- [mutamr GitHub Repository](./references/github_com_MDU-PHL_mutamr.md)
- [mutamr Wiki](./references/github_com_MDU-PHL_mutamr_wiki.md)