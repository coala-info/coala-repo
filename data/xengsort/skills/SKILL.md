---
name: xengsort
description: xengsort classifies sequencing reads from xenograft samples into host, graft, both, neither, or ambiguous categories. Use when user asks to build a hash index, classify sequencing reads, or inspect a hash index.
homepage: https://gitlab.com/genomeinformatics/xengsort
metadata:
  docker_image: "quay.io/biocontainers/xengsort:2.1.0--pyhdfd78af_1"
---

# xengsort

## Overview

xengsort is a high-performance tool designed to classify sequencing reads from xenograft samples by assigning them to host, graft, both, neither, or ambiguous categories. It utilizes space-efficient k-mer hashing and JIT-compiled Python (via Numba) to achieve high speeds. Since version 2.1.0, it explicitly supports bisulfite-treated data (WGBS) alongside standard genomic and transcriptomic libraries.

## Installation and Setup

Install xengsort via Bioconda:

```bash
conda install bioconda::xengsort
```

## Core Workflow

### 1. Index Construction
Before classifying reads, you must build a hash index from the reference genomes of both the host (e.g., mouse) and the graft (e.g., human).

*   **Standard Genomic Data:** Use the default k-mer size ($k=25$).
*   **Bisulfite (WGBS) Data:** Use a larger k-mer size ($k=29$) for better specificity.
*   **Constraint:** The k-mer size ($k$) must be an odd integer $\le 31$.

### 2. Read Classification
Classify single-end or paired-end FASTQ files against the generated index.

*   **Input:** Supports compressed files (`.gz`, `.bz2`, `.xz`) natively.
*   **Memory:** Version 2.0+ uses the index as shared memory, allowing multiple classification processes to access the same index efficiently.
*   **Method:** The default classification is based on covered base pairs.

### 3. Index Inspection
Use the `info` subcommand to retrieve metadata or data from an existing hash index:

```bash
xengsort info <index_file>
```

## Expert Tips and Best Practices

*   **Long Read Guidance (ONT/PacBio):** While optimized for short reads, xengsort can be used for long reads. For Oxford Nanopore (ONT), stick to $k=25$. Although larger $k$ increases uniqueness, the higher error rate of long reads necessitates the shorter $k$ for better error tolerance.
*   **Bisulfite Sequencing:** When working with WGBS, always ensure you are using version 2.1.0 or later, as these versions include specific logic for handling the reduced alphabet of bisulfite-converted DNA.
*   **Gapped K-mers:** For advanced users seeking better error tolerance without sacrificing specificity, xengsort supports gapped k-mers via the `--mask` parameter instead of a fixed `--kmersize`.
*   **Performance:** If classification is slow, ensure your environment supports Numba's JIT compilation. xengsort is designed to be "embarrassingly parallel" during the classification phase.

## Reference documentation
- [xengsort Overview](./references/anaconda_org_channels_bioconda_packages_xengsort_overview.md)
- [xengsort README](./references/gitlab_com_genomeinformatics_xengsort_-_blob_master_README.md)
- [xengsort Releases](./references/gitlab_com_genomeinformatics_xengsort_-_releases.md)