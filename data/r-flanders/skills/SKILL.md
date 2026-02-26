---
name: r-flanders
description: This R package converts finemapping results into AnnData objects and performs pairwise colocalization analysis. Use when user asks to convert finemapping RDS files to AnnData format, aggregate credible set metadata, or run colocalization tests on genetic association data.
homepage: https://cran.r-project.org/web/packages/flanders/index.html
---


# r-flanders

name: r-flanders
description: R package for converting finemapping results into AnnData objects and performing colocalization analysis. Use when you need to process *finemap.rds files, create unified AnnData objects with credible set metadata, or run pairwise colocalization tests (coloc) on genetic association data.

# r-flanders

## Overview
The `flanders` package facilitates the integration of finemapping outputs into a standardized AnnData format and provides efficient workflows for colocalization analysis. It is particularly useful for handling outputs from the `nf-flanders` pipeline, allowing users to manage multiple credible sets and perform rapid pairwise colocalization testing.

## Installation
To install the package from GitHub:
```R
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")
devtools::install_github("Biostatistics-Unit-HT/flanders_r")
```

## Core Workflow

### 1. Convert Finemapping Results to AnnData
Use `finemap2anndata` to aggregate multiple `.rds` finemapping files into a single AnnData object.

```R
library(flanders)

finemap_files <- list.files("/path/to/results/", pattern = "*.rds", full.names = TRUE)
# phenotype_id and study_id should be vectors matching the length of finemap_files
ad <- finemap2anndata(
  finemap_files = finemap_files,
  phenotype_id = phenotype_ids,
  study_id = study_ids
)

# Save for later use
ad$write_h5ad("my_finemapping_data.h5ad")
```

### 2. Prepare Colocalization Input
Generate a guide table specifying which pairs of credible sets should be tested.

```R
library(zellkonverter)
# Load as SingleCellExperiment for R-based processing
sce <- readH5AD("my_finemapping_data.h5ad", reader = "R")

coloc_input <- anndata2coloc_input(sce)
```

### 3. Run Colocalization
Perform the actual colocalization tests using the AnnData/SCE object and the input table.

```R
coloc_results <- anndata2coloc(sce, coloc_input)
print(coloc_results)
```

## Data Specifications

### Variable Metadata (ad$var)
- `snp`: Format `chr{num}:{pos}:EA:RA`. This must be the row name.
- `chr`: Chromosome identifier.
- `pos`: Physical position in base pairs.

### Observation Metadata (ad$obs)
- `cs_name`: Unique identifier for the credible set (Row name).
- `study_id` & `phenotype_id`: Identifiers for the source study and trait.
- `min_res_labf`: Minimal logABF in the locus.
- `coverage`: Requested coverage (e.g., 0.95 or 0.99).

## Tips for Large Datasets
- For small to moderate datasets, `anndata2coloc` runs efficiently on a local machine (5–10 tests per second).
- For large-scale analyses, use `anndata2coloc_input` to generate a CSV guide table and provide it to the `flanders_nf_coloc` Nextflow pipeline.
- When merging multiple AnnData objects, use `merged_ad <- fix_ad_var(merged_ad)` to ensure variable consistency.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)