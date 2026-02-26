---
name: mseqtools
description: "mseqtools is a command-line utility for manipulating biological sequence files. Use when user asks to subset sequences from FASTQ or FASTA files."
homepage: https://github.com/arumugamlab/mseqtools
---


# mseqtools

---
## Overview
mseqtools is a command-line utility designed for efficient manipulation of FASTQ and FASTA files, which are standard formats for biological sequence data. It offers a range of functionalities useful in bioinformatics workflows, particularly for shotgun metagenomics analysis. This tool is valuable when you need to process, filter, or transform sequence data before or during downstream analysis.

## Usage Instructions

mseqtools provides several subcommands for various sequence manipulation tasks. The general syntax is `mseqtools <subcommand> [options] <input_file>`.

### Installation

The recommended installation method is via conda from the bioconda channel:
```bash
conda install -c bioconda mseqtools
```
Alternatively, you can install from source by following the instructions in the `README.md` file within the repository. Ensure `gcc`, `gzip`, `tar`, and `wget` are installed, along with `zlib` and `argtable2` development libraries if building from source.

### Core Functionalities and Examples

mseqtools is a wrapper around several functionalities. The primary tool is `mseqtools` itself, and a notable subcommand is `mseq_subset`.

#### Subsetting Sequences (`mseq_subset`)

The `mseq_subset` command allows you to extract specific sequences from a FASTQ or FASTA file based on sequence IDs.

**Example:** Extract sequences with specific IDs from a FASTA file.
```bash
mseqtools mseq_subset --seqid_file seqids.txt --input input.fasta --output output.fasta
```
*   `--seqid_file`: A file containing the sequence IDs to extract, one per line.
*   `--input`: The input FASTA or FASTQ file.
*   `--output`: The output file for the extracted sequences.

#### General `mseqtools` Commands

While `mseq_subset` is a specific subcommand, the `mseqtools` executable itself can be used for various operations. The documentation suggests it's a "watered down version" of a larger package, implying it focuses on commonly needed functions.

**Common Use Cases (Inferred from tool's purpose):**

*   **Filtering sequences:** Based on length, quality scores (for FASTQ).
*   **Format conversion:** Between FASTA and FASTQ.
*   **Sequence manipulation:** Reverse complement, etc. (though specific commands for these are not detailed in the provided snippets).

**Expert Tips:**

*   **Leverage `gzip`:** mseqtools uses `zlib` for reading compressed files and pipes to `gzip` for writing compressed output. Ensure `gzip` is in your system's PATH if building from source. Conda and Docker installations handle this dependency.
*   **Refer to `seqtk`:** The README explicitly recommends Heng Li's `seqtk` package for many sequence manipulation tasks, suggesting `mseqtools` might be best for functionalities not covered by `seqtk` or for specific integrations within a larger pipeline.
*   **Check `mseqtools help`:** For a comprehensive list of available subcommands and options, run `mseqtools help` after installation.

## Reference documentation
- [mseqtools Overview](./references/anaconda_org_channels_bioconda_packages_mseqtools_overview.md)
- [mseqtools GitHub Repository](./references/github_com_arumugamlab_mseqtools.md)