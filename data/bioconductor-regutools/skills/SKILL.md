---
name: bioconductor-regutools
description: This tool provides programmatic access to RegulonDB for extracting and analyzing bacterial gene regulatory networks in R. Use when user asks to retrieve information about transcription factors, binding sites, operons, and regulatory interactions for Escherichia coli K-12.
homepage: https://bioconductor.org/packages/release/bioc/html/regutools.html
---


# bioconductor-regutools

name: bioconductor-regutools
description: Programmatic access to RegulonDB for extracting and analyzing bacterial gene regulatory networks (GRNs) in R. Use this skill when you need to retrieve information about transcription factors, binding sites, operons, and regulatory interactions for Escherichia coli K-12.

# bioconductor-regutools

## Overview
The `regutools` package provides an R interface to RegulonDB, the primary database for the regulatory network of *Escherichia coli* K-12. It allows users to query gene regulations, transcription factor (TF) binding sites, and genomic elements, returning results as standard Bioconductor objects like `GRanges` or `DNAStringSet`.

## Core Workflow

### 1. Connection and Initialization
To start, you must connect to the database and create a `regulondb` object.
```r
library(regutools)

# Connect to the latest version via AnnotationHub
regulondb_conn <- connect_database()

# Build the regulondb object
e_coli_regulondb <- regulondb(
    database_conn = regulondb_conn,
    organism = "E.coli",
    database_version = "1",
    genome_version = "1"
)
```

### 2. Exploring the Database
Use these functions to understand available data:
- `list_datasets(e_coli_regulondb)`: Lists available tables (e.g., "GENE", "NETWORK", "TF").
- `list_attributes(e_coli_regulondb, "GENE")`: Lists columns for a specific table.

### 3. Retrieving Data with `get_dataset()`
This is the primary query function. It supports filtering, partial matching, and interval searches.
```r
# Basic query for specific genes
genes_info <- get_dataset(
    regulondb = e_coli_regulondb,
    dataset = "GENE",
    attributes = c("posleft", "posright", "strand", "name"),
    filters = list("name" = c("araC", "crp"))
)

# Query with partial matching and intervals
ara_genes <- get_dataset(
    e_coli_regulondb,
    dataset = "GENE",
    attributes = c("posright", "name"),
    filters = list("name" = "ara", "posright" = c(1, 500000)),
    partialmatch = "name",
    interval = "posright"
)
```

### 4. Specialized Regulatory Queries
`regutools` provides high-level functions for common GRN tasks:
- **Get Regulators**: `get_gene_regulators(e_coli_regulondb, c("araC", "fis"))`
- **Get Full Network**: `get_regulatory_network(e_coli_regulondb, type = "TF-GENE")`
- **Get Binding Sites**: `get_binding_sites(e_coli_regulondb, transcription_factor = "AraC")`
- **Regulatory Summary**: `get_regulatory_summary(e_coli_regulondb, gene_regulators = c("araC", "modB"))`

### 5. Bioconductor Integration
Convert results to standard formats for downstream analysis:
- **GRanges**: Set `output_format = "GRanges"` in `get_dataset()` or use `convert_to_granges(res)`.
- **Sequences**: Set `output_format = "DNAStringSet"` or use `convert_to_biostrings(res, seq_type = "DNA")`.

### 6. Genomic Visualization
Retrieve and plot genomic elements (genes, promoters, terminators) within a specific range:
```r
grange <- GenomicRanges::GRanges("chr", IRanges::IRanges(5000, 10000))

# Retrieve objects
elements <- get_dna_objects(e_coli_regulondb, grange)

# Plot objects (requires Gviz)
plot_dna_objects(e_coli_regulondb, grange, elements = c("gene", "promoter"))
```

## Tips and Best Practices
- **Complex Filters**: Use `and = TRUE` (all conditions) or `and = FALSE` (any condition) when passing multiple filters in a list.
- **Partial Matching**: Only apply `partialmatch` to character columns.
- **Cytoscape**: If Cytoscape is running locally, `get_regulatory_network(..., cytograph = TRUE)` will automatically push the network to the Cytoscape GUI.
- **Coordinates**: Ensure you include `posleft`, `posright`, and `strand` in your attributes if you intend to convert the result to a `GRanges` object.

## Reference documentation
- [regutools: an R package for the extraction of gene regulatory networks from RegulonDB](./references/regutools.Rmd)
- [regutools: an R package for data extraction from RegulonDB](./references/regutools.md)