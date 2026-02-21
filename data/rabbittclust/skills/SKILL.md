---
name: rabbittclust
description: RabbitTClust is a specialized toolkit designed for the rapid clustering of massive bacterial genome collections.
homepage: https://github.com/RabbitBio/RabbitTClust
---

# rabbittclust

## Overview

RabbitTClust is a specialized toolkit designed for the rapid clustering of massive bacterial genome collections. By utilizing dimensionality reduction techniques like MinHash sketches and KSSD, it bypasses the computational bottleneck of all-against-all alignments. It is particularly effective for researchers working with hundreds of thousands to millions of genomes who require fast distance estimations and flexible clustering logic, including hierarchical, greedy, and graph-based approaches.

## Installation and Environment

Install RabbitTClust via Bioconda for the most stable environment:

```bash
conda install bioconda::rabbittclust
```

Note: The tool requires a 64-bit Linux system with support for at least AVX2 instructions for optimal performance.

## Core Clustering Modules

Select the appropriate module based on your analytical goals:

### 1. Hierarchical Clustering (clust-mst)
Use this for traditional single-linkage hierarchical clustering. It is the best choice when you need to visualize relationships via a tree structure.

*   **Basic usage**: `./clust-mst -l -i genome_list.txt -o output_prefix`
*   **Generate a tree**: Add `--newick-tree` to produce a Newick format file for downstream visualization.
*   **High-speed mode**: Use `--fast` to enable the KSSD algorithm for sketching and distance computation.
*   **Representative selection**: Use `--reps-per-cluster [INT]` to automatically pick representative genomes from each cluster.

### 2. Greedy Incremental Clustering (clust-greedy)
Use this for the fastest possible clustering or when you need to add new genomes to an existing clustered dataset without recomputing everything.

*   **Basic usage**: `./clust-greedy -l -i genome_list.txt -o output_prefix`
*   **Incremental update**: Use `--append [PRE-GENERATED_SKETCHES]` to add new sequences to an existing project.
*   **Memory optimization**: Use `--save-rep` to maintain an inverted index of representatives, which speeds up incremental runs.

### 3. Graph-based Clustering (clust-leiden)
Use this for community detection in genomic networks. It requires the `igraph` library.

*   **Basic usage**: `./clust-leiden --fast -l -i genome_list.txt -o output_prefix`
*   **Adjust granularity**: Use `--resolution [FLOAT]` (higher values result in more, smaller clusters).
*   **Algorithm choice**: While Leiden is the default, you can switch to Louvain using the `--louvain` flag.

## Common CLI Patterns and Parameters

*   **Input Handling**: 
    *   For a single FASTA: `-i genome.fasta`
    *   For multiple files: Create a text file with one path per line and use `-l -i list.txt`.
*   **Distance Thresholds**: Set the clustering stringency with `-d [FLOAT]`. For example, a distance of 0.05 roughly corresponds to 95% Average Nucleotide Identity (ANI).
*   **Sketch Tuning**: 
    *   Increase `-s [INT]` (default 1000) for higher sensitivity in distance estimation at the cost of speed and memory.
    *   Use `-k [INT]` to adjust k-mer size based on the taxonomic level of your organisms.
*   **Resource Management**: Always specify threads with `-t` to match your hardware capabilities, as RabbitTClust is highly parallelized.

## Expert Tips

*   **Intermediate Files**: By default, the tool saves sketches and intermediate files. If disk space is a concern and you do not plan to run incremental updates, use the `-e` or `--no-save` flag.
*   **Filtering**: Use `-m [UINT]` to set a minimum genome length (default 10,000). This prevents short, poor-quality assemblies or contaminants from skewing the clustering results.
*   **Containment Distance**: For datasets with significant size variation (e.g., comparing genomes to much smaller plasmids or fragments), use the `-c` flag to enable AAF distance with containment coefficients.
*   **Pre-computed Inputs**: If you have already generated sketches or MST files in a previous run, use `--presketched` or `--premsted` to skip the most computationally expensive steps.

## Reference documentation
- [RabbitTClust GitHub Repository](./references/github_com_RabbitBio_RabbitTClust.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_rabbittclust_overview.md)