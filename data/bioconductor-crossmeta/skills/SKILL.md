---
name: bioconductor-crossmeta
description: This tool performs cross-platform meta-analysis of microarray data from Gene Expression Omnibus. Use when user asks to download GEO datasets, perform differential expression analysis, or conduct effect-size and pathway meta-analyses across different microarray platforms.
homepage: https://bioconductor.org/packages/3.8/bioc/html/crossmeta.html
---


# bioconductor-crossmeta

name: bioconductor-crossmeta
description: Perform cross-platform meta-analysis of microarray data using the crossmeta Bioconductor package. Use this skill to automate the downloading, annotation, differential expression, and meta-analysis (effect-size and pathway) of GEO microarray datasets (Affymetrix, Illumina, Agilent).

# bioconductor-crossmeta

## Overview
The `crossmeta` package streamlines the meta-analysis of microarray data from different platforms. It automates the pipeline from raw data acquisition (GEO) to meta-analysis of effect sizes and biological pathways. It supports 21 species and handles the complexities of cross-platform gene mapping and surrogate variable analysis to remove batch effects.

## Core Workflow

### 1. Data Acquisition
Identify GSE numbers from GEO and download raw data.
```R
library(crossmeta)
data_dir <- file.path(getwd(), "data_analysis")
gse_names <- c("GSE9601", "GSE15069") # Example GSEs
get_raw(gse_names, data_dir)
```

### 2. Loading and Annotation
Load raw data into ExpressionSets and map probes to HGNC symbols.
```R
# Automatically downloads required annotation packages
esets <- load_raw(gse_names, data_dir)

# If automatic annotation fails, use symbol_annot for manual mapping
# esets$GSEXXXXX <- symbol_annot(esets$GSEXXXXX)
```

### 3. Differential Expression Analysis
Perform differential expression for each study. This typically uses a GUI for sample selection, but can be automated.
```R
# GUI approach
anals <- diff_expr(esets, data_dir)

# Non-GUI approach (requires pData setup)
# pData(eset)$group <- c("control", "control", "treat", "treat")
# sel <- setup_prev(eset, contrasts = "treat-control")
# anal <- diff_expr(eset, data_dir, prev_anal = sel)
```

### 4. Meta-Analysis
After individual analyses, perform meta-analysis across studies.

**Effect-Size Meta-Analysis:**
```R
# Load previous analyses
anals <- load_diff(gse_names, data_dir)
# Perform meta-analysis (optionally by tissue source)
es_res <- es_meta(anals, by_source = TRUE)
```

**Pathway Meta-Analysis:**
Uses PADOG to prioritize pathways and Fisher's method to combine p-values.
```R
# Requires diff_path to be run on individual studies first
path_anals <- diff_path(esets, anals, data_dir)
path_res <- path_meta(path_anals, by_source = TRUE)
```

## Key Functions and Tips

- **Illumina Data**: Raw Illumina files often lack standard headers. Use `open_raw_illum(illum_names, data_dir)` to open and manually inspect/fix headers if `load_raw` fails.
- **Tissue Sources**: Use `add_sources(anals, data_dir)` to group studies by tissue type before running meta-analysis with `by_source = TRUE`.
- **Drug Discovery**: Use `explore_paths(es_res, path_res)` to interface with `ccmap` and identify drug candidates that might mimic or reverse the meta-analysis signature.
- **Persistence**: Most functions save results to `data_dir`. Use `load_diff`, `load_path`, and `load_raw` to resume work without re-processing.

## Reference documentation
- [Cross-Platform Meta Analysis](./references/crossmeta-vignette.md)