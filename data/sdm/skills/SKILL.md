---
name: sdm
description: The sdm tool efficiently demultiplexes and dereplicates biological sequence data. Use when user asks to demultiplex samples, remove primers, filter sequences by quality, extract sequences by header, or combine input files.
homepage: https://github.com/hildebra/sdm/
metadata:
  docker_image: "quay.io/biocontainers/sdm:3.11--h077b44d_0"
---

# sdm

yaml
name: sdm
description: |
  A fast and memory-efficient tool for sequence demultiplexing and dereplication in bioinformatics.
  Use when Claude needs to process FASTQ or FASTA files for:
  - Demultiplexing samples based on DNA sequence or header keywords.
  - Removing sequencing or PCR primers.
  - Filtering DNA sequences based on quality parameters.
  - Extracting subsets of sequences by header names.
  - Combining multiple input files.
  - Handling various FASTQ/FASTA formats, including gzipped files and potentially corrupt files.
```
## Overview
The `sdm` tool is a high-performance command-line utility designed for efficient processing of biological sequence data, primarily in FASTQ and FASTA formats. It excels at demultiplexing samples, cleaning reads by removing primers, filtering sequences based on quality, and extracting specific sequences. Its speed and memory efficiency make it suitable for large datasets and integration into complex bioinformatics pipelines.

## Usage Instructions

`sdm` is a versatile tool with numerous options for sequence manipulation. The general command structure is:

```bash
sdm [options] <input_file(s)>
```

### Core Functionalities and Options

*   **Demultiplexing**:
    *   `-d <sample_sheet>`: Specify a sample sheet for demultiplexing. The sample sheet should define sample names and their corresponding barcodes or header keywords.
    *   `-k <keyword>`: Demultiplex based on header keywords.
    *   `-p <primer_file>`: Remove primers specified in a file.

*   **Input Handling**:
    *   `sdm` automatically detects input formats (FASTA, FASTQ, gzipped versions).
    *   Handles potentially corrupt files gracefully.

*   **Filtering and Extraction**:
    *   `-q <min_quality>`: Filter sequences with a minimum average quality score.
    *   `-l <min_length>`: Filter sequences shorter than a specified length.
    *   `-XfirstReadsWritten <output_prefix>`: Write only the first N reads to output files, where N is determined by the number of samples.
    *   `-XfirstReadsRead <N>`: Write only the first N reads from the input.
    *   `-H <header_file>`: Extract sequences whose headers are listed in `<header_file>`. This works for paired-end reads as well.

*   **Output Control**:
    *   By default, `sdm` outputs to standard output. Use shell redirection (`>`) to save to files.
    *   For demultiplexing, output files are typically named based on sample names (e.g., `sample1.fastq`, `sample2.fastq`).

### Common CLI Patterns and Expert Tips

1.  **Basic Demultiplexing with Barcodes**:
    If you have a sample sheet (`samples.txt`) defining barcodes for each sample:
    ```bash
    sdm -d samples.txt input.fastq.gz > output.demultiplexed.fastq
    ```
    The `samples.txt` file might look like:
    ```
    sample1	barcode1
    sample2	barcode2
    ```

2.  **Demultiplexing by Header Keyword**:
    If sample identifiers are embedded in read headers (e.g., `>sample1_read1`):
    ```bash
    sdm -k sample1 -k sample2 input.fastq > output.demultiplexed.fastq
    ```
    This will create separate output streams for `sample1` and `sample2`. You'll likely need to redirect these to specific files using shell features or by running `sdm` multiple times with different `-k` options if you need distinct files for each sample.

3.  **Primer Removal**:
    To remove primers defined in `primers.txt`:
    ```bash
    sdm -p primers.txt input.fastq > output.trimmed.fastq
    ```

4.  **Quality Filtering and Length Filtering**:
    Combine filtering options:
    ```bash
    sdm -q 20 -l 50 input.fastq.gz > filtered_reads.fastq
    ```

5.  **Extracting Specific Reads by Header**:
    If you have a list of read headers in `target_headers.txt`:
    ```bash
    sdm -H target_headers.txt input.fastq > extracted_reads.fastq
    ```

6.  **Handling Paired-End Reads**:
    `sdm` generally handles paired-end reads automatically when input files are provided correctly (e.g., `read1.fastq.gz read2.fastq.gz`). Options like `-H` will attempt to match and extract corresponding reads from both files.

7.  **Performance**:
    `sdm` is written in C++11 for speed and memory efficiency. For very large files, consider using `bgzip` and `tabix` for indexed access if applicable to your workflow, though `sdm`'s direct handling of gzipped files is often sufficient.

8.  **Error Handling**:
    The tool is designed to handle corrupt files to some extent. If you encounter persistent issues, inspect the input files for specific corruption patterns.

## Reference documentation
- [README.md](./references/github_com_hildebra_sdm.md)