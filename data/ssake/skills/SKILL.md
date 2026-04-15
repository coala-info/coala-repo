---
name: ssake
description: SSAKE performs de novo assembly of short DNA sequences using a prefix tree and k-mer searching to extend reads into contigs. Use when user asks to assemble short reads into contigs, perform targeted assembly from a seed sequence, or process linked-read data.
homepage: https://github.com/warrenlr/SSAKE
metadata:
  docker_image: "biocontainers/ssake:v4.0-2-deb_cv1"
---

# ssake

## Overview
SSAKE (Short Sequence Assembly by K-mer search and 3' read Extension) is a specialized tool designed for the de novo assembly of millions of very short DNA sequences. Unlike many modern assemblers that use De Bruijn graphs, SSAKE utilizes a prefix tree and k-mer searching to extend reads into contigs. It is particularly effective for targeted assembly (reconstructing specific regions from a seed) and handling linked-read data.

## Installation and Setup
The most reliable way to install SSAKE is via Bioconda:
```bash
conda install bioconda::ssake
```

## Pre-processing Best Practices
SSAKE is highly sensitive to read quality. Always perform quality trimming before assembly.
- **Standard Fastq Trimming**: Use `TQSfastq.py` (included in the tools directory).
  ```bash
  TQSfastq.py -f reads.fq -t 20 -c 30 -e 64
  ```
- **Paired-End Preparation**: SSAKE requires paired reads to be in a specific format where headers end in `:1` and `:2` or `a` and `b`. Use the provided helper script to merge trimmed files:
  ```bash
  makePairedOutput2UNEQUALfiles.pl read1_trimmed.fa read2_trimmed.fa 350
  ```
  This produces `paired.fa` and `unpaired.fa`.

## Common CLI Patterns

### Standard De Novo Assembly
For general assembly of paired and unpaired reads:
```bash
SSAKE -f paired.fa -g unpaired.fa -p 1 -m 20 -o 3 -c 1 -w 5 -b output_prefix
```
- `-p 1`: Enables paired-end mode.
- `-m 20`: Minimum overlap required for extension (k-mer size).
- `-w 5`: Minimum depth of coverage for contigs (filters out low-depth errors).
- `-o 3`: Minimum number of reads needed to allow an extension.

### Targeted Assembly
Use this mode when you have a specific "seed" sequence (e.g., a known gene or viral fragment) and want to extend it using a pool of short reads.
```bash
SSAKE -f paired.fa -s seed_sequence.fa -i 1 -m 20 -b targeted_output
```
- `-s`: Path to the seed sequence file.
- `-i 1`: Recruits whole read pairs if at least one read matches the target.

### Linked-Read Assembly (10x Genomics)
SSAKE v4.0+ supports linked reads. Barcode information should follow a single underscore in the sequence header.
```bash
SSAKE -f linked_reads.fa -p 1 -w 10 -b linked_assembly
```

## Expert Tips
- **Memory Management**: For large datasets, SSAKE can be memory-intensive. Use the `-w` (weight) parameter to ignore low-depth contigs early in the process, which significantly reduces RAM usage and runtime.
- **Tie-Breaking**: If you encounter non-deterministic behavior or equal-coverage bases, use `-q 1` to enable a tie-breaker for consensus determination.
- **Post-Assembly Stats**: After running SSAKE, use the `getStats.pl` script to generate N50 and contig length distributions:
  ```bash
  getStats.pl output_prefix_contigs
  ```

## Reference documentation
- [SSAKE GitHub Repository](./references/github_com_bcgsc_SSAKE.md)
- [Bioconda SSAKE Overview](./references/anaconda_org_channels_bioconda_packages_ssake_overview.md)