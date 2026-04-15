---
name: bioconductor-rmir.hs.mirna
description: This package provides a unified SQLite database of human microRNA targets from multiple sources like TargetScan, miRanda, and TarBase. Use when user asks to query miRNA-gene relationships, retrieve validated or predicted miRNA targets, or compare miRNA target databases.
homepage: https://bioconductor.org/packages/release/data/annotation/html/RmiR.Hs.miRNA.html
---

# bioconductor-rmir.hs.mirna

## Overview

The `RmiR.Hs.miRNA` package is a Bioconductor annotation data package that provides a unified SQLite database containing human microRNA (miRNA) targets from several major sources. It allows for efficient querying of miRNA-gene relationships using standard SQL or R data frame operations.

Supported databases:
*   **mirBase**: miRNA sequence and annotation data.
*   **targetScan**: Predicted miRNA targets based on seed complementarity.
*   **miRanda**: Predicted targets from microrna.org.
*   **tarBase**: Experimentally validated miRNA-gene interactions.
*   **mirTarget2**: Predicted targets from mirDB.
*   **picTar**: Predicted miRNA targets.

## Basic Usage

### Connecting to the Database

The package uses an SQLite backend. Access the connection object using `RmiR.Hs.miRNA_dbconn()`.

```r
library(RmiR.Hs.miRNA)
library(RSQLite)

# List available tables (databases)
dbListTables(RmiR.Hs.miRNA_dbconn())
```

### Querying miRNA Targets

You can use `dbGetQuery` for specific SQL searches or `dbReadTable` to load an entire database into a data frame.

```r
# Query specific miRNA from TarBase (validated targets)
query <- "SELECT * FROM tarbase WHERE mature_miRNA='hsa-miR-21'"
res <- dbGetQuery(RmiR.Hs.miRNA_dbconn(), query)

# Read an entire table
targetscan_df <- dbReadTable(RmiR.Hs.miRNA_dbconn(), "targetscan")
```

### Mapping Results

Results typically return a `mature_miRNA` column and a `gene_id` (Entrez Gene ID) column.

*   **From miRNA to Genes**: Filter the data frame by the miRNA name.
*   **From Genes to miRNA**: Filter by Entrez ID. If starting with probe IDs, use an appropriate annotation package (e.g., `hgug4112a.db`) to map to Entrez IDs first.

```r
# Example: Finding targets for a list of miRNAs in TargetScan
mir_list <- c("hsa-miR-148b", "hsa-miR-27b")
mirs <- targetscan_df[targetscan_df$mature_miRNA %in% mir_list, ]

# Example: Finding miRNAs targeting specific genes
# Assuming 'genes' contains Entrez IDs
targs <- targetscan_df[targetscan_df$gene_id %in% genes, ]
```

## Workflow: Evaluating Database Consistency

You can compare the "multiplicity" (number of targets per miRNA) and "cooperativity" (number of miRNAs per gene) across different databases.

```r
# Extract miRNA and Gene columns
tarbase <- dbReadTable(RmiR.Hs.miRNA_dbconn(), "tarbase")[, 1:2]

# Multiplicity: How many targets does each miRNA have?
mir_counts <- sort(table(tarbase$mature_miRNA), decreasing = TRUE)
plot(log2(1:length(mir_counts)), mir_counts, 
     main="Multiplicity", xlab="log2(rank)", ylab="Targets")

# Cooperativity: How many miRNAs target each gene?
gene_counts <- sort(table(tarbase$gene_id), decreasing = TRUE)
plot(log2(1:length(gene_counts)), gene_counts, 
     main="Cooperativity", xlab="log2(rank)", ylab="miRNAs")
```

## Tips
*   **Data Volume**: Predicted databases like TargetScan or miRanda are significantly larger than validated ones like TarBase. Use SQL queries (`dbGetQuery`) instead of loading the whole table if memory is a concern.
*   **Naming**: Ensure miRNA names follow the "hsa-miR-X" format used in the database.
*   **Additional Columns**: Different tables contain unique metadata (e.g., PubMed IDs in `tarbase`, seed start/end positions in `targetscan`).

## Reference documentation
- [RmiR.Hs.miRNA package vignette](./references/RmiR.Hs.miRNA.md)
- [Multiplicity in TarBase](./references/RmiRdb-fig1a.md)
- [Cooperativity in TarBase](./references/RmiRdb-fig1b.md)
- [Multiplicity in TargetScan](./references/RmiRdb-fig2a.md)
- [Cooperativity in TargetScan](./references/RmiRdb-fig2b.md)