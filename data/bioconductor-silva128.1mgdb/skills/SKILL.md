---
name: bioconductor-silva128.1mgdb
description: This package provides a database object containing SILVA SSU rRNA sequence and taxonomic data for use with the metagenomeFeatures framework. Use when user asks to query ribosomal RNA sequences, retrieve taxonomic lineages, or annotate sequence IDs with SILVA taxonomy.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/silva128.1MgDb.html
---

# bioconductor-silva128.1mgdb

## Overview
The `silva128.1MgDb` package provides a specialized `MgDb-class` object containing sequence and taxonomic data from the SILVA SSU rRNA database (version 128.1). It is designed for use with the `metagenomeFeatures` framework, allowing users to efficiently query ribosomal RNA sequences and their associated hierarchical taxonomy.

## Usage Guidance

### Loading the Database
The package automatically instantiates a database object named `slv128.1MgDb` upon loading.

```r
library(silva128.1MgDb)

# View object summary
slv128.1MgDb
```

### Core Workflows
Since `slv128.1MgDb` is an `MgDb` object, you interact with it using methods from the `metagenomeFeatures` package.

#### 1. Taxonomic Queries
Use `mgDb_select` to retrieve specific taxonomic lineages or sequences based on keys (e.g., GenBank accession numbers or taxonomic names).

```r
library(metagenomeFeatures)

# Select data for a specific genus
genus_data <- mgDb_select(slv128.1MgDb, 
                          type = "taxonomy", 
                          keys = "Bacteroides", 
                          keytype = "Genus")
```

#### 2. Sequence Retrieval
Retrieve DNA sequences associated with specific taxonomic groups.

```r
# Get sequences for a specific set of IDs
seqs <- mgDb_select(slv128.1MgDb, 
                    type = "seq", 
                    keys = c("AJ000001", "AJ000002"), 
                    keytype = "IDS")
```

#### 3. Annotating Metadata
If you have a set of sequence IDs, you can annotate them with the full SILVA taxonomic path.

```r
# Retrieve taxonomy for specific IDs
taxa_info <- mgDb_select(slv128.1MgDb, 
                         type = "all", 
                         keys = c("AJ000001"), 
                         keytype = "IDS")
```

### Key Object: slv128.1MgDb
*   **Class**: `MgDb`
*   **Data Source**: SILVA SSU rRNA release 128.1
*   **Contents**: Taxonomic tree, sequence data (DNAStringSet), and metadata.

## Tips
*   **Memory Management**: The database object points to an integrated SQLite database and a sequence file; it is more memory-efficient than loading a raw FASTA file of the entire SILVA database.
*   **Keytypes**: Common keytypes include "IDS" (Accession numbers), "Kingdom", "Phylum", "Class", "Order", "Family", and "Genus".
*   **Dependencies**: Ensure `metagenomeFeatures` is installed to utilize the full API for the `slv128.1MgDb` object.

## Reference documentation
- [silva128.1MgDb Reference Manual](./references/reference_manual.md)