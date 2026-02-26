---
name: rapmap-dev
description: RapMap is a high-performance tool designed for the rapid quasi-mapping of sequencing reads to a reference transcriptome. Use when user asks to index a transcriptome, map single-end or paired-end reads, or perform selective alignment for transcript quantification.
homepage: https://github.com/COMBINE-lab/RapMap
---


# rapmap-dev

## Overview

RapMap is a high-performance tool designed for the rapid mapping of sequencing reads to a reference transcriptome. It utilizes a technique called quasi-mapping, which identifies the position and orientation of reads without performing a full, computationally expensive base-level alignment. This makes it ideal for downstream applications like transcript quantification (e.g., in Salmon or Sailfish). The tool supports both standard quasi-mapping and selective alignment, which improves mapping accuracy by validating alignment scores.

## Installation

The most efficient way to install RapMap is via Bioconda:

```bash
conda install bioconda::rapmap
```

## Core Workflows

### 1. Indexing the Transcriptome
Before mapping, you must create an index of your reference transcriptome (FASTA format).

*   **Standard Indexing**:
    ```bash
    rapmap quasiindex -t reference.fa -i transcriptome_index
    ```
*   **Memory-Optimized Indexing**: Use a minimum perfect hash to reduce memory consumption during the mapping phase.
    ```bash
    rapmap quasiindex -t reference.fa -i transcriptome_index -p -x 4
    ```
    *   `-p`: Enables minimum perfect hash.
    *   `-x <N>`: Number of threads to use during index construction.

### 2. Mapping Reads
Once the index is built, you can map single-end or paired-end reads.

*   **Paired-End Mapping with Selective Alignment**:
    ```bash
    rapmap quasimap -i transcriptome_index -1 reads_R1.fq.gz -2 reads_R2.fq.gz -s -t 8 -o output.sam
    ```
    *   `-i`: Path to the index directory.
    *   `-1` / `-2`: Paths to the first and second mate files.
    *   `-s`: **Highly Recommended.** Enables selective alignment to generate better mappings and validate alignment scores.
    *   `-t`: Number of threads.
    *   `-o`: Output SAM file path.

### 3. Efficient Output Handling (BAM Conversion)
SAM files are large and slow to write. It is best practice to stream the output directly to `samtools` for BAM compression.

*   **On-the-fly BAM conversion**:
    ```bash
    rapmap quasimap -i transcriptome_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 | samtools view -Sb -@ 4 - > output.bam
    ```

*   **Using the Wrapper Script**: RapMap includes `RunRapMap.sh` to simplify the piping process.
    ```bash
    RunRapMap.sh quasimap -i transcriptome_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 --bamOut output.bam --bamThreads 4
    ```

## Expert Tips and Best Practices

*   **Target Organisms**: RapMap is optimized for transcriptomes. While it can map to small genomes (bacterial or viral), it is not recommended for mammalian-sized genomes due to high memory requirements.
*   **Selective Alignment**: Always use the `-s` flag unless speed is the absolute only priority. Selective alignment significantly reduces false positive mappings by checking the quality of the hit.
*   **Unmapped Reads**: Use the `-u` flag if you need to write unaligned reads to a specific file for further analysis.
*   **Thread Scaling**: Indexing and mapping scale well with threads. Ensure the number of threads (`-t` or `-x`) matches your available CPU resources to maximize throughput.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_COMBINE-lab_RapMap.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_rapmap_overview.md)