---
name: rust-overlaps
description: rust-overlaps identifies approximate suffix-prefix overlaps between sequences for constructing overlap graphs in de novo assembly. Use when user asks to find sequence overlaps, solve the approximate suffix-prefix overlap problem, or identify matches between sequence suffixes and prefixes with a specific error rate.
homepage: https://github.com/jbaaijens/rust-overlaps
---


# rust-overlaps

## Overview
`rust-overlaps` is a high-performance command-line utility designed to solve the Approximate Suffix-Prefix Overlap Problem (ASPOP). It identifies instances where the suffix of one sequence matches the prefix of another, allowing for a user-defined error rate. This tool is particularly effective for constructing overlap graphs in de novo assembly workflows, providing a fast and memory-efficient alternative to general-purpose aligners.

## Installation
The tool can be installed via Bioconda or compiled from source using Cargo:

```bash
# Via Conda
conda install bioconda::rust-overlaps

# Via Cargo (from source)
cargo build --release
```

## Command Line Usage
The basic syntax requires four positional arguments followed by optional flags:

`rust_overlaps <input_fasta> <output_tsv> <error_rate> <min_overlap_length> [flags]`

### Core Arguments
1.  **Input Path**: Path to the sequence file in FASTA format.
2.  **Output Path**: Path for the resulting TSV file.
3.  **Error Rate**: A float representing the maximum allowed errors per overlapping symbol (e.g., `0.012`).
4.  **Overlap Threshold**: An integer for the minimum length of the overlap (e.g., `80`).

### Common Flags and Options
- `-r`: **Reversal solutions**. Finds overlaps involving the reverse complement of sequences (essential for double-stranded DNA).
- `-e`: **Edit distance**. Uses edit distance (allowing indels) instead of the default Hamming distance.
- `-t`: **Task progress**. Prints a progress bar and ETA to the terminal.
- `-w=<int>`: **Worker threads**. Sets the number of threads. Defaults to `logical_cores - 1`.
- `-vv`: **Maximum verbosity**. Useful for debugging or detailed execution logs.
- `-g`: **Greedy output**. Disables the default unique/lexicographic sorting of results for faster output.

## Best Practices and Tips
- **Distance Metrics**: Use the default Hamming distance for high-fidelity reads (like Illumina) to maximize speed. Switch to `-e` (Edit distance) for noisier long-read data where insertions and deletions are common.
- **Thread Management**: On shared HPC nodes, always specify `-w` to match your allocated CPU cores to avoid over-subscription.
- **Memory Efficiency**: The tool is optimized for speed; however, for extremely large datasets, ensure your system has sufficient RAM to hold the suffix-filter structures.
- **Output Interpretation**: The output TSV includes `idA` and `idB`. By default, the tool ensures `idA < idB` to avoid redundant reciprocal matches unless `-r` or specific flags are used.
- **Orientation**: In the output `O` column, `N` stands for Normal and `I` stands for Inverted (reverse complement).

## Reference documentation
- [github_com_jbaaijens_rust-overlaps.md](./references/github_com_jbaaijens_rust-overlaps.md)
- [anaconda_org_channels_bioconda_packages_rust-overlaps_overview.md](./references/anaconda_org_channels_bioconda_packages_rust-overlaps_overview.md)