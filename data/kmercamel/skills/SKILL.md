---
name: kmercamel
description: KmerCamel represents k-mer sets as masked superstrings to reduce their storage footprint and optimize genomic data compression. Use when user asks to compute masked superstrings from FASTA files, optimize masks for indexing, or convert between masked superstring and simplitig formats.
homepage: https://github.com/OndrejSladky/kmercamel/
---


# kmercamel

## Overview
KmerCamel is a specialized tool designed to reduce the storage footprint of k-mer sets by representing them as masked superstrings. Unlike traditional methods that simply list k-mers, KmerCamel uses greedy algorithms to find a single nucleotide sequence (superstring) where the case of the letters (upper/lower) acts as a mask to indicate which k-mers are actually present. This approach is highly effective for genomic data compression and building compact search indices.

## Core Workflows

### Computing Masked Superstrings
The primary command is `compute`. It processes FASTA files to generate a masked-cased superstring.

*   **Standard Compression**:
    `kmercamel compute -k 31 -o output.msfa input.fa`
*   **Memory-Efficient (Streaming)**: Use when RAM is limited (e.g., human genome on machines with <128GB RAM).
    `kmercamel compute -k 31 -a streaming -o output.msfa input.fa`
*   **Filtering by Frequency**: Only include k-mers appearing at least $z$ times.
    `kmercamel compute -k 31 -z 2 -o filtered.msfa input.fa`
*   **Bidirectional vs. Unidirectional**: By default, it treats k-mers and reverse complements as the same. To treat them as distinct:
    `kmercamel compute -k 31 -u -o distinct.msfa input.fa`

### Mask Optimization
After generating a superstring, you can optimize the mask for specific downstream requirements (e.g., maximizing 1s for indexing or minimizing runs for compression).

*   **Maximize 1s (MaxOne)**: Best for k-mer indexing.
    `kmercamel maskopt -t maxone -k 31 -o optimized.msfa input.msfa`
*   **Minimize 1s (MinOne)**: Useful for specific set subtraction tasks.
    `kmercamel maskopt -t minone -k 31 -o optimized.msfa input.msfa`
*   **Minimize Runs (MinRun)**: Best for reducing the complexity of the mask.
    `kmercamel maskopt -t minrun -k 31 -o optimized.msfa input.msfa`

### Format Conversion
KmerCamel acts as a bridge between various k-mer representation formats.

*   **MSFA to rSPSS**: Convert a masked superstring back to a general FASTA format.
    `kmercamel ms2spss -k 31 -o output.rspss input.msfa`
*   **rSPSS to MSFA**: Convert simplitigs or unitigs into a masked superstring.
    `kmercamel spss2ms -k 31 -o output.msfa input.fa`
*   **Split MSFA**: Separate the superstring sequence and the mask into two files.
    `kmercamel ms2mssep -m mask.txt -s superstring.txt input.msfa`

## Expert Tips & Best Practices

*   **Simplitig Speedup**: If your input file already contains simplitigs or eulertigs, add the `-S` flag to significantly accelerate the computation.
*   **Large K-mers**: For $k > 127$, use the Aho-Corasick versions of the algorithms by adding `AC` to the algorithm name (e.g., `-a globalAC`), though note this is significantly slower.
*   **Piping**: Use `-` as a filename to read from stdin or write to stdout for integration into bioinformatics pipelines.
*   **Lower Bound Calculation**: To check how close your compression is to the theoretical limit, use:
    `kmercamel lowerbound -k 31 input.fa`
*   **Storage Optimization**: For maximum disk savings, extract the mask and superstring using `ms2mssep`, then compress the mask with `bzip2 --best` and the superstring with `xz -9` or specialized tools like `GeCo3`.

## Reference documentation
- [KmerCamel GitHub Repository](./references/github_com_OndrejSladky_kmercamel.md)
- [KmerCamel Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kmercamel_overview.md)