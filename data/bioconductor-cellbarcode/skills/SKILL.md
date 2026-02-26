---
name: bioconductor-cellbarcode
description: This tool performs comprehensive DNA barcode analysis including extraction, quality control, error correction, and quantification from sequencing data. Use when user asks to extract barcodes from FASTQ or BAM files, perform lineage tracing analysis, or conduct clonal tracking using regular expressions.
homepage: https://bioconductor.org/packages/release/bioc/html/CellBarcode.html
---


# bioconductor-cellbarcode

name: bioconductor-cellbarcode
description: Comprehensive cellular DNA barcode analysis including extraction from FASTQ/BAM/SAM files, quality control, error correction (UMI and clustering), and quantification. Use when analyzing lineage tracing, clonal tracking, or amplicon data (CRISPR gRNA, immune repertoire) where barcodes are identifiable via regular expressions.

# bioconductor-cellbarcode

## Overview

The `CellBarcode` package is a toolkit for DNA barcode analysis, primarily used in genetic lineage tracing and clonal tracking. It handles diverse barcode designs (fixed or flexible length, with or without UMIs) provided they can be defined by a regular expression. The package manages the full pipeline from raw sequencing reads to a quantified barcode-sample matrix.

## Core Workflow

### 1. Quality Control and Filtering
Before extraction, evaluate the sequencing quality of FASTQ files.

```r
library(CellBarcode)

# QC evaluation
qc <- bc_seq_qc(fq_files)
bc_plot_seqQc(qc) # Visualize base distribution and quality

# Filter reads based on quality and length
fq_filtered <- bc_seq_filter(
  fq_files,
  min_average_quality = 30,
  min_read_length = 60,
  sample_name = sample_names
)
```

### 2. Barcode Extraction
Extraction uses regular expressions where parentheses `()` capture the target sequences.

**Standard FASTQ Extraction:**
```r
# Define pattern: UMI (12bp) followed by constant region, then variable barcode
pattern <- "([ACGT]{12})CTCGAG([ACGT]+)CCGTAG"
bc_obj <- bc_extract(
  fq_filtered,
  pattern = pattern,
  pattern_type = c("UMI" = 1, "barcode" = 2),
  sample_name = sample_names
)
```

**10X Genomics BAM/SAM Extraction:**
For 10X data, use `bc_extract_sc_sam`. It is recommended to use unmapped reads from the BAM file (converted to SAM) to save time.
```r
d <- bc_extract_sc_sam(
  sam = "scRNASeq_10X.sam",
  pattern = "CONSTANT(.*)CONSTANT",
  cell_barcode_tag = "CR", # Default 10X cell barcode tag
  umi_tag = "UR"           # Default 10X UMI tag
)
```

### 3. Error Correction (Curing)
`CellBarcode` uses a "messy" to "clean" transition. Extraction populates `@messyBc`; curing functions populate `@cleanBc`.

*   **bc_cure_umi**: Filters UMI-barcode combinations by read depth.
*   **bc_cure_depth**: Filters by total barcode count or UMI count.
*   **bc_cure_cluster**: Merges similar sequences (Hamming/Levenshtein distance) to correct for PCR/sequencing errors.

```r
# Typical cleaning sequence
bc_obj <- bc_cure_umi(bc_obj, depth = 2, isUniqueUMI = TRUE) %>%
          bc_cure_depth(depth = 2) %>%
          bc_cure_cluster(dist_thresh = 2)
```

### 4. Data Management and Export
The `BarcodeObj` can be subsetted like a matrix `obj[barcodes, samples]`.

```r
# Export to standard R formats
df <- bc_2df(bc_obj)      # Long format data.frame
mat <- bc_2matrix(bc_obj) # Barcode (row) by Sample (column) matrix

# Set/Get Metadata
bc_meta(bc_obj)$group <- c("A", "A", "B", "B")
sub_obj <- bc_subset(bc_obj, sample = group == "A")
```

## Key Patterns and Tips

*   **Function Naming**: Most functions start with `bc_` for easy auto-completion.
*   **Regex Capture**: The `pattern_type` argument must map the integers to the capture groups `()` in your `pattern` string.
*   **Set Operations**:
    *   `+`: Combine two `BarcodeObj` objects.
    *   `*`: Filter by a whitelist of barcodes.
    *   `-`: Filter by a blacklist of barcodes.
*   **Visualization**: Use `bc_plot_single()`, `bc_plot_pair()`, or `bc_plot_mutual()` to inspect barcode distributions and sample correlations.

## Reference documentation

- [Get barcode from 10X Genomics scRNASeq data](./references/Barcode_in_10X_scRNASeq.md)
- [Analyzing Cellular DNA Barcode with CellBarcode](./references/UMI_VDJ_Barcode.md)