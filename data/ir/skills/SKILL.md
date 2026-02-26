---
name: ir
description: This tool calculates the repetitiveness of DNA sequences. Use when user asks to analyze DNA sequences for repetitive elements.
homepage: http://guanine.evolbio.mpg.de/cgi-bin/ir/ir.cgi.pl
---


# ir

yaml
name: ir
description: Calculates the repetitiveness of DNA sequences. Use when Claude needs to analyze DNA sequences for repetitive elements, such as identifying tandem repeats or other patterns of repetition within a given sequence.
---
## Overview
The `ir` tool is designed to analyze DNA sequences and quantify their repetitiveness. It helps in identifying and characterizing repetitive regions within a genome or specific DNA sequences.

## Usage Instructions

The `ir` tool is typically used via the command line. The basic syntax involves providing the DNA sequence and specifying parameters to control the analysis.

### Basic Command Structure

```bash
ir [options] <sequence_file>
```

Where `<sequence_file>` is a FASTA file containing the DNA sequence to be analyzed.

### Common Options and Parameters

*   **`-d <int>`**: Specifies the maximum distance between two repeats. This is a crucial parameter for defining what constitutes a "repeat" and how far apart identical or similar sequences can be.
*   **`-m <int>`**: Sets the minimum length of a repeat unit. Shorter sequences below this threshold will not be considered as repeat units.
*   **`-n <int>`**: Defines the minimum number of times a repeat unit must occur to be reported.
*   **`-o <file>`**: Specifies an output file to write the results to. If not provided, results are typically printed to standard output.
*   **`-f`**: Forces overwriting of the output file if it already exists.
*   **`-v`**: Verbose output, providing more detailed information during the analysis.

### Expert Tips

*   **Parameter Tuning**: The effectiveness of `ir` heavily relies on appropriate parameter tuning (`-d`, `-m`, `-n`). Experiment with different values based on the expected nature of the repetitive elements you are looking for. For instance, if you suspect short, highly frequent repeats, decrease `-m` and increase `-n`. For longer, more dispersed repeats, increase `-d`.
*   **Input Format**: Ensure your input sequence is in a standard FASTA format. The tool is optimized for this format.
*   **Output Interpretation**: The output typically details the identified repeat units, their lengths, their positions in the sequence, and the number of occurrences. Understanding these metrics is key to interpreting the repetitiveness of your DNA.
*   **Large Datasets**: For very large sequences, consider redirecting output to a file (`-o`) to avoid overwhelming the terminal and to facilitate further processing.

## Reference documentation
- [Program for Calculating the Repetitiveness of DNA Sequences](./references/guanine_evolbio_mpg_de_cgi-bin_ir_ir.cgi.pl.md)