---
name: srprism
description: SRPRISM aligns short DNA sequences to a reference genome. Use when user asks to align reads to a reference genome.
homepage: https://github.com/ncbi/SRPRISM
---


# srprism

---
## Overview
SRPRISM is a powerful command-line tool designed for aligning short DNA sequences (reads) to a reference genome. It's essential for various bioinformatics workflows, including identifying genetic variations, understanding gene expression, and assembling genomes. This skill provides guidance on how to effectively use SRPRISM for these purposes, focusing on its native command-line interface.

## Usage Instructions

SRPRISM is a command-line tool. The general syntax for running SRPRISM is as follows:

```bash
srprism [options] <reference_genome.fasta> <reads.fastq/fastq.gz>
```

### Key Options and Parameters

While the full range of options can be extensive, here are some commonly used and important parameters:

*   **`-t <threads>`**: Specifies the number of threads to use for alignment. This can significantly speed up processing on multi-core systems.
    *   Example: `srprism -t 8 reference.fasta reads.fastq.gz`
*   **`-o <output_prefix>`**: Sets a prefix for the output files. SRPRISM generates several output files, and this option helps organize them.
    *   Example: `srprism -o alignment_results reference.fasta reads.fastq.gz`
*   **`-m <memory_limit>`**: Sets a memory limit for the process. Useful for managing resource consumption.
*   **`-e <max_errors>`**: Maximum number of errors (mismatches, insertions, deletions) allowed in an alignment.
    *   Example: `srprism -e 2 reference.fasta reads.fastq.gz`
*   **`--indel <max_indels>`**: Maximum number of indels (insertions/deletions) allowed.
*   **`--sub <max_substitutions>`**: Maximum number of substitutions allowed.
*   **`--minimizer`**: Enables the minimizer-based seeding strategy, which can improve performance for large genomes.
*   **`--paired`**: Indicates that the input reads are paired-end. SRPRISM will expect two input files or a format that specifies paired reads.
*   **`--sra`**: Enables direct access to NCBI SRA archives. This requires the NCBI SRA toolkit to be installed and configured.

### Input File Formats

SRPRISM typically accepts:

*   **Reference Genome**: FASTA format (`.fasta`, `.fa`).
*   **Short Reads**: FASTQ format (`.fastq`, `.fq`, `.fastq.gz`, `.fq.gz`). Paired-end reads can be provided as two separate files or through specific SRA formats.

### Compilation and Installation

Refer to the `README.md` for detailed instructions on compiling SRPRISM for Linux and Windows.

*   **Linux Compilation**:
    ```bash
    git clone https://github.com/ncbi/SRPRISM
    cd SRPRISM/srprism
    make
    ```
    To enable NGS library support for SRA archives, uncomment `# export USE_SRA = 1` in the top-level Makefile.
*   **Windows Compilation**: Requires MS Visual Studio 2022 and Git Bash. Follow the instructions in the `windows/` directory of the repository.

### Expert Tips

*   **Multi-threading**: Always leverage multi-threading (`-t`) for faster alignments, especially with large datasets.
*   **Output Prefix**: Use the `-o` option to keep your output files organized, particularly when running multiple alignment jobs.
*   **Error Tolerance**: Carefully consider the `-e`, `--indel`, and `--sub` parameters based on your experimental goals. Too strict parameters might miss valid alignments, while too lenient ones can lead to false positives.
*   **Minimizer Strategy**: For very large reference genomes, enabling the `--minimizer` option can offer performance benefits.
*   **SRA Integration**: If working with data directly from NCBI SRA, ensure the SRA toolkit is correctly installed and use the `--sra` flag.

## Reference documentation
- [SRPRISM README](./references/github_com_ncbi_SRPRISM.md)