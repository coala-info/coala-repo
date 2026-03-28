---
name: mmft
description: mmft is a collection of Rust-based utilities for rapid FASTA file processing and sequence manipulation. Use when user asks to calculate assembly metrics like N50, filter records by regex or ID, extract subsequences, or perform basic transformations like reverse complementing.
homepage: https://github.com/ARU-life-sciences/mmft
---


# mmft

## Overview

`mmft` (Max's Minimal Fasta Toolkit) is a collection of streamlined, Rust-based utilities designed for rapid FASTA file processing. It is particularly useful for bioinformaticians who need to quickly assess assembly quality (N50), filter large datasets using regular expressions, or perform basic sequence transformations like reverse complementing or range extraction without the overhead of complex software suites.

## Usage Instructions

### Sequence Statistics and Calculations
Use these commands to generate summaries of your FASTA data. Most support both direct file arguments and STDIN.

*   **Summary Stats**: Get the total number of sequences and total base pairs.
    `mmft num <fasta_files>`
*   **Record Lengths**: Calculate the length of every record in the file.
    `mmft len <fasta_files>`
*   **GC Content**: Calculate the GC percentage for each record.
    `mmft gc <fasta_files>`
*   **Assembly Metrics**: Calculate the N50 of a FASTA file or a combined stream.
    `mmft n50 <fasta_files>`

### Sequence Manipulation
*   **Reverse Complement**: Generate the reverse complement of every record.
    `mmft revcomp <fasta_files>`
*   **Subsequence Extraction**: Extract a specific range of nucleotides (e.g., first 100 bp).
    `mmft extract -r 1-100 <fasta_files>`
*   **Lexicographical Rotation**: Find the minimally lexicographically rotated string (useful for circular genomes).
    `mmft min <fasta_files>`

### Filtering and File Management
*   **Regex Extraction**: Extract records where the header matches a specific pattern.
    `mmft regex -r "<regex_pattern>" <fasta_files>`
*   **ID Filtering**: Extract records based on a list of IDs provided in a text file (one ID per line).
    `mmft filter -f <id_list.txt> <fasta_files>`
*   **Random Sampling**: Randomly sample exactly N records from the input.
    `mmft sample -n <number_of_records> <fasta_files>`
*   **Splitting**: Divide a FASTA file into equal chunks of N records.
    `mmft split -n <records_per_chunk> -d <output_directory> <fasta_files>`
*   **Merging**: Combine multiple FASTA files into a single record.
    `mmft merge <fasta_files>`

## Expert Tips and Best Practices

### Piping vs. File Arguments
`mmft` handles input differently depending on how it is provided:
*   **Separate Files**: Providing files as arguments (e.g., `mmft n50 1.fa 2.fa`) calculates statistics for each file individually.
*   **Piped Stream**: Piping (e.g., `cat *.fa | mmft n50`) treats the entire input as a single continuum of records. Use this to calculate aggregate N50 or total base counts across multiple files.

### Memory Management
Be cautious when using `mmft sample` with STDIN. This specific subcommand loads the entire input stream into memory to perform the sampling. For extremely large files, provide the file path as an argument instead of piping if possible.

### Command Limitations
The following subcommands **do not** support piping from STDIN and require file arguments:
*   `filter`
*   `merge`
*   `sample`
*   `split`

### Regex Scope
The `mmft regex` command searches both the record headers and descriptions. Use specific anchors in your regex if you only want to match the primary ID.



## Subcommands

| Command | Description |
|---------|-------------|
| mmft regex | Extract fasta records using regex on headers. |
| mmft split | Split a fasta into multiple files based on record count. |
| mmft_extract | Extract (sub)sequence within a fasta file record. |
| mmft_filter | Filter sequences on a file of ID's |
| mmft_gc | Calculate GC content of fasta file records. |
| mmft_len | Calculate lengths of fasta file records. |
| mmft_merge | Merge sequence records within/between fasta files into a single fasta record. |
| mmft_min | Return the lexicographically minimal rotation of fasta file record sequences. |
| mmft_n50 | Calculates the N50 statistic for a given FASTA file. |
| mmft_num | Calculate number and total base count of fasta file records. |
| mmft_reverse | Reverse complement each record in an input fasta |
| mmft_sample | Randomly sample records from a fasta file. |
| mmft_trans | Translate a fasta into all six frames. |

## Reference documentation
- [My Minimal Fasta Toolkit README](./references/github_com_ARU-life-sciences_mmft_blob_main_README.md)
- [mmft Overview](./references/github_com_ARU-life-sciences_mmft.md)