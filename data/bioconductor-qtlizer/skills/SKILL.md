---
name: bioconductor-qtlizer
description: This tool annotates human genetic variants and genes with Quantitative Trait Loci information by querying the Qtlizer database. Use when user asks to query expression QTLs for specific rsIDs, genomic coordinates, or gene symbols to understand the functional impact of genetic variants.
homepage: https://bioconductor.org/packages/release/bioc/html/Qtlizer.html
---


# bioconductor-qtlizer

name: bioconductor-qtlizer
description: Annotate human genetic variants (SNPs) and genes with Quantitative Trait Loci (QTL) information using the Qtlizer database. Use this skill to query expression QTLs (e.g., eQTLs) for specific rsIDs, genomic coordinates (hg19/hg38), or gene symbols to understand the functional impact of GWAS results.

## Overview

The `Qtlizer` package provides an R interface to the Qtlizer web server, which aggregates published QTL data. It allows researchers to quickly determine if a variant of interest is associated with changes in gene expression across various tissues.

## Core Workflow

### 1. Installation and Loading
```r
if(!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("Qtlizer")
library(Qtlizer)
```

### 2. Querying the Database
The primary function is `get_qtls()`. It accepts three types of query terms:
- **RSID**: e.g., `"rs4284742"`
- **Genomic Coordinates**: e.g., `"hg19:19:45412079"` or `"hg38:19:45412079"`
- **Gene Symbols**: e.g., `"DEFA1"` (HGNC guidelines)

#### Single and Multiple Queries
```r
# Single term
res <- get_qtls("rs4284742")

# Multiple terms (comma-separated string or vector)
res <- get_qtls("rs4284742, rs2070901")
res <- get_qtls(c("rs4284742", "DEFA1"))
```

### 3. Advanced Query Parameters
- **Linkage Disequilibrium (LD) Enrichment**: Expand the search to include variants in LD with the input.
  - `corr`: Correlation threshold (0 to 1). Default is `NA`.
  - `ld_method`: Method for correlation, either `"r2"` (default) or `"dprime"`.
- **Output Format**:
  - `return_obj`: Set to `"dataframe"` (default) or `"granges"` for a `GenomicRanges` object.
  - `ref_version`: If returning GRanges, specify `"hg19"` (default) or `"hg38"`.

```r
# Query with LD enrichment (r2 > 0.8)
df <- get_qtls("rs4284742", corr = 0.8, ld_method = "r2")

# Return as GenomicRanges object for hg38
gr <- get_qtls("rs4284742", return_obj = "granges", ref_version = "hg38")
```

### 4. Interpreting Results
The resulting data frame contains detailed annotations. To understand the columns, use the `comment()` function on the returned object:

```r
res <- get_qtls("rs4284742")
comment(res) # Displays metadata for each column
```

**Key Columns:**
- `type`: The type of QTL (e.g., eQTL).
- `gene` / `ensgid`: Target gene associated with the variant.
- `tissue`: The tissue where the association was observed.
- `p` / `beta`: Statistical significance and effect size.
- `colocalization`: Indicates if the variant and gene are in the same TAD (`cis`) or not (`trans`).
- `is_sign`: Boolean indicating if the association meets significance thresholds in the source study.

## Reference documentation

- [Qtlizer](./references/Qtlizer.md)