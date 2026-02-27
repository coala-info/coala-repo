---
name: bioconductor-rblast
description: The rBLAST package provides an R interface to the BLAST+ software suite for performing local sequence alignments using Biostrings objects. Use when user asks to create local BLAST databases, perform sequence searches against a database, or integrate BLAST alignments into Bioconductor workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/rBLAST.html
---


# bioconductor-rblast

## Overview

The `rBLAST` package provides a seamless R interface to the BLAST+ software suite. It allows users to integrate local sequence alignment directly into Bioconductor workflows by using `Biostrings` objects (like `DNAStringSet` or `AAStringSet`) as queries. Key capabilities include creating local databases from FASTA files or R objects and executing searches with customizable parameters.

## System Requirements

The BLAST+ command-line tools must be installed on the system.
- Check installation: `Sys.which("blastn")`
- If not found, set the path: `Sys.setenv(PATH = paste(Sys.getenv("PATH"), "path/to/blast/bin", sep=.Platform$path.sep))`

## Core Workflow

### 1. Database Management

**Create a database from a FASTA file:**
```r
library(rBLAST)
# dbtype can be "nucl" for nucleotides or "prot" for proteins
makeblastdb(file = "sequences.fasta", db_name = "my_db", dbtype = "nucl")
```

**Load an existing database:**
```r
# Point to the base name of the database files
bl <- blast(db = "./my_db")
```

### 2. Performing Queries

Use the `predict()` function to run the alignment. The query should be a `Biostrings` object.

```r
library(Biostrings)
query_seq <- readDNAStringSet("query.fasta")

# Run BLAST search
results <- predict(bl, query_seq)
```

### 3. Customizing Search Parameters

You can pass standard BLAST+ command-line arguments via the `BLAST_args` parameter and define specific output columns using `custom_format`.

```r
# Example: 99% identity threshold and custom output columns
fmt <- "qaccver saccver pident length evalue bitscore"
results <- predict(bl, query_seq, 
                   BLAST_args = "-perc_identity 99", 
                   custom_format = fmt)
```

## Common Tasks

- **Download NCBI Databases:** Use `blast_db_get("database_name.tar.gz")` to fetch pre-trained databases (e.g., 16S Microbial rRNA).
- **Create DB from R Objects:** First write the `XStringSet` to a temporary file using `writeXStringSet()`, then call `makeblastdb()`.
- **Result Format:** The output is a standard R `data.frame`, making it easy to filter using `subset()` or `dplyr`.

## Reference documentation

- [rBLAST: R Interface for the Basic Local Alignment Search Tool](./references/blast.md)