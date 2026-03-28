---
name: mseqtools
description: mseqtools is a high-performance C-based toolkit designed for handling and manipulating genomic sequence data with a focus on microbiome workflows. Use when user asks to subset sequences, convert sequence formats, or process large gzipped FASTQ files efficiently.
homepage: https://github.com/arumugamlab/mseqtools
---

# mseqtools

## Overview

mseqtools is a high-performance C-based toolkit for handling genomic sequence data. While it shares some functional overlap with tools like `seqtk`, it is specifically optimized for microbiome workflows and implements unique sequence manipulation routines. It leverages the `kseq.h` library for maximum parsing efficiency and natively supports gzipped files by piping through the system's `gzip` utility. This skill provides the necessary patterns for executing its primary functions, such as sequence subsetting and format conversion.

## Installation and Setup

Before using mseqtools, ensure the environment is properly configured:

- **Conda**: `conda install -c bioconda mseqtools`
- **Dependencies**: The tool requires `gzip` to be available in the system PATH for handling compressed output.
- **Verification**: Run `mseqtools help` to verify the installation and view available subcommands.

## Common CLI Patterns

### Basic Usage
The primary entry point is the `mseqtools` executable followed by a subcommand:
```bash
mseqtools <subcommand> [options] <input_file>
```

### Subsetting Sequences
One of the core functionalities is extracting specific subsets of data from large metagenomic files.
```bash
mseqtools subset -n <number_of_sequences> input.fastq.gz > subset.fastq
```

### Handling Compressed Data
mseqtools automatically detects compressed input using `zlib`. For output, it uses system pipes to `gzip`.
- **Reading**: Pass a `.gz` file directly as the input argument.
- **Writing**: Redirect output to a file or pipe to `gzip` if the subcommand does not handle compression internally.

## Expert Tips

- **Streaming**: Use `-` as a filename to read from `stdin` or write to `stdout`, allowing mseqtools to be integrated into complex bioinformatics pipes.
- **Performance**: Because mseqtools uses `kseq.h`, it is extremely memory-efficient. It is preferred over Python or Perl scripts for processing multi-gigabyte FASTQ files.
- **Illumina Headers**: The tool contains internal logic for parsing Illumina-specific mate-paired template names (e.g., handling the `/1` and `/2` suffixes), making it ideal for preprocessing raw reads before assembly.



## Subcommands

| Command | Description |
|---------|-------------|
| mseqtools | Sequence manipulation toolkit |
| mseqtools_subset | Subset a fasta/fastq file based on a list of identifiers. |

## Reference documentation

- [mseqtools README](./references/github_com_arumugamlab_mseqtools_blob_main_README.md)
- [mseqtools Main Source](./references/github_com_arumugamlab_mseqtools_blob_main_mseqtools.c.md)
- [Sequence Subsetting Logic](./references/github_com_arumugamlab_mseqtools_blob_main_mseq_subset.c.md)