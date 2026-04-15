---
name: bioconductor-sradb
description: Bioconductor-sradb provides an interface to query and download metadata and sequencing data from the NCBI Sequence Read Archive via a local SQLite database. Use when user asks to search for sequencing experiments, convert between SRA accession types, perform full-text searches on metadata, or generate download links for SRA and FASTQ files.
homepage: https://bioconductor.org/packages/release/bioc/html/SRAdb.html
---

# bioconductor-sradb

name: bioconductor-sradb
description: Querying and downloading metadata and data from the Sequence Read Archive (SRA) using the SRAdb Bioconductor package. Use this skill when you need to search for sequencing experiments, convert between SRA accessions (SRP, SRX, SRR, SRS), perform full-text searches on SRA metadata, or generate download links for SRA/FASTQ files.

# bioconductor-sradb

## Overview
The `SRAdb` package provides a powerful interface to the NCBI Sequence Read Archive (SRA) by utilizing a regularly updated local SQLite database. This allows for complex SQL queries and high-performance full-text searches that are often difficult via the NCBI web interface. It also facilitates high-speed data downloads using both FTP and the Aspera (fasp) protocol.

## Core Workflow

### 1. Database Setup
The package requires a local SQLite file (`SRAmetadb.sqlite`).
```r
library(SRAdb)
# Download the latest SRAmetadb.sqlite file (Warning: >35GB uncompressed)
# sqlfile <- getSRAdbFile() 

# Connect to the database
sra_con <- dbConnect(SQLite(), sqlfile)
```

### 2. Metadata Exploration
You can list tables and fields to understand the schema.
```r
# List all tables (study, sample, experiment, run, etc.)
dbListTables(sra_con)

# List fields in a specific table
dbListFields(sra_con, "study")

# Get column descriptions
colDescriptions(sra_con)
```

### 3. Searching the SRA
There are two primary ways to search: standard SQL and Full-Text Search (FTS).

**Full-Text Search (Recommended for discovery):**
```r
# Search for "breast cancer" across all metadata fields
rs <- getSRA(search_terms = "breast cancer", out_types = c('run', 'study'), sra_con)

# Search for specific fields using Boolean operators
rs <- getSRA(search_terms = 'submission_center: GEO AND "MCF7"', out_types = c('sample'), sra_con)
```

**Standard SQL (Recommended for specific filtering):**
```r
# Find transcriptome studies
query <- "SELECT study_accession, study_title FROM study WHERE study_type LIKE 'Transcriptome%'"
rs <- dbGetQuery(sra_con, query)
```

### 4. Accession Conversion
Convert between different SRA entity types (e.g., finding all Runs for a Study).
```r
# Convert Study accession to all associated types
conversion <- sraConvert(c('SRP001007'), sra_con = sra_con)
```

### 5. Downloading Data
`SRAdb` can retrieve file information and download files.

**Retrieve File Info:**
```r
# Get FTP/FASP links for FASTQ files
fastq_info <- getFASTQinfo(c("SRX000122"), sra_con, srcType = 'ftp')
```

**Download Files:**
```r
# Download SRA files via FTP
getSRAfile(c("SRR000648"), sra_con, fileType = 'sra')

# Download via Aspera (fasp) for high speed (requires ascp installed)
# ascpCMD <- 'ascp -QT -l 300m -i <path_to_aspera_key>'
# getSRAfile("SRR000648", sra_con, fileType = 'fastq', srcType = 'fasp', ascpCMD = ascpCMD)
```

### 6. Visualization
Generate entity relationship graphs for specific search terms.
```r
library(Rgraphviz)
g <- sraGraph('primary thyroid cell line', sra_con)
plot(g)
```

## Tips and Best Practices
- **Memory Management**: The SQLite database is large. Always use `dbDisconnect(sra_con)` when finished to free resources.
- **Demo Mode**: For testing, `SRAdb` includes a small demo database: `system.file("extdata", "SRAmetadb_demo.sqlite", package="SRAdb")`.
- **FTS Syntax**: Use `*` for prefix matching (e.g., `'Carcino*'`) and double quotes for exact phrases (e.g., `'"breast cancer"'`).
- **IGV Integration**: Use `startIGV()` and `load2IGV()` to programmatically send BAM files to a running Integrative Genomics Viewer instance.

## Reference documentation
- [SRAdb](./references/SRAdb.md)