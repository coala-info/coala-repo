---
name: bedparse
description: bedparse is a Python-based tool designed for the processing and feature extraction of Browser Extensible Data (BED) files. Use when user asks to extract promoters, introns, or coding sequences from transcript models, convert between GTF and BED formats, rename chromosomes, or filter and join BED annotations.
homepage: https://github.com/tleonardi/bedparse
---

# bedparse

## Overview

`bedparse` is a Python-based CLI tool and library designed to simplify the processing of Browser Extensible Data (BED) files. While simple genomic arithmetic can often be done with general-purpose tools like `awk`, `bedparse` provides a robust, strand-aware alternative for complex transcript-level operations. It is particularly useful for bioinformaticians working with transcript models (BED12) who need to extract specific sub-features like promoters, introns, or coding sequences (CDS) while ensuring the resulting files maintain valid BED formatting and coordinate integrity.

## Core Workflows and CLI Patterns

### Feature Extraction
Extract specific genomic regions from transcript models. `bedparse` automatically handles strand orientation and recomputes block sizes/starts for BED12 outputs.

*   **Promoters**: Define a window around the Transcription Start Site (TSS).
    ```bash
    bedparse promoter --up 1000 --down 500 input.bed > promoters.bed
    ```
    *Tip: Use `--unstranded` if you want to ignore strand and always use the start coordinate (column 2).*

*   **Introns**: Extract the gaps between exons as new BED records.
    ```bash
    bedparse introns input.bed > introns.bed
    ```

*   **Coding Sequences (CDS)**: Extract only the "thick" portion of a BED record.
    ```bash
    bedparse cds input.bed > cds.bed
    ```

*   **UTRs**: Extract 5' or 3' Untranslated Regions.
    ```bash
    bedparse 5pUTR input.bed > 5prime_utr.bed
    bedparse 3pUTR input.bed > 3prime_utr.bed
    ```

### Format Conversion
*   **GTF to BED12**: Convert Ensembl/Gencode GTF files to BED12.
    ```bash
    bedparse gtf2bed --extraFields gene_id,gene_name input.gtf > output.bed
    ```
*   **BED12 to BED6**: Explode multi-exon transcripts into individual exon records.
    ```bash
    bedparse bed12tobed6 --appendExN input.bed > exons.bed
    ```
*   **Chromosome Renaming**: Convert between UCSC (chr1) and Ensembl (1) naming conventions. Supports `hg38` and `mm10`.
    ```bash
    bedparse convertChr --assembly hg38 --target ens input.bed > ensembl_names.bed
    ```

### Filtering and Joining
*   **Filter by Annotation**: Subset a BED file based on a list of names in a text file.
    ```bash
    bedparse filter --annotation list.txt --column 1 input.bed > filtered.bed
    ```
*   **Join Annotations**: Append extra columns from a metadata file to a BED file using column 4 as the key.
    ```bash
    bedparse join --annotation metadata.tsv --column 1 input.bed > joined.bed
    ```

## Expert Tips and Best Practices

1.  **Validation First**: Before running complex extractions, use `bedparse validateFormat input.bed` to ensure the file adheres to BED specifications. This prevents downstream errors in coordinate math.
2.  **Strand Awareness**: By default, `bedparse` is strand-aware. For a transcript on the negative strand, the "start" (TSS) is the higher coordinate (column 3). Always verify your strand column (column 6) is populated correctly.
3.  **Non-Coding Transcripts**: Commands like `cds`, `3pUTR`, and `5pUTR` will skip records where `thickStart` equals `thickEnd` (non-coding).
4.  **Piping**: `bedparse` reads from stdin if no file is provided, making it ideal for unix pipes:
    ```bash
    cat input.bed | bedparse promoter --up 200 | bedparse convertChr --assembly mm10 --target ucsc
    ```
5.  **Python API**: For custom scripts, use the `bedline` class:
    ```python
    from bedparse import bedline
    bl = bedline(['chr1', 100, 500, 'Tx1', '0', '+'])
    prom = bl.promoter(up=200, down=50)
    prom.print()
    ```



## Subcommands

| Command | Description |
|---------|-------------|
| bedparse | A tool for parsing and manipulating BED files, with various sub-commands for specific operations. |
| bedparse | bedparse: error: argument sub-command: invalid choice: '5putr' (choose from '3pUTR', '5pUTR', 'cds', 'promoter', 'introns', 'filter', 'join', 'gtf2bed', 'bed12tobed6', 'convertChr', 'validateFormat') |
| bedparse | bedparse: error: argument sub-command: invalid choice: 'convertchr' (choose from '3pUTR', '5pUTR', 'cds', 'promoter', 'introns', 'filter', 'join', 'gtf2bed', 'bed12tobed6', 'convertChr', 'validateFormat') |
| bedparse | bedparse: error: argument sub-command: invalid choice: 'validateformat' (choose from '3pUTR', '5pUTR', 'cds', 'promoter', 'introns', 'filter', 'join', 'gtf2bed', 'bed12tobed6', 'convertChr', 'validateFormat') |
| bedparse bed12tobed6 | Convert the BED12 format into BED6 by reporting a separate line for each block of the original record. |
| bedparse filter | Filters a BED file based on an annotation. BED entries with a name (i.e. col4) that appears in the specified column of the annotation are printed to stdout. For efficiency reasons this command doesn't perform BED validation. |
| bedparse gtf2bed | Converts a GTF file to BED12 format. This tool supports the Ensembl GTF format, which uses features of type 'transcript' (field 3) to define transcripts. In case the GTF file defines transcripts with a different feature type, it is possible to provide the feature name from the command line. If the GTF file also annotates 'CDS' 'start_codon' or 'stop_codon' these are used to annotate the thickStart and thickEnd in the BED file. |
| bedparse_cds | Report the CDS of each coding transcript (i.e. transcripts with distinct values of thickStart and thickEnd). Transcripts without CDS are not reported. |
| bedparse_introns | Report BED12 lines corresponding to the introns of each transcript. Unspliced transcripts are not reported. |
| bedparse_join | Adds the content of an annotation file to a BED file as extra columns. The two files are joined by matching the BED Name field (column 4) with a user-specified field of the annotation file. |
| bedparse_promoter | Report the promoter of each transcript, defined as a fixed interval around its start. |

## Reference documentation
- [Bedparse Usage Guide](./references/bedparse_readthedocs_io_en_stable_Usage.html.md)
- [Bedparse Tutorial](./references/bedparse_readthedocs_io_en_stable_Tutorial.html.md)
- [Bedline API Reference](./references/bedparse_readthedocs_io_en_stable_bedparse.bedline.html.md)