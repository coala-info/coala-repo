---
name: hubward-all
description: The hubward-all skill provides procedural knowledge for operating the BWA (Burrow-Wheeler Aligner) suite.
homepage: https://github.com/lh3/bwa
---

# hubward-all

## Overview
The hubward-all skill provides procedural knowledge for operating the BWA (Burrow-Wheeler Aligner) suite. This tool is essential for bioinformatics workflows involving the mapping of low-divergent sequences against a large reference genome. It supports a variety of sequencing technologies and read lengths through three primary algorithms: BWA-MEM (the industry standard for reads >70bp), BWA-backtrack (optimized for short Illumina reads <70bp), and BWA-SW (for long-read or chimeric alignment).

## Core Workflows

### 1. Reference Indexing
Before any alignment, you must construct an FM-index for the reference genome.
```bash
bwa index ref.fa
```

### 2. BWA-MEM (Recommended for most tasks)
Use for Illumina, 454, or IonTorrent reads longer than 70bp. It is the fastest and most accurate algorithm for modern sequencing data.

**Single-end alignment:**
```bash
bwa mem ref.fa reads.fq > aln.sam
```

**Paired-end alignment:**
```bash
bwa mem ref.fa read1.fq read2.fq > aln-pe.sam
```

**Smart pairing (interleaved):**
```bash
bwa mem -p ref.fa interleaved_reads.fq > aln.sam
```

### 3. Long-Read Alignment
BWA-MEM includes specific modes for high-error long reads. Note that for very long reads, `minimap2` is often preferred, but BWA-MEM remains a valid option.

**PacBio subreads:**
```bash
bwa mem -x pacbio ref.fa reads.fq > aln.sam
```

**Oxford Nanopore (ONT) reads:**
```bash
bwa mem -x ont2d ref.fa reads.fq > aln.sam
```

### 4. BWA-backtrack (Short reads <70bp)
Use the `aln` command to generate `.sai` files, then convert to SAM.

**Single-end:**
```bash
bwa aln ref.fa reads.fq > reads.sai
bwa samse ref.fa reads.sai reads.fq > aln-se.sam
```

**Paired-end:**
```bash
bwa aln ref.fa read1.fq > read1.sai
bwa aln ref.fa read2.fq > read2.sai
bwa sampe ref.fa read1.sai read2.sai read1.fq read2.fq > aln-pe.sam
```

## Expert Tips and Best Practices

- **Memory Management**: BWA uses significant memory for the FM-index. For the human genome, expect to use ~3-4GB of RAM.
- **Multi-threading**: Use the `-t` flag to speed up alignment.
  ```bash
  bwa mem -t 8 ref.fa reads.fq > aln.sam
  ```
- **Marking Split Hits**: When using BWA-MEM for downstream tools like GATK, use the `-M` flag to mark shorter split hits as secondary for Picard compatibility.
  ```bash
  bwa mem -M ref.fa read1.fq read2.fq > aln.sam
  ```
- **Piping to SAMtools**: To save disk space and time, pipe the SAM output directly to SAMtools to create a compressed BAM file.
  ```bash
  bwa mem ref.fa reads.fq | samtools view -Sb - > aln.bam
  ```
- **ALT Contigs**: If working with GRCh38 and ALT contigs, use the `bwakit` distribution which includes the `run-genotyper` script to handle post-processing of ALT alignments.

## Reference documentation
- [BWA Main Repository and Documentation](./references/github_com_lh3_bwa.md)
- [BWA Kit and ALT Contig Handling](./references/github_com_lh3_bwa_tree_master_bwakit.md)