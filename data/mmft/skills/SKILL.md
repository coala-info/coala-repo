---
name: mmft
description: `mmft` (Max's Minimal Fasta Toolkit) is a collection of self-contained, high-performance Rust utilities for FASTA file processing.
homepage: https://github.com/ARU-life-sciences/mmft
---

# mmft

## Overview

`mmft` (Max's Minimal Fasta Toolkit) is a collection of self-contained, high-performance Rust utilities for FASTA file processing. It is designed for speed and simplicity, providing a "minimalist" alternative to heavier bioinformatics suites for common tasks like sequence extraction, statistical summaries, and basic file manipulations.

## Usage Patterns

### Sequence Statistics and Calculations
Use these commands to generate summaries of sequence data. Most calculation commands support both direct file arguments and piped input.

*   **Sequence Lengths**: `mmft len <fasta(s)>`
    *   Calculates the length of every record in the provided files.
*   **GC Content**: `mmft gc <fasta(s)>`
    *   Calculates the percentage of G and C bases for each record.
*   **N50 Calculation**: `mmft n50 <fasta(s)>`
    *   Calculates the N50 metric. Note: `mmft n50 file1.fasta file2.fasta` calculates N50 for each file separately, while `cat *.fasta | mmft n50` calculates a single N50 for the combined stream.
*   **File Summary**: `mmft num <fasta(s)>`
    *   Returns the total number of sequences and the total base pair count.

### Sequence Transformations
*   **Reverse Complement**: `mmft revcomp <fasta(s)>`
    *   Generates the reverse complement of every record.
*   **Minimal Rotation**: `mmft min <fasta(s)>`
    *   Returns the lexicographically minimal rotation of the string, accounting for the reverse complement.

### Filtering and Extraction
*   **Regex Header Search**: `mmft regex -r "<regex>" <fasta(s)>`
    *   Extracts records where the header matches the specified regular expression.
*   **Subsequence Extraction**: `mmft extract -r <start>-<end> <fasta(s)>`
    *   Extracts a specific coordinate range (e.g., `1-100`) from every record.
*   **ID Filtering**: `mmft filter -f <id_list.txt> <fasta(s)>`
    *   Filters records based on a text file containing one ID per line. **Note**: This command does not support piped input.

### File Manipulation and Sampling
*   **Merging**: `mmft merge <fasta(s)>`
    *   Combines multiple FASTA files into a single record. **Note**: Does not support piped input.
*   **Random Sampling**: `mmft sample -n <N> <fasta(s)>`
    *   Randomly samples exactly `<N>` records. **Warning**: When piping into `sample`, the tool loads the entire input into memory.
*   **Splitting**: `mmft split -n <N> <fasta(s)>`
    *   Splits a FASTA file into chunks of `<N>` records. Use `-d <DIR>` to specify an output directory.

## Expert Tips and Best Practices

*   **Piping vs. Arguments**: `mmft` treats piped input (`cat file | mmft ...`) as a single continuous stream of records. If you need per-file statistics for multiple files, pass the filenames as arguments instead of piping.
*   **Memory Management**: Be cautious when using `mmft sample` with STDIN on extremely large datasets (e.g., raw NGS reads), as it will attempt to load the stream into RAM.
*   **Command Limitations**: The following subcommands **do not** support piping and require direct file paths: `filter`, `merge`, `sample`, and `split`.
*   **Installation**: If the tool is missing, it can be installed via Bioconda: `conda install bioconda::mmft`.

## Reference documentation
- [My Minimal Fasta Toolkit README](./references/github_com_ARU-life-sciences_mmft.md)
- [mmft Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mmft_overview.md)