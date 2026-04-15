---
name: ema
description: EMA is a specialized alignment tool that leverages shared barcode information to resolve mapping ambiguities in linked-read sequencing data. Use when user asks to count barcodes, preprocess binned reads, or align barcoded FASTQ files to a reference genome using a latent variable model.
homepage: http://ema.csail.mit.edu/
metadata:
  docker_image: "quay.io/biocontainers/ema:0.7.0--h5ca1c30_2"
---

# ema

## Overview
EMA (EMerAld) is a specialized alignment tool designed for "linked-read" sequencing data. Unlike standard aligners that treat every read pair independently, EMA leverages the shared barcode information to resolve mapping ambiguities in repetitive regions of the genome. It uses a latent variable model to calculate per-alignment probabilities, resulting in higher accuracy for structural variant calling and haplotyping. Use this tool when you have FASTQ files containing barcodes and need to produce a high-quality SAM/BAM file that accounts for the long-range information provided by those barcodes.

## Workflow and CLI Patterns

### 1. Barcode Counting (`count`)
The first step identifies which barcodes are present and their frequency.
- **Input**: Interleaved FASTQ via stdin.
- **Requirement**: A barcode whitelist file.
- **Pattern**:
  ```bash
  pigz -cd reads.fastq.gz | ema count -w whitelist.txt -o sample_prefix
  ```
- **Tip**: If your files are not interleaved, use `paste` and `tr` to interleave R1 and R2 on the fly before piping to `ema count`.

### 2. Preprocessing (`preproc`)
This stage bins the reads into "buckets" based on their barcodes to allow for parallel alignment.
- **Pattern**:
  ```bash
  pigz -cd reads.fastq.gz | ema preproc -w whitelist.txt -n 500 -t 8 -o output_dir sample_prefix.ema-ncnt
  ```
- **Key Options**:
  - `-n`: Number of buckets (default 500). Increase for very large datasets to keep bucket sizes manageable.
  - `-h`: Enable Hamming-2 correction for barcodes (recommended for 10x data).

### 3. Alignment (`align`)
The final stage performs the actual alignment using the latent variable model.
- **Pattern**:
  ```bash
  ema align -t 4 -d -r reference.fa -s output_dir/ema-bin-000 > bin_000.sam
  ```
- **Expert Tips**:
  - **Density Optimization**: Always use `-d` (fragment read density optimization) for 10x Genomics data to improve accuracy.
  - **Platform Selection**: Use `-p` to specify the technology (e.g., `10x`, `tellseq`, `tru`, `cpt`).
  - **Parallelization**: Use GNU Parallel to process multiple bins simultaneously. A common optimal strategy is 10 jobs with 4 threads each (`-j10` in parallel and `-t 4` in EMA).
  - **No-Barcode Reads**: Reads without valid barcodes (found in `ema-nobc`) should be aligned using standard `bwa mem` and then merged with the EMA results.

### 4. Post-processing
EMA performs internal duplicate marking. After alignment:
1. Sort the resulting SAM/BAM files.
2. Merge the binned BAMs and the `ema-nobc` BAM into a single final file using `samtools` or `sambamba`.



## Subcommands

| Command | Description |
|---------|-------------|
| ema | EMA is a tool for processing and aligning barcoded sequencing data. |
| ema align | choose best alignments based on barcodes |

## Reference documentation
- [EMA GitHub Repository](./references/github_com_arshajii_ema_blob_master_README.md)
- [EMA Overview and MIT Lab Info](./references/cb_csail_mit_edu_ema.md)