---
name: r-taxonomizr
description: Functions for assigning taxonomy to NCBI accession numbers and taxon IDs based on NCBI's accession2taxid and taxdump files. This package allows the user to download NCBI data dumps and create a local database for fast and local taxonomic assignment.</p>
homepage: https://cran.r-project.org/web/packages/taxonomizr/index.html
---

# r-taxonomizr

## Overview
The `taxonomizr` package provides an efficient, local solution for mapping NCBI accession numbers and taxonomic IDs to full taxonomic lineages. It is particularly useful for processing BLAST results or large-scale genomic datasets without relying on slow web APIs. It uses a local SQLite database to store NCBI's `accession2taxid` and `taxdump` data.

## Installation
Install the package from CRAN:
```r
install.packages("taxonomizr")
library(taxonomizr)
```

## Database Preparation
Before performing lookups, you must initialize a local SQLite database. **Note:** A full database requires ~75 GB of disk space and significant time to download/index.

```r
# Prepare a full database (Nucleotide GB and WGS)
prepareDatabase('accessionTaxa.sql')

# Prepare only for proteins
prepareDatabase('accessionTaxa.sql', types = 'prot')

# Prepare only taxonomy (no accessions) - much smaller/faster
prepareDatabase('accessionTaxa.sql', getAccessions = FALSE)
```

## Core Workflow: Accessions to Taxonomy
The most common workflow involves converting BLAST accessions to IDs, then IDs to a taxonomy matrix.

```r
sql <- 'accessionTaxa.sql'
accessions <- c("Z17430.1", "Z17429.1", "X62402.1")

# 1. Convert accessions to Taxon IDs
ids <- accessionToTaxa(accessions, sql)

# 2. Get full taxonomy matrix
taxa <- getTaxonomy(ids, sql)
# Returns columns: superkingdom, phylum, class, order, family, genus, species
```

## Specialized Functions

### Finding IDs by Name
Convert biological names to NCBI Taxon IDs:
```r
ids <- getId(c('Homo sapiens', 'Bos taurus'), sql)
```

### Finding Descendants
Retrieve all descendants at a specific rank (e.g., all species in a genus):
```r
# Get all species in the Homininae subfamily (ID 207598)
getDescendants(207598, sql, rank = 'species')
```

### Common Names
Retrieve common names and synonyms for IDs:
```r
getCommon(c(9606, 9913), sql)
```

### Lowest Common Ancestor (LCA)
Condense multiple taxonomic hits into their most specific shared rank:
```r
# taxa is a matrix from getTaxonomy
lca <- condenseTaxa(taxa)

# Grouped LCA (e.g., multiple BLAST hits per read)
groups <- c('read1', 'read1', 'read2')
lca_grouped <- condenseTaxa(taxa, groups)
```

### Raw Taxonomy and Normalization
For lineages containing non-standard ranks (clades, suborders):
```r
# Get every rank available
raw <- getRawTaxonomy(c(9606, 9913), sql)

# Normalize into a consistent matrix
norm_taxa <- normalizeTaxa(raw)
```

### Newick Tree Generation
Convert a taxonomy matrix into a Newick-formatted tree string:
```r
tree <- makeNewick(taxa, quote = "'", excludeTerminalNAs = TRUE)
```

## Tips and Troubleshooting
- **Accession Versions**: If `accessionToTaxa` returns `NA`, try `version = 'base'` to ignore the version suffix (e.g., `.1`).
- **Database Updates**: NCBI changed several prokaryote phylum names in 2023 (e.g., Firmicutes to Bacillota). If names look unexpected, ensure your database is recently generated.
- **Memory/Speed**: For `getAccessions` (finding accessions for a Taxon ID), you must rebuild the database with `indexTaxa = TRUE` in `read.accession2taxid`.
- **Protocols**: If FTP downloads fail due to firewalls, use `protocol = 'http'` in download functions.

## Reference documentation
- [taxonomizr usage](./references/usage.Rmd)