---
name: scssim
description: SCSsim is a bioinformatics suite that simulates realistic single-cell genome sequencing data by applying genomic variations and platform-specific error profiles to a reference sequence. Use when user asks to simulate single-cell genomic variations, learn sequencing error profiles from existing data, or generate synthetic single-cell reads.
homepage: https://github.com/qasimyu/scssim
metadata:
  docker_image: "quay.io/biocontainers/scssim:1.0--h9948957_5"
---

# scssim

## Overview

SCSsim is a bioinformatics suite designed to emulate the complexities of single-cell genome sequencing. It enables the creation of "ground truth" single-cell genomes by applying user-defined variations to a reference sequence. The tool is particularly useful for benchmarking variant callers or testing single-cell analysis pipelines, as it can learn platform-specific profiles (such as GC-content bias and Phred quality distributions) from real data to produce highly realistic synthetic reads.

## Command Line Usage

The `scssim` tool uses a subcommand-based architecture. The standard workflow involves three primary stages.

### 1. Simulating Genomic Variations (simuvars)
Use this module to create a modified genome containing specific variations.

```bash
scssim simuvars -r <reference.fa> -s <snps.txt> -v <vars.txt> -o <output_simulated.fa>
```
- **-r**: Path to the reference genome (can be gzipped).
- **-s**: Input SNP file.
- **-v**: Input variation file (defining SNVs, indels, and CNVs).
- **-o**: Path for the resulting simulated single-cell genome.

### 2. Learning Sequencing Profiles (learn)
This optional step allows you to extract error and bias profiles from existing Illumina datasets to make the simulation more realistic.

```bash
# Basic usage
scssim learn -b <sample.bam> -v <sample.vcf> -r <reference.fa> -o <output.profile>

# Usage with target regions and specific samtools path
scssim learn -b <sample.bam> -t <targets.bed> -v <sample.vcf> -r <reference.fa> -s /path/to/samtools > <output.profile>
```
- **Profiles captured**: Indel error distributions, base substitution probabilities, Phred quality distributions, and GC-content bias.
- **Note**: If you do not have real data, you can use pre-built profiles (e.g., `Illumina_HiSeq2500.profile`) typically found in the tool's `testData/models` directory.

### 3. Generating Reads (genreads)
The final step simulates the amplification and sequencing process to produce FASTQ files.

```bash
scssim genreads -i <simulated.fa> -r <mutation_rate> -m <platform.profile> -t <threads> -o <output_prefix>
```
- **-i**: The simulated genome produced in Step 1.
- **-r**: Mutation rate (e.g., `2e-10`).
- **-m**: The sequencing profile (learned in Step 2 or pre-built).
- **-t**: Number of threads for parallel processing.
- **-o**: Output directory and prefix for the generated reads.

## Expert Tips and Best Practices

- **Reference Preparation**: Ensure your reference FASTA is indexed if the tool requires random access, though `simuvars` can handle gzipped input directly.
- **Variation Files**: When defining variations for `simuvars`, ensure the genomic coordinates in `snps.txt` and `vars.txt` are 1-based or 0-based according to the specific version requirements (usually 1-based for bioinformatics compatibility).
- **Coverage Calculation**: The tool calculates the number of reads based on the desired coverage. If you need a specific depth, ensure the `-r` (mutation rate) and the profile parameters are tuned to your experimental design.
- **Performance**: Read generation (`genreads`) is the most computationally intensive step. Always utilize the `-t` flag to allocate multiple CPU cores.
- **Realism**: For the most accurate single-cell simulation, always perform the `learn` step on a bulk or single-cell dataset from the same sequencing center and platform you intend to mimic.



## Subcommands

| Command | Description |
|---------|-------------|
| scssim genreads | Generate reads from a sequence file using MALBAC and read simulation models |
| scssim learn | Learn parameters from a normal BAM file for single-cell sequencing simulation |
| scssim simuvars | Simulate genomic variations and SNPs on a reference sequence to generate new sequences. |

## Reference documentation
- [SCSsim GitHub Repository](./references/github_com_qasimyu_scssim.md)
- [SCSsim README](./references/github_com_qasimyu_scssim_blob_master_README.md)