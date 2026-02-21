---
name: rattle
description: RATTLE (Reference-free reconstruction and quantification of transcriptomes from long-read sequencing) is a specialized toolset for de novo transcriptome analysis.
homepage: https://github.com/comprna/RATTLE
---

# rattle

## Overview
RATTLE (Reference-free reconstruction and quantification of transcriptomes from long-read sequencing) is a specialized toolset for de novo transcriptome analysis. It enables researchers to group raw Nanopore reads into gene and isoform clusters, perform error correction, and generate high-quality consensus sequences. It is particularly effective for non-model organisms, allowing for the identification of transcripts and quantification of expression levels without the bias of a reference genome.

## Core Workflow

The standard RATTLE pipeline follows a sequential process: Clustering -> Error Correction -> Polishing.

### 1. Clustering
The initial step groups reads based on sequence similarity.

*   **Gene-level clustering (cDNA):**
    `./rattle cluster -i reads.fq -t 24 -o output_folder`
*   **Isoform-level clustering (cDNA):**
    `./rattle cluster -i reads.fq -t 24 --iso`
*   **Direct RNA clustering:**
    `./rattle cluster -i reads.fq -t 24 --iso --rna`

### 2. Cluster Management and Extraction
After clustering, you can inspect the results or extract specific sequences.

*   **Generate summary:**
    `./rattle cluster_summary -i reads.fq -c clusters.out`
*   **Extract clusters to FASTQ:**
    `./rattle extract_clusters -i reads.fq -c transcripts.out -o clusters_dir --fastq`

### 3. Error Correction
Corrects individual reads using the information from the clusters.

*   `./rattle correct -i reads.fq -c clusters.out -t 24`

### 4. Polishing
Generates the final consensus transcriptome.

*   `./rattle polish -i consensi.fq -t 24 --rna`

## Expert Tips and Parameters

### Data Filtering
RATTLE applies default length filters to improve assembly quality.
*   `--lower-length`: Defaults to 150nt. Increase this to focus on full-length transcripts or decrease it for small non-coding RNA studies.
*   `--upper-length`: Defaults to 100,000nt. Reads exceeding this are often experimental artifacts and are filtered out by default.
*   `--raw`: Use this flag to disable all length filtering.

### Multi-Sample Analysis
RATTLE can process multiple input files simultaneously while maintaining sample identity through labels.
*   Example: `./rattle cluster -i sample1.fq,sample2.fq -l label1,label2 -t 24`

### Tuning Sensitivity
*   **K-mer Size (`-k` / `--iso-kmer-size`):** Default is 10 for genes and 11 for isoforms. Maximum value is 16. Smaller k-mers increase sensitivity but may increase computational cost and false positives.
*   **Score Threshold (`-s`):** Minimum similarity score (0.0 to 1.0) for reads to be clustered. Increase this value to produce more specific, tighter clusters.
*   **Bitvector Thresholds (`-B`, `-b`):** Controls the initial fast k-mer comparison. `-B` is the starting threshold (default 0.4).

### Direct RNA vs cDNA
Always use the `--rna` flag when processing direct RNA sequencing data. This disables double-strand checking, as direct RNA is inherently single-stranded and directional.

## Reference documentation
- [RATTLE GitHub Repository](./references/github_com_comprna_RATTLE.md)
- [Bioconda RATTLE Overview](./references/anaconda_org_channels_bioconda_packages_rattle_overview.md)