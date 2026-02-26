---
name: bamhash
description: BamHash generates order-independent checksums for genomic data to verify file integrity across different formats and processing stages. Use when user asks to generate checksums for BAM, CRAM, or FASTQ files, verify data consistency after re-sorting, or compare raw reads to aligned outputs.
homepage: https://github.com/DecodeGenetics/BamHash
---


# bamhash

## Overview

BamHash is a specialized utility designed to generate order-independent checksums for genomic data. Unlike standard MD5 or SHA sums that change if a file is re-sorted, BamHash focuses on the content of the reads—specifically the read name, sequence, and quality scores. By summing individual read hashes, it produces a final value that remains consistent even if the reads are reordered during alignment or processing. This makes it an essential tool for quality control in NGS pipelines to confirm that no data was lost or corrupted between the raw FASTQ stage and the final BAM/CRAM output.

## Usage Instructions

### Core Executables
BamHash provides three distinct executables based on the input file type:
- `bamhash_checksum_bam`: For BAM and CRAM files.
- `bamhash_checksum_fastq`: For FASTQ files (supports gzipped input).
- `bamhash_checksum_fasta`: For FASTA files (assumes single-end, no quality).

### Common CLI Patterns

#### Verifying BAM Integrity
To generate a checksum for a BAM file:
```bash
bamhash_checksum_bam input.bam
```

#### Verifying CRAM Integrity
CRAM files require the original reference genome used for compression:
```bash
bamhash_checksum_bam -r reference.fasta input.cram
```

#### Verifying FASTQ Pairs
When processing paired-end FASTQ files, provide both files. The tool expects read names to match between pairs:
```bash
bamhash_checksum_fastq read_R1.fastq.gz read_R2.fastq.gz
```

#### Single-End Data
By default, the tool assumes paired-end data. For single-end runs, you must specify the flag:
```bash
bamhash_checksum_bam --no-paired input.bam
bamhash_checksum_fastq --no-paired input.fastq.gz
```

### Expert Tips and Best Practices

#### Handling Pipeline Modifications
If your bioinformatics pipeline modifies read names (e.g., adding suffixes) or recalibrates quality scores, the default hash will not match. Use these flags to ignore specific components:
- **Ignore Read Names**: Use when a tool has mangled or renamed headers.
- **Ignore Quality**: Use after Base Quality Score Recalibration (BQSR) or if quality scores were quantized.
- **Example (Comparing BAM to FASTQ without quality)**:
  ```bash
  # Run on FASTQ
  bamhash_checksum_fastq --no-quality R1.fq R2.fq
  # Run on BAM
  bamhash_checksum_bam --no-quality input.bam
  ```

#### Debugging Mismatches
If two files that should be identical produce different hashes, use the `-d` (debug) flag. This prints the information and hash value for every individual read, allowing you to identify exactly where the discrepancy occurs (e.g., a specific read pair that was dropped or modified).

#### Comparing FASTA to BAM
Since FASTA files lack quality information, you must disable quality checking when comparing them to a BAM file:
```bash
bamhash_checksum_bam --no-paired --no-quality input.bam
```

## Reference documentation
- [BamHash GitHub Repository](./references/github_com_DecodeGenetics_BamHash.md)
- [BamHash Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bamhash_overview.md)