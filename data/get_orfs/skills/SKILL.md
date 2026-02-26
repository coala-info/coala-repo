---
name: get_orfs
description: This tool identifies and translates DNA sequences into protein sequences by finding open reading frames. Use when user asks to translate DNA to protein, identify open reading frames, or filter protein sequences by minimum length.
homepage: https://github.com/linsalrob/get_orfs
---


# get_orfs

## Overview

`get_orfs` is a lightweight, C-based utility designed for the rapid translation of DNA sequences into protein sequences. It identifies Open Reading Frames (ORFs) and is optimized for speed through multi-threading and minimal dependencies (zlib and pthreads). This tool is particularly useful for bioinformaticians who need to process large genomic datasets quickly and require protein outputs with specific minimum length requirements.

## Installation

The recommended way to install `get_orfs` is via Bioconda:

```bash
conda install bioconda::get_orfs
```

## Command Line Usage

The tool follows a straightforward CLI pattern. The input must be a FASTA format DNA sequence file.

### Basic Translation
To translate a DNA sequence using the default settings (Standard translation table, minimum length of 1 codon):

```bash
get_orfs -f input.fasta > output.faa
```

### Specifying Translation Tables
Use the `-t` or `--translation_table` flag to specify the NCBI translation table ID. This is critical when working with non-standard genetic codes (e.g., Bacteria, Mitochondria).

```bash
# Use the Bacterial, Archaeal, and Plant Plastid Code (Table 11)
get_orfs -f input.fasta -t 11 > bacterial_orfs.faa
```

### Filtering by ORF Length
To reduce noise and focus on significant coding regions, use the `-l` or `--length` flag to set a minimum amino acid length.

```bash
# Only output ORFs that are at least 100 amino acids long
get_orfs -f input.fasta -l 100 > long_orfs.faa
```

## Expert Tips and Best Practices

- **Output Formatting**: The tool outputs protein sequences. If an ORF terminates with a stop codon, the sequence will end with an asterisk (`*`). If the sequence simply ends before a stop codon is reached, no asterisk is appended.
- **Performance**: Because `get_orfs` is written in C and uses pthreads, it is significantly faster than pure Python alternatives for large-scale translation tasks. It is best used as a component in `snakemake` or `bash` pipelines.
- **Memory Efficiency**: The tool is designed to be lightweight. It uses `kseq.h` for fast FASTA parsing, making it suitable for environments with limited memory.
- **NCBI Table Reference**: Always verify the integer ID of the translation table you need. Common IDs include:
    - `1`: Standard
    - `4`: The Mold, Protozoan, and Coelenterate Mitochondrial Code and the Mycoplasma/Spiroplasma Code
    - `11`: The Bacterial, Archaeal, and Plant Plastid Code

## Reference documentation
- [get_orfs - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_get_orfs_overview.md)
- [GitHub - linsalrob/get_orfs: C code to translate a DNA sequence](./references/github_com_linsalrob_get_orfs.md)