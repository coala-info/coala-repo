---
name: r-rblast
description: This tool provides an R interface for the Basic Local Alignment Search Tool to perform sequence searches and manage BLAST databases. Use when user asks to search genetic sequence databases, create custom BLAST databases, or perform sequence alignments within R.
homepage: https://cran.r-project.org/web/packages/rblast/index.html
---

# r-rblast

name: r-rblast
description: R interface for the Basic Local Alignment Search Tool (BLAST). Use this skill when you need to search genetic sequence databases (blastn, blastp, blastx) or create custom BLAST databases within R using the Bioconductor infrastructure.

## Overview

The `rBLAST` package provides an R interface to the NCBI BLAST+ software. It allows users to build custom BLAST databases from `Biostrings` objects and perform sequence searches directly within the R environment, returning results as standard R data frames.

## Installation

To install the package, use the BiocManager:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rBLAST")
```

Note: The NCBI BLAST+ command-line tools must be installed on your system and available in the system path for this package to function.

## Core Workflow

### 1. Database Management
You can load an existing BLAST database or create a new one from a FASTA file or a `Biostrings` object.

```R
library(rBLAST)

# Load an existing database
bl <- blast(db = "./path/to/database")

# Create a new database from a FASTA file
makeblastdb(file = "my_sequences.fasta", dbtype = "nucl")
```

### 2. Querying the Database
Use the `predict()` function to perform searches. The query should be a `DNAStringSet`, `RNAStringSet`, or `AAStringSet` object.

```R
# Load query sequences
query <- readDNAStringSet("query.fasta")

# Run BLAST search
results <- predict(bl, query)

# Run BLAST with specific arguments (e.g., E-value threshold, identity percentage)
results <- predict(bl, query, BLAST_args = "-evalue 1e-5 -perc_identity 95")
```

### 3. Remote Searches
`rBLAST` can also interface with remote NCBI databases.

```R
# Setup remote search against 'nr' database
bl_remote <- blast(db = "nr", remote = TRUE)

# Execute remote query
results <- predict(bl_remote, query)
```

## Key Functions

- `blast(db, type, remote = FALSE)`: Initializes a BLAST database object.
- `predict(object, newdata, ...)`: Performs the sequence alignment search.
- `makeblastdb(file, dbtype, ...)`: Creates a local BLAST database.
- `blast_db_get(db)`: Utility to download pre-formatted databases from NCBI.

## Tips
- **Data Frames**: Results are returned as a `data.frame` with standard BLAST headers (qseqid, sseqid, pident, length, etc.), making them easy to filter using `dplyr` or base R.
- **Sequence Types**: Ensure the `dbtype` in `makeblastdb` matches your sequence data ("nucl" for DNA/RNA, "prot" for Protein).
- **BLAST Arguments**: Pass any standard BLAST+ command-line flags as a single string to the `BLAST_args` parameter in `predict()`.

## Reference documentation

- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)