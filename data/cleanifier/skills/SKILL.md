---
name: cleanifier
description: Cleanifier removes contaminant sequences from biological data using k-mer analysis. Use when user asks to remove contamination from sequencing data or filter biological sequences.
homepage: https://gitlab.com/rahmannlab/cleanifier
---


# cleanifier

cleanifier/SKILL.md
```yaml
name: cleanifier
description: A fast, lightweight tool for removing contamination from biological sequences using k-mers. Use when dealing with sequencing data that may contain contaminant sequences and requires efficient filtering based on k-mer profiles.
```
## Overview
Cleanifier is a command-line tool designed for the rapid and efficient removal of contaminant DNA or RNA sequences from biological datasets. It leverages k-mer analysis to identify and filter out sequences that are likely contaminants, making it a valuable tool for preprocessing genomic and transcriptomic data.

## Usage Instructions

Cleanifier operates by comparing k-mer profiles of input sequences against a reference database or by identifying unique k-mers within the dataset itself. The primary goal is to isolate the target sequences by removing unwanted contaminants.

### Core Command Structure

The general command structure for `cleanifier` is as follows:

```bash
cleanifier [OPTIONS] <input_fasta_or_fastq> <output_fasta_or_fastq>
```

### Key Options and Their Usage

*   **`-k` or `--ksize`**: Specifies the k-mer size to be used for analysis. A larger k-mer size can be more specific but may miss shorter contaminants. A smaller k-mer size is more sensitive but might flag legitimate sequences as contaminants.
    *   **Example**: `cleanifier -k 31 input.fasta output.fasta`

*   **`-t` or `--threads`**: Sets the number of threads to use for parallel processing, significantly speeding up analysis on multi-core systems.
    *   **Example**: `cleanifier -t 8 input.fastq output.fastq`

*   **`--contaminant_db`**: Path to a FASTA file containing known contaminant sequences. Cleanifier will use this database to identify and remove contaminants.
    *   **Example**: `cleanifier --contaminant_db contaminants.fasta input.fasta output.fasta`

*   **`--min_contam_freq`**: Minimum frequency of a k-mer to be considered a contaminant. This helps to filter out rare k-mers that might be due to sequencing errors.
    *   **Example**: `cleanifier --min_contam_freq 0.01 input.fasta output.fasta`

*   **`--min_target_freq`**: Minimum frequency of a k-mer to be considered part of the target sequence.
    *   **Example**: `cleanifier --min_target_freq 0.001 input.fasta output.fasta`

*   **`--output_contaminants`**: If specified, this option will write the identified contaminant sequences to a separate output file.
    *   **Example**: `cleanifier --output_contaminants contaminants_only.fasta input.fasta output.fasta`

### Expert Tips and Best Practices

1.  **Choosing `ksize`**: The optimal `ksize` often depends on the nature of your data and expected contaminants. For general microbial contamination, k-mers between 21 and 31 are common. Experimentation may be necessary.
2.  **Utilizing `contaminant_db`**: If you have a specific set of known contaminants (e.g., from a particular organism or lab environment), providing a custom `contaminant_db` will yield the most accurate results.
3.  **Parallel Processing**: Always leverage the `--threads` option for large datasets to drastically reduce processing time.
4.  **Outputting Contaminants**: Use `--output_contaminants` to inspect the sequences that were flagged as contaminants. This can be useful for quality control and understanding the nature of the contamination.
5.  **Frequency Thresholds**: Adjusting `--min_contam_freq` and `--min_target_freq` can fine-tune the sensitivity of the contamination removal. Lowering these thresholds might remove more sequences, while increasing them might be more conservative.
6.  **Input/Output Formats**: Cleanifier supports both FASTA and FASTQ formats for input and output. Ensure your input and desired output formats are consistent.

## Reference documentation
- [README](./references/gitlab_com_rahmannlab_cleanifier_-_README.md)