---
name: hera
description: Hera is a bioinformatics tool designed for rapid and precise RNA-seq data processing using a hybrid alignment strategy. Use when user asks to build a transcriptome index, estimate transcript abundance, or detect splicing events and gene fusions.
homepage: https://github.com/bioturing/hera
metadata:
  docker_image: "quay.io/biocontainers/hera:1.1--h8121788_3"
---

# hera

## Overview
Hera is a specialized bioinformatics tool designed to optimize the processing of RNA-seq data. It utilizes a hybrid alignment strategy—combining hash-based seed anchoring with the Needleman-Wunsch algorithm—to provide rapid mapping without sacrificing precision. It is particularly effective for researchers needing to estimate transcript abundance or detect splicing events with high accuracy, as demonstrated by its performance in the SMC-RNA DREAM challenges.

## Installation and Setup
Hera is most easily managed via the Bioconda channel:
```bash
conda config --add channels bioconda
conda install hera
```

## Core Workflows

### 1. Building an Index
Before quantification, you must create an index from your reference genome and annotation files.

*   **Transcriptome Index (Standard):** Requires ~8GB RAM.
    ```bash
    hera_build --fasta genome_sequence.fa --gtf annotation_file.gtf --outdir hera_index/
    ```
*   **Full Genome Index:** Required for genome mapping and fusion detection. Requires ~30GB RAM.
    ```bash
    hera_build --fasta genome.fa --gtf annotation.gtf --outdir hera_index/ --full_index 1
    ```
*   **GRCh38 Specifics:** If using the GRCh38 human genome with ALT contigs, explicitly enable the flag:
    ```bash
    hera_build --fasta GRCh38.fa --gtf GRCh38.gtf --outdir hera_index/ --grch38 1
    ```

### 2. Transcript Quantification (`hera quant`)
The quantification step estimates transcript abundance and can optionally produce alignment files.

*   **Standard Paired-End Run:**
    ```bash
    hera quant -i hera_index/ -1 read_1.fq.gz -2 read_2.fq.gz -t 32 -o hera_output/
    ```
*   **Paired-End with BAM Output and Bootstrapping:**
    Use `-w` to generate a BAM file and `-b` for bootstrap samples (useful for downstream differential expression tools like Sleuth).
    ```bash
    hera quant -i hera_index/ -w -b 100 -t 32 -1 R1.fq.gz -2 R2.fq.gz -o hera_output/
    ```
*   **Single-End with Multiple Lanes:**
    Separate multiple files for the same end with spaces.
    ```bash
    hera quant -i hera_index/ -t 16 -1 lane1_R1.fq lane2_R1.fq -o hera_output/
    ```

## Expert Tips and Best Practices

*   **Memory Management:** Always ensure the host machine has at least 32GB of RAM if you are performing full genome indexing or mapping. Transcriptome-only mapping is significantly lighter (~8GB).
*   **Genome Mapping Fallback:** By default, Hera maps to the transcriptome. To enable remapping of unaligned reads to the genome (improving splicing detection), provide the genome fasta file with the `-f` argument during quantification:
    ```bash
    hera quant -i hera_index/ -f genome.fa -1 R1.fq -2 R2.fq -o output/
    ```
*   **Output Interpretation:**
    *   `abundance.tsv`: Contains the primary transcript abundance estimations.
    *   `abundance.h5`: HDF5 format containing abundance and bootstrap results.
    *   `transcript.bam`: The base-to-base alignment result (only if `-w` is used).
*   **Thread Optimization:** Hera scales well with threads. For 60 million read pairs, using 32 cores is recommended to achieve optimal processing speeds.

## Reference documentation
- [Hera GitHub Repository](./references/github_com_bioturing_hera.md)
- [Hera Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hera_overview.md)