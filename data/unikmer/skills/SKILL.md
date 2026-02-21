---
name: unikmer
description: `unikmer` is a high-performance toolkit designed for k-mer analysis with a focus on taxonomic integration.
homepage: https://github.com/shenwei356/unikmer
---

# unikmer

## Overview

`unikmer` is a high-performance toolkit designed for k-mer analysis with a focus on taxonomic integration. Unlike tools that only track counts, `unikmer` allows for the association of TaxIds with k-mers, enabling the calculation of the Lowest Common Ancestor (LCA) during set operations. It uses a compact binary format (`.unik`) and supports various sketching methods like Minimizers and MinHash. Use this skill to manipulate k-mer sets, perform taxonomic filtering, and locate k-mer sequences within reference genomes.

## Core CLI Patterns

### 1. K-mer Counting and Sketching
The `count` command is the entry point for generating `.unik` files from FASTA/Q sequences.

*   **Standard counting**: Generate canonical k-mers (k=23) with compact output.
    `unikmer count -k 23 input.fasta.gz -o output.k23 --canonical --compact`
*   **Taxonomic counting**: Assign a specific TaxId to all k-mers in a genome.
    `unikmer count -k 23 input.fasta.gz -o output.k23 -t 511145`
*   **Minimizer sketching**: Generate minimizers (k=23, window=5) in linear order.
    `unikmer count -k 23 -W 5 -l input.fasta.gz -o output.m`

### 2. Set Operations
`unikmer` excels at comparing multiple k-mer sets while maintaining taxonomic LCA information.

*   **Intersection**: Find k-mers present in all provided files.
    `unikmer inter file1.unik file2.unik file3.unik -o intersection`
*   **Union**: Combine k-mers from multiple files (computes LCA for TaxIds).
    `unikmer union *.unik -o combined`
*   **Difference**: Find k-mers in the first file that are not in the others.
    `unikmer diff query.unik reference1.unik reference2.unik -o unique_to_query`

### 3. Inspection and Conversion
*   **Quick stats**: View k-mer counts and metadata for binary files.
    `unikmer info *.unik -a`
*   **Plain text export**: Convert binary `.unik` to readable k-mer sequences.
    `unikmer view file.unik --show-taxid`
*   **Search**: Find specific k-mer sequences within a binary file.
    `unikmer grep -f patterns.txt input.unik`

### 4. Genomic Mapping
*   **Locate**: Find the exact coordinates of k-mers from a `.unik` file in a genome.
    `unikmer locate -g genome.fasta input.unik`
*   **Map**: Extract successive regions/subsequences by mapping k-mers back to a genome.
    `unikmer map -g genome.fasta input.unik`

## Expert Tips and Best Practices

*   **Canonical K-mers**: Always use the `--canonical` flag during `count` unless strand-specific analysis is required. This ensures that a k-mer and its reverse complement are treated as the same entity.
*   **Storage Optimization**: Use the `--sort` flag during counting to significantly reduce file size and accelerate downstream set operations like `inter` or `union`.
*   **Taxonomic Filtering**: Use `rfilter` to filter k-mers based on their taxonomic rank (e.g., keeping only k-mers at or below the 'species' level).
*   **Memory Management**: For extremely large datasets, use `split` to create sorted chunks and `merge` to combine them, which is more memory-efficient than processing everything at once.
*   **Hashed K-mers**: For k > 32, `unikmer` uses ntHash. Note that `view` commands for hashed k-mers require the original FASTA/Q file via the `--genome` flag to reconstruct the sequences.

## Reference documentation

- [unikmer Main Documentation](./references/github_com_shenwei356_unikmer.md)
- [unikmer Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_unikmer_overview.md)