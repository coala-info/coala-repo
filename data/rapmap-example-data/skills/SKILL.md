---
name: rapmap-example-data
description: RapMap maps sequencing reads to a transcriptome with high speed and accuracy using a quasi-mapping approach. Use when user asks to index a reference transcriptome, map reads to a transcriptome, or generate SAM/BAM alignments.
homepage: https://github.com/COMBINE-lab/RapMap
metadata:
  docker_image: "biocontainers/rapmap-example-data:v0.12.0dfsg-3-deb_cv1"
---

# rapmap-example-data

## Overview

RapMap is a high-performance "quasi-mapper" designed to map sequencing reads to a transcriptome with extreme speed and high accuracy. It serves as a core component for transcript quantification tools like Salmon. This skill guides the user through the two-step process of transcriptome mapping: first, generating a specialized index from a reference FASTA file, and second, mapping reads (FASTQ) against that index to produce SAM/BAM alignments. It is particularly useful for testing workflows using the provided sample data before scaling to full-sized genomic experiments.

## Core Workflows

### 1. Indexing the Reference
Before mapping, you must build an index of your reference transcriptome.

**Standard Indexing:**
```bash
rapmap quasiindex -t ref.fa -i ref_index
```

**Memory-Optimized Indexing:**
To reduce the memory footprint during the mapping phase, use a minimum perfect hash.
```bash
rapmap quasiindex -t ref.fa -i ref_index -p -x 4
```
*   `-p`: Enables minimum perfect hashing.
*   `-x`: Specifies the number of threads to use during index construction.

### 2. Mapping Reads
Once the index is created, you can map paired-end or single-end reads.

**Standard Quasi-mapping (Paired-end):**
```bash
rapmap quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -o mapped_reads.sam
```

**High-Accuracy Mapping (Selective Alignment):**
It is highly recommended to use the `-s` flag to enable selective alignment, which validates the alignment score of hits and improves mapping quality.
```bash
rapmap quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 -o mapped_reads.sam
```
*   `-s`: Enables selective alignment.
*   `-t`: Number of threads for mapping.

### 3. Efficient Output Handling
SAM files are large and slow to write. Stream the output directly to `samtools` to create compressed BAM files on-the-fly.

```bash
rapmap quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 | samtools view -Sb -@ 4 - > mapped_reads.bam
```

Alternatively, use the provided wrapper script which simplifies this syntax:
```bash
RunRapMap.sh quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 --bamOut mapped_reads.bam --bamThreads 4
```

## Expert Tips and Best Practices

*   **Transcriptome Focus:** RapMap is specifically engineered for transcriptomes. While it can map to small genomes (bacterial/viral), it will consume excessive memory if applied to mammalian-sized genomes.
*   **Selective Alignment:** Always prefer the `-s` flag for production runs. While quasi-mapping alone is faster, selective alignment provides the necessary validation to ensure reads are mapped to the correct isoforms.
*   **Thread Scaling:** Mapping is highly parallelizable. Increase the `-t` parameter based on available CPU cores to significantly decrease processing time.
*   **Index Persistence:** The index records whether it was built with a perfect hash (`-p`). You do not need to specify this flag again during the mapping step; RapMap detects it automatically.



## Subcommands

| Command | Description |
|---------|-------------|
| rapmap | RapMap Transcriptome Aligner v0.6.0 |
| rapmap-example-data_RunRapMap.sh | RapMap Transcriptome Aligner v0.6.0 |

## Reference documentation
- [RapMap Main Repository and Usage Guide](./references/github_com_COMBINE-lab_RapMap.md)