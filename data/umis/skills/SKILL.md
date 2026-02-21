---
name: umis
description: The `umis` toolkit is designed to handle the specific requirements of RNA-tag sequencing, where transcripts are identified by both a cellular barcode (CB) and a Unique Molecular Identifier (UMI).
homepage: https://github.com/vals/umis
---

# umis

## Overview

The `umis` toolkit is designed to handle the specific requirements of RNA-tag sequencing, where transcripts are identified by both a cellular barcode (CB) and a Unique Molecular Identifier (UMI). It provides a streamlined command-line interface to transform raw FASTQ files into a standardized format, filter out noisy or low-abundance barcodes, and ultimately generate count matrices from aligned SAM/BAM files. It is particularly effective when used in conjunction with pseudo-aligners like Kallisto or RapMap.

## Core Workflow and CLI Patterns

### 1. Read Transformation
The first step extracts non-biological information (CB and UMI) from the reads and moves them into the read header.

*   **Command**: `umis fastqtransform`
*   **Requirement**: A JSON "transform" file containing Python-flavored regular expressions to define the structure of your reads.
*   **Pattern**:
    ```bash
    umis fastqtransform --transform transform.json read1.fastq read2.fastq > transformed.fastq
    ```
*   **Tip**: Ensure your regex captures groups named `cell` and `umi` to match the expected header format: `@ID:CELL_GGTCCA:UMI_CCCT`.

### 2. Barcode Filtering and Histograms
After transformation, you must identify which cellular barcodes represent real cells versus background noise.

*   **Filter Barcodes**: Use `umis cb_filter` to drop reads with unknown or low-quality barcodes.
    *   Use `--nedit` to allow for 1 or 2 mismatches when matching against a known whitelist.
*   **Generate Histogram**: Use `umis cb_histogram` to create a frequency distribution of barcodes.
    ```bash
    umis cb_histogram transformed.fastq > cb_histogram.txt
    ```
*   **Expert Tip**: Use the histogram output to determine a count cut-off for high-abundance barcodes before proceeding to quantitation.

### 3. UMI Counting
Once reads are mapped (using Kallisto, RapMap, or STAR), use `tagcount` to collapse UMIs and generate the final counts.

*   **Standard Counting**:
    ```bash
    umis tagcount --cb_filter barcodes.txt input.bam > counts.txt
    ```
*   **BAM Tag Parsing**: If your aligner or pre-processor has already placed barcodes in BAM tags:
    *   Use `--parse_tags` to extract CB and UMI from the `CR` and `UM` tags.
    *   Use `--gene_tags` and `--GX` if you are mapping to a genome and need to extract gene names from the `GX` tag.
*   **Sparse Matrices**: For large datasets, use `umis sparse` to generate output in a memory-efficient sparse matrix format.

### 4. Kallisto Integration
If using Kallisto for principled UMI quantification, `umis` can reformat files to meet Kallisto's specific requirements (one FASTQ per cell barcode and a separate UMI file).

*   **Command**: `umis kallisto`

## Best Practices

*   **Header Consistency**: `umis` relies heavily on the read header format established during `fastqtransform`. If you use external tools for mapping, ensure they do not strip or alter the `@ID:CELL_XXX:UMI_YYY` string.
*   **Memory Management**: When working with millions of cells, always prefer the `sparse` subcommand or the `--parse_tags` option to reduce the overhead of string manipulation in Python.
*   **Demultiplexing**: If you need to split your data into individual files per cell after filtering, use the `umis demultiplex_cells` command.

## Reference documentation
- [GitHub Repository - vals/umis](./references/github_com_vals_umis.md)
- [Bioconda - umis Overview](./references/anaconda_org_channels_bioconda_packages_umis_overview.md)