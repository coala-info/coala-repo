---
name: fastq_utils
description: fastq_utils is a suite of utilities for processing and manipulating FASTQ files, with a focus on scRNA-seq barcode extraction and read synchronization. Use when user asks to validate FASTQ integrity, filter reads by N-content, trim poly-A/T tails, synchronize paired-end files, or extract and transfer scRNA-seq barcodes to BAM tags.
homepage: https://github.com/nunofonseca/fastq_utils
---


# fastq_utils

## Overview
The `fastq_utils` suite provides a collection of Linux-based utilities optimized for handling large-scale sequencing data. While it offers standard manipulation tasks like counting reads and filtering by "N" content, its primary strength lies in its specialized scRNA-seq preprocessing capabilities. It allows users to extract barcodes (Cell, UMI, Sample) from FASTQ sequences, embed them into read names, and subsequently convert those read-name tags into standard BAM tags (CR, UM, BC) after alignment.

## Core CLI Patterns

### Validation and Information
Use `fastq_info` to verify file integrity and format.
*   **Standard check**: `fastq_info file1.fastq.gz`
*   **Paired-end check**: `fastq_info file_1.fastq.gz file_2.fastq.gz`
*   **Interleaved check**: `fastq_info file.fastq.gz pe`
*   **Performance Tip**: Use the `-r` flag to skip unique identifier checks, significantly reducing memory usage and execution time. Use `-s` if you know the paired files are already sorted identically.

### FASTQ Manipulation
*   **Synchronize Paired-End Files**: If your R1 and R2 files have become desynchronized due to independent filtering, use `fastq_filterpair` to restore order and extract singletons:
    `fastq_filterpair R1.fq.gz R2.fq.gz matched_R1.fq.gz matched_R2.fq.gz singletons.fq.gz`
*   **Filter by Uncalled Bases**: Discard reads with more than a specific percentage of 'N' bases:
    `fastq_filter_n -n 10 input.fq.gz > filtered.fq.gz` (Default is 0, meaning any 'N' discards the read).
*   **Poly-A/T Trimming**: Remove 3' poly-A or 5' poly-T stretches:
    `fastq_trim_poly_at --file in.fq.gz --outfile out.fq.gz --min_poly_at_len 10 --min_len 20`

### scRNA-seq Preprocessing Workflow
A common expert workflow involves moving barcodes from the sequence to the BAM tags to preserve information during alignment.

1.  **Extract Barcodes to Readnames**:
    Use `fastq_pre_barcodes` to move UMI/Cell sequences into the read header.
    ```bash
    fastq_pre_barcodes --read1 input.fq.gz --outfile1 tagged.fq.gz \
      --umi_read read1 --umi_offset 12 --umi_size 8 \
      --read1_offset 22 --read1_size -1
    ```
    *Note: This formats the readname as `@STAGS_CELL=[cell]_UMI=[umi]..._ETAGS_[ORIGINAL_NAME]`.*

2.  **Align tagged FASTQs**: Use your preferred aligner (e.g., STAR, BWA) to generate a BAM file.

3.  **Transfer Tags to BAM Fields**:
    Use `bam_add_tags` to convert the header strings into proper BAM tags (CR, UM, BC):
    `bam_add_tags --inbam aligned.bam --outbam final_tagged.bam`

4.  **Quantify**:
    Count unique UMIs using `bam_umi_count`.

## Expert Tips
*   **Memory Management**: For extremely large datasets, always prefer `fastq_info -r -s` to avoid memory exhaustion during validation.
*   **BAM Annotation**: Use the `bam_annotate.sh` script to quickly add GX (Gene) and TX (Transcript) tags to alignments using BED files, which is essential for downstream single-cell quantification.
*   **Piping**: Many utilities in this suite support standard streams, allowing you to chain operations without writing intermediate large FASTQ files to disk.

## Reference documentation
- [fastq_utils GitHub README](./references/github_com_nunofonseca_fastq_utils.md)
- [fastq_utils Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastq_utils_overview.md)