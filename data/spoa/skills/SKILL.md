---
name: spoa
description: Spoa (SIMD Partial Order Alignment) is a high-performance C++ library and CLI tool designed to generate consensus sequences and multiple sequence alignments using the POA algorithm.
homepage: https://github.com/rvaser/spoa
---

# spoa

## Overview

Spoa (SIMD Partial Order Alignment) is a high-performance C++ library and CLI tool designed to generate consensus sequences and multiple sequence alignments using the POA algorithm. By leveraging SIMD instructions (SSE4.1, AVX2), it provides significant speedups over traditional POA implementations. It supports various alignment modes—local, global, and semi-global—and handles complex gap penalties including linear, affine, and convex (piecewise affine) models.

## Command Line Usage

The basic syntax for spoa is:
`spoa [options ...] <sequences> > output`

### Common Result Modes (-r)
The `-r` flag determines the output format. You can use this option multiple times to generate multiple outputs.
- `-r 0`: Consensus sequence in FASTA format (Default).
- `-r 1`: Multiple sequence alignment (MSA) in FASTA format.
- `-r 2`: Both consensus and MSA in FASTA format.
- `-r 3`: Partial order graph in GFA format.
- `-r 4`: Both consensus and partial order graph in GFA format.

### Alignment Algorithms (-l)
Choose the alignment mode based on the nature of your input sequences:
- `-l 0`: Local (Smith-Waterman) - Best for finding conserved regions in dissimilar sequences.
- `-l 1`: Global (Needleman-Wunsch) - Best for sequences of similar length that align end-to-end.
- `-l 2`: Semi-global (Overlap) - Best for sequences that overlap but have different start/end points (common in assembly).

### Scoring and Gap Penalties
Fine-tune the alignment by adjusting the scoring matrix and gap models:
- `-m <int>`: Match score (default: 5).
- `-n <int>`: Mismatch score (default: -4).
- `-g <int>`: Gap opening penalty (default: -8).
- `-e <int>`: Gap extension penalty (default: -6).

**Gap Mode Logic:**
- **Linear**: Triggered if `g >= e`.
- **Affine**: Triggered if `g <= q` or `e >= c` (using `-q` and `-c` for the second affine function).
- **Convex**: The default mode, providing a piecewise affine gap penalty.

## Expert Tips and Best Practices

- **Handling Strand Ambiguity**: If your input reads are not oriented (e.g., raw long reads), always use the `-s` or `--strand-ambiguous` flag. Spoa will pick the strand that yields the better alignment for each sequence.
- **Graph Visualization**: To visualize the internal partial order graph, use the `-d <file>` option to export the graph in DOT format, which can then be rendered using Graphviz.
- **Input Formats**: Spoa natively supports FASTA and FASTQ formats. It can also process gzipped files directly without manual decompression.
- **Performance**: For maximum speed on local hardware, ensure the binary is compiled with `-march=native` to utilize the best available SIMD instructions (AVX2 vs SSE4.1).
- **Consensus Quality**: When working with very noisy data, consider adjusting the mismatch (`-n`) and gap penalties (`-g`, `-e`) to be more or less stringent depending on whether you are seeing too many indels or substitutions in the consensus.

## Reference documentation
- [spoa GitHub Repository](./references/github_com_rvaser_spoa.md)
- [spoa Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_spoa_overview.md)