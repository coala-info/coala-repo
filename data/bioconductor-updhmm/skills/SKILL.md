---
name: bioconductor-updhmm
description: This tool detects, classifies, and locates Uniparental Disomy (UPD) events in trio genetic data using a Hidden Markov Model. Use when user asks to identify maternal or paternal isodisomy and heterodisomy from VCF files, filter genomic inheritance artifacts, or visualize UPD events across the genome.
homepage: https://bioconductor.org/packages/release/bioc/html/UPDhmm.html
---

# bioconductor-updhmm

name: bioconductor-updhmm
description: Detect, classify, and locate Uniparental Disomy (UPD) events in trio genetic data (proband, mother, father) using a Hidden Markov Model (HMM). Use this skill to identify maternal/paternal isodisomy and heterodisomy from multisample VCF files, apply quality filters, and visualize results.

# bioconductor-updhmm

## Overview
UPDhmm is an R/Bioconductor package designed to identify Uniparental Disomy (UPD) events in trio-based genomic data. It utilizes a Hidden Markov Model (HMM) where hidden states represent inheritance patterns (Normal, Maternal/Paternal Isodisomy, and Maternal/Paternal Heterodisomy). The package provides a complete workflow from VCF preprocessing and quality control to event detection, collapsing contiguous segments, and genome-wide visualization.

## Core Workflow

### 1. Data Preparation and VCF Checking
The input must be a multisample VCF containing genotypes for a trio. Only biallelic variants are supported.

```r
library(UPDhmm)
library(VariantAnnotation)

# Load VCF
vcf <- readVcf("trio_data.vcf.gz")

# Validate trio structure and extract relevant variants
vcf_checked <- vcfCheck(
  vcf,
  proband = "Sample_Child",
  mother  = "Sample_Mother",
  father  = "Sample_Father"
)
```

### 2. Detecting UPD Events
The `calculateEvents` function applies the Viterbi algorithm to infer inheritance states.

```r
# Detect events and optionally calculate sequencing depth ratios
events <- calculateEvents(vcf_checked, add_ratios = TRUE)

# For large datasets, use parallel execution
library(BiocParallel)
events <- calculateEvents(vcf_checked, BPPARAM = MulticoreParam(workers = 2))
```

### 3. Filtering and Collapsing Events
Raw HMM output often contains small artifacts or fragmented large events. Use `collapseEvents` to merge contiguous segments of the same type and apply size/error filters.

```r
# Default filters: n_mendelian_error > 2 and size > 500kb
collapsed <- collapseEvents(events)

# Manual filtering example
library(dplyr)
filtered <- events %>%
  filter(
    n_mendelian_error > 2,
    (end - start) > 500000,
    ratio_proband >= 0.8 & ratio_proband <= 1.2
  ) %>%
  collapseEvents()
```

### 4. Postprocessing and Recurrence Analysis
Identify regions that appear across multiple samples, which often indicate technical artifacts or common polymorphisms.

```r
# Identify regions shared by at least 2 samples
recurrent_regions <- identifyRecurrentRegions(
  df = collapsed,
  ID_col = "ID",
  min_support = 2
)

# Annotate the original event list
annotated_events <- markRecurrentRegions(
  df = collapsed,
  recurrent_regions = recurrent_regions
)
```

### 5. Visualization
Visualize events across the genome using `karyoploteR`.

```r
library(karyoploteR)
library(regioneR)

# Basic visualization logic
kp <- plotKaryotype(genome = "hg19")
# Filter for specific group (e.g., maternal isodisomy)
iso_mat <- toGRanges(subset(annotated_events, group == "iso_mat"))
kpPlotRegions(kp, iso_mat, col = "#E9B864")
```

## Key Functions Reference

| Function | Purpose |
| --- | --- |
| `vcfCheck()` | Validates trio IDs and filters for biallelic, informative SNPs. |
| `calculateEvents()` | Main HMM engine; returns a data.frame of detected segments. |
| `collapseEvents()` | Merges adjacent segments of the same UPD type and applies quality thresholds. |
| `identifyRecurrentRegions()` | Clusters overlapping events across a cohort to find artifacts. |
| `markRecurrentRegions()` | Flags events in a table if they overlap known recurrent/artifact regions. |

## Usage Tips
- **Depth Ratios:** Use `add_ratios = TRUE` in `calculateEvents` to help distinguish true UPD from Copy Number Variations (CNVs). True UPD should have a ratio near 1.0.
- **Mendelian Errors:** True UPD regions (especially isodisomy) should show a significant accumulation of Mendelian inconsistencies.
- **Masking:** It is highly recommended to mask centromeres and segmental duplications during VCF preprocessing to reduce false positives.

## Reference documentation
- [UPDhmm User Guide: From Detection to Postprocessing](./references/UPDhmm.md)
- [Long reads VCF Preprocessing User Guide](./references/long-reads-processing.Rmd)
- [VCF Preprocessing User Guide](./references/preprocessing.md)