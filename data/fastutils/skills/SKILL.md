---
name: fastutils
description: fastutils is a high-performance toolkit for processing and manipulating genomic sequence data in FASTA and FASTQ formats. Use when user asks to generate sequence statistics, reformat or filter reads, interleave paired-end files, subsample datasets by coverage, extract subsequences, or perform reverse complement operations.
homepage: https://github.com/haghshenas/fastutils
---


# fastutils

## Overview
`fastutils` is a lightweight C++ toolkit designed for high-performance processing of genomic sequence data. It provides a suite of command-line utilities that handle common bioinformatics tasks such as quality control reporting, sequence transformation, and dataset downsampling. Use this skill to perform rapid operations on large FASTA/FASTQ files without the overhead of complex pipelines, especially when working with raw sequencing reads or reference genomes.

## Core Commands and Usage

### 1. Sequence Statistics and Lengths
Use these commands to assess the quality and composition of your data.
*   **General Stats**: `fastutils stat -i reads.fastq`
    *   Reports read count, total bases, and GC composition.
*   **Read Lengths**: `fastutils length -i reads.fastq`
    *   Outputs a tab-separated list of read IDs and their lengths.
    *   **Tip**: Use `-t` to include a running total of bases in a third column.

### 2. Reformatting and Filtering
The `format` command is the primary tool for file conversion and cleaning.
*   **Convert FASTQ to FASTA**: `fastutils format -i reads.fastq > reads.fasta`
*   **Wrap Lines**: Use `-w <int>` to set line width (e.g., `-w 60`). Use `-w 0` for no wrapping (single-line sequences).
*   **Length Filtering**: Use `-m <int>` for minimum length and `-M <int>` for maximum length.
*   **Header Manipulation**: 
    *   `-p <string>`: Prepend a prefix to read names.
    *   `-d`: Replace read names with a digital index (useful for anonymizing or shortening headers).

### 3. Paired-End Interleaving
Combine separate forward and reverse read files into a single interleaved file.
*   **Command**: `fastutils interleave -1 forward.fq -2 reverse.fq -q > interleaved.fq`
*   **Note**: The `-q` flag ensures the output remains in FASTQ format if the input allows.

### 4. Subsampling and Downsampling
Useful for creating smaller datasets for testing or normalizing coverage.
*   **By Coverage**: `fastutils subsample -i reads.fastq -d 25 -g 4.6m -r > subsampled.fastq`
    *   `-d`: Target depth (e.g., 25x).
    *   `-g`: Genome size (supports suffixes k, m, g).
    *   `-r`: Random selection (default is top-down).
    *   `-l`: Select the longest reads instead of random.

### 5. Sequence Extraction and Manipulation
*   **Subsequence Extraction**: `fastutils subseq -i ref.fa chr1:100-500`
    *   Extracts specific coordinates from a named entry.
*   **Reverse Complement**: `fastutils revcomp -i reads.fq`
    *   **Expert Tip**: Use `-l` to output the lexicographically smaller sequence between the original and the reverse complement (useful for canonical k-mer analysis).
*   **Scaffold Splitting**: `fastutils cutN -i scaffolds.fa > contigs.fa`
    *   Breaks sequences at 'N' bases to convert scaffolds into contigs.

## Common CLI Patterns

**Filtering and Reformatting Pipeline:**
```bash
# Extract reads longer than 1kb, wrap at 60bp, and add a sample prefix
fastutils format -i input.fastq -m 1000 -w 60 --prefix "SampleA_" > filtered.fasta
```

**Calculating Mean Read Length:**
```bash
# Combine with standard unix tools for quick metrics
fastutils length -i reads.fastq | datamash mean 1
```

**Extracting Contigs from a Specific Chromosome:**
```bash
# Pipe formatted output to grep to isolate a chromosome, then split at Ns
cat genome.fa | fastutils format | grep ">chrX" -A1 | fastutils cutN -i - > chrX.contigs.fa
```

## Reference documentation
- [fastutils GitHub Repository](./references/github_com_haghshenas_fastutils.md)
- [fastutils Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastutils_overview.md)