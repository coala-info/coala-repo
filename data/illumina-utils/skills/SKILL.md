---
name: illumina-utils
description: The `illumina-utils` suite is a specialized collection of Python scripts designed to handle the initial processing of Illumina paired-end data.
homepage: https://github.com/meren/illumina-utils
---

# illumina-utils

## Overview

The `illumina-utils` suite is a specialized collection of Python scripts designed to handle the initial processing of Illumina paired-end data. It provides robust workflows for demultiplexing raw runs based on index files, merging overlapping paired-end reads into single sequences, and performing quality control. This tool is particularly valuable for researchers working with amplicon sequencing (like 16S rRNA) or libraries where the insert size is small enough to allow for read overlaps.

## Core Workflows and CLI Patterns

### 1. Demultiplexing Raw Data
Use `iu-demultiplex` to split a raw Illumina run into sample-specific FASTQ files. You need the R1, R2, and Index FASTQ files, plus a TAB-delimited barcode-to-sample mapping file.

```bash
iu-demultiplex -s barcode_to_sample.txt \
               --r1 r1.fastq \
               --r2 r2.fastq \
               --index index.fastq \
               -o output_directory/
```

### 2. Automated Configuration Generation
Most `illumina-utils` scripts rely on `.ini` configuration files. Instead of writing these manually, use `iu-gen-configs`.

*   **From a demultiplexing report:**
    ```bash
    iu-gen-configs output_directory/00_DEMULTIPLEXING_REPORT
    ```
*   **From a simple TAB-delimited file:**
    Create a file with the header `sample\tr1\tr2` and run:
    ```bash
    iu-gen-configs samples_list.txt
    ```

### 3. Merging Overlapping Pairs
To merge R1 and R2 reads into a single high-quality sequence, use `iu-merge-pairs`. This tool uses Levenshtein distance to find the optimal overlap.

```bash
iu-merge-pairs sample_config.ini
```
**Note:** By default, it expects a minimum overlap of 15 nucleotides. You can adjust this with command-line parameters if your library preparation requires it.

### 4. Quality Filtering and Trimming
For basic FASTQ maintenance, use `iu-trim-fastq`. This is often used to remove low-quality ends or specific adapter sequences.

```bash
iu-trim-fastq --input R1.fastq --output R1_trimmed.fastq [options]
```

## Configuration File (.ini) Structure
When manually inspecting or tweaking configs, ensure they follow this native format:

```ini
[general]
project_name = MyProject
researcher_email = user@example.edu
input_directory = /path/to/fastq_files
output_directory = /path/to/results

[files]
# Comma-separated list of files; indices must match between pair_1 and pair_2
pair_1 = sample1_R1.fastq, sample2_R1.fastq
pair_2 = sample1_R2.fastq, sample2_R2.fastq

[prefixes]
# Optional: Regular expressions for primers/barcodes to be trimmed
pair_1_prefix = ^....TACGCCCAGCAGC[C,T]GCGGTAA.
pair_2_prefix = ^CCGTC[A,T]ATT[C,T].TTT[G,A]A.T
```

## Expert Tips and Best Practices

*   **Directory Safety:** `illumina-utils` is conservative. It will **not** automatically create the `output_directory` if it doesn't exist, and it will **not** overwrite existing files. Always ensure your output path is created before running a command.
*   **Discovery:** To see the full list of available utilities installed on your system, type `iu-` and press `TAB` twice in your terminal.
*   **Regular Expressions:** The `[prefixes]` section in the config file supports standard regex. Use dots (`.`) to represent random sequences like UMIs (e.g., `......` for a 6nt UMI).
*   **Merging Logic:** Merged reads are output as FASTA files. The header of the merged sequence includes the length of the overlapped region, which is useful for downstream QC.

## Reference documentation
- [illumina-utils GitHub Repository](./references/github_com_merenlab_illumina-utils.md)
- [Sample Configuration File (.ini)](./references/github_com_merenlab_illumina-utils_blob_master_examples_merging_general-config-SAMPLE.ini.md)
- [Demultiplexing Examples](./references/github_com_merenlab_illumina-utils_tree_master_examples_demultiplexing.md)