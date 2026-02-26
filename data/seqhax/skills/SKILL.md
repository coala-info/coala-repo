---
name: seqhax
description: Seqhax is a bioinformatics toolkit for fast sequence processing, paired-end read management, and variant file analysis. Use when user asks to interleave or validate paired-end reads, anonymize sequence headers, truncate sequences, or generate histograms for VCF metrics like allele frequency and depth.
homepage: https://github.com/kdmurray91/seqhax
---


# seqhax

## Overview

`seqhax` is a specialized toolkit designed for bioinformatics workflows that require fast, command-line sequence processing. It complements general-purpose tools like `seqtk` by providing unique features such as robust paired-end handling and VCF-specific histogram generation. It is ideal for cleaning up sequence headers, validating read pairs, and performing quick quality checks on variant files. The package provides two primary binaries: `seqhax` for sequence manipulation and `htshax` for HTS-specific (VCF/BCF) utilities.

## Core Command Usage

### Paired-End Management
One of the most powerful features of `seqhax` is its ability to handle inconsistent paired-end data.

*   **Interleaving Reads**: Use `seqhax pairs` to combine R1 and R2 files.
    *   **Strict Mode**: Replaces missing reads with a single 'N' to maintain sync.
    *   **Broken Mode**: Simply omits missing reads.
*   **Validation**: Use `seqhax pecheck` to verify that read IDs match between R1 and R2 files or within an interleaved file. This is a critical step before mapping if you suspect file corruption or sorting issues.

### Sequence Header and Content Manipulation
*   **Anonymization**: Use `seqhax anon` to rename sequences to a sequential number, which is useful for sharing data while stripping original metadata.
*   **Barcode Recovery**: Use `seqhax rebarcode` to move index sequences found in the FASTQ header to the beginning of the actual read sequence.
*   **Modification**: Use `seqhax preapp` to quickly prepend or append specific strings to every sequence ID in a file.
*   **Truncation**: Use `seqhax trunc` to shorten sequences to a fixed length.

### Statistics and Histograms
*   **Basic Stats**: Use `seqhax stats` for a quick summary of sequence counts and lengths.
*   **CLI Histograms**: Use `seqhax clihist` to generate a text-based histogram from any numerical data piped through stdin.
*   **VCF/BCF Analysis**: Use `htshax bcfhist` to generate histograms for variant metrics. Unlike `bcftools stats`, this tool specifically summarizes:
    *   Allele Frequency (AF)
    *   Missingness across samples (F_MISSING)
    *   Quality (QUAL)
    *   Depth (DP)

## Best Practices
*   **Piping**: Most `seqhax` commands are designed to work within Unix pipes. Use `-` to represent stdin where applicable.
*   **Help Flags**: Since subcommands have specific options, always check `seqhax [subcommand] -h` for the most up-to-date parameter list.
*   **Static Binaries**: If working in an environment without Conda, look for static binaries in the GitHub releases to avoid dependency issues with `zlib` or `htslib`.

## Reference documentation
- [Seqhax GitHub README](./references/github_com_kdm9_seqhax.md)
- [Bioconda Seqhax Overview](./references/anaconda_org_channels_bioconda_packages_seqhax_overview.md)