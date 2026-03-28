---
name: kmercamel
description: "KmerCamel compresses k-mer sets into masked superstrings to optimize genomic data storage and indexing. Use when user asks to compute masked superstrings, optimize masks for indexing or compression, or convert between masked superstring formats."
homepage: https://github.com/OndrejSladky/kmercamel/
---


# kmercamel

## Overview

KmerCamel is a specialized bioinformatics tool designed to compress k-mer sets into a single "masked superstring." By using a nucleotide alphabet where the character case (upper vs. lower) represents the mask symbols, it provides a unified framework for textual k-mer representations. This approach is significantly more efficient than storing raw k-mers and is particularly useful for genomic data compression and building k-mer indices. It supports both global and local greedy algorithms to balance between superstring compactness and memory usage.

## Common CLI Patterns

### Computing Masked Superstrings
The `compute` subcommand is the primary entry point for generating a masked superstring from FASTA/FASTQ input.

*   **Standard usage (Bidirectional):**
    `kmercamel compute -k 31 -o output.msfa input.fa`
    *Note: By default, k-mers and their reverse complements are treated as identical.*

*   **Unidirectional model:**
    `kmercamel compute -k 31 -u -o output.msfa input.fa`
    *Use `-u` if you need to treat a k-mer and its reverse complement as distinct entities.*

*   **Filtering by frequency:**
    `kmercamel compute -k 31 -z 2 -o output.msfa input.fa`
    *Use `-z` to only represent k-mers appearing at least N times (useful for sequencing error removal).*

*   **Optimizing for Simplitigs/Eulertigs:**
    `kmercamel compute -k 31 -S -o output.msfa simplitigs.fa`
    *The `-S` flag significantly speeds up computation if the input is already a set of maximal simplitigs.*

### Mask Optimization
After computing a superstring, you can optimize its mask for different downstream applications using the `maskopt` subcommand.

*   **Maximize 1s (Best for Indexing):**
    `kmercamel maskopt -t max-one -k 31 -o optimized.msfa input.msfa`

*   **Minimize 1s (Best for specific compression):**
    `kmercamel maskopt -t min-one -k 31 -o optimized.msfa input.msfa`

*   **Minimize Runs (Best for RLE-based storage):**
    `kmercamel maskopt -t min-run -k 31 -o optimized.msfa input.msfa`

### Format Conversions
KmerCamel provides utilities to move between masked superstring formats and separated mask/string files.

*   **Extract Superstring and Mask:**
    `kmercamel ms2mssep -m mask.txt -s superstring.txt input.msfa`

*   **Combine Superstring and Mask:**
    `kmercamel mssep2ms -m mask.txt -s superstring.txt -o output.msfa`

## Expert Tips and Best Practices

*   **Memory Management:** The default "global greedy" algorithm produces the most compact superstrings but consumes significant memory (~115 GB for a human genome). If memory is limited, switch to the "local greedy" or "streaming" algorithms:
    `kmercamel compute -a local -k 31 -o output.msfa input.fa`
*   **Large K-mers:** KmerCamel natively supports $k$ up to 127. For $k$ values larger than this, use the experimental Aho-Corasick versions of the algorithms by appending `AC` to the algorithm name (e.g., `-a globalAC`), though be aware these are slower.
*   **Downstream Compression:** For maximum storage efficiency, extract the superstring and mask using `ms2mssep`. Compress the mask with `bzip2 --best` and the superstring with `xz -9` or specialized genomic compressors like GeCo3 or Jarvis3.
*   **Lower Bound Analysis:** To evaluate how close your representation is to the theoretical minimum length, use the `lowerbound` subcommand:
    `kmercamel lowerbound -k 31 input.fa`



## Subcommands

| Command | Description |
|---------|-------------|
| kmercamel compute | Compute k-mer based superstrings. |
| kmercamel maskopt | Masks a superstring using k-mers. |
| lowerbound | Calculates the lower bound of the number of unique k-mers in a FASTA file. |
| ms2mssep | Converts MS/MS spectra to MS2 format. |
| ms2spss | Converts a masked superstring to a set of k-mers. |
| mssep2ms | Cannot have both superstring and mask redirected from stdin. |
| spss2ms | Converts a FASTA file to a masked superstring format. |

## Reference documentation
- [KmerCamel GitHub Repository](./references/github_com_OndrejSladky_kmercamel.md)
- [KmerCamel README](./references/github_com_OndrejSladky_kmercamel_blob_main_README.md)
- [Source Code Documentation](./references/github_com_OndrejSladky_kmercamel_blob_main_src_README.md)