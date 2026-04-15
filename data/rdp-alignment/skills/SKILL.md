---
name: rdp-alignment
description: This tool classifies 16S rRNA gene sequences using the Ribosomal Database Project classifier. Use when user asks to classify 16S rRNA gene sequences or assign taxonomic labels to sequences.
homepage: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations
metadata:
  docker_image: "biocontainers/rdp-alignment:v1.2.0-5-deb_cv1"
---

# rdp-alignment

## Overview

The rdp-alignment skill provides a streamlined way to perform sequence classification using the Ribosomal Database Project (RDP) classifier. It is designed for users who need to assign taxonomic labels to 16S rRNA gene sequences, commonly encountered in microbial ecology and bioinformatics studies. This skill leverages the RDP's extensive curated database to identify the likely origin of query sequences.

## Usage Instructions

The `rdp-alignment` tool is primarily used via its command-line interface. Below are common patterns and expert tips for effective usage.

### Core Functionality

The primary function of `rdp-alignment` is to classify query sequences against the RDP database. This typically involves providing your sequence data and specifying parameters for the classification process.

### Common CLI Patterns

1.  **Basic Classification:**
    To perform a basic classification of a FASTA file:
    ```bash
    rdp-alignment --input <your_sequences.fasta> --output <classification_results.txt>
    ```
    Replace `<your_sequences.fasta>` with the path to your input FASTA file and `<classification_results.txt>` with the desired output file name.

2.  **Specifying the RDP Database:**
    Ensure you have the correct RDP database version downloaded and accessible. You may need to specify its path if it's not in a default location.
    ```bash
    rdp-alignment --input <your_sequences.fasta> --output <results.txt> --rdp_database /path/to/rdp/database/
    ```

3.  **Setting Classification Confidence Thresholds:**
    You can adjust the confidence threshold for classification to filter out less certain assignments.
    ```bash
    rdp-alignment --input <your_sequences.fasta> --output <results.txt> --threshold 0.8
    ```
    This command sets the minimum confidence score to 0.8 (80%).

4.  **Outputting in Different Formats:**
    The tool may support various output formats. Check the tool's documentation for available options. A common format is tab-separated values (TSV).
    ```bash
    rdp-alignment --input <your_sequences.fasta> --output <results.tsv> --format tsv
    ```

### Expert Tips

*   **Database Management:** Always ensure you are using a recent and appropriate version of the RDP database. Outdated databases can lead to inaccurate classifications. Download the latest version from the official RDP website.
*   **Sequence Quality:** The accuracy of classification heavily depends on the quality of your input sequences. Pre-processing steps such as quality trimming and chimera checking are highly recommended before running `rdp-alignment`.
*   **Parallel Processing:** For large datasets, investigate if `rdp-alignment` supports parallel processing or if you can run multiple instances concurrently on different subsets of your data to speed up analysis.
*   **Understanding Output:** Familiarize yourself with the output columns. Key information typically includes the query sequence ID, assigned taxonomy (often in a hierarchical format), and a confidence score.
*   **Error Handling:** Pay close attention to any warnings or errors reported by the tool. These can indicate issues with input sequences, database integrity, or parameter settings.



## Subcommands

| Command | Description |
|---------|-------------|
| AlignNucleotideToProtein | Aligns nucleotide sequences to a protein alignment. |
| CompareErrorType | Compare error types in alignments |
| PairwiseKNN | Pairwise alignment tool using k-nearest neighbors |
| java AlignmentMerger | This program reads in all the files from the input directory and merges the alignment into one single file |
| rdp-alignment_rm-partialseq | Performs alignment of sequences, marking partial sequences based on gap count. |

## Reference documentation
- [Overview of rdp-alignment on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_rdp-alignment_overview.md)