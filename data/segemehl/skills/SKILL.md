---
name: segemehl
description: segemehl is a versatile mapping tool designed for short-read sequencing data.
homepage: http://www.bioinf.uni-leipzig.de/Software/segemehl/
---

# segemehl

## Overview
segemehl is a versatile mapping tool designed for short-read sequencing data. It utilizes enhanced suffix arrays (ESA) to achieve high sensitivity, particularly for alignments containing insertions, deletions, and mismatches. It is highly effective for specialized genomic tasks such as identifying split-read alignments (e.g., for RNA-seq splice junctions or genomic rearrangements) and mapping bisulfite-treated DNA to determine methylation states. The tool outputs standard SAM/BAM formats and provides additional post-processing capabilities via the `haarz.x` utility.

## Core Workflows

### 1. Genome Indexing
Before mapping, you must generate an index (`.idx`) for your reference FASTA files.
- **Single/Multiple FASTA:** `segemehl.x -x reference.idx -d ref1.fa ref2.fa`
- **Memory Requirement:** Indexing a human-sized genome requires ~64GB RAM.

### 2. Standard Read Mapping
Align reads to the generated index. Ensure the `-d` files are in the same order used during indexing.
- **Single-end:** `segemehl.x -i reference.idx -d reference.fa -q reads.fastq > alignment.sam`
- **Paired-end:** `segemehl.x -i reference.idx -d reference.fa -q R1.fastq -p R2.fastq > alignment.sam`
- **Performance:** Always use `-t <threads>` to utilize multiple CPU cores.

### 3. Split-Read Mapping (Splicing/Rearrangements)
To detect non-linear alignments (e.g., mRNA splicing), use the `-S` flag.
- **Command:** `segemehl.x -i reference.idx -d reference.fa -q reads.fastq -S > alignment.sam`
- **Post-processing:** Use `haarz.x` to summarize splice junctions from the resulting BED files.

### 4. Bisulfite Mapping (Methyl-Seq)
Requires two indices (original and converted).
- **Indexing:** 
  1. `segemehl.x -x ref.idx -y ref_bisulfite.idx -d reference.fa`
- **Mapping:**
  2. `segemehl.x -i ref.idx -j ref_bisulfite.idx -d reference.fa -q reads.fastq -F 1 > alignment.sam`
- **Methylation Calling:** Use `haarz.x` on the output to calculate methylation rates.

## Parameter Tuning

| Parameter | Purpose | Best Practice |
|-----------|---------|---------------|
| `-D` | Seed differences | Default is 1. For reads >100bp, `-D 0` increases speed with minimal sensitivity loss. |
| `-E` | E-value | Controls seed significance. Increase for higher sensitivity, decrease for speed. |
| `-A` | Accuracy | Minimum alignment identity (percentage). Default is 85. |
| `-M` | Max occurrences | Limits reporting of multi-mapping reads. |

## Expert Tips
- **Gzip Support:** segemehl natively accepts `.gz` and `.bgzf` files for queries.
- **BAM Output:** While SAM is default, ensure `htslib` is available to support direct BAM writing.
- **Read Groups:** Use `-g <ID>` or `-G <header_file>` to add essential metadata for downstream GATK/Samtools pipelines.
- **Memory Management:** If running out of RAM during mapping, consider the `-o` option to use a pre-calculated offset table, though this requires significant disk space.

## Reference documentation
- [segemehl Manual](./references/legacy_bioinf_uni-leipzig_de_Software_segemehl.md)