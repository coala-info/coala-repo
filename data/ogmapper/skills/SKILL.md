---
name: ogmapper
description: ogmapper is a fast and memory-efficient tool for mapping short DNA or RNA sequencing reads to a reference genome. Use when user asks to map short reads to a reference genome or generate SAM files for downstream analysis.
homepage: https://github.com/vtrevino/ogmapper
metadata:
  docker_image: "quay.io/biocontainers/ogmapper:1.0.0--h077b44d_0"
---

# ogmapper

A fast and light genomic mapper for short reads. Use when you need to map short DNA or RNA sequencing reads to a reference genome, generating SAM files for downstream analysis. This tool is particularly useful for its speed and low memory footprint, making it suitable for large genomes.
---
## Overview

ogMapper is a high-performance tool designed for mapping short sequencing reads to a reference genome. It excels in speed and memory efficiency, making it a strong choice for large-scale genomic analyses. The primary workflow involves creating an index for the reference genome, followed by mapping the short reads (either paired or unpaired) to generate output in the standard SAM format.

## Usage Instructions

ogMapper operates primarily through its command-line interface. The typical workflow involves two main steps: indexing the reference genome and then mapping the reads.

### 1. Indexing the Reference Genome

Before mapping reads, you must create an index file for your reference genome. This index is crucial for efficient read mapping.

**Command:**

```bash
ogmapper --index <reference_genome.fasta> --output <output_index.ogi>
```

*   `<reference_genome.fasta>`: Path to your reference genome file in FASTA format.
*   `<output_index.ogi>`: The desired name for the generated index file (typically with a `.ogi` extension).

### 2. Mapping Short Reads

Once the index is created, you can proceed to map your short reads. ogMapper supports both paired-end and single-end reads.

**For Paired-End Reads:**

```bash
ogmapper --index <reference_index.ogi> --reads1 <reads1.fastq> --reads2 <reads2.fastq> --output <output.sam>
```

*   `<reference_index.ogi>`: Path to the previously generated reference genome index file.
*   `<reads1.fastq>`: Path to the first FASTQ file of your paired-end reads.
*   `<reads2.fastq>`: Path to the second FASTQ file of your paired-end reads.
*   `<output.sam>`: The desired name for the output SAM file.

**For Single-End Reads:**

```bash
ogmapper --index <reference_index.ogi> --reads1 <single_reads.fastq> --output <output.sam>
```

*   `<reference_index.ogi>`: Path to the previously generated reference genome index file.
*   `<single_reads.fastq>`: Path to your single-end FASTQ file.
*   `<output.sam>`: The desired name for the output SAM file.

### Key Options and Tips

*   **Memory Efficiency:** ogMapper is designed to be memory-efficient. The index file size is typically a fraction of the genome size, and runtime memory usage is also kept low, even with multiple threads.
*   **Output Format:** The default output format is SAM. Ensure your downstream tools can process SAM files.
*   **Compilation:** While pre-compiled binaries are available for various platforms, you can also compile ogMapper from source if needed. This typically involves compiling the WFA2 library first and then ogMapper itself. Refer to the project's README for detailed compilation instructions.
*   **File Formats:** ogMapper primarily works with FASTA for reference genomes and FASTQ for sequencing reads.

## Reference documentation

- [README.md](./references/github_com_vtrevino_ogmapper.md)