---
name: bamhash
description: "BamHash generates order-independent checksums for sequencing data to verify data integrity across different file formats and pipeline stages. Use when user asks to calculate checksums for BAM, CRAM, FASTQ, or FASTA files, detect data corruption, or verify that read data remains consistent after alignment and processing."
homepage: https://github.com/DecodeGenetics/BamHash
---


# bamhash

## Overview

BamHash provides a robust method for generating order-independent checksums for high-throughput sequencing data. By computing hash values for individual reads (incorporating read names, sequences, and quality scores) and summing them, the tool produces a final value that remains consistent even if the reads are reordered during alignment or processing. This allows bioinformaticians to detect data corruption or loss across different stages of a pipeline.

## Common CLI Patterns

### Hashing BAM and CRAM Files
Use `bamhash_checksum_bam` for alignment files. By default, it assumes paired-end data.

*   **Standard BAM check:**
    `bamhash_checksum_bam input.bam`
*   **CRAM check (requires reference):**
    `bamhash_checksum_bam -r reference.fasta input.cram`
*   **Single-end BAM:**
    `bamhash_checksum_bam --no-paired input.bam`

### Hashing FASTQ and FASTA Files
*   **Paired-end FASTQ:**
    `bamhash_checksum_fastq read_1.fastq.gz read_2.fastq.gz`
*   **Single-end FASTQ:**
    `bamhash_checksum_fastq --no-paired input.fastq.gz`
*   **FASTA (assumes single-end, no quality):**
    `bamhash_checksum_fasta input.fasta`

## Expert Tips and Best Practices

### Handling Pipeline Modifications
If your bioinformatics pipeline modifies specific parts of the read data, use these flags to ensure the checksums still match:
*   **Quality Score Changes:** If you have performed Base Quality Score Recalibration (BQSR) or quality binning, use `--no-quality` on both the BAM and FASTQ commands to compare only the sequences and names.
*   **Read Name Mangling:** If the aligner or a script alters read names, use the `--no-name` flag to hash only the sequences and quality values.
*   **Comparing FASTA to BAM:** To compare a FASTA file (which lacks quality data) to a BAM file, you must run the BAM check with both `--no-paired` and `--no-quality`.

### Troubleshooting Mismatches
If two files that should be identical produce different hashes:
1.  **Debug Mode:** Use the `-d` flag to print the information and hash value for every individual read. This helps identify exactly which read is causing the discrepancy.
2.  **Validation:** Ensure that `bamhash_checksum_fastq` is provided with pairs in the correct order (R1 then R2). The tool will exit with a failure if read names between the two FASTQ files do not match.
3.  **Secondary Alignments:** Note that the tool is designed to handle secondary alignments properly to avoid double-counting reads that appear multiple times in a BAM file.



## Subcommands

| Command | Description |
|---------|-------------|
| bamhash_checksum_bam | Checksum of a sam, bam or cram file |
| bamhash_checksum_fasta | Checksum of a set of fasta files |
| bamhash_checksum_fastq | Program for checksum of sequence reads. |

## Reference documentation
- [BamHash Main Repository and Usage](./references/github_com_DecodeGenetics_BamHash.md)