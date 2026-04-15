---
name: r-annotables
description: The r-annotables package provides local lookup tables for converting and annotating Ensembl gene IDs across multiple model organisms in R. Use when user asks to join gene metadata to Ensembl IDs, map transcripts to genes, or annotate genomic results without querying external databases.
homepage: https://cran.r-project.org/web/packages/annotables/index.html
---

# r-annotables

name: r-annotables
description: Provides tables for converting and annotating Ensembl Gene IDs for multiple organisms (Human, Mouse, Rat, etc.) without querying external databases. Use when you need to join gene metadata (symbols, descriptions, biotypes, Entrez IDs) to Ensembl IDs or map transcripts to genes in R.

## Overview

The `annotables` package provides pre-built tibbles containing genomic annotation data from Ensembl (currently Ensembl Genes 114). It is designed to replace the need for repetitive `biomaRt` queries by providing local, high-performance lookup tables for common model organisms.

## Installation

```R
install.packages("devtools")
devtools::install_github("stephenturner/annotables")
```

## Available Data Tables

The package provides two types of tables for each supported organism:
1.  **Gene Annotation Tables**: Contain `ensgene`, `entrez`, `symbol`, `chr`, `start`, `end`, `strand`, `biotype`, and `description`.
2.  **Transcript Mapping Tables**: (`_tx2gene`) Link Ensembl transcript IDs (`enstxp`) to Ensembl gene IDs (`ensgene`).

### Supported Organisms/Builds
- **Human**: `grch38` (Build 38), `grch37` (Build 37)
- **Mouse**: `grcm38`
- **Rat**: `rnor6`
- **Chicken**: `galgal5`
- **Worm**: `wbcel235`
- **Fly**: `bdgp6`
- **Macaque**: `mmul801`
- **Pig**: `Sscrofa11.1`
- **Dog**: `ROS_Cfam_1.0`
- **Zebrafish**: `GRCz11`

## Workflows

### Basic Annotation
To annotate a results table (e.g., from DESeq2) that has Ensembl IDs:

```R
library(annotables)
library(dplyr)

# Assuming 'res' is a data frame with a column 'ensgene'
annotated_res <- res %>%
  inner_join(grch38, by = "ensgene")
```

### Filtering by Biotype or Location
Since tables are standard tibbles, use `dplyr` for subsetting:

```R
# Get all protein coding genes on chromosome 1
pc_chr1 <- grch38 %>%
  filter(biotype == "protein_coding", chr == "1") %>%
  select(ensgene, symbol, description)
```

### Transcript to Gene Mapping
Useful for tools like `tximport` that require a mapping between transcripts and genes:

```R
# View mapping for Human Build 38
head(grch38_tx2gene)
```

## Tips
- **Memory Efficiency**: The tables are loaded into memory when the package is attached.
- **Join Conflicts**: If your data has a column named `symbol` or `description` already, use `suffix` in your join or `select` specific columns from the annotable first.
- **Version Consistency**: These tables are static snapshots. For the most recent Ensembl releases not covered here, you may still need `biomaRt`.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [custom_versions_howto.md](./references/custom_versions_howto.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)