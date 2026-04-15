---
name: wtdbg
description: wtdbg is a de novo sequence assembler designed for rapid assembly of long, noisy reads from third-generation sequencing technologies. Use when user asks to perform de novo assembly, generate contig layouts from long reads, or produce polished consensus sequences.
homepage: https://github.com/ruanjue/wtdbg-1.2.8
metadata:
  docker_image: "quay.io/biocontainers/wtdbg:2.5--h5b5514e_2"
---

# wtdbg

## Overview
The `wtdbg2` toolset is designed for high-speed assembly of third-generation sequencing data without the need for prior error correction. It utilizes a Fuzzy Bruijn Graph approach, which operates on 1024bp segments rather than individual k-mers, making it exceptionally efficient for large genomes (e.g., Human or Axolotl). This skill provides guidance on executing the assembly pipeline, from raw reads to polished consensus.

## Core Workflow
A standard assembly requires two primary steps: generating the layout and deriving the consensus.

### 1. Assembly (wtdbg2)
Generates the contig layout and edge sequences.
```bash
wtdbg2 -x <preset> -g <size> -t <threads> -i <reads.fa.gz> -fo <prefix>
```
*   **Presets (`-x`)**: **Must be set first.**
    *   `rs`: PacBio RSII
    *   `sq`: PacBio Sequel
    *   `ccs`: PacBio CCS
    *   `ont`: Oxford Nanopore
*   **Genome Size (`-g`)**: Estimated size (e.g., `4.6m`, `3g`).

### 2. Consensus (wtpoa-cns)
Produces the final FASTA sequence from the layout file.
```bash
wtpoa-cns -t <threads> -i <prefix>.ctg.lay.gz -fo <prefix>.ctg.fa
```

## Expert Tips and Parameter Tuning

### Handling Coverage Issues
*   **Low Coverage**: Decrease `-e` (minimum edge coverage, default 3). Use `-e 2 --rescue-low-cov-edges`.
*   **High Coverage**: Increase `--edge-min` to 4 or higher to reduce graph complexity.
*   **Subsampling**: If memory allows, reduce `-S` (default 4) to increase the k-mer sampling rate for better sensitivity in low-coverage regions.

### Improving Accuracy
*   **High Error Rates**: Decrease `-p` (HPC k-mer length) to 19 or 17.
*   **Read Filtering**: Use `--tidy-reads 5000` to ignore short, noisy fragments.
*   **Polishing**: While `wtpoa-cns` provides a base consensus, accuracy can be improved by re-mapping reads to the raw assembly:
    ```bash
    minimap2 -t16 -ax map-pb -r2k raw.fa reads.fa.gz | samtools sort -@4 > mapped.bam
    samtools view -F0x900 mapped.bam | wtpoa-cns -t 16 -d raw.fa -i - -fo polished.fa
    ```

### Read Mapping (kbm)
`kbm` is the internal aligner. It can be used independently for fast synteny mapping.
*   **Standard Mapping**: `kbm -d ref.fa -i queries.fa -o out.kbmap`
*   **Server Mode**: For frequent queries against a large reference, use `-W` to build an index and `start` to cache it in memory.

## Limitations
*   **Input Order**: If mixing formats, provide FASTQ files before FASTA files to prevent parsing errors.
*   **Read Length**: Maximum supported read length is 256 Kb; longer reads are automatically split.
*   **OS**: Only supported on 64-bit Linux.



## Subcommands

| Command | Description |
|---------|-------------|
| wtdbg2 | De novo assembler for long noisy sequences |
| wtpoa-cns | Consensuser for wtdbg using PO-MSA |

## Reference documentation
- [github_com_ruanjue_wtdbg2_blob_master_README.md](./references/github_com_ruanjue_wtdbg2_blob_master_README.md)
- [github_com_ruanjue_wtdbg2_blob_master_README-ori.md](./references/github_com_ruanjue_wtdbg2_blob_master_README-ori.md)