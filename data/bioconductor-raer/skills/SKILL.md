---
name: bioconductor-raer
description: "bioconductor-raer characterizes RNA Adenosine-to-Inosine editing in single-cell and bulk RNA-sequencing data. Use when user asks to quantify known editing sites, detect novel editing sites from BAM files, calculate the Alu Editing Index, or perform differential editing analysis."
homepage: https://bioconductor.org/packages/release/bioc/html/raer.html
---


# bioconductor-raer

name: bioconductor-raer
description: Tools for characterizing RNA Adenosine-to-Inosine (A-to-I) editing in single-cell and bulk RNA-sequencing data. Use this skill to quantify known editing sites, detect novel editing sites from BAM files, calculate the Alu Editing Index (AEI), and perform differential editing analysis.

## Overview

The `raer` package provides a comprehensive framework for analyzing RNA editing (specifically A-to-I) within the Bioconductor ecosystem. It utilizes HTSlib-based pileup routines to extract base counts from BAM files and integrates with `SingleCellExperiment` and `SummarizedExperiment` objects for downstream analysis.

## Core Workflows

### 1. Single-Cell RNA-seq Quantification
Use `pileup_cells()` to quantify UMI counts for edited and non-edited bases per cell.

```r
library(raer)

# Define sites as GRanges with REF/ALT metadata
# For A-to-I, REF="A", ALT="G" (strand-specific)
sites$REF <- "A"
sites$ALT <- "G"

# Set filtering parameters
params <- FilterParam(
    min_mapq = 255,
    library_type = "fr-second-strand", # Use 'unstranded' for SS2
    min_variant_reads = 1
)

# Run pileup
e_sce <- pileup_cells(
    bamfile = "path/to/sample.bam",
    sites = sites,
    cell_barcodes = colnames(sce),
    cb_tag = "CB",
    umi_tag = "UB",
    param = params
)

# Calculate frequencies and integrate with main SCE
e_sce <- calc_edit_frequency(e_sce, edit_from = "Ref", edit_to = "Alt")
altExp(sce) <- e_sce
```

### 2. Bulk RNA-seq and Differential Editing
Use `pileup_sites()` to generate a `RangedSummarizedExperiment` for bulk samples.

```r
# Quantify sites
rse <- pileup_sites(
    bam_files,
    fasta = "genome.fa",
    sites = known_sites,
    param = FilterParam(library_type = "fr-first-strand")
)

# Calculate frequency and filter
rse <- calc_edit_frequency(rse, edit_from = "A", edit_to = "G", drop = TRUE)

# Prepare for differential testing (e.g., DESeq2 or edgeR)
deobj <- make_de_object(rse, min_prop = 0.05, min_samples = 3)
results <- find_de_sites(
    deobj,
    test = "DESeq2",
    condition_col = "genotype",
    condition_control = "WT",
    condition_treatment = "KO"
)
```

### 3. Alu Editing Index (AEI)
Calculate global editing activity across Alu elements.

```r
alu_index <- calc_AEI(
    bam_files,
    fasta = "genome.fa",
    snp_db = snp_granges, # Exclude known SNPs
    alu_ranges = alu_granges,
    param = FilterParam()
)
# Access global index via alu_index$AEI
```

### 4. Novel Editing Site Detection
Identify sites by comparing RNA-seq to matched DNA-seq (WGS) or using strict filters.

1. **Initial Pileup**: Run `pileup_sites()` on RNA and DNA BAMs.
2. **DNA Filtering**: Remove sites where the DNA-seq shows a variant (to exclude SNPs).
3. **Annotation**: Use `annot_from_gr()` to add RepeatMasker or SNP info.
4. **Clustered Filter**: Use `filter_clustered_variants()` to remove artifacts.
5. **Frequency Filter**: Require minimum editing frequency (e.g., > 0.05) and supporting reads.

## Key Functions and Parameters

- `FilterParam()`: Central configuration for quality control.
    - `library_type`: Critical for strand-specific counting (`fr-first-strand`, `fr-second-strand`, or `unstranded`).
    - `trim_5p`/`trim_3p`: Removes bases from read ends to avoid alignment artifacts.
    - `min_splice_overhang`: Filters variants near splice junctions.
- `calc_edit_frequency()`: Adds `edit_freq` and `depth` assays to objects.
- `read_sparray()`: Efficiently loads sparse matrix outputs from `pileup_cells()`.

## Reference documentation
- [Introducing the raer package](./references/raer.md)