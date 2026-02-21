---
name: seqfu
description: The `seqfu` suite is a high-performance collection of DNA sequence utilities designed for the robust manipulation of FASTX files.
homepage: http://github.com/quadram-institute-bioscience/seqfu/
---

# seqfu

## Overview
The `seqfu` suite is a high-performance collection of DNA sequence utilities designed for the robust manipulation of FASTX files. It is particularly useful for bioinformatics pipelines that require seamless handling of both FASTA and FASTQ formats, often within the same command. The toolset excels at handling compressed (.gz) files and standard input/output streams, making it a lightweight alternative to heavier sequence processing frameworks. Use this skill to perform common tasks like sequence counting, length filtering, and paired-end data management.

## Core Toolset and CLI Patterns

### Sequence Statistics and Counting
*   **Calculate N50 and assembly metrics**: Use `n50` to get a quick summary of sequence lengths, including N50, total length, and sequence counts.
    ```bash
    n50 genome.fasta
    ```
*   **Count sequences**: Use `fu-count` for a fast tally of records in one or multiple files.
    ```bash
    fu-count *.fastq.gz
    ```

### Filtering and Extraction
*   **Filter by length**: Use `fu-len` to keep sequences within a specific size range.
    ```bash
    fu-len -m 100 -M 500 input.fasta > filtered.fasta
    ```
*   **Pattern matching**: Use `fu-grep` to extract sequences based on DNA motifs, sequence names, or header comments.
    ```bash
    fu-grep "GATC" input.fastq > matches.fastq
    ```
*   **Sort sequences**: Use `fu-sort` to organize sequences by their length.
    ```bash
    fu-sort input.fasta > sorted.fasta
    ```

### Paired-End (PE) Operations
*   **Interleave/Deinterleave**: Use `interleafq` to convert between interleaved and separate R1/R2 files.
*   **Repair and Concatenate**: Use `pe-cat` to merge paired-end files. This tool is specifically designed to be error-tolerant and can often repair broken PE sets where one file has more reads than the other.
*   **Filter PE sets**: Use `pe-len` or `pe-grep` to ensure that filtering operations are applied to both pairs simultaneously, maintaining the integrity of the dataset.

### Sequence Modification
*   **Rename headers**: Use `fu-rename` to add prefixes or standardize sequence identifiers.
    ```bash
    fu-rename --prefix "SampleA_" input.fasta > renamed.fasta
    ```

## Expert Tips and Best Practices
*   **Stream Processing**: Most `seqfu` tools support standard input. Pipe outputs together to avoid creating large intermediate files.
    ```bash
    cat reads.fastq | fu-len -m 50 | fu-count
    ```
*   **Gzip Support**: You do not need to decompress files before using `seqfu`. It natively handles `.gz` files, saving disk space and I/O time.
*   **Unified Parsing**: Since `seqfu` uses the same parser for FASTA and FASTQ, you can often run the same command on mixed-format datasets without changing parameters.
*   **Header Metadata**: Unlike simpler tools, `seqfu` is designed to parse both the sequence name and the comments in the header (e.g., `>Name Comment`), which is critical when filtering based on metadata added by assemblers or simulators.

## Reference documentation
- [SeqFu Wiki - Home](./references/github_com_quadram-institute-bioscience_seqfu_wiki.md)
- [SeqFu GitHub Overview](./references/github_com_quadram-institute-bioscience_seqfu.md)
- [Bioconda SeqFu Package](./references/anaconda_org_channels_bioconda_packages_seqfu_overview.md)