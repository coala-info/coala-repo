---
name: fastqtk
description: fastqtk is a high-efficiency utility for manipulating, trimming, and generating statistics for FASTQ and FASTA files. Use when user asks to interleave or deinterleave paired-end reads, count reads, calculate length statistics, trim sequences, or convert between genomic file formats.
homepage: https://github.com/ndaniel/fastqtk
metadata:
  docker_image: "quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0"
---

# fastqtk

## Overview
The `fastqtk` tool is a C-based utility designed for high-efficiency manipulation of FASTQ and FASTA files. It is particularly useful in bioinformatics pipelines for handling paired-end data (interleaving/deinterleaving), generating quick summary statistics on read lengths, and performing various trimming operations (5', 3', and poly-tails). Its design emphasizes speed and low memory overhead, making it suitable for processing large-scale genomic datasets.

## Command Reference

### Paired-End Management
*   **Interleave**: Combine two separate R1 and R2 files into a single interleaved file.
    `fastqtk interleave reads1.fq reads2.fq out.fq`
*   **Deinterleave**: Split an interleaved file back into R1 and R2.
    `fastqtk deinterleave interleaved.fq r1.fq r2.fq`
*   **Drop Single-Ends**: Remove unpaired reads from an interleaved file to ensure all reads have a partner.
    `fastqtk drop-se interleaved.fq cleaned.fq`

### Statistics and Counting
*   **Count Reads**: Quickly get the total number of reads.
    `fastqtk count reads.fq count.txt`
*   **Length Statistics**: Generate summary statistics for read lengths.
    `fastqtk lengths reads.fq lengths.txt`
*   **Combined Stats**: Get both count and length stats in one pass.
    `fastqtk count-lengths reads.fq count.txt lengths.txt`

### Trimming and Filtering
*   **Fixed Trimming**: Remove a specific number of bases from either end.
    `fastqtk trim-5 10 input.fq output.fq` (Removes 10bp from start)
    `fastqtk trim-3 10 input.fq output.fq` (Removes 10bp from end)
*   **Retention**: Keep only a specific number of bases and discard the rest.
    `fastqtk retain-5 70 input.fq output.fq` (Keeps first 70bp)
*   **Poly-Tail Trimming**: Remove repetitive tails (A, C, G, T, or N).
    `fastqtk trim-poly A 15 input.fq output.fq` (Trims poly-A tails ≥ 15bp)
*   **Length Filtering**: Discard reads shorter than a threshold.
    `fastqtk drop-short 30 input.fq output.fq`

### Format Conversion and Sequence Modification
*   **FASTA/FASTQ Conversion**:
    `fastqtk fq2fa input.fq output.fa`
    `fastqtk fa2fq input.fa output.fq`
*   **Tabular Conversion**: Convert to 4-column (SE) or 8-column (PE) tab-delimited text for easy parsing with `awk` or `sed`.
    `fastqtk tab-4 input.fq output.txt`
    `fastqtk tab-8 interleaved.fq output.txt`
*   **Reverse Complement**: Generate the reverse complement of all reads.
    `fastqtk rev-com input.fq output.fq`
*   **N-Masking**: Replace all 'N' characters with 'A'.
    `fastqtk NtoA input.fq output.fq`

## Expert Tips and Best Practices
*   **Streaming with Pipes**: Use `-` as a filename to read from `stdin` or write to `stdout`. This is essential for gzipped files.
    `zcat reads.fq.gz | fastqtk count - count.txt`
    `fastqtk interleave r1.fq r2.fq - | gzip > interleaved.fq.gz`
*   **ID Compression**: If storage is a concern and unique descriptive headers aren't required, use `compress-id` to replace headers with a minimal numeric counter.
    `fastqtk compress-id 200000000 input.fq output.fq`
*   **Cleaning IDs**: Use `trim-id` to remove everything after the first space in the read header, which often resolves compatibility issues with older bioinformatics tools.
*   **Poly-N Trimming**: Always run `trim-poly N 1` on raw data to clean up leading or trailing ambiguous calls that can interfere with sensitive alignments.



## Subcommands

| Command | Description |
|---------|-------------|
| fastqtk NtoA | It replaces all the As from reads sequences with As in a FASTQ file. |
| fastqtk compress-id | It does lossy compression on the reads ids from a FASTQ file. |
| fastqtk count | It provides the total number of reads from an input FASTQ file and outputs it to a text file. |
| fastqtk count-lengths | It provides total number of reads and a summary statistics regarding the lengths of the reads from an input FASTQ file and outputs it to a text file. |
| fastqtk deinterleave | It splits an interleaved input FASTQ file into two paired-end FASTQ files. |
| fastqtk detab | Converts a 4 or 8 columns text tab-delimited file into a FASTQ file. |
| fastqtk drop-se | It drops the unparied reads from an interleaved FASTQ file. |
| fastqtk drop-short | It drops the reads that have the sequences stricly shorter than N. N is a non-zero positive integer. |
| fastqtk fa2fq | Converts a FASTA file to a FASTQ file. |
| fastqtk fq2fa | It a FASTQ file to FASTA file. |
| fastqtk interleave | It interleaves two input paired-end FASTQ files into one output FASTQ file. |
| fastqtk lengths | It provides a summary statistics regarding the lengths of the reads from an input FASTQ file and outputs it to a text file. The output text file contains the unique lengths of the reads found in the input file, which are sorted in descending order. |
| fastqtk retain-3 | It retains the last N nucleotides from 3' end of the reads from a FASTQ file. N is a non-zero positive integer. |
| fastqtk retain-5 | It retains the first N nucleotides from 5' end of the reads from a FASTQ file. N is a non-zero positive integer. |
| fastqtk rev-com | It reverse complements all the reads from a FASTQ file. |
| fastqtk tab-4 | It converts a FASTQ file into a tab-delimited text file with four columns. |
| fastqtk tab-8 | It converts an interleaved paired-end FASTQ file into a tab-delimited text file with 8 columns. |
| fastqtk trim-3 | It trims N nucleotides from 3' end of the reads from a FASTQ file. N is a non-zero positive integer. |
| fastqtk trim-5 | It trims N nucleotides from 5' end of the reads from a FASTQ file. N is a non-zero positive integer. |
| fastqtk trim-id | It retains the beginning part of the reads ids all the way to the first blank space or newline. Basically the reads ids are truncated after the first blank space if they have one. Also the trims ids for the quality sequences (every third line is changed to +). |
| fastqtk trim-poly | It trims poly-A/C/G/T/N tails at both ends of the reads sequences from a FASTQ file. For redirecting to STDOUT/STDIN use - instead of file name. |

## Reference documentation
- [fastqtk README](./references/github_com_ndaniel_fastqtk_blob_master_README.md)
- [fastqtk Source Code (fastqtk.c)](./references/github_com_ndaniel_fastqtk_blob_master_fastqtk.c.md)
- [fastqtk Test Suite](./references/github_com_ndaniel_fastqtk_blob_master_test_debug.sh.md)