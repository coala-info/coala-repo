---
name: mdust
description: "mdust removes repetitive sequences from DNA or RNA sequences. Use when user asks to remove adapter sequences from biological sequence data."
homepage: https://github.com/lh3/mdust
---


# mdust

yaml
name: mdust
description: |
  A command-line tool for removing repetitive sequences from DNA or RNA sequences.
  Use when Claude needs to process biological sequence data, specifically for cleaning
  and preparing sequences by removing common adapter sequences or other repetitive
  elements. This is particularly useful in next-generation sequencing (NGS) data
  preprocessing pipelines.
```
## Overview
mdust is a command-line utility designed for the efficient removal of repetitive sequences, such as adapter sequences, from biological sequence data (DNA/RNA). It is particularly useful in the context of next-generation sequencing (NGS) data preprocessing, where removing these artifacts is crucial for downstream analysis.

## Usage Instructions

mdust operates by identifying and removing specified repetitive sequences from input FASTA files.

### Basic Usage

The fundamental command structure is:

```bash
mdust [options] <input.fasta> <output.fasta>
```

- `<input.fasta>`: The path to the input FASTA file containing the sequences to be processed.
- `<output.fasta>`: The path where the cleaned FASTA file will be saved.

### Key Options

*   **`-s <sequences.fasta>`**: Specifies a FASTA file containing the repetitive sequences (e.g., adapter sequences) to be removed. This is the most common and critical option.
*   **`-n <number>`**: Sets the minimum length of a repetitive sequence to be considered for removal. Sequences shorter than this will be ignored.
*   **`-l <number>`**: Sets the maximum length of a repetitive sequence to be considered for removal. Sequences longer than this will be ignored.
*   **`-p <number>`**: Specifies the minimum number of times a repetitive sequence must appear in a read to be considered for removal.
*   **`-m <number>`**: Sets the maximum number of mismatches allowed when matching a repetitive sequence against a read.
*   **`-o <number>`**: Defines the minimum overlap required between a repetitive sequence and a read for it to be considered a match.
*   **`-a`**: Enables the removal of adapter sequences from *both* ends of a read.
*   **`-d`**: Enables the removal of duplicate sequences from the output.
*   **`-c`**: Counts the number of removed sequences and prints it to standard error.
*   **`-v`**: Enables verbose output, showing more details about the processing.

### Common CLI Patterns and Expert Tips

1.  **Standard Adapter Removal**: The most frequent use case involves removing known adapter sequences. You'll typically need a FASTA file containing these adapters.

    ```bash
    mdust -s adapters.fasta input_sequences.fasta cleaned_sequences.fasta
    ```

2.  **Controlling Mismatches**: When dealing with sequencing errors, you might need to allow for some mismatches. The `-m` option is crucial here.

    ```bash
    mdust -s adapters.fasta -m 2 input_sequences.fasta cleaned_sequences.fasta
    ```
    This command allows up to 2 mismatches when identifying adapter sequences.

3.  **Specifying Sequence Lengths**: If you know the approximate length of the adapters you're targeting, use `-l` and `-n` to refine the search and avoid spurious matches.

    ```bash
    mdust -s adapters.fasta -n 10 -l 50 input_sequences.fasta cleaned_sequences.fasta
    ```
    This command will only consider adapter sequences between 10 and 50 bases long.

4.  **Removing from Both Ends**: For paired-end sequencing data, adapters can appear at either end. The `-a` flag is essential for this.

    ```bash
    mdust -s adapters.fasta -a input_sequences.fasta cleaned_sequences.fasta
    ```

5.  **Handling Duplicate Sequences**: If your input might contain identical sequences that you wish to collapse, use the `-d` flag.

    ```bash
    mdust -s adapters.fasta -d input_sequences.fasta cleaned_sequences.fasta
    ```

6.  **Verbose Output for Debugging**: When troubleshooting or understanding the process, the `-v` flag provides detailed information.

    ```bash
    mdust -s adapters.fasta -v input_sequences.fasta cleaned_sequences.fasta
    ```

7.  **Counting Removed Sequences**: To get a quick summary of how many sequences were modified or removed, use the `-c` flag.

    ```bash
    mdust -s adapters.fasta -c input_sequences.fasta cleaned_sequences.fasta
    ```
    The count will be printed to standard error.

## Reference documentation
- [mdust from DFCI Gene Indices Software Tools (archived for a historical record only)](./references/github_com_lh3_mdust.md)