---
name: dashing2
description: Dashing2 is a high-performance toolkit designed for the rapid analysis of genomic sequences through sketching.
homepage: https://github.com/dnbaker/dashing2
---

# dashing2

## Overview
Dashing2 is a high-performance toolkit designed for the rapid analysis of genomic sequences through sketching. It serves as the successor to the original Dashing system, providing faster and more accurate distance estimations. By converting large sequence datasets into compact "sketches," it allows for the comparison of thousands of genomes or protein sets in near-linear time. The tool is particularly useful for building k-nearest neighbor graphs, performing all-pairs comparisons, and handling weighted datasets using advanced algorithms like BagMinHash and ProbMinHash.

## Core CLI Patterns

### Sequence Comparison
The primary command is `dashing2 cmp`. By default, it performs an all-pairs symmetric comparison.

*   **Basic DNA Comparison**:
    `dashing2 cmp input1.fasta input2.fasta input3.fastq.gz`
*   **Protein Sequences**: Use the `--protein` flag to enable 20-character alphabet support.
    `dashing2 cmp --protein proteins.faa`
*   **Rectangular Comparison**: Compare a query set against a reference set.
    `dashing2 cmp -Q queries.txt -F references.txt`

### Sketching Algorithms
Choose the algorithm based on the nature of your data:
*   **SetSketch (Default)**: Best for simple presence/absence of k-mers.
*   **BagMinHash (`--bagminhash` or `--multiset`)**: Best for genome assemblies where k-mer counts (weights) matter.
*   **ProbMinHash (`--prob`)**: Best for splicing and expression datasets where discrete probability distributions are compared.
*   **Exact Comparison**: Use `--set` or `--countdict` for exact results instead of sketches (slower but deterministic).

### Large-Scale Indexing and LSH
To avoid the $O(N^2)$ cost of all-pairs comparisons on massive datasets, use Locality Sensitive Hashing (LSH):
*   **Similarity Threshold**: Only output pairs above a certain Jaccard similarity.
    `dashing2 cmp --similarity-threshold 0.8 inputs/*.fna`
*   **K-Nearest Neighbors**: Find the top $k$ matches for each item.
    `dashing2 cmp --topk 10 inputs/*.fna`
*   **Refine Results**: Use `--refine-exact` to generate candidates via fast LSH but compute final distances using full hash values for accuracy.

## Expert Tips and Best Practices

### Performance Optimization
*   **Binary Output**: For large matrices, use `--binary-output`. This emits results in flat, row-major float32 format, avoiding the overhead of formatting human-readable text.
*   **Parallelization**: Dashing2 is highly threaded. Ensure your environment allows for multi-core execution to take advantage of its speed.
*   **K-mer Length**: For $k \le 64$, DNA uses exact encoding. For $k > 64$, use `--long-kmers` to trigger rolling hash support.

### Advanced Input Handling
*   **Genomic Intervals**: Dashing2 can sketch BED and BigWig files.
    *   Use `--bigwig` for weighted interval sets.
    *   Use `--bed` for base/contig pairs.
    *   Use `--normalize-intervals` if you want every interval in a BED file to carry equal weight regardless of length.
*   **Spaced Seeds**: Improve sensitivity for divergent sequences using `--spacing <N>`, which ignores $N$ characters between used characters in a k-mer.
*   **Winnowing**: Set `--window-size` larger than $k$ to use minimizers, significantly reducing sketch size and processing time for long sequences.

### Output Formats
*   **Symmetric All-Pairs**: Default output is PHYLIP format.
*   **Asymmetric/Rectangular**: Output is a flat TSV.
*   **Thresholded Results**: Emitted in CSR (Compressed Sparse Row) format or a TSV with varying items per line.

## Reference documentation
- [Dashing2 GitHub README](./references/github_com_dnbaker_dashing2.md)
- [Dashing2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dashing2_overview.md)