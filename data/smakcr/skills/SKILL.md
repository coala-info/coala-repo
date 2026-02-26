---
name: smakcr
description: "SmaKCR efficiently counts short k-mers in DNA sequences. Use when user asks to count short k-mers in DNA sequences."
homepage: https://github.com/julibeg/smakcr
---


# smakcr

yaml
name: smakcr
description: Counts short k-mers (k < 13) efficiently. Use when needing to quickly count short k-mers in DNA sequences, especially when performance is critical and existing tools like Jellyfish or KMC are too slow for short k-mer ranges.
```
## Overview
SmaKCR is a specialized tool designed for the rapid counting of short k-mers (specifically, k < 13) within DNA sequences. It offers a performance advantage over more general-purpose k-mer counters like Jellyfish and KMC when dealing with these shorter k-mer lengths. This makes it ideal for bioinformatics tasks where precise and fast enumeration of short sequence motifs is required.

## Usage Instructions

SmaKCR is a command-line tool. The primary command is `smakcr`.

### Basic Usage

To count k-mers in a DNA sequence file:

```bash
smakcr <input_fasta_file> <output_file> <k_value>
```

- `<input_fasta_file>`: Path to the input FASTA file containing DNA sequences.
- `<output_file>`: Path where the k-mer counts will be saved. The output format is typically a list of k-mers and their counts.
- `<k_value>`: The length of the k-mer to count. This tool is optimized for `k < 13`.

### Key Options and Considerations

*   **Performance for Short k-mers**: SmaKCR is specifically optimized for counting short k-mers (k < 13). For larger k values, other tools might be more suitable.
*   **Input Format**: The tool expects input in FASTA format. Ensure your DNA sequences are correctly formatted.
*   **Output Format**: The output file will contain the k-mers and their corresponding counts. The exact format may vary, but it's generally designed for easy parsing.
*   **Memory Usage**: While optimized for speed, be mindful of memory usage for very large input files.

### Expert Tips

*   **Benchmarking**: If you are comparing k-mer counting performance, SmaKCR is a strong candidate for short k-mer ranges.
*   **Integration**: For integration into larger bioinformatics pipelines, consider using shell scripting to manage input/output files and pass parameters to `smakcr`.

## Reference documentation
- [Overview of SmaKCR](./references/github_com_julibeg_smakcr.md)