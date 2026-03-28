---
name: seqfu
description: SeqFu is a versatile toolkit for the manipulation, filtering, and statistical analysis of FASTA and FASTQ sequence files. Use when user asks to count sequences, calculate assembly statistics like N50, filter reads by length, reverse complement sequences, or manage paired-end files.
homepage: http://github.com/quadram-institute-bioscience/seqfu/
---

# seqfu

## Overview

SeqFu is a versatile toolkit designed for robust and reproducible manipulation of sequence files. It provides a unified interface for FASTA and FASTQ formats, supporting transparent decompression and standard input/output streams. Whether you are performing initial quality checks, filtering reads, or summarizing assembly metrics, SeqFu offers a faster, more memory-efficient alternative to traditional scripts. It is optimized for modern bioinformatics workflows, particularly those involving Illumina paired-end data and large-scale genomic datasets.

## Core CLI Patterns

### General Usage
Most SeqFu commands follow a standard syntax:
```bash
seqfu <command> [options] <input_files>
```
*   **Compressed Files**: SeqFu natively handles `.gz` files without needing `zcat`.
*   **Streams**: Use `-` to read from standard input.
*   **Unified Parsing**: Most tools accept both FASTA and FASTQ interchangeably.

### Essential Commands

#### 1. Sequence Statistics and Counting
*   **Quick Count**: Get the number of sequences in one or more files.
    ```bash
    seqfu count reads.fq.gz
    ```
*   **Assembly Stats (N50)**: Calculate N50, total length, and GC content.
    ```bash
    seqfu stats contigs.fasta
    ```

#### 2. Filtering and Manipulation
*   **Length Filtering**: Keep sequences within a specific size range.
    ```bash
    seqfu len -m 500 -M 1000 input.fasta > filtered.fasta
    ```
*   **Reverse Complement**: Generate the reverse complement of sequences.
    ```bash
    seqfu rc input.fasta
    ```
*   **Subsetting**: Extract the first or last N sequences.
    ```bash
    seqfu head -n 100 reads.fq
    seqfu tail -n 100 reads.fq
    ```

#### 3. Searching (Grep)
*   **Pattern Matching**: Search for DNA motifs or header strings.
    ```bash
    seqfu grep "GATTACA" reads.fq
    ```

#### 4. Paired-End Management
*   **Interleaving**: Combine R1 and R2 files into a single interleaved file.
    ```bash
    seqfu interleave reads_R1.fq reads_R2.fq > interleaved.fq
    ```
*   **Deinterleaving**: Split an interleaved file back into R1 and R2.
    ```bash
    seqfu deinterleave interleaved.fq -1 R1.fq -2 R2.fq
    ```

## Expert Tips

*   **Metadata Extraction**: Use `seqfu metadata` to quickly view information about the sequencing run or file properties.
*   **Tabulation**: Use `seqfu tabulate` to convert FASTX files into a tab-separated format, which is ideal for downstream processing with `awk` or `sed`.
*   **Memory Efficiency**: When working with massive datasets, prefer `seqfu` over general-purpose text tools like `grep` or `cat`, as SeqFu is specifically optimized for the multi-line nature of FASTX formats.
*   **Piping**: Combine tools for complex workflows:
    ```bash
    seqfu grep "ATG" input.fq | seqfu len -m 100 | seqfu stats
    ```



## Subcommands

| Command | Description |
|---------|-------------|
| bases | Print the DNA bases, and %GC content, in the input files |
| cat | Concatenate multiple FASTA or FASTQ files. |
| count | Count sequences in paired-end aware format |
| dei | interleave FASTQ files |
| derep | Dereplicate sequences based on their content. |
| fu-rotate | Rotate the sequences of one or more sequence files using    coordinates or motifs. |
| grep | Print sequences selected if they match patterns or contain oligonucleotides using regular expressions. |
| head | Select a number of sequences from the beginning of a file, allowing to select a fraction of the reads (for example to print 100 reads, selecting one every 10). |
| ilv | interleave FASTQ files |
| lanes | This tool supports up to 8 lanes of Illumina-formatted output files. Merged lane output files will be in an uncompressed format. |
| list | Print sequences that are present in a list file, which can contains leading ">" or "@" characters. Duplicated entries in the list will be ignored. |
| metadata | Prepare mapping files from directory containing FASTQ files |
| rc | Print the reverse complementary of sequences in files or sequences given as parameters. Can read FASTA/FASTQ also from STDIN, but not naked strings. |
| seqfu check | Check the integrity of FASTQ files, returns non zero   if an error occurs. Will print a table with a report. |
| sort | Sort sequences by size printing only unique sequences |
| stats | Print statistics about input files |
| tabulate | Convert FASTQ to TSV and viceversa. Single end is a 4 columns table (name, comment, seq, qual), paired end have 4 columns for the R1 and 4 columns for the R2. Paired end reads need to be supplied as interleaved. |
| tail | Print the last sequences of files |
| tofasta | Convert various sequence formats to FASTA format. |
| view | View a FASTA/FASTQ file for manual inspection, allowing to search for an oligonucleotide. |

## Reference documentation
- [SeqFu Home](./references/github_com_quadram-institute-bioscience_seqfu_wiki.md)
- [Design Guidelines](./references/github_com_quadram-institute-bioscience_seqfu_wiki_Design-guidelines.md)
- [SeqFu2 Introduction](./references/telatin_github_io_seqfu2_intro.md)