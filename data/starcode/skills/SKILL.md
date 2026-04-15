---
name: starcode
description: Starcode is a high-performance DNA sequence clustering tool that groups similar sequences within a defined Levenshtein distance to correct sequencing errors. Use when user asks to cluster DNA barcodes or UMIs, recover original sequences from high-throughput data, or perform all-pairs search clustering using message passing, spheres, or connected components algorithms.
homepage: https://github.com/gui11aume/starcode
metadata:
  docker_image: "quay.io/biocontainers/starcode:1.4--h7b50bb2_6"
---

# starcode

## Overview
Starcode is a high-performance DNA sequence clustering tool designed to handle sequencing errors by grouping similar sequences within a defined Levenshtein distance. Unlike tools that rely on heuristics, starcode performs an all-pairs search to ensure accuracy. It is particularly effective for recovering original barcodes or UMIs from high-throughput sequencing data. It supports multiple clustering strategies, including Message Passing (default), Spheres, and Connected Components.

## CLI Usage and Patterns

### Basic Clustering
The most common use case is clustering a single file of sequences.
```bash
starcode -i sequences.txt -o clusters.txt
```

### Adjusting Clustering Sensitivity
*   **Distance (-d):** Defines the maximum Levenshtein distance (insertions, deletions, substitutions). If not set, it is auto-computed as `min(8, 2 + [median seq length]/30)`.
    ```bash
    starcode -d 2 -i input.txt
    ```
*   **Cluster Ratio (-r):** In Message Passing mode, a cluster absorbs a smaller one only if it is at least `ratio` times bigger. Default is 5.0. For sparse datasets where counts are low, reduce this to 1.0 to trigger more merging.
    ```bash
    starcode -r 1.2 -i input.txt
    ```

### Clustering Algorithms
*   **Message Passing (Default):** Bottom-up recursive merging. Sequences in a cluster may not all be within the specified distance of the centroid.
*   **Spheres (-s):** Greedy clustering. Centroids (sorted by size) absorb all neighbors within the distance. Use this if you require all members to be within distance `d` of the representative sequence.
*   **Connected Components (-c):** Groups all sequences that are connected by a path of distance `d`.

### Paired-End Processing
Starcode can process paired-end FASTQ files directly.
```bash
starcode -1 read_R1.fastq -2 read_R2.fastq -o paired_clusters.txt
```

### UMI Clustering
For UMI-tagged sequences, use the `starcode-umi` script. It performs a double round of clustering (UMI region then sequence region).
```bash
starcode-umi --umi-len 12 --starcode-path /usr/local/bin/starcode input.txt
```

## Expert Tips and Best Practices
*   **Memory Management:** Starcode is memory-intensive for very large datasets with high diversity. If you encounter memory issues, ensure you are using the latest version (1.4+) which includes trie memory enhancements.
*   **Thread Optimization:** Use `-t` to specify parallel threads. Starcode scales well with multiple cores.
    ```bash
    starcode -t 8 -i input.txt
    ```
*   **Output Detail:** By default, starcode only returns the centroid and the total count. Use `--print-clusters` to see every sequence assigned to a cluster, or `--seq-id` to get the 1-based input line numbers for downstream mapping.
*   **Non-Redundant Output:** Use `--non-redundant` to simplify results if you only care about the canonical sequences and not the constituent members.
*   **Input Format:** While starcode accepts FASTQ, it is often faster to provide a simple text file with one sequence per line if you have already pre-processed your data.

## Reference documentation
- [github_com_gui11aume_starcode.md](./references/github_com_gui11aume_starcode.md)
- [anaconda_org_channels_bioconda_packages_starcode_overview.md](./references/anaconda_org_channels_bioconda_packages_starcode_overview.md)