---
name: bioconductor-edirquery
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/EDIRquery.html
---

# bioconductor-edirquery

name: bioconductor-edirquery
description: Query the Exome Database of Interspersed Repeats (EDIR) to identify pairwise repeat structures within human genes. Use when analyzing intragenic exonic deletions, identifying regions of homology flanking coding sequences, or searching for repetitive structures in specific genes using HGNC symbols or Ensembl IDs.

# bioconductor-edirquery

## Overview

The `EDIRquery` package provides tools to query the Exome Database of Interspersed Repeats (EDIR). This database contains pairwise repeat structures (within 1000 bp of each other) where at least one repeat is in an exon or both repeats flank one or more exons. It is primarily used to study genetic diseases where intragenic deletions are mediated by homologous repetitive sequences.

## Installation

Install the package via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("EDIRquery")
library(EDIRquery)
```

## Core Workflow

### Querying Genes

The primary function is `gene_lookup()`. It searches the database for a specific gene and returns repeat pairs.

```r
# Basic lookup using HGNC symbol (uses built-in example data for GAA)
results <- gene_lookup(gene = "GAA")

# Lookup using Ensembl ID with specific constraints
results <- gene_lookup(
  gene = "ENSG00000171298",
  length = 7,           # Repeat length (7-20)
  mismatch = TRUE,      # Allow 1 mismatch
  mindist = 0,          # Min spacer distance
  maxdist = 1000        # Max spacer distance
)
```

### Handling Output Formats

The package supports two output formats via the `format` parameter:

1.  **data.frame** (Default): Best for tabular analysis and inspection.
2.  **GInteractions**: Returns a `GenomicInteractions` object, useful for integration with other Bioconductor genomic interval packages.

```r
# Return as GenomicInteractions
gi_results <- gene_lookup("GAA", format = "GInteractions")
```

### Using the Full Database

By default, `gene_lookup` uses a small example subset (gene GAA). To query the full human genome database, you must download the database files and provide the path.

```r
# Query full database
results <- gene_lookup("BRCA1", path = "/path/to/EDIR_database_directory/")
```

## Interpreting Results

The output contains detailed information about the repeat pairs:
- `start1`, `end1`, `start2`, `end2`: Genomic coordinates of the two repeats.
- `repeat_seq1`, `repeat_seq2`: The actual sequences.
- `intron_exon1`, `intron_exon2`: Location of the repeats (e.g., E1 for Exon 1, I2 for Intron 2).
- `feature`: Describes the relationship (e.g., "same exon", "spanning intron-exon").
- `distance`: The spacer distance between the two repeats.

## Tips and Best Practices

- **Length Parameter**: If `length = NA` (default), the function returns all available repeat lengths (7-20 bp) and prints a summary table to the console.
- **Console Summary**: The function prints a summary of parameters and results to the console by default. Set `summary = FALSE` to suppress this if running in a loop.
- **Mismatches**: Enabling `mismatch = TRUE` significantly increases the number of hits but may increase runtime.

## Reference documentation

- [EDIRquery](./references/EDIRquery.md)