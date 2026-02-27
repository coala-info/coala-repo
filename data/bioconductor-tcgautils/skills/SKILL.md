---
name: bioconductor-tcgautils
description: TCGAutils provides a suite of helper functions to process, transform, and harmonize The Cancer Genome Atlas data for use in the MultiAssayExperiment ecosystem. Use when user asks to map identifiers between barcodes and UUIDs, subset data by sample type, or convert TCGA data into genomic-range-aware Bioconductor objects.
homepage: https://bioconductor.org/packages/release/bioc/html/TCGAutils.html
---


# bioconductor-tcgautils

## Overview

`TCGAutils` is a utility suite designed to bridge the gap between raw TCGA data (from Firehose or GDC) and Bioconductor's `MultiAssayExperiment` ecosystem. It provides essential functions for identifier mapping, sample type identification, and data transformation, ensuring that multi-omic TCGA datasets are harmonized for downstream analysis.

## Core Workflows

### 1. Managing MultiAssayExperiments
When working with objects from `curatedTCGAData`, use these functions to organize your data:

*   **Identify Sample Types**: Use `sampleTables(mae)` to see a tally of sample codes (e.g., 01 for Primary Solid Tumor, 11 for Solid Tissue Normal).
*   **Split by Tissue**: Use `TCGAsplitAssays(mae, c("01", "11"))` to separate tumor and normal samples into distinct assays within the same object.
*   **Filter to Primary Tumors**: Use `TCGAprimaryTumors(mae)` to quickly subset the object to only primary tumor samples.
*   **Extract Clinical Metadata**: Use `getClinicalNames("DISEASE_CODE")` to find the standard "Level 4" clinical variables (e.g., vital_status, pathologic_stage).

### 2. Identifier Translation & Parsing
TCGA uses both UUIDs (GDC) and Barcodes (Legacy). `TCGAutils` handles the conversion:

*   **Barcode to UUID**: `barcodeToUUID(barcodes)`
*   **UUID to Barcode**: `UUIDtoBarcode(uuids, from_type = "file_id")` (supports `case_id`, `file_id`, or `aliquot_ids`).
*   **Parse Barcodes**: `TCGAbarcode(barcodes, participant = TRUE, sample = TRUE)` allows granular extraction of participant, sample, or portion IDs.
*   **Detailed Biospecimen Data**: `TCGAbiospec(barcodes)` returns a data frame with decoded information (vial, plate, center, etc.).

### 3. Data Transformation & Lifting
Convert various data types into genomic-range-aware Bioconductor classes:

*   **Methylation**: `CpGtoRanges(mae)` converts CpG probe IDs to genomic coordinates.
*   **Mutations**: `qreduceTCGA(mae)` summarizes `RaggedExperiment` mutation data into gene-level `RangedSummarizedExperiment` objects.
*   **Gene Symbols**: `symbolsToRanges(mae)` converts assays with gene symbol row names to `RangedSummarizedExperiment`.
*   **GISTIC**: `makeSummarizedExperimentFromGISTIC(firehoseObject, "Peaks")` converts RTCGAToolbox GISTIC results.
*   **Copy Number**: `makeGRangesListFromCopyNumber(df, split.field = "Sample")` imports flat text files of segment data.

### 4. Visualization
*   **OncoPrint**: Use `oncoPrintTCGA(mae)` to create a mutation landscape plot. It automatically searches for mutation assays and maps variant classifications.

## Implementation Tips

*   **Genome Builds**: Many TCGA datasets use `hg18` or `hg19`. Use `rtracklayer::liftOver` with `AnnotationHub` chain files to update coordinates to `hg38` before integration with modern GDC data.
*   **Replicate Handling**: After using `TCGAsplitAssays`, use `MultiAssayExperiment::mergeReplicates()` to handle technical replicates without accidentally merging tumor and normal samples.
*   **Subtype Mapping**: Use `getSubtypeMap(mae)` to access manually curated molecular subtypes stored in the object metadata.

## Reference documentation

- [TCGAutils: Helper functions for working with TCGA datasets](./references/TCGAutils.md)