---
name: r-firebrowser
description: This R client provides programmatic access to the Broad Institute's Firehose Web API for downloading and analyzing TCGA data sets. Use when user asks to download TCGA data, retrieve mRNA expression levels, fetch clinical information, or query somatic mutations.
homepage: https://cran.r-project.org/web/packages/firebrowser/index.html
---

# r-firebrowser

name: r-firebrowser
description: R client for the Broad Institute's Firehose Web API. Use this skill to programmatically download and analyze TCGA (The Cancer Genome Atlas) data sets, including mRNA expression, clinical data, and mutations, directly into R data frames.

## Overview
r-firebrowser (FirebrowseR) provides a seamless interface to the Broad Firehose pipeline. It eliminates the need to manually download and parse inconsistent TCGA file formats by providing standardized access to JSON, CSV, and TSV data through the Firebrowse API.

## Installation
To install the stable version from CRAN:
```R
install.packages("FirebrowseR")
```

To install the development version:
```R
devtools::install_github("mariodeng/FirebrowseR")
```

## Core Workflows

### 1. Metadata Discovery
Before downloading data, identify available cohorts and data types.
```R
library(FirebrowseR)

# List all available cancer cohorts (e.g., BRCA, LUAD, SKCM)
cohorts = Metadata.Cohorts()

# List available clinical data elements
clinical_elements = Metadata.Clinical.Names()
```

### 2. Downloading mRNA Expression Data
Retrieve expression levels for specific genes across participants.
```R
# Fetch mRNA expression for PTEN and RUNX1 in specific samples
mRNA.Exp = Samples.mRNASeq(
  format = "csv",
  gene = c("PTEN", "RUNX1"),
  tcga_participant_barcode = c("TCGA-GF-A4EO", "TCGA-AC-A2FG")
)

# View expression and z-scores
head(mRNA.Exp[, c("tcga_participant_barcode", "expression_log2", "z.score")])
```

### 3. Clinical Data Retrieval
Fetch patient clinical information for a cohort.
```R
# Get clinical data for Breast Invasive Carcinoma (BRCA)
brca_clinical = Samples.Clinical(cohort = "BRCA", format = "csv")
```

### 4. Mutation Data
Query somatic mutations for specific genes or cohorts.
```R
# Get mutations for TP53 in the LUAD cohort
luad_muts = Analyses.Mutation.MAF(cohort = "LUAD", gene = "TP53", format = "csv")
```

## Tips for Efficient Usage
- **Format Selection**: Use `format = "csv"` or `format = "tsv"` to receive standard R data frames. Using `format = "json"` requires the `jsonlite` package for parsing.
- **Pagination**: The API often limits the number of records per request. Check function documentation for `page` and `page_size` parameters if working with large cohorts.
- **Barcodes**: TCGA participant barcodes (e.g., `TCGA-XX-XXXX`) are the primary identifiers for linking data across different `Samples.*` functions.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)