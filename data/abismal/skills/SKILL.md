---
name: abismal
description: "Abismal aligns bisulfite-converted DNA sequences to a reference genome using a memory-efficient two-letter alphabet approach. Use when user asks to index a reference genome, map single-end or paired-end bisulfite reads, or process PBAT sequencing data."
homepage: https://github.com/smithlabcode/abismal
---


# abismal

## Overview

Abismal (Another Bisulfite Mapping Algorithm) is a specialized tool designed for the alignment of bisulfite-converted DNA sequences. It utilizes a two-letter alphabet approach to achieve high speed and low memory consumption while maintaining accuracy. This skill provides the necessary command-line patterns to process raw sequencing data into SAM/BAM formats, which are essential for downstream methylation analysis.

## Core Workflows

### 1. Genome Indexing
Before mapping, you must create an index from a FASTA reference genome.

```bash
# Basic indexing
abismal idx reference.fa reference.idx

# Multi-threaded indexing (e.g., 8 threads)
abismal idx -t 8 reference.fa reference.idx
```

### 2. Read Mapping
Abismal supports various sequencing protocols and output formats.

**Single-End Mapping**
```bash
abismal map -i reference.idx -o output.sam reads.fq
```

**Paired-End Mapping**
```bash
abismal map -i reference.idx -o output.sam reads_1.fq reads_2.fq
```

**On-the-fly Mapping**
If you want to skip the explicit indexing step (useful for one-off runs):
```bash
abismal map -g reference.fa -o output.sam reads.fq
```

### 3. Specialized Protocols
*   **PBAT (Post-Bisulfite Adapter Tagging):** Use `-P` for standard PBAT data.
*   **Random PBAT:** Use `-R` for random-primed PBAT libraries.

```bash
abismal map -i reference.idx -P -o output.sam reads.fq
```

## Output Management

### Format Selection
By default, Abismal outputs SAM. Use the `-B` flag to generate BAM output directly.
```bash
abismal map -i reference.idx -B -o output.bam reads.fq
```

### Mapping Statistics
To capture alignment metrics (e.g., mapping rate, read counts) in a structured YAML format:
```bash
abismal map -i reference.idx -s stats.yaml -o output.sam reads.fq
```

## Expert Tips

*   **Performance:** Abismal scales nearly linearly with CPU cores. Always use the `-t` flag with the maximum available cores for large datasets (e.g., `-t 64`).
*   **Read Length:** The tool is optimized for reads between 50 and 1000 bases.
*   **SAM Tags:** 
    *   `NM`: Reports the edit distance (mismatches + indels).
    *   `CV`: Reports the assumed bisulfite base. `CV:A:A` indicates A-rich mapping; `CV:A:T` indicates T-rich mapping.
*   **Memory Efficiency:** Abismal is significantly more memory-efficient than many traditional bisulfite mappers, making it suitable for high-throughput environments with limited RAM.

## Reference documentation
- [Abismal GitHub Repository](./references/github_com_smithlabcode_abismal.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_abismal_overview.md)