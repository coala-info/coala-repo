---
name: msamtools
description: msamtools is a specialized extension of samtools designed for microbiome research.
homepage: https://github.com/arumugamlab/msamtools
---

# msamtools

## Overview
msamtools is a specialized extension of samtools designed for microbiome research. While samtools provides general-purpose manipulation of high-throughput sequencing data, msamtools adds procedural logic for metagenomic tasks such as host-read removal, stringent alignment filtering (by identity and length), and the generation of abundance profiles. It is built to operate within Unix streams, allowing it to be piped directly from aligners like BWA or Bowtie2.

## Core Commands and Usage

### 1. Filtering Alignments (`filter`)
The `filter` command is used to refine alignments based on quality metrics beyond simple mapping quality.

*   **Common Flags:**
    *   `-l <int>`: Minimum alignment length.
    *   `-p <float>`: Minimum percent identity (e.g., 95).
    *   `-z <float>`: Minimum percent of the read length covered by the alignment.
    *   `-S`: Input is in SAM format (default is BAM).
    *   `-b`: Output in BAM format.
    *   `-u`: Output uncompressed BAM (faster for piping).
    *   `--besthit`: Retain only the best alignment for each read.
    *   `--invert`: Invert the filter (useful for host removal).
    *   `--keep_unmapped`: Retain unmapped reads in the output.

**Example: Standard Metagenomic Filter**
Retain alignments ≥80bp, ≥95% identity, and covering ≥80% of the read length:
`msamtools filter -S -b -l 80 -p 95 -z 80 input.sam > filtered.bam`

**Example: Host Removal (Human Read Filtering)**
To remove human reads, align to a human reference, filter for confident matches, and invert the selection:
`bwa-mem2 mem human_db R1.fq R2.fq | msamtools filter -S -l 30 --invert --keep_unmapped -bu - | samtools fastq -1 hostfree_1.fq -2 hostfree_2.fq -`

### 2. Abundance Profiling (`profile`)
The `profile` command estimates the relative abundance of reference sequences (e.g., species or genes) within a BAM file.

*   **Multi-mapping Handling (`--multi`):**
    *   `proportional`: Distributes the weight of a multi-mapped read across all its targets.
    *   `ignore`: Skips multi-mapped reads.
*   **Other Flags:**
    *   `--label`: Add a sample name/label to the output table.
    *   `--mincount`: Filter out features with very low counts to reduce noise.
    *   `--pandas`: Output in a format easily readable by Python/Pandas.

**Example: Generating a Profile**
`msamtools profile --multi=proportional --label=Sample_A -o profile.txt filtered.bam`

### 3. Coverage Estimation (`coverage`)
Calculates per-base or per-sequence read coverage. This is essential for determining the breadth of a genome covered in a metagenomic sample.

### 4. Summary Statistics (`summary`)
Provides a table summarizing alignment statistics for every read, useful for deep-dive QC or custom filtering logic in downstream scripts.

## Expert Tips and Best Practices

*   **Stream Processing:** Always prefer piping (`|`) between `samtools` and `msamtools` to avoid the I/O overhead of creating large intermediate BAM files.
*   **Sorting Requirements:** Note that some subprograms or specific flags (like `--besthit`) may require the BAM file to be sorted by read name (`samtools sort -n`) rather than coordinate.
*   **Uncompressed BAM for Pipes:** When piping from `msamtools` to another tool, use the `-u` flag to output uncompressed BAM. This saves significant CPU time otherwise spent on compression.
*   **Combining with Samtools:** msamtools is a supplement, not a replacement. Use `samtools` for indexing (`index`), sorting (`sort`), and viewing (`view`), and `msamtools` for the metagenomic-specific logic.

## Reference documentation
- [msamtools GitHub README](./references/github_com_arumugamlab_msamtools.md)
- [msamtools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_msamtools_overview.md)