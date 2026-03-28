---
name: rattle
description: RATTLE performs reference-free reconstruction and quantification of transcriptomes from Oxford Nanopore long-read sequencing data. Use when user asks to cluster reads into genes or isoforms, perform error correction and polishing on long-reads, or extract transcript sequences from non-model organisms without a reference genome.
homepage: https://github.com/comprna/RATTLE
---

# rattle

## Overview

RATTLE is a specialized tool for processing Oxford Nanopore long-read sequencing data to reconstruct and quantify transcriptomes without the need for a reference genome. It is particularly effective for non-model organisms or complex samples where a high-quality reference is unavailable. The workflow typically involves clustering reads based on k-mer similarity, extracting these clusters, performing error correction via consensus, and a final polishing step to produce high-quality transcript sequences.

## Core Workflow and CLI Patterns

### 1. Clustering Reads
This is the primary step to identify potential genes and isoforms.

*   **Gene-level clustering (cDNA):**
    ```bash
    ./rattle cluster -i reads.fq -t 24 -o output_folder
    ```
*   **Isoform-level clustering (cDNA):**
    ```bash
    ./rattle cluster -i reads.fq -t 24 --iso
    ```
*   **Direct RNA clustering:**
    Always include the `--rna` flag to disable double-strand checking.
    ```bash
    ./rattle cluster -i reads.fq -t 24 --iso --rna
    ```

### 2. Managing Multiple Inputs
RATTLE can process multiple samples simultaneously while maintaining source labels.
```bash
./rattle cluster -i sample1.fq,sample2.fq -l label1,label2 -t 24 --iso
```

### 3. Post-Clustering Analysis
After generating `clusters.out`, use these commands to inspect or prepare data for correction.

*   **Generate a summary CSV (read_id to cluster_id mapping):**
    ```bash
    ./rattle cluster_summary -i reads.fq -c clusters.out > summary.csv
    ```
*   **Extract clusters into individual FASTQ files:**
    ```bash
    mkdir clusters_dir
    ./rattle extract_clusters -i reads.fq -c clusters.out -o clusters_dir --fastq
    ```

### 4. Error Correction and Polishing
Transform noisy long-reads into high-quality consensus sequences.

*   **Correct reads using clusters:**
    ```bash
    ./rattle correct -i reads.fq -c clusters.out -t 24
    ```
*   **Final Polishing (Direct RNA example):**
    ```bash
    ./rattle polish -i consensi.fq -t 24 --rna
    ```

## Expert Tips and Best Practices

*   **Length Filtering:** By default, RATTLE filters out reads shorter than 150nt and longer than 100,000nt. Adjust these using `--lower-length` and `--upper-length` if working with small RNAs or ultra-long transcripts.
*   **Sensitivity Tuning:** 
    *   If you have too many unclustered reads, lower the bitvector end threshold (`-b`) or the score threshold (`-s`).
    *   For isoform clustering, the default score threshold is `0.3`. Increase this if clusters are too "greedy" (mixing distinct isoforms).
*   **Memory and Performance:** Always specify threads (`-t`) to match your hardware. Clustering is the most computationally intensive step.
*   **Direct RNA vs cDNA:** The `--rna` flag is critical for direct RNA-seq because the data is strand-specific; omitting it will cause the tool to check both strands, leading to incorrect clusters and wasted computation.



## Subcommands

| Command | Description |
|---------|-------------|
| rattle_cluster | Rattlesnake clustering tool |
| rattle_cluster_summary | Generates a summary of clustering results from input FASTA/FASTQ and cluster files. |
| rattle_correct | Corrects errors in fasta/fastq files based on cluster information. |
| rattle_extract_clusters | Extracts clusters from a fasta/fastq file based on a clusters file. |
| rattle_polish | RATTLE Polish |

## Reference documentation
- [RATTLE README](./references/github_com_comprna_RATTLE_blob_master_README.md)
- [RATTLE Main Repository](./references/github_com_comprna_RATTLE.md)