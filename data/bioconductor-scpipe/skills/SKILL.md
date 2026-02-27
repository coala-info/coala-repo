---
name: bioconductor-scpipe
description: scPipe is an R package for preprocessing single-cell RNA-seq and ATAC-seq data from raw FASTQ files to a SingleCellExperiment object. Use when user asks to trim barcodes, align reads, perform quality control, or generate gene and peak count matrices for single-cell sequencing experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/scPipe.html
---


# bioconductor-scpipe

## Overview

`scPipe` is a versatile R package for the preprocessing of single-cell sequencing data. While originally designed for 3' end scRNA-seq (supporting both UMI and non-UMI protocols like CEL-seq2, Drop-seq, and 10x Chromium), it includes a dedicated module for scATAC-seq. The package handles the transition from raw FASTQ files to a structured `SingleCellExperiment` object, incorporating barcode processing, alignment (via `Rsubread`), and rigorous quality control.

## Core Workflows

### 1. scRNA-seq Preprocessing
The scRNA-seq workflow focuses on transcript counting and UMI deduplication.

*   **Reformatting**: Use `sc_trim_barcode` to move barcodes/UMIs from the sequence to the read header.
    ```r
    # read_structure defines positions for barcode (bs/bl) and UMI (us/ul)
    sc_trim_barcode(output_fastq, fq_R1, fq_R2, 
                    read_structure = list(bs1=-1, bl1=0, bs2=6, bl2=8, us=0, ul=6))
    ```
*   **Alignment & Mapping**: Align using `Rsubread` and map reads to exons.
    ```r
    sc_exon_mapping(in_bam, out_bam, ann_filename)
    ```
*   **Counting**: Demultiplex by barcode and generate the gene count matrix.
    ```r
    sc_demultiplex(in_bam, data_dir, barcode_anno, has_UMI = TRUE)
    sc_gene_counting(data_dir, barcode_anno)
    ```

### 2. scATAC-seq Preprocessing
The scATAC-seq module handles the specific requirements of chromatin accessibility data, such as fragment file generation and peak calling.

*   **Barcode Trimming**: `sc_atac_trim_barcode` handles FASTQ or CSV barcode inputs.
*   **Alignment**: `sc_aligning` wraps the alignment process for ATAC-specific needs.
*   **Tagging & Fragments**:
    ```r
    # Add CB (Cell Barcode) tags to BAM
    sc_atac_bam_tagging(inbam, output_folder, bam_tags = list(bc="CB", mb="OX"))
    # Create fragment file (BED format)
    sc_atac_create_fragments(inbam, output_folder)
    ```
*   **Feature Counting**: Assign fragments to peaks or genome bins.
    ```r
    sc_atac_feature_counting(fragment_file, feature_input, feature_type = "peak", organism = "hg38")
    ```

### 3. Quality Control and SCE Creation
After counting, `scPipe` provides tools to visualize data quality and filter outliers.

*   **Object Creation**: Use `create_sce_by_dir` (RNA) or `sc_atac_create_sce` (ATAC) to load results into a `SingleCellExperiment` object.
*   **Outlier Detection**:
    ```r
    sce <- calculate_QC_metrics(sce)
    sce <- detect_outlier(sce, type = "both", conf = 0.99)
    sce <- remove_outliers(sce)
    ```
*   **Visualization**:
    *   `plot_demultiplex(sce)`: Check barcode matching success.
    *   `plot_mapping(sce)`: Visualize alignment distribution (exon, intron, etc.).
    *   `plot_UMI_dup(sce)`: Assess PCR duplication rates.

## Tips for Success

*   **Read Convention**: In `scPipe`, `read1` is always the read containing the transcript/genomic sequence (usually the longer read), regardless of the sequencer's R1/R2 designation.
*   **Zero-based Indexing**: When defining `read_structure`, use 0-based indexing (e.g., the first base is position 0).
*   **Platform Constraints**: `Rsubread` (the default aligner) is not available on Windows. For Windows users, alignment must be performed externally, and the resulting BAM file can then be imported into `scPipe`.
*   **Cell Calling**: For scATAC-seq, the `filter` method in `sc_atac_feature_counting` is generally preferred over `emptyDrops` or `cellranger` for identifying valid cells.

## Reference documentation

- [scPipe: a flexible data preprocessing pipeline for scATAC-Seq data](./references/scPipe_atac_tutorial.md)
- [scPipe: a flexible data preprocessing pipeline for 3' end scRNA-seq data](./references/scPipe_tutorial.md)