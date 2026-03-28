---
name: hulk
description: "HULK creates compact histosketched representations of metagenomic data streams for rapid k-mer frequency analysis. Use when user asks to sketch sequencing reads, calculate pairwise distances between metagenomic datasets, or generate similarity matrices for microbiome samples."
homepage: https://github.com/will-rowe/hulk
---

# hulk

## Overview

HULK (Histosketching Using Little Kmers) is a bioinformatics tool designed for the rapid analysis of metagenomic data streams. It bypasses the need for large, memory-intensive k-mer tables by using a "histosketched" representation of the k-mer spectrum. By collecting minimizers and assigning them to histogram bins via a consistent jump hash, HULK creates small, fixed-size sketches that incorporate k-mer frequency information. These sketches are ideal for calculating pairwise distances between massive datasets on standard hardware, such as a laptop, and can be used as input for microbiome sample origin classifiers.

## Core Workflows

### 1. Sketching Sequences
The `sketch` command processes FASTQ data (often via a stream) to create a HULK sketch.

*   **Basic Sketching**:
    ```bash
    # Sketch a gzipped FASTQ file
    gunzip -c sample.fq.gz | hulk sketch -o sketches/sample_output
    ```
*   **Key Parameters**:
    *   `-p`: Number of threads to use.
    *   `-k`: K-mer size (default is usually 21 or 31).
    *   `-o`: Output prefix for the resulting JSON sketch.

### 2. Metagenomic Dissimilarity (Smashing)
The `smash` command compares multiple sketches to generate a similarity matrix.

*   **Generate Similarity Matrix**:
    ```bash
    # Compare all sketches in a directory using weighted Jaccard similarity
    hulk smash -d ./sketches -m weightedjaccard -o similarity_matrix.csv
    ```
*   **Key Parameters**:
    *   `-d`: Directory containing `.json` sketches created by `hulk sketch`.
    *   `-m`: Similarity metric (e.g., `weightedjaccard`).
    *   `-k`: Ensure the k-mer size matches the size used during sketching.

## Expert Tips and Best Practices

*   **Streaming Efficiency**: HULK is designed for streaming. You can pipe data directly from sequencing tools or pre-processors into `hulk sketch` to avoid writing large intermediate FASTQ files to disk.
*   **Sketch Portability**: HULK sketches (version 1.0.0+) are saved as JSON files. This makes them highly portable and easy to inspect or use with external Python/R scripts for downstream statistical analysis.
*   **K-mer Size Consistency**: Always ensure that the `-k` value used in `hulk smash` matches the `-k` value used when the sketches were originally created.
*   **Machine Learning Integration**: The fixed-size nature of HULK sketches makes them excellent features for Machine Learning. Use the sketches as input vectors for tools like BANNER to predict sample metadata or origins.
*   **Minimizer Frequencies**: Note that HULK >= 1.0.0 uses minimizer frequencies rather than raw k-mer counts, which significantly improves performance and reduces memory overhead while maintaining accuracy for dissimilarity analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| hulk sketch | Create a sketch from a set of reads. The sketch subcommand can be used to create a histosketch, minhash or count min sketch. |
| hulk smash | Smash a bunch of sketches and return a distance matrix. This subcommand performs pairwise comparisons of sketches and then writes a distance matrix. |

## Reference documentation
- [github_com_will-rowe_hulk_blob_master_README.md](./references/github_com_will-rowe_hulk_blob_master_README.md)
- [github_com_will-rowe_hulk.md](./references/github_com_will-rowe_hulk.md)