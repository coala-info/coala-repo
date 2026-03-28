---
name: rapmap
description: RapMap is a specialized tool designed for the rapid quasi-mapping of high-throughput sequencing reads to a reference transcriptome. Use when user asks to index a reference transcriptome, map single-end or paired-end reads using selective alignment, or generate SAM and BAM files for transcriptomic data.
homepage: https://github.com/COMBINE-lab/RapMap
---


# rapmap

## Overview

RapMap is a specialized tool designed for "quasi-mapping"—a technique that identifies the position and orientation of high-throughput sequencing reads relative to a reference transcriptome without performing a full, computationally expensive base-to-base alignment. It provides a "testing ground" for selective alignment and quasi-mapping, offering a significant speed advantage over traditional aligners while maintaining high accuracy for transcriptomic data.

## Core Workflows

### 1. Indexing the Reference
Before mapping, you must create an index of your reference transcriptome (FASTA format).

**Basic Indexing:**
```bash
rapmap quasiindex -t reference.fa -i ref_index
```

**Memory-Optimized Indexing:**
Use a minimum perfect hash to lower the memory requirements during the mapping phase.
```bash
rapmap quasiindex -t reference.fa -i ref_index -p -x 4
```
*   `-p`: Enables minimum perfect hashing.
*   `-x <N>`: Number of threads to use during hash construction.

### 2. Mapping Reads
Once the index is built, you can map single-end or paired-end reads.

**Paired-End Mapping with Selective Alignment:**
Selective alignment (`-s`) is recommended to generate higher quality mappings and validate alignment scores.
```bash
rapmap quasimap -i ref_index -1 reads_R1.fq.gz -2 reads_R2.fq.gz -s -t 8 -o output.sam
```
*   `-i`: Path to the index directory created in the previous step.
*   `-1` / `-2`: Paths to the first and second mate files.
*   `-s`: Enables selective alignment.
*   `-t`: Number of threads.
*   `-o`: Output file (SAM format).

### 3. Efficient Output Handling (BAM Conversion)
Because SAM files are large and slow to write, it is best practice to stream the output directly to `samtools` for BAM compression.

```bash
rapmap quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 | samtools view -Sb -@ 4 - > mapped_reads.bam
```

### 4. Using the Wrapper Script
RapMap includes a wrapper script `RunRapMap.sh` that simplifies the piping process to BAM.

```bash
RunRapMap.sh quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 --bamOut mapped_reads.bam --bamThreads 4
```

## Expert Tips and Best Practices

*   **Transcriptome Focus:** RapMap is highly optimized for transcriptomes. While it can map to mammalian genomes, the memory footprint will be extremely high. It is, however, very effective for bacterial and viral genomic mapping.
*   **Selective Alignment:** Always use the `-s` flag if you require validated alignment scores rather than just the hit locations provided by basic quasi-mapping.
*   **Thread Scaling:** Mapping is highly parallelizable. Increase the `-t` parameter to match your available CPU cores to significantly decrease processing time.
*   **Unassigned Reads:** If you need to capture reads that did not map, check for the `-u` flag (available in some versions/branches) to write unaligned reads to a separate file.



## Subcommands

| Command | Description |
|---------|-------------|
| rapmap | RapMap Indexer |
| rapmap | RapMap Mapper |

## Reference documentation
- [RapMap GitHub Repository Overview](./references/github_com_COMBINE-lab_RapMap.md)