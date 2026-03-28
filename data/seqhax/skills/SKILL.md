---
name: seqhax
description: "seqhax is a toolkit for manipulating FASTA/FASTQ files and analyzing VCF/BCF data through specialized subcommands. Use when user asks to interleave read pairs, verify paired-end synchronization, rename sequence headers, convert file formats, or generate histograms for variant metrics and missingness."
homepage: https://github.com/kdmurray91/seqhax
---

# seqhax

## Overview

seqhax is a "seqtk-style" toolkit designed to provide specific sequence analysis features that are often missing from larger, more common bioinformatics suites. It consists of two main components: `seqhax` for general sequence file manipulation (FASTA/FASTQ) and `htshax` for handling HTS formats (VCF/BCF) via HTSlib. This skill helps navigate its subcommands for tasks like read pair management, sequence renaming, and variant filtering statistics.

## Command Usage and Best Practices

### Sequence Manipulation (seqhax)

The `seqhax` binary contains several subcommands for processing FASTA and FASTQ files.

*   **Paired-End Management**:
    *   Use `seqhax pairs` to interleave or de-interleave reads. It supports "Strict" interleaving (replacing missing reads with 'N') and "Broken paired" interleaving (removing missing reads).
    *   Use `seqhax pecheck` to verify that R1 and R2 files (or interleaved files) have matching read IDs. This is a critical quality control step before assembly or mapping.
*   **Sequence Renaming and Modification**:
    *   `anon`: Use this to replace complex headers with simple sequential numbers.
    *   `preapp`: Prepend or append specific strings to sequence IDs.
    *   `trunc`: Truncate sequences to a specific length.
*   **Filtering and Conversion**:
    *   `convert`: Quickly toggle between FASTA and FASTQ formats.
    *   `filter`: Extract specific reads based on criteria.
    *   `rebarcode`: Move index sequences from the header to the start of the actual read sequence.
*   **Utility and Stats**:
    *   `stats`: Generate basic summary statistics for sequence files.
    *   `randseq`: Generate random sequence data for testing pipelines.
    *   `clihist`: Generate a text-based histogram of input data from stdin.

### HTS Data Analysis (htshax)

The `htshax` binary focuses on VCF/BCF utilities that extend the capabilities of `bcftools`.

*   **Variant Histograms**:
    *   Use `htshax bcfhist` to calculate histograms for metrics like Quality (QUAL), Allele Frequency (ALLELE_FREQ), and Depth (DP).
    *   **Expert Tip**: Unlike `bcftools stats`, `htshax bcfhist` specifically summarizes **missingness** (`F_MISSING`) across samples, which is essential for determining filtering thresholds in population genetics.

## Common CLI Patterns

**Interleaving R1 and R2 files:**
```bash
seqhax pairs R1.fastq R2.fastq > interleaved.fastq
```

**Checking if paired files are synchronized:**
```bash
seqhax pecheck R1.fastq R2.fastq
```

**Adding a prefix to all sequence headers:**
```bash
seqhax preapp -p "SampleA_" input.fasta > output.fasta
```

**Analyzing VCF missingness:**
```bash
htshax bcfhist input.vcf.gz
```



## Subcommands

| Command | Description |
|---------|-------------|
| seqhax anon | Anonymize sequence headers in a file |
| seqhax convert | Convert sequence files to FASTA or FASTQ format |
| seqhax filter | Filter sequence files based on length and format options. |
| seqhax pair | Process and split paired-end sequence files in FASTA or FASTQ format. |

## Reference documentation
- [Seqhax GitHub Repository](./references/github_com_kdm9_seqhax.md)