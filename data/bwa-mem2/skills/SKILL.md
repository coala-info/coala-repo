---
name: bwa-mem2
description: bwa-mem2 is a high-performance tool for aligning DNA sequences against a large reference genome using hardware-level acceleration. Use when user asks to index a reference genome, map single-end or paired-end reads, or perform fast sequence alignment to a reference.
homepage: https://github.com/bwa-mem2/bwa-mem2
metadata:
  docker_image: "quay.io/biocontainers/bwa-mem2:2.3--he70b90d_0"
---

# bwa-mem2

## Overview

bwa-mem2 is the high-performance successor to the original BWA-MEM algorithm. It provides a massive speedup (often 2x or more) by utilizing hardware-level acceleration through SIMD (Single Instruction, Multiple Data) instructions. While the underlying alignment logic remains consistent with BWA-MEM, the implementation is optimized for modern Intel and AMD processors. It is the preferred choice for large-scale genomic workflows where alignment throughput is a primary bottleneck.

## Core Workflows

### 1. Indexing the Reference Genome
Before alignment, you must build a specific index for the reference fasta.
```bash
bwa-mem2 index <reference.fa>
```
**Expert Tips:**
* **Space Requirements:** Indexing a human genome requires approximately 48GB of temporary disk space.
* **Memory Footprint:** Since version 2.1, the index size on disk and in memory has been reduced significantly (~10GB for a human genome).
* **Compatibility:** Indices are not compatible with the original BWA; you must re-index specifically for bwa-mem2.

### 2. Mapping Reads (Single or Paired-End)
The `mem` command is used for the actual alignment.
```bash
# Paired-end alignment with 16 threads
bwa-mem2 mem -t 16 <reference.fa> <read1.fq> <read2.fq> > <output.sam>
```

### 3. Performance Optimization
To get the most out of the tool, align the execution mode with your hardware:
* **Binary Selection:** If using a "multi" build, running `bwa-mem2` will automatically detect and run the fastest version for your CPU (e.g., `.avx512bw`, `.avx2`, or `.sse41`).
* **NUMA Binding:** On multi-socket systems, use `numactl` to prevent cross-socket memory latency:
  ```bash
  numactl -m 0 -C 0-15 bwa-mem2 mem -t 16 <ref.fa> <reads.fq> > <out.sam>
  ```
* **Piping to Samtools:** To save disk space and I/O time, pipe directly to BAM conversion:
  ```bash
  bwa-mem2 mem -t 16 <ref.fa> <r1.fq> <r2.fq> | samtools view -Sb - > <out.bam>
  ```

## Common CLI Options
* `-t INT`: Number of threads (scales well, but monitor memory usage).
* `-o STR`: Output file name (alternative to redirection).
* `-5`: Support for 5'-end trimming.
* `-q`: Support for quality-based trimming.
* `-K INT`: Fixed chunk size for deterministic output across different thread counts.

## Troubleshooting
* **Segmentation Faults:** Often caused by insufficient memory during the loading of the index. Ensure the system has at least 15-20GB of RAM available for human genome alignment.
* **Output Mismatch:** If comparing to original BWA-MEM, ensure you are using bwa-mem2 version 2.0+ which guarantees identical output to bwa-mem-0.7.17.



## Subcommands

| Command | Description |
|---------|-------------|
| bwa-mem2 index | Build index for BWA-MEM2 |
| bwa-mem2 mem | Align sequences to the reference genome. |

## Reference documentation
- [Original README with Performance Notes](./references/github_com_bwa-mem2_bwa-mem2_blob_master_README-ori.md)
- [Main README and Usage Guide](./references/github_com_bwa-mem2_bwa-mem2_blob_master_README.md)
- [Release Notes and Version Changes](./references/github_com_bwa-mem2_bwa-mem2_blob_master_NEWS.md)