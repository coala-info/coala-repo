---
name: dnp-diprofile
description: This tool calculates the frequency of dinucleotide occurrences in aligned FASTA sequences. Use when user asks to analyze dinucleotide composition of DNA sequences.
homepage: https://github.com/erinijapranckeviciene/dnpatterntools
---


# dnp-diprofile

---
## Overview
The `dnp-diprofile` tool analyzes the frequency of dinucleotide occurrences within a set of aligned FASTA sequences. This is particularly useful in bioinformatics for investigating sequence patterns, such as those related to nucleosome positioning, by understanding how pairs of nucleotides are distributed. It helps in characterizing DNA sequences based on their dinucleotide composition.

## Usage Instructions

The `dnp-diprofile` tool is part of the `dnpatterntools` suite and is typically used via the command line. It requires an input FASTA file containing aligned sequences.

### Core Functionality

The primary function of `dnp-diprofile` is to calculate the frequency of each dinucleotide (e.g., AA, AC, AG, AT, etc.) across a batch of aligned sequences.

### Command Line Usage

The basic syntax for `dnp-diprofile` is as follows:

```bash
dnp-diprofile <FASTA_FILE> [OPTIONS]
```

**Required Argument:**

*   `<FASTA_FILE>`: The path to the input FASTA file containing aligned DNA sequences.

**Common Options:**

*   `-h, --help`: Display the help message and exit.
*   `--version-check BOOL`: Enable or disable version update notifications. Defaults to `1` (enabled).
*   `-di, --dinucleotide STRING`: Specify a particular dinucleotide to identify and count. If not specified, all dinucleotides are considered.

### Expert Tips and Best Practices

*   **Input Data Quality**: Ensure your input FASTA file contains sequences that are properly aligned. Misaligned sequences can lead to inaccurate dinucleotide frequency profiles.
*   **Sequence Type**: This tool is designed for DNA sequences. Ensure your FASTA file contains DNA sequences.
*   **Output Interpretation**: The output will typically be a table or matrix where rows represent dinucleotides and columns represent sequence positions or features, with the values indicating their frequencies. Understanding the biological context of your sequences is crucial for interpreting these profiles.
*   **Specific Dinucleotide Analysis**: If you are interested in the occurrence of a specific dinucleotide, use the `--dinucleotide` option to focus the analysis and potentially simplify the output.

## Reference documentation
- [README.rst](./references/github_com_erinijapranckeviciene_dnpatterntools.md)