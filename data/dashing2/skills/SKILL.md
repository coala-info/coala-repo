---
name: dashing2
description: Dashing2 utilizes advanced sketching algorithms to rapidly estimate evolutionary distances and similarities between massive genomic datasets. Use when user asks to compare biological sequences, estimate genomic distances, find similar sequence pairs using locality sensitive hashing, or sketch genomic intervals.
homepage: https://github.com/dnbaker/dashing2
---


# dashing2

## Overview

Dashing2 is a specialized tool for biological sequence analysis that utilizes advanced sketching algorithms—such as SetSketch, BagMinHash, and ProbMinHash—to transform massive genomic datasets into compact, searchable representations. By working with these "sketches" rather than raw sequences, it enables rapid estimation of evolutionary distances and similarities. It supports diverse data types including nucleotides, proteins with reduced alphabets, and weighted interval sets, making it a versatile choice for clustering, indexing, and large-scale comparative analysis.

## Common CLI Patterns

### Sequence Comparison
Perform an all-pairs symmetric comparison of DNA sequences:
`dashing2 cmp *.fasta`

For protein sequences, enable the protein alphabet:
`dashing2 cmp --protein *.faa`

### Weighted and Multiset Sketching
Use BagMinHash for weighted sets (useful for genome assemblies where k-mer counts matter):
`dashing2 cmp --multiset *.fastq`

Use ProbMinHash for discrete probability distributions (ideal for normalized splicing or expression data):
`dashing2 cmp --prob *.fastq`

### Efficient Neighbor Discovery
Instead of an $O(N^2)$ all-pairs matrix, use Locality Sensitive Hashing (LSH) to find only the most similar pairs:
`dashing2 cmp --similarity-threshold 0.8 *.fasta`
`dashing2 cmp --topk 10 *.fasta`

### Working with Genomic Intervals
Sketch BED files as sets of reference base/contig pairs:
`dashing2 cmp --bed regions.bed`

To treat every interval as having equal weight regardless of length:
`dashing2 cmp --bed --normalize-intervals regions.bed`

## Expert Tips and Best Practices

*   **Refine for Accuracy**: Use `--refine-exact` in combination with `--set` or `--countdict`. This uses fast sketches to find candidate pairs via LSH but computes the final distance using full hash values for exact results.
*   **Handle Large Matrices**: For large-scale comparisons, always use `--binary-output`. This emits matrices in flat, row-major float32 format, significantly reducing I/O overhead and parsing time compared to human-readable TSV/PHYLIP formats.
*   **K-mer Configuration**:
    *   For $k \le 64$, DNA/RNA uses exact encoding.
    *   For $k > 64$, Dashing2 automatically switches to a rolling hash.
    *   Use `--spacing` to implement spaced seeds, which can improve sensitivity for distant homologs.
*   **Minimizer Transduction**: Enable `--seq` to emit a sequence of minimizer values as a string. This is useful for downstream analysis where you want to compare the "compressed" version of the sequence directly.
*   **Memory Management**: If you need to approximate weighted set comparisons without the memory overhead of exact counting, use `--countsketch-size [size]` to enable CountSketch-based approximation.



## Subcommands

| Command | Description |
|---------|-------------|
| cmp | Performs comparisons across inputs, but sketches if necessary. |
| dashing2 contain | This application is inspired by mash screen. |
| printmin | Prints the minimum sketch size for a given k-mer size and sketch size. |
| sketch | Sketch only generates sketches, while cmp performs comparisons across inputs, but sketches if necessary. |
| wsketch | Sketch raw IDs, with optional weights added |

## Reference documentation
- [Dashing2 GitHub README](./references/github_com_dnbaker_dashing2_blob_main_README.md)
- [Dashing2 Python Parsing Utilities](./references/github_com_dnbaker_dashing2_blob_main_python_parse.py.md)