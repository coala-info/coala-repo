---
name: dwgsim
description: dwgsim is a robust command-line tool designed to simulate the sequencing process for whole genomes.
homepage: https://github.com/nh13/DWGSIM
---

# dwgsim

## Overview
dwgsim is a robust command-line tool designed to simulate the sequencing process for whole genomes. It takes a reference FASTA file as input and produces simulated paired-end or single-end reads while incorporating realistic sequencing errors, polymorphisms (SNPs/Indels), and quality scores. This skill provides the necessary patterns to configure library parameters, mutation rates, and output types for various sequencing scenarios.

## Installation
The tool is most easily installed via Bioconda:
```bash
conda install bioconda::dwgsim
```

## Common CLI Patterns

### Basic Read Simulation
To generate a standard set of paired-end reads from a reference genome:
```bash
dwgsim reference.fa output_prefix
```
This produces `output_prefix.bwa.read1.fastq.gz`, `output_prefix.bwa.read2.fastq.gz`, and a `output_prefix.vcf` containing the simulated mutations.

### Controlling Output Type
Use the `-M` option to specify what the simulator should produce:
- **Reads and Variants (Default)**: Generates both FASTQ and VCF.
- **Reads Only**: `-M r`
- **Variants Only**: `-M v`
- **Both**: `-M b`

### Adjusting Library Parameters
Fine-tune the physical characteristics of the simulated library:
- **Read Length**: `-1 <int>` (Read 1) and `-2 <int>` (Read 2).
- **Outer Distance**: `-d <int>` (mean distance between pairs) and `-s <int>` (standard deviation).
- **Number of Reads**: `-N <int>` (total number of read pairs to generate).
- **Coverage**: Instead of `-N`, use `-C <float>` to specify desired fold coverage (e.g., `-C 30.0` for 30x).

### Mutation and Error Rates
- **Mutation Rate**: `-r <float>` (default is 0.001).
- **Indel Fraction**: `-R <float>` (fraction of mutations that are indels, default 0.10).
- **Probability of Indel Extension**: `-X <float>` (default 0.30).
- **Sequencing Error Rate**: `-e <float>` (per-base error rate for the first read) and `-E <float>` (for the second read).

### Advanced Strand and Target Control
- **Read Strand**: Use `-A` to control the strand of the generated reads.
- **Target Regions**: Use `-x <bed_file>` to limit simulation to specific genomic regions defined in a BED file. Ensure the BED file is coordinate-sorted to avoid errors.

## Expert Tips
- **Handling "Failed to generate a read"**: If you encounter the error `[dwgsim_core] failed to generate a read after 10001 trials`, it usually indicates that the simulator is trying to generate reads from a region with too many 'N' bases or the target region is too small for the specified library size. Try reducing the library outer distance (`-d`) or checking the reference for gaps.
- **Reproducibility**: Use the `-z <int>` flag to set a specific random seed. This ensures that the same set of mutations and reads are generated across different runs.
- **RNA-Seq Simulation**: While primarily a DNA simulator, you can simulate transcriptomic data by providing a transcriptome FASTA (cDNA) as the reference.
- **VCF Validation**: The output VCF is a standard format that can be used directly with tools like `bcftools` or `vcf-validator` to verify the ground truth of your pipeline.

## Reference documentation
- [DWGSIM Main Repository](./references/github_com_nh13_DWGSIM.md)
- [Bioconda dwgsim Overview](./references/anaconda_org_channels_bioconda_packages_dwgsim_overview.md)
- [DWGSIM Commit History (Feature Flags)](./references/github_com_nh13_DWGSIM_commits_main.md)