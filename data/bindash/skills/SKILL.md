---
name: bindash
description: BinDash is a high-performance utility that rapidly estimates genomic distances and Average Nucleotide Identity (ANI) using a specialized MinHash scheme. Use when user asks to sketch genomic sequences, estimate distances between genomes, or calculate Jaccard indices and ANI values.
homepage: https://github.com/zhaoxiaofei/bindash
metadata:
  docker_image: "quay.io/biocontainers/bindash:2.6--h077b44d_0"
---

# bindash

## Overview

BinDash (Binwise Densified MinHash) is a high-performance command-line utility designed for the rapid estimation of genomic distances. It utilizes a specialized MinHash scheme (b-bit one-permutation rolling MinHash with densification) to reduce massive genomic datasets into compact "sketches." These sketches allow for near-instantaneous comparison of sequences to calculate Jaccard indices, which are then converted into ANI values. It is significantly more memory-efficient and faster than traditional alignment-based methods, making it suitable for large-scale environmental genomics and pangenome analysis on typical personal computers.

## Core Workflows

### 1. Sketching Sequences
Before comparing genomes, you must convert the raw sequence data into a sketch file. BinDash supports FASTA and FASTQ formats, including gzipped files.

```bash
# Sketch a single genome
bindash sketch --outfname=genome_A.sketch input_A.fasta

# Sketch a gzipped metagenome
bindash sketch --outfname=sample_B.sketch sample_B.fastq.gz
```

### 2. Estimating Distances
Once sketches are created, use the `dist` command to compare them. The output typically includes the Jaccard index and the estimated ANI.

```bash
# Compare two sketch files
bindash dist genome_A.sketch sample_B.sketch
```

### 3. Model Selection
BinDash allows you to choose the underlying statistical model used to convert the Jaccard index into ANI.

*   **Poisson Model**: Generally used for most mutation rate estimations.
*   **Binomial Model**: An alternative statistical approach for specific genomic contexts.

```bash
# Specify the model during distance calculation
bindash dist --model=poisson genome_A.sketch genome_B.sketch
bindash dist --model=binomial genome_A.sketch genome_B.sketch
```

## Expert Tips and Best Practices

*   **Input Flexibility**: You do not need to decompress `.gz` files before sketching; BinDash handles zlib compression natively, saving disk space and I/O time.
*   **Scaling to Terabytes**: For massive datasets, sketch all genomes individually first. The resulting `.sketch` files are orders of magnitude smaller than the raw data, making the subsequent `dist` operations extremely fast.
*   **ANI Equations**:
    *   Poisson: $ANI = 1 + \frac{1}{k} \log \frac{2J}{1+J}$
    *   Binomial: $ANI = (\frac{2J}{1+J})^{\frac{1}{k}}$
    *   Where $J$ is the Jaccard index and $k$ is the k-mer size.
*   **Hardware Optimization**: BinDash is optimized for C++11 and utilizes OpenMP for parallel processing. Ensure your environment supports multi-threading to take full advantage of its speed.



## Subcommands

| Command | Description |
|---------|-------------|
| bindash | B-bit One-Permutation Rolling MinHash with Optimal/Faster Densification for Genome Search and Comparisons. Or Binwise Densified MinHash. |
| bindash | B-bit One-Permutation Rolling MinHash with Optimal/Faster Densification for Genome Search and Comparisons. Or Binwise Densified MinHash. |
| bindash | B-bit One-Permutation Rolling MinHash with Optimal/Faster Densification for Genome Search and Comparisons. Or Binwise Densified MinHash. |
| bindash | B-bit One-Permutation Rolling MinHash with Optimal/Faster Densification for Genome Search and Comparisons. Or Binwise Densified MinHash. |
| bindash | B-bit One-Permutation Rolling MinHash with Optimal/Faster Densification for Genome Search and Comparisons. Or Binwise Densified MinHash. |

## Reference documentation
- [BinDash README](./references/github_com_zhaoxiaofei_bindash_blob_master_README.md)
- [Installation and Build Guide](./references/github_com_zhaoxiaofei_bindash.md)