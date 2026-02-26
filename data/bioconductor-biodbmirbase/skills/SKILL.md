---
name: bioconductor-biodbmirbase
description: The biodbMirbase package provides a connector to the miRBase mature database for retrieving miRNA entry details and sequences within the biodb framework. Use when user asks to retrieve miRNA entry data, fetch miRBase accession IDs, or convert miRNA database entries into R data frames.
homepage: https://bioconductor.org/packages/3.16/bioc/html/biodbMirbase.html
---


# bioconductor-biodbmirbase

## Overview
The `biodbMirbase` package is a Bioconductor extension that provides a connector to the miRBase mature database. It operates within the `biodb` framework, allowing users to programmatically retrieve miRNA entry details, including sequences and nomenclature, and convert them into standard R data structures like data frames.

## Installation
To install the package, use the BiocManager:
```r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install('biodbMirbase')
```

## Typical Workflow

### 1. Initialization
Every session must start by creating a `biodb` instance and then instantiating the miRBase connector.
```r
# Load the library and create the main biodb instance
mybiodb <- biodb::newInst()

# Create the connector specifically for miRBase mature database
conn <- mybiodb$getFactory()$createConn('mirbase.mature')
```

### 2. Retrieving Entry IDs
You can fetch a specific number of entry IDs (accession numbers) from the database.
```r
# Get the first 10 accession IDs
ids <- conn$getEntryIds(10)
```

### 3. Accessing Entry Data
Once you have IDs (e.g., "MIMAT0000001"), you can retrieve the full entry objects.
```r
# Retrieve entries for specific IDs
entries <- conn$getEntry(ids)
```

### 4. Data Conversion
To perform analysis, convert the list of entry objects into a standard R data frame.
```r
# Convert entries to a data frame
df <- mybiodb$entriesToDataframe(entries)

# The resulting data frame typically contains:
# accession, description, name, aa.seq (the miRNA sequence), and mirbase.mature.id
```

### 5. Termination
Always terminate the `biodb` instance to release system resources and close connections.
```r
mybiodb$terminate()
```

## Tips and Best Practices
- **Caching**: `biodb` uses a local cache system. Subsequent requests for the same IDs will be significantly faster.
- **Batch Processing**: When dealing with many miRNAs, retrieve them in batches using `getEntry()` to optimize network usage.
- **Sequence Column**: Note that in the resulting data frame, the miRNA sequence is often found in the `aa.seq` column (inherited from the generic biodb entry schema).

## Reference documentation
- [An introduction to biodbMirbase](./references/biodbMirbase.md)