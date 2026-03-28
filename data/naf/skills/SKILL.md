---
name: naf
description: The Nucleotide Archival Format tool provides efficient, reference-free binary compression and decompression for FASTA and FASTQ biological sequences. Use when user asks to compress genomic data into NAF format, decompress NAF files, or perform partial extraction of sequences and headers.
homepage: https://github.com/KirillKryukov/naf
---


# naf

## Overview
The Nucleotide Archival Format (NAF) is a specialized binary format designed for the efficient storage of biological sequences. It excels in scenarios where storage space is limited or rapid data access is required. Unlike many other genomic compressors, NAF is reference-free, meaning it does not require a specific genome assembly to function. It supports FASTA and FASTQ formats, preserves IUPAC ambiguity codes, maintains sequence masking (case sensitivity), and handles quality scores. The toolset consists of two primary utilities: `ennaf` for encoding and `unnaf` for decoding.

## Core CLI Usage

### Compression (ennaf)
The encoder converts FASTA/FASTQ files into `.naf` archives.

*   **Basic Compression:**
    `ennaf input.fasta -o output.naf`
*   **Set Compression Level:**
    Use levels 1 (fastest) to 22 (most compact).
    `ennaf -22 input.fastq -o output.naf`
*   **Specify Sequence Type:**
    Explicitly setting the type improves performance and validation.
    `ennaf --dna input.fa -o output.naf`
    `ennaf --rna input.fa -o output.naf`
    `ennaf --protein input.fa -o output.naf`
*   **Text Mode:**
    Use for non-standard characters or general text sequences.
    `ennaf --text input.txt -o output.naf`

### Decompression (unnaf)
The decoder restores NAF files to their original format.

*   **Basic Decompression:**
    `unnaf input.naf -o output.fasta`
*   **Partial Decompression:**
    NAF allows decompressing only specific parts of the archive for increased speed.
    `unnaf --sequence input.naf` (Extracts only the sequences)
    `unnaf --names input.naf` (Extracts only the sequence headers)

## Expert Tips and Best Practices

*   **Prefer --dna/--rna over --text:** For nucleotide data, the `--dna` and `--rna` modes are significantly faster and more compact because they use a 4-bit representation before passing data to the Zstd engine.
*   **Piping for Pipelines:** NAF tools support Unix pipes, allowing them to be integrated into bioinformatics workflows without writing intermediate files to disk.
    `cat data.fa | ennaf --dna -o data.naf`
    `unnaf data.naf | some_analysis_tool`
*   **Handling Large Files:** For extremely large files, use the `--long` option with `ennaf` to enable Zstd's long-distance matching, which can further improve compression ratios on repetitive genomic data.
*   **Multi-file Archives:** While NAF is typically a single-file format, you can archive multiple files by using the `mumu.pl` script (included in the NAF distribution) to create a Multi-Multi-FASTA intermediate. Use the `.nafnaf` extension for these archives.
*   **Lossless Verification:** NAF is lossless by design. To verify integrity, you can compare the MD5 hash of the original FASTA/FASTQ with the output of `unnaf`.



## Subcommands

| Command | Description |
|---------|-------------|
| ennaf | ennaf |
| unnaf | Decompress NAF files |

## Reference documentation
- [Nucleotide Archival Format (NAF) Overview](./references/kirill-kryukov_com_study_naf.md)
- [NAF GitHub Repository](./references/github_com_KirillKryukov_naf.md)
- [Text vs DNA Mode Benchmark](./references/kirill-kryukov_com_study_naf_benchmark-text-vs-dna-Spur.html.md)