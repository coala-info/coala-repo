---
name: bioconductor-grasp2db
description: This package provides a high-performance SQLite interface to the GRASP v2.0 database for querying millions of genetic associations from GWAS studies. Use when user asks to access GRASP database records, filter genetic variants by P-value or phenotype, or join SNP-level data with study metadata.
homepage: https://bioconductor.org/packages/release/data/annotation/html/grasp2db.html
---


# bioconductor-grasp2db

## Overview

The `grasp2db` package provides a high-performance SQLite interface to the GRASP v2.0 database, which contains over 8 million genetic associations (P < 0.05) from GWAS studies. The data is managed via `AnnotationHub` and queried using `dplyr` or `RSQLite`.

## Core Workflow

### 1. Initializing the Database
The first time you call `GRASP2()`, a ~5.3GB SQLite file is downloaded to your local `AnnotationHub` cache.

```r
library(grasp2db)
# This may take time on the first run
grasp2 <- GRASP2()
```

### 2. Exploring Tables
The database consists of three primary tables:
- `variant`: SNP-level association data (P-values, genomic coordinates hg19, functional annotations).
- `study`: Publication details (PMID, Journal, Phenotype descriptions).
- `count`: Sample sizes and population-specific counts (Discovery vs. Replication).

```r
# View table names and connection details
grasp2

# Create references to tables
variant_tbl <- tbl(grasp2, "variant")
study_tbl <- tbl(grasp2, "study")
count_tbl <- tbl(grasp2, "count")
```

### 3. Querying with dplyr
Use standard `dplyr` verbs to filter and select data. Queries are executed lazily on the SQLite backend.

```r
library(dplyr)

# Filter by significance using the indexed NegativeLog10PBin
# NegativeLog10PBin is an integer rounding of -log10(Pvalue)
top_hits <- variant_tbl %>%
  filter(NegativeLog10PBin > 10) %>%
  select(SNPid_dbSNP134, chr_hg19, pos_hg19, Pvalue)

# Join variants with study information using PMID
results <- top_hits %>%
  left_join(study_tbl, by = "PMID") %>%
  filter(PaperPhenotypeDescription == "Asthma") %>%
  collect() # Bring results into R memory
```

### 4. Advanced Filtering
You can use SQL-like pattern matching for phenotype searches.

```r
# Search for specific keywords in phenotypes
lipid_studies <- study_tbl %>%
  filter(PaperPhenotypeDescription %like% "%Lipid%") %>%
  collect()
```

## Database Schema Details

| Table | Key Column | Description |
| :--- | :--- | :--- |
| `variant` | `NHLBIkey` | Main association data; includes `NegativeLog10PBin` for fast P-value filtering. |
| `study` | `PMID` | Citation metadata; use `PaperPhenotypeDescription` for trait filtering. |
| `count` | `NHLBIkey` | Breakdown of sample sizes across 12 distinct populations. |

## Tips and Performance
- **Use Bins for P-values**: Always filter on `NegativeLog10PBin` rather than the raw `Pvalue` column when possible, as the bin column is indexed for speed.
- **Read-Only Access**: The database is opened in read-only mode by default via `AnnotationHub`.
- **Direct SQL**: If you prefer raw SQL, access the connection via `grasp2$con` and use `dbGetQuery(grasp2$con, "SELECT ...")`.

## Reference documentation
- [Notes on Bioconductor’s GRASP2 database curation](./references/BiocGRASP2.md)
- [Using the NHLBI GRASP repository of GWAS test results with Bioconductor](./references/grasp2db.md)