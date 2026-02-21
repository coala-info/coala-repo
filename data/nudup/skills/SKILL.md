---
name: nudup
description: The `nudup` tool is specifically designed for high-throughput sequencing data prepared with NuGEN kits.
homepage: http://nugentechnologies.github.io/nudup/
---

# nudup

## Overview
The `nudup` tool is specifically designed for high-throughput sequencing data prepared with NuGEN kits. Unlike standard duplicate removal tools that rely solely on genomic coordinates, `nudup` incorporates Molecular Tag (UMI) information to distinguish between true biological duplicates and PCR artifacts. This is essential for accurate quantification in DNA-seq and RNA-seq workflows where high duplication rates are expected or where precise molecule counting is required.

## Usage Guidelines

### Core Command Structure
The basic execution requires a BAM file and a file containing the molecular tags (usually parsed from the FASTQ headers).

```bash
python nudup.py -f <molecular_tags.txt> -o <output_prefix> <input.sorted.bam>
```

### Key Parameters
- `-f <file>`: A text file containing the molecular tag sequence for each read name.
- `-o <prefix>`: Prefix for all output files (BAM, logs, and statistics).
- `-s <int>`: Starting position of the molecular tag in the read (default is 1).
- `-l <int>`: Length of the molecular tag.
- `-T <dir>`: Directory for temporary files (important for large datasets).
- `--rmdup`: Use this flag to physically remove duplicates from the output BAM rather than just marking them with the 0x400 flag.

### Best Practices
- **Input Sorting**: Ensure the input BAM file is coordinate-sorted (e.g., via `samtools sort`) before running `nudup`.
- **Read Names**: The read names in the molecular tag file must match the read names in the BAM file exactly.
- **Paired-End Data**: For paired-end data, `nudup` typically expects the tags to be provided for both reads or handled according to the specific NuGEN kit instructions (e.g., integrated into the read header).
- **Memory Management**: When processing large BAM files, use the `-T` option to point to a high-capacity scratch disk to avoid filling up the system `/tmp` directory during the sorting phase.

## Reference documentation
- [nudup Overview](./references/anaconda_org_channels_bioconda_packages_nudup_overview.md)