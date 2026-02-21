---
name: bedparse
description: bedparse is a specialized CLI tool and Python library designed to simplify the manipulation of BED files, particularly those representing transcript structures (BED12).
homepage: https://github.com/tleonardi/bedparse
---

# bedparse

## Overview
bedparse is a specialized CLI tool and Python library designed to simplify the manipulation of BED files, particularly those representing transcript structures (BED12). It is highly effective for bioinformaticians who need to derive specific genomic coordinates—like promoter regions or coding sequences—from existing annotations without writing custom parsing scripts.

## Common CLI Patterns

### Feature Extraction
Extract specific regions from a BED12 file (which contains blocks for exons).

*   **Promoters**: Generate promoter regions based on the Transcription Start Site (TSS).
    ```bash
    bedparse promoter --up 1000 --down 200 input.bed > promoters.bed
    ```
*   **Introns**: Extract intronic coordinates.
    ```bash
    bedparse introns input.bed > introns.bed
    ```
*   **CDS**: Extract only the coding sequences (requires valid thickStart/thickEnd fields).
    ```bash
    bedparse cds input.bed > cds.bed
    ```
*   **UTRs**: Extract 5' or 3' Untranslated Regions.
    ```bash
    bedparse 5pUTR input.bed > 5pUTR.bed
    bedparse 3pUTR input.bed > 3pUTR.bed
    ```

### Format Conversion and Validation
*   **GTF to BED**: Convert transcript annotations from GTF/GFF format to BED12. This tool is specifically optimized for Ensembl/Gencode GTF files and Pinfish GFF2.
    ```bash
    bedparse gtf2bed input.gtf > output.bed
    ```
*   **BED12 to BED6**: Flatten complex transcript structures into simple 6-column BED files (one line per exon/block).
    ```bash
    bedparse bed12tobed6 input.bed12 > output.bed6
    ```
*   **Chromosome Renaming**: Quickly switch between UCSC (e.g., "chr1") and Ensembl (e.g., "1") naming conventions.
    ```bash
    bedparse convertChr --target ucsc input.bed > ucsc_names.bed
    ```
*   **Validation**: Ensure a file strictly adheres to the BED format specifications.
    ```bash
    bedparse validateFormat input.bed
    ```

### Filtering and Joining
*   **Filter**: Filter transcripts based on specific criteria or annotation matches.
    ```bash
    bedparse filter --annotation filter_list.txt input.bed > filtered.bed
    ```
*   **Join**: Merge two annotation files based on transcript names.
    ```bash
    bedparse join file1.bed file2.bed > joined.bed
    ```

## Expert Tips
*   **Help Access**: Use `bedparse <subcommand> --help` to see specific arguments for feature extraction, such as defining upstream/downstream distances for promoters.
*   **Strand Awareness**: bedparse is strand-aware; when extracting promoters or UTRs, it correctly identifies the TSS based on the strand column (+/-).
*   **Piping**: bedparse supports standard streams, allowing you to chain operations (e.g., `bedparse gtf2bed in.gtf | bedparse promoter --up 500 > out.bed`).

## Reference documentation
- [bedparse GitHub Repository](./references/github_com_tleonardi_bedparse.md)
- [bedparse Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bedparse_overview.md)