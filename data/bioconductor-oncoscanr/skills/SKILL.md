---
name: bioconductor-oncoscanr
description: This tool analyzes Copy Number Variation (CNV) data to identify chromosomal alterations and calculate genomic instability scores. Use when user asks to compute HRD or TDplus scores, identify arm-level chromosomal alterations, or process CNV data from OncoScan or ASCAT outputs.
homepage: https://bioconductor.org/packages/release/bioc/html/oncoscanR.html
---


# bioconductor-oncoscanr

name: bioconductor-oncoscanr
description: Analyze Copy Number Variation (CNV) data from ThermoFisher OncoScan assays (ChAS exports) or ASCAT outputs. Use this skill to compute Homologous Recombination Deficiency (HRD) scores (LST, HR-LOH, nLST, gLOH), Tandem Duplication plus (TDplus) scores, and identify arm-level chromosomal alterations (gains, losses, LOH).

# bioconductor-oncoscanr

## Overview
The `oncoscanR` package performs secondary analysis on CNV data. While tailored for ThermoFisher OncoScan assays analyzed with the Chromosome Alteration Suite (ChAS), it can process any segmented CNV data (including ASCAT) to identify arm-level alterations and calculate genomic instability signatures like HRD and TDplus scores.

## Installation
Install the package using BiocManager:
```R
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("oncoscanR")
```

## Data Loading
The package supports two primary input formats. Both require a kit coverage object (default is `oncoscan_na33.cov` for hg19).

### ChAS Export Files
Load text files exported from ChAS. The file must contain columns: `Type`, `CN State`, and `Full Location`.
```R
library(oncoscanR)
chas.fn <- "path/to/chas_export.txt"
segments <- load_chas(chas.fn, oncoscan_na33.cov)
```

### ASCAT Files
Load ASCAT output files. Required columns: `chr`, `startpos`, `endpos`, `nMajor`, `nMinor`.
```R
ascat.fn <- "path/to/ascat_output.txt"
ascat.segments <- load_ascat(ascat.fn, oncoscan_na33.cov)
```

## Automated Workflows
Use the high-level workflow functions to perform cleaning, arm-level analysis, and scoring in one step.

```R
# For ChAS data
results <- workflow_oncoscan.chas("chas_file.txt")

# For ASCAT data
results <- workflow_oncoscan.ascat("ascat_file.txt")

# Access results
results$armlevel$LOSS  # List of arms with losses
results$scores$HRD     # nLST score and status
results$scores$TDplus  # TDplus score
```

## Custom Analysis Pipeline
For granular control, follow the manual cleaning and scoring steps.

### 1. Data Cleaning
Clean segments by trimming to kit coverage, adjusting LOH overlaps, and merging small gaps.
```R
library(magrittr)
segs.clean <- segments %>%
    trim_to_coverage(oncoscan_na33.cov) %>%
    adjust_loh() %>%
    merge_segments() %>%
    prune_by_size()
```

### 2. Arm-Level Alterations
Identify arms where >80% (default) of the arm is altered.
```R
# Identify LOH arms
arms.loh <- get_loh_segments(segs.clean) %>%
    armlevel_alt(kit.coverage = oncoscan_na33.cov) %>%
    names()
```

### 3. Computing HRD Scores
Calculate specific genomic signatures:
- **LST (Large-scale State Transitions):** Breakpoints between adjacent segments >10Mb.
- **HR-LOH:** Number of LOH segments >15Mb (excluding whole-arm LOH).
- **nLST:** LST score normalized by whole-genome doubling (WGD) events.
- **gLOH:** Percentage of the genome exhibiting LOH.

```R
# Calculate WGD and nLST
wgd <- score_estwgd(segs.clean, oncoscan_na33.cov)
nlst <- score_nlst(segs.clean, wgd["WGD"], oncoscan_na33.cov)

# Calculate gLOH
gloh <- score_gloh(segs.clean, arms.loh, arms.loss, oncoscan_na33.cov)
```

### 4. TDplus Score
Identify CDK12-mutated tumor signatures by counting tandem duplications (gains of 1-2 copies) between 1Mb and 10Mb.
```R
td_results <- score_td(segs.clean)
td_plus_score <- td_results$TDplus
```

## Global Genomic Metrics
- `score_avgcn(segments, coverage)`: Average copy number.
- `score_estwgd(segments, coverage)`: Estimated whole-genome doubling events.
- `score_mbalt(segments, coverage)`: Total Megabases altered.

## Reference documentation
- [Secondary analyses of CNV data (HRD and more) with oncoscanR](./references/oncoscanR.md)