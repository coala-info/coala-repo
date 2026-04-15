---
name: bioconductor-screencounter
description: The screenCounter package quantifies barcode frequencies from raw FASTQ files for various experimental designs. Use when user asks to count single, combinatorial, dual, or random barcodes and generate a SummarizedExperiment object.
homepage: https://bioconductor.org/packages/release/bioc/html/screenCounter.html
---

# bioconductor-screencounter

## Overview

The `screenCounter` package provides R functions to quantify barcode frequencies from raw FASTQ files. It supports various experimental designs, including single barcodes, combinatorial barcodes (multiple variable regions in one read), dual barcodes (barcodes on paired reads), and random barcodes (randomly synthesized sequences). The output is typically a `SummarizedExperiment` object containing a count matrix and associated metadata.

## Core Workflows

### 1. Counting Single Barcodes
Use `matrixOfSingleBarcodes()` when each read contains one variable region flanked by constant sequences.

```r
library(screenCounter)
known <- c("AAAAAAAA", "CCCCCCCC", "GGGGGGGG", "TTTTTTTT")
out <- matrixOfSingleBarcodes(
    "sample.fastq", 
    flank5="GTAC", 
    flank3="CATG", 
    choices=known
)
# Access counts
assay(out)
```

### 2. Counting Combinatorial Barcodes
Use `matrixOfComboBarcodes()` for reads containing multiple variable regions. A `template` string defines the structure, where `N` represents variable positions.

```r
known1 <- c("AAAA", "CCCC")
known2 <- c("ATTA", "CGGC")
out <- matrixOfComboBarcodes(
    "combo.fastq",
    template="GTACNNNNCATGNNNNGTAC",
    choices=list(first=known1, second=known2)
)
# rowData(out) contains the combination identities
```

### 3. Counting Dual Barcodes (Paired-End)
Use `matrixOfDualBarcodes()` for paired-end data where each read in a pair contains one barcode.

```r
# choices is a DataFrame of valid barcode pairs
choices <- DataFrame(barcode1=c("AGAG", "CTCT"), barcode2=c("ATAT", "CGCG"))
out <- matrixOfDualBarcodes(
    list(c("read1.fastq", "read2.fastq")), 
    choices=choices,
    template=c("PREFIXNNNNNNSUFFIX", "PREFIXNNNNNNSUFFIX")
)
```

### 4. Counting Random Barcodes
Use `matrixOfRandomBarcodes()` when the variable region is not from a known pool. This extracts all observed sequences matching the template.

```r
out <- matrixOfRandomBarcodes(
    "random.fastq",
    template="CCCAGTNNNNNNNNGGGATAC"
)
```

## Key Parameters and Tips

*   **Template vs Flanks**: You can specify `flank5`/`flank3` for simple designs or a `template` (e.g., `"GGGNNNNNNNTTT"`) for complex ones.
*   **Strand Specificity**: By default, functions search both strands. Use `strand="original"`, `"reverse"`, or `"both"` to restrict the search based on your library prep.
*   **Mismatches**: Set `substitutions` (default 0) to allow for sequencing errors. Note that synthesis errors often create valid but "wrong" barcodes, so use this carefully.
*   **Parallelization**: Use the `BPPARAM` argument with `BiocParallel` objects (e.g., `MulticoreParam()`) to process multiple FASTQ files simultaneously.
*   **Result Object**: The output is a `SummarizedExperiment`. 
    *   `assay(out)`: The count matrix.
    *   `rowData(out)`: Barcode sequences/identities.
    *   `colData(out)`: Mapping statistics (e.g., `nreads`, `nmapped`).

## Reference documentation

- [Counting barcodes in sequencing screens](./references/counting.Rmd)
- [Counting barcodes in sequencing screens (Markdown)](./references/counting.md)