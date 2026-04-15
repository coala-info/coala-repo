---
name: lrtk
description: LRTK is a toolkit for processing and analyzing linked-read sequencing data from various platforms. Use when user asks to simulate linked-reads, correct barcodes, perform barcode-aware alignment, reconstruct DNA fragments, or detect genomic variants.
homepage: https://github.com/ericcombiolab/LRTK
metadata:
  docker_image: "quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0"
---

# lrtk

## Overview

LRTK (Linked-Read ToolKit) is a versatile, platform-agnostic suite designed to handle the complexities of linked-read sequencing. Unlike standard NGS tools, LRTK utilizes barcode information to reconstruct long-range genomic information from short-read data. It supports a full workflow from raw FASTQ processing to structural variant detection and metagenome assembly, providing specialized algorithms for barcode-aware alignment and fragment reconstruction.

## Core Workflows and CLI Patterns

### 1. Data Simulation (MKFQ)
Use this to generate synthetic linked-reads for benchmarking or pipeline testing.
- **Command**: `lrtk MKFQ -CF <config_dir> -IT <platform>`
- **Platforms**: `10x`, `stLFR`.
- **Tip**: Ensure the configuration directory contains the required diploid configuration files.

### 2. Barcode Correction and Conversion (FQCONVER)
Essential for preparing raw data for alignment, especially for TELL-Seq which requires an index file.
- **Standard (10x/stLFR)**: `lrtk FQCONVER -I1 <R1.fq> -I2 <R2.fq> -IT <platform> -O1 <out1.fq> -O2 <out2.fq> -B <whitelist>`
- **TELL-Seq**: Requires the `-ID` flag for the index FASTQ containing barcode sequences.
- **Best Practice**: Always provide a barcode whitelist (`-B`) for 10x data to ensure high-quality correction.

### 3. Barcode-Aware Alignment (ALIGN)
Maps reads to a reference genome while preserving barcode associations.
- **Command**: `lrtk ALIGN -FQ1 <R1.fq> -FQ2 <R2.fq> -R <ref.fa> -O <out.bam> -RG <RG_string> -P <platform> -A <aligner>`
- **Aligners**: Supports `ema` and `lariat`.
- **Read Groups**: The `-RG` string is mandatory (e.g., `'@RG\tID:sample1\tSM:sample1'`).

### 4. Fragment Reconstruction (RLF)
Reconstructs the original long DNA fragments (read clouds) from aligned BAM files.
- **Command**: `lrtk RLF -B <input.bam> -D <distance> -O <output_fragments>`
- **Parameter Tip**: The `-D` (distance) parameter defines the seed extension limit. A common default for human genomes is `200000` (200kb).

### 5. Variant Detection (SNV & SV)
LRTK wraps several specialized callers to leverage linked-read data.
- **Small Variants**: `lrtk SNV -B <input.bam> -R <ref.fa> -A <caller> -O <output.vcf>`
  - Callers: `FreeBayes`, `Samtools`, or `GATK`.
- **Structural Variants**: `lrtk SV -B <input.bam> -R <ref.fa> -A <caller> -O <output.vcf>`
  - Callers: `Aquila`, `LinkedSV`, or `VALOR`.

### 6. Automated Pipelines
For end-to-end analysis, use the wrapper commands:
- **Human WGS**: `lrtk WGS [options]`
- **Metagenomics**: `lrtk MWGS [options]`

## Expert Tips and Best Practices

- **Reference Preparation**: Ensure your reference FASTA is indexed with BWA and Samtools before running `ALIGN` or `SNV` modules.
- **Memory Management**: Metagenome assembly (`ASSEMBLY`) and SV calling are resource-intensive. Ensure your environment has sufficient RAM for the specific caller (e.g., Aquila requires significant memory for assembly-based SV detection).
- **Platform Specifics**: Always match the `-IT` (Input Type) or `-P` (Platform) flag to your specific library prep (10x, stLFR, or TELLSeq), as barcode structures differ significantly between them.
- **Parallelization**: Use the `-T` flag across most modules to specify the number of threads for faster processing.



## Subcommands

| Command | Description |
|---------|-------------|
| lrtk | lrtk version 2.0 |
| lrtk | lrtk version 2.0 |
| lrtk | lrtk version 2.0 |

## Reference documentation
- [LRTK GitHub Repository Overview](./references/github_com_ericcombiolab_LRTK.md)
- [LRTK README and Usage Guide](./references/github_com_ericcombiolab_LRTK_blob_main_README.md)
- [LRTK Bioconda Package Information](./references/anaconda_org_channels_bioconda_packages_lrtk_overview.md)