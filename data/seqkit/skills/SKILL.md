---
name: seqkit
description: SeqKit is a high-performance command-line toolkit for the rapid manipulation and analysis of FASTA and FASTQ files. Use when user asks to generate sequence statistics, filter by length, convert file formats, extract subsequences, or sample and split genomic datasets.
homepage: https://github.com/shenwei356/seqkit
metadata:
  docker_image: "quay.io/biocontainers/seqkit:2.12.0--he881be0_1"
---

# seqkit

## Overview

SeqKit is a high-performance, cross-platform command-line toolkit designed for the rapid manipulation of FASTA and FASTQ files. It provides a comprehensive suite of subcommands that allow for seamless parsing of both formats, including support for various compression types (gzip, xz, zstd, bzip2, lz4). SeqKit is particularly useful for bioinformaticians needing to perform "one-liner" operations on large genomic datasets, such as extracting subsequences, renaming headers via regular expressions, or generating reproducible random samples of sequence data.

## Core CLI Patterns and Best Practices

### 1. Sequence Statistics and Validation
Use `stats` for a quick overview of your data.
*   **Basic stats:** `seqkit stats sequences.fasta`
*   **Tabular output with GC content:** `seqkit stats -T -G sequences.fasta`
*   **Multi-threaded processing:** Use `-j` (e.g., `-j 4`) to speed up statistics on large files.

### 2. Transformation and Filtering
The `seq` command is the primary tool for modifying sequence content.
*   **Filter by length:** `seqkit seq -m 100 input.fasta` (keeps sequences ≥ 100bp).
*   **Convert FASTQ to FASTA:** `seqkit seq -a input.fastq -o output.fasta`.
*   **Remove gaps:** `seqkit seq -g input.fasta`.
*   **Reverse complement:** `seqkit seq -r -p input.fasta`.

### 3. Searching and Subsetting
*   **Grep by ID/Pattern:** `seqkit grep -p "ID_001" input.fasta`.
*   **Grep using a file of IDs:** `seqkit grep -f id_list.txt input.fasta`.
*   **Extract subsequences by region:** `seqkit subseq -r 1:100 input.fasta` (extracts first 100 bases).
*   **Locate motifs:** `seqkit locate -p "TATA" input.fasta` (finds positions of the TATA box).

### 4. File Manipulation
*   **Splitting files:** Use `split2` for better performance on large files.
    *   `seqkit split2 -s 10000 input.fastq` (splits into files of 10,000 sequences each).
*   **Sampling:** Use `sample2` for improved random sampling.
    *   `seqkit sample2 -p 0.1 input.fastq` (samples 10% of the records).
*   **Shuffling:** `seqkit shuffle input.fasta` (randomizes record order). Use `-r` for non-deterministic results.

### 5. Format Conversion
*   **FASTA/Q to Tabular:** `seqkit fx2tab input.fasta > output.tsv`.
*   **Tabular to FASTA/Q:** `seqkit tab2fx input.tsv > output.fasta`.
*   **Useful for Unix tools:** Converting to tabular allows you to use `awk`, `cut`, and `sort` on sequence data easily.

## Expert Tips

*   **Piping:** SeqKit is designed for pipes. Always prefer `seqkit command1 | seqkit command2` to avoid writing large intermediate files.
*   **Compression:** SeqKit automatically detects compression based on file extensions. You can pipe gzipped data directly: `zcat data.fastq.gz | seqkit stats`.
*   **Header Manipulation:** Use `replace` with regular expressions to clean up complex headers.
    *   Example: `seqkit replace -p "\s.+" -r "" input.fasta` (removes everything after the first space in the header).
*   **Circular Genomes:** Use `restart` to change the starting position of a circular sequence.
*   **Memory Management:** For extremely large files, commands like `split2` and `sample2` are optimized to use less memory than their predecessors.



## Subcommands

| Command | Description |
|---------|-------------|
| seqkit amplicon | extract amplicon (or specific region around it) via primer(s). |
| seqkit bam | monitoring and online histograms of BAM record features |
| seqkit common | find common/shared sequences of multiple files by id/name/sequence |
| seqkit concat | concatenate sequences with same ID from multiple files |
| seqkit convert | convert FASTQ quality encoding between Sanger, Solexa and Illumina |
| seqkit duplicate | duplicate sequences N times |
| seqkit fa2fq | retrieve corresponding FASTQ records by a FASTA file |
| seqkit head | print the first N FASTA/Q records, or leading records whose total length >= L |
| seqkit locate | locate subsequences/motifs, mismatch allowed |
| seqkit merge-slides | merge sliding windows generated from seqkit sliding |
| seqkit pair | match up paired-end reads from two fastq files |
| seqkit restart | reset start position for circular genome |
| seqkit sample | sample sequences by number or proportion. |
| seqkit sana | sanitize broken single line FASTQ files Sana is a resilient FASTQ/FASTA parser. Unlike many parsers, it won't stop at the first error. Instead, it skips malformed records and continues processing the file. |
| seqkit shuffle | shuffle sequences. |
| seqkit split | split sequences into files by name ID, subsequence of given region, part size or number of parts. |
| seqkit sum | compute message digest for all sequences in FASTA/Q files |
| seqkit translate | translate DNA/RNA to protein sequence (supporting ambiguous bases) |
| seqkit_faidx | create the FASTA index file and extract subsequences |
| seqkit_fish | look for short sequences in larger sequences using local alignment |
| seqkit_fq2fa | convert FASTQ to FASTA |
| seqkit_fx2tab | convert FASTA/Q to tabular format, and provide various information, like sequence length, GC content/GC skew. |
| seqkit_grep | search sequences by ID/name/sequence/sequence motifs, mismatch allowed |
| seqkit_head-genome | print sequences of the first genome with common prefixes in name |
| seqkit_mutate | edit sequence (point mutation, insertion, deletion) |
| seqkit_range | print FASTA/Q records in a range (start:end) |
| seqkit_rename | Rename duplicated IDs |
| seqkit_replace | replace name/sequence by regular expression. |
| seqkit_rmdup | remove duplicated sequences by ID/name/sequence |
| seqkit_scat | real time recursive concatenation and streaming of fastx files |
| seqkit_seq | transform sequences (extract ID, filter by length, remove gaps, reverse complement...) |
| seqkit_sliding | extract subsequences in sliding windows |
| seqkit_sort | sort sequences by id/name/sequence/length. |
| seqkit_split2 | split sequences into files by part size or number of parts |
| seqkit_stats | simple statistics of FASTA/Q files |
| seqkit_subseq | get subsequences by region/gtf/bed, including flanking sequences. |
| seqkit_tab2fx | convert tabular format (first two/three columns) to FASTA/Q format |
| seqkit_watch | monitoring and online histograms of sequence features |

## Reference documentation

- [SeqKit GitHub Repository](./references/github_com_shenwei356_seqkit.md)
- [SeqKit README](./references/github_com_shenwei356_seqkit_blob_master_README.md)
- [SeqKit Changelog](./references/github_com_shenwei356_seqkit_blob_master_CHANGELOG.md)