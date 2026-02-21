---
name: rapmap
description: RapMap is a high-speed mapping tool designed for "quasi-mapping," a technique that determines the position and orientation of sequencing reads relative to a reference transcriptome without the computational overhead of full base-to-base alignment.
homepage: https://github.com/COMBINE-lab/RapMap
---

# rapmap

## Overview

RapMap is a high-speed mapping tool designed for "quasi-mapping," a technique that determines the position and orientation of sequencing reads relative to a reference transcriptome without the computational overhead of full base-to-base alignment. It is particularly useful for quantification workflows where speed is a priority. This skill guides you through the two-step process of indexing a reference and mapping reads, including optimizations for memory and accuracy.

## Installation

The recommended way to install RapMap is via Bioconda:

```bash
conda install bioconda::rapmap
```

## Core Workflows

### 1. Indexing the Reference
Before mapping, you must create an index of your reference transcriptome (e.g., `ref.fa`).

**Standard Indexing:**
```bash
rapmap quasiindex -t ref.fa -i ref_index
```

**Memory-Optimized Indexing:**
Use the `-p` flag to enable a minimum perfect hash, which significantly reduces the memory footprint during the mapping phase.
```bash
rapmap quasiindex -t ref.fa -i ref_index -p -x 4
```
*   `-p`: Enables minimum perfect hash.
*   `-x [threads]`: Sets the number of threads for building the hash.

### 2. Mapping Reads
Once the index is built, you can map single-end or paired-end reads.

**Paired-End Mapping with Selective Alignment:**
Selective alignment (`-s`) validates the alignment score of hits, providing higher accuracy than raw quasi-mapping.
```bash
rapmap quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 -o mapped_reads.sam
```
*   `-i`: Path to the index directory.
*   `-1` / `-2`: Paths to the first and second mate files.
*   `-s`: Enables selective alignment (highly recommended for accuracy).
*   `-t`: Number of threads.
*   `-o`: Output SAM file.

### 3. Efficient BAM Output
RapMap outputs SAM format by default, which can be very large. It is best practice to stream the output directly to `samtools` for BAM compression.

**On-the-fly BAM Conversion:**
```bash
rapmap quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 | samtools view -Sb -@ 4 - > mapped_reads.bam
```

**Using the Wrapper Script:**
RapMap includes a wrapper script `RunRapMap.sh` that simplifies the BAM conversion syntax.
```bash
RunRapMap.sh quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 --bamOut mapped_reads.bam --bamThreads 4
```

## Expert Tips and Best Practices

*   **Transcriptome Focus:** RapMap is optimized for transcriptomes. While it can map to mammalian genomes, the memory requirements will be extremely high. It is, however, very effective for smaller bacterial or viral genomes.
*   **Selective Alignment:** Always use the `-s` flag unless you have a specific reason to prefer raw quasi-mapping. Selective alignment significantly reduces false positives by validating the quality of the mapping.
*   **Unmapped Reads:** If you need to capture unaligned reads for downstream analysis, use the `-u` flag to write them to a file.
*   **Thread Scaling:** Mapping is highly parallelizable. Ensure the number of threads (`-t`) matches your available CPU cores for maximum throughput.

## Reference documentation
- [RapMap GitHub Repository](./references/github_com_COMBINE-lab_RapMap.md)
- [RapMap Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rapmap_overview.md)