---
name: bioconductor-ensembldb
description: The ensembldb package creates and queries Ensembl-based annotation databases to manage transcript-centric genomic features. Use when user asks to retrieve genomic features like genes or exons, perform coordinate mapping between genome, transcript, and protein levels, or filter Ensembl annotations using the AnnotationFilter framework.
homepage: https://bioconductor.org/packages/release/bioc/html/ensembldb.html
---


# bioconductor-ensembldb

name: bioconductor-ensembldb
description: Expert guidance for using the Bioconductor package ensembldb to create and query Ensembl-based annotation databases (EnsDb). Use this skill when you need to retrieve genomic features (genes, transcripts, exons), perform coordinate mapping between genome, transcript, and protein levels, or filter Ensembl annotations using the AnnotationFilter framework.

# bioconductor-ensembldb

## Overview
The `ensembldb` package provides a powerful framework for working with transcript-centric annotations fetched directly from Ensembl. It functions similarly to `GenomicFeatures` (TxDb) but adds advanced filtering, protein-specific annotations (mappings between proteins and transcripts), and robust coordinate mapping utilities.

## Core Workflows

### Loading and Inspecting EnsDb
Annotation databases are typically provided as Bioconductor packages (e.g., `EnsDb.Hsapiens.v86`).
```r
library(ensembldb)
library(EnsDb.Hsapiens.v86)
edb <- EnsDb.Hsapiens.v86

# Basic inspection
edb
organism(edb)
metadata(edb)
```

### Retrieving Features with Filters
Use `genes()`, `transcripts()`, or `exons()` to retrieve data. Filtering can be done via filter objects or formula expressions.
```r
# Using formula-based filters
gns <- genes(edb, filter = ~ gene_name == "BCL2")

# Combining filters
txs <- transcripts(edb, filter = ~ genename == "ZBTB16" & tx_biotype == "protein_coding")

# Supported filters overview
supportedFilters(edb)
```

### Coordinate Mapping
`ensembldb` supports seamless mapping across three coordinate systems: Genome, Transcript, and Protein.

| From | To | Function |
| :--- | :--- | :--- |
| Genome | Transcript | `genomeToTranscript(granges, edb)` |
| Genome | Protein | `genomeToProtein(granges, edb)` |
| Protein | Transcript | `proteinToTranscript(iranges, edb)` |
| Protein | Genome | `proteinToGenome(iranges, edb)` |
| Transcript | Genome | `transcriptToGenome(iranges, edb)` |
| Transcript | Protein | `transcriptToProtein(iranges, edb)` |

**Note:** Mapping to/from protein coordinates returns a `cds_ok` column. If `FALSE`, the CDS length doesn't match the protein length (common in incomplete Ensembl models), and results should be verified.

### Protein Annotations
Retrieve protein sequences or domain information directly from the database.
```r
# Get protein sequences for a gene
prt <- proteins(edb, filter = ~ gene_name == "SYP", return.type = "AAStringSet")

# Get protein domains
pdoms <- proteins(edb, filter = ~ gene_name == "SIM2", 
                  columns = c("protein_domain_id", "prot_dom_start", "prot_dom_end"))
```

### Using a MySQL Backend
If you have a local Ensembl MySQL mirror, you can use it instead of the default SQLite files.
```r
# Convert an existing EnsDb to MySQL
edb_mysql <- useMySQL(EnsDb.Hsapiens.v86, host = "localhost", user = "user", pass = "pass")

# Connect to an existing MySQL EnsDb
library(RMariaDB)
dbcon <- dbConnect(MariaDB(), host = "localhost", dbname = "ensdb_hsapiens_v75")
edb <- EnsDb(dbcon)
```

## Tips and Best Practices
- **UCSC vs Ensembl Names:** Ensembl uses "1", "2", "X" while UCSC uses "chr1", "chr2", "chrX". Use `seqlevelsStyle(edb) <- "UCSC"` to switch styles globally for the object.
- **Global Filtering:** Use `addFilter(edb, SeqNameFilter("X"))` to create a virtual database object that only returns results for a specific chromosome, speeding up subsequent queries.
- **Return Types:** Most functions return `GRanges` by default. Use `return.type = "DataFrame"` or `return.type = "data.frame"` if you do not need genomic coordinates.
- **CDS vs Transcript:** Remember that `transcriptToGenome` uses coordinates relative to the start of the transcript (5' UTR), whereas many clinical variants are reported relative to the CDS. Use `cdsToTranscript()` to convert before mapping to the genome.

## Reference documentation
- [Using a MySQL server backend](./references/MySQL-backend.md)
- [Use cases for coordinate mapping with ensembldb](./references/coordinate-mapping-use-cases.md)
- [Mapping between genome, transcript and protein coordinates](./references/coordinate-mapping.md)
- [Generating and using Ensembl based annotation packages](./references/ensembldb.md)
- [Protein Annotations](./references/proteins.md)