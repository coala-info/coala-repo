---
name: bioconductor-rmir.hsa
description: This tool provides access to human miRNA target prediction and validation databases through a unified SQLite interface. Use when user asks to retrieve miRNA-gene target relationships, compare different miRNA target databases, or map human miRNAs to Entrez Gene IDs.
homepage: https://bioconductor.org/packages/release/data/annotation/html/RmiR.hsa.html
---


# bioconductor-rmir.hsa

name: bioconductor-rmir.hsa
description: Access and query human miRNA target prediction and validation databases (mirBase, TargetScan, miRanda, tarBase, mirTarget2, picTar). Use this skill when you need to retrieve miRNA-gene target relationships, compare different miRNA target databases, or map a list of human miRNAs to their Entrez Gene ID targets (and vice versa) using the RmiR.hsa annotation package.

# bioconductor-rmir.hsa

## Overview

The `RmiR.hsa` package is a Bioconductor annotation resource that bundles multiple human microRNA (miRNA) target databases into a single SQLite interface. It allows for efficient querying of both predicted and experimentally validated miRNA-target interactions. Supported databases include:
- **tarBase**: Experimentally validated targets.
- **targetScan**, **mirBase**, **miRanda**, **mirTarget2**, **picTar**: Predicted targets.

## Typical Workflow

### 1. Loading the Package and Connecting to the Database
The package uses a central SQLite database. You can access the connection directly to perform SQL queries or use standard `DBI` functions.

```r
library(RmiR.hsa)

# List available tables (databases)
dbListTables(RmiR.hsa_dbconn())
# Expected: "miranda", "mirbase", "mirtarget2", "pictar", "tarbase", "targetscan"
```

### 2. Querying miRNA Targets
You can retrieve targets for a specific miRNA using SQL `SELECT` statements. Results typically include the mature miRNA name and the Entrez Gene ID.

```r
# Query tarBase for a specific miRNA
query <- "SELECT * FROM tarbase WHERE mature_miRNA='hsa-miR-21'"
mir21_targets <- dbGetQuery(RmiR.hsa_dbconn(), query)

# View results
head(mir21_targets)
```

### 3. Mapping Lists of miRNAs or Genes
If you have a vector of miRNAs or genes (e.g., from a differential expression analysis), you can filter the database tables to find matches.

```r
# Example miRNA list
my_mirnas <- c("hsa-miR-148b", "hsa-miR-27b", "hsa-miR-25")

# Read a full table and filter in R
targetscan_db <- dbReadTable(RmiR.hsa_dbconn(), "targetscan")
matches <- targetscan_db[targetscan_db$mature_miRNA %in% my_mirnas, ]

# Mapping Genes to miRNAs (using Entrez IDs)
# If starting with probe IDs, use an org or chip package to get Entrez IDs first
# library(hgug4112a.db)
# entrez_ids <- mget(my_probes, hgug4112aENTREZID)
# gene_matches <- targetscan_db[targetscan_db$gene_id %in% entrez_ids, ]
```

### 4. Evaluating Database Properties
You can evaluate the "multiplicity" (number of targets per miRNA) and "cooperativity" (number of miRNAs per gene) by analyzing the table distributions.

```r
# Multiplicity: How many targets does each miRNA have?
mir_counts <- sort(table(targetscan_db$mature_miRNA), decreasing = TRUE)
plot(log2(1:length(mir_counts)), mir_counts, xlab="log2 rank", ylab="miRNA targets")

# Cooperativity: How many miRNAs target each gene?
gene_counts <- sort(table(targetscan_db$gene_id), decreasing = TRUE)
plot(log2(1:length(gene_counts)), gene_counts, xlab="log2 rank", ylab="target sites")
```

## Tips
- **Database Specifics**: Different tables contain different metadata. For example, `tarbase` includes PubMed IDs (`pmid`), while `targetscan` includes seed location info.
- **Entrez IDs**: The `gene_id` column always refers to Entrez Gene IDs. Ensure your gene list is converted to this format for successful joining.
- **Memory Management**: For very large tables like `miranda` or `targetscan`, it is often more memory-efficient to use `dbGetQuery` with a specific SQL filter rather than `dbReadTable` followed by R-side filtering.

## Reference documentation
- [RmiR.hsa package vignette](./references/RmiR.hsa.md)
- [Multiplicity of miRNA in TarBase](./references/RmiRdb-fig1a.md)
- [Cooperativity of miRNA in TarBase](./references/RmiRdb-fig1b.md)
- [Multiplicity of miRNA in TargetScan](./references/RmiRdb-fig2a.md)
- [Cooperativity of miRNA in TargetScan](./references/RmiRdb-fig2b.md)