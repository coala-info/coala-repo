---
name: mashmap
description: MashMap is a fast and memory-efficient tool for genomic sequence comparison that estimates sequence identity using a k-mer based winnowing scheme. Use when user asks to map long noisy reads to a reference, compare whole genome assemblies, identify orthologous regions, or compute average nucleotide identity.
homepage: https://github.com/marbl/MashMap
metadata:
  docker_image: "quay.io/biocontainers/mashmap:3.1.3--pl5321hb4818e0_2"
---

# mashmap

## Overview

MashMap is a specialized tool for genomic sequence comparison that prioritizes speed and memory efficiency. Instead of computing exact base-to-base alignments (CIGAR strings), it uses a k-mer based winnowing scheme (minmers) and MinHash to estimate Jaccard similarity, which is then converted to a sequence identity estimate. It is particularly effective for mapping long, noisy reads or comparing whole genome assemblies to identify orthologous regions and compute Average Nucleotide Identity (ANI).

## Common CLI Patterns

### Basic Mapping
Map a query file (reads or assembly) against a reference genome:
```bash
mashmap -r reference.fna -q query.fa
```

### Mapping Against Multiple References
If you have many reference genomes, provide a text file containing the paths to each reference (one per line):
```bash
mashmap --rl referenceList.txt -q query.fa
```

### Adjusting Identity and Sensitivity
*   **For high-identity assembly mapping (e.g., Human vs. Human):**
    ```bash
    mashmap -r ref.fa -q query.fa --pi 95 -s 10000
    ```
*   **For noisy long reads (PacBio/ONT):**
    ```bash
    mashmap -r ref.fa -q query.fa --pi 80
    ```

### Filtering Modes
Use the `-f` or `--filter_mode` flag to optimize output for your specific use case:
*   **`map`**: Best for reporting the top mappings for long reads.
*   **`one-to-one`**: Best for reporting orthologous mappings between two assemblies.

## Expert Tips and Best Practices

*   **Output Format**: As of version 3, the default output is PAF (Pairwise Mapping Format). The `id` tag in the PAF output represents the predicted ANI. To use the older MashMap2 space-delimited format, add the `--legacy` flag.
*   **Segment Length Guarantee**: MashMap provides a guarantee of reporting local alignments that are at least twice the length of the specified segment length (`-s` / `--segLength`). The default is 5,000 bp.
*   **Accuracy vs. Performance**: If you require more precise ANI estimates and can afford higher RAM usage and longer runtimes, use the `--dense` flag. This significantly increases the k-mer sampling rate.
*   **Memory Efficiency**: MashMap is highly optimized. For example, mapping a human genome assembly to a reference typically requires less than 4 GB of RAM.
*   **Visualization**: MashMap results can be visualized as dot-plots using the provided Perl script in the repository (requires `gnuplot`).

## Reference documentation
- [MashMap GitHub Repository](./references/github_com_marbl_MashMap.md)
- [MashMap Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mashmap_overview.md)