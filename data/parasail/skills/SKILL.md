---
name: parasail
description: Parasail is a specialized library and toolset designed for rapid pairwise sequence alignment.
homepage: https://github.com/jeffdaily/parasail
---

# parasail

## Overview
Parasail is a specialized library and toolset designed for rapid pairwise sequence alignment. It implements vectorized versions of Smith-Waterman (local), Needleman-Wunsch (global), and semi-global alignment algorithms. By utilizing SIMD (Single Instruction, Multiple Data) instructions, it provides a reference implementation for high-speed alignment on modern hardware. Use this skill to execute alignments via the command line, select optimized algorithm variants, and format alignment output.

## Installation
The most efficient way to access the `parasail_aligner` CLI is via Bioconda:
```bash
conda install bioconda::parasail
```

## Command Line Usage
The primary CLI tool is `parasail_aligner`. It requires a query/target file and an algorithm specification.

### Basic Alignment Pattern
```bash
parasail_aligner -f sequences.fasta -a <algorithm_name>
```

### Common Flags
- `-f <file>`: Input FASTA file containing sequences to align.
- `-a <name>`: The specific parasail function name to use.
- `-m <matrix>`: Substitution matrix (e.g., blosum62, pam100).
- `-o <int>`: Gap open penalty.
- `-e <int>`: Gap extension penalty.
- `-O <format>`: Output format (e.g., `EMBOSS` for human-readable alignment).

## Algorithm Selection Guide
Parasail uses a specific naming convention for its functions: `parasail_<alg>_[stats]_[implementation]_[bits]`.

### 1. Algorithm Type (`alg`)
- `sw`: Smith-Waterman (local alignment)
- `nw`: Needleman-Wunsch (global alignment)
- `sg`: Semi-global alignment (penalties for end-gaps are optional)

### 2. Statistics (`stats`)
- If `stats` is included in the name, the tool returns the number of matches, similarities, and alignment length in addition to the score.
- **Tip**: Omit `stats` if you only need the alignment score, as it is significantly faster.

### 3. Implementation Strategy
- `striped`: Generally the fastest and most robust implementation (Farrar's algorithm).
- `blocked`: Efficient for certain CPU architectures.
- `diag`: The diagonal implementation (Wozniak's algorithm).

### 4. Bit Width (`bits`)
- `8`, `16`, `32`, `64`: Specifies the precision of the score calculation.
- `sat`: Saturated implementation that automatically handles overflows.

## Expert Tips and Best Practices
- **Performance Tuning**: Use the `striped` implementation (e.g., `sw_stats_striped_16`) as your default choice for the best balance of speed and compatibility.
- **Memory Efficiency**: If you are aligning very long sequences, ensure the bit width (e.g., `32` or `64`) is sufficient to prevent score overflow, or use the `sat` (saturated) variants.
- **Tracebacks**: To obtain a SAM CIGAR string or a visual alignment, ensure you use a function variant that supports tracebacks (usually indicated in the documentation for specific library calls, or by using the `-O` flag in the aligner).
- **CPU Dispatching**: Parasail automatically detects the highest instruction set supported by your CPU (SSE2, AVX2, NEON, etc.) at runtime. You do not need to manually specify the instruction set in the CLI.

## Reference documentation
- [Parasail Overview](./references/anaconda_org_channels_bioconda_packages_parasail_overview.md)
- [Parasail GitHub README](./references/github_com_jeffdaily_parasail.md)