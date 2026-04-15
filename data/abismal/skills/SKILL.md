---
name: abismal
description: Abismal is a high-performance read mapper designed for aligning bisulfite-treated DNA sequencing data to a reference genome. Use when user asks to index a reference genome, map single-end or paired-end bisulfite reads, or simulate reads with bisulfite conversion.
homepage: https://github.com/smithlabcode/abismal
metadata:
  docker_image: "quay.io/biocontainers/abismal:3.3.0--h077b44d_0"
---

# abismal

## Overview

Abismal (Another Bisulfite Mapping Algorithm) is a high-performance read mapper specifically engineered for bisulfite-treated DNA sequencing data. It addresses the reduced complexity of the genomic alphabet resulting from C-to-T conversions by employing a bisulfite-aware alignment strategy. Use this skill to streamline the transition from raw FASTQ files to aligned SAM/BAM files while maintaining high sensitivity and multi-threaded efficiency.

## Command Line Usage

### 1. Genome Indexing
Before mapping, you must create an index for your reference genome.

```bash
# Basic indexing
abismal idx reference.fa reference.idx

# Multi-threaded indexing (e.g., 8 threads)
abismal idx -t 8 reference.fa reference.idx
```

### 2. Read Mapping
Abismal supports single-end and paired-end reads, with various output options.

**Single-end mapping:**
```bash
abismal map -i reference.idx -o aligned_reads.sam reads.fq
```

**Paired-end mapping:**
```bash
abismal map -i reference.idx -o aligned_reads.sam reads_1.fq reads_2.fq
```

**Direct BAM output:**
Use the `-B` flag to output directly to BAM format, saving disk space and skipping manual SAM-to-BAM conversion.
```bash
abismal map -i reference.idx -B -o aligned_reads.bam reads.fq
```

**On-the-fly indexing:**
If you do not want to maintain a separate index file, you can map directly using the FASTA file.
```bash
abismal map -g reference.fa -o aligned_reads.sam reads.fq
```

### 3. Specialized Library Types
If your data was generated using Post-Bisulfite Adapter Tagging (PBAT), use the specific mode flags:

*   **Standard PBAT:** `-P`
*   **Random PBAT:** `-R`

```bash
abismal map -i reference.idx -P -o pbat_reads.sam reads.fq
```

## Best Practices and Expert Tips

*   **Thread Scaling:** Abismal scales near-linearly with CPU cores. For large datasets (e.g., human hg38), always utilize the `-t` flag with the maximum available cores to significantly reduce processing time.
*   **Mapping Statistics:** Use the `-s` flag to generate a YAML file containing detailed mapping statistics. This is essential for quality control and reporting.
    ```bash
    abismal map -i hg38.idx -s reads.stats.yaml -o reads.sam reads.fq
    ```
*   **Understanding Custom Tags:**
    *   **NM tag:** Reports the edit distance (sum of mismatches, insertions, and deletions).
    *   **CV tag:** Reports the assumed bisulfite base used for mapping. `CV:A:A` indicates A-rich mapping, while `CV:A:T` indicates T-rich mapping. This is independent of the mapped strand.
*   **Memory Management:** While abismal is efficient, indexing large genomes requires significant RAM. Ensure your environment has sufficient memory relative to the genome size (e.g., ~3GB for human genome indexing).



## Subcommands

| Command | Description |
|---------|-------------|
| abismal idx | build abismal index |
| abismal map | map bisulfite converted reads (v3.3.0) |
| abismal sim | Simulate reads from a reference genome with optional bisulfite conversion and mutations. |

## Reference documentation
- [Abismal README](./references/github_com_smithlabcode_abismal_blob_master_README.md)
- [Abismal GitHub Repository](./references/github_com_smithlabcode_abismal.md)