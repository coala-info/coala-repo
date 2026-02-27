---
name: bioconductor-ribosomaldatabaseproject11.5mgdb
description: This package provides access to the Ribosomal Database Project version 11.5 16S rRNA database using the MgDb-class framework. Use when user asks to query taxonomic data, retrieve 16S rRNA sequences, or perform taxonomic assignment for Bacteria and Archaea.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/ribosomaldatabaseproject11.5MgDb.html
---


# bioconductor-ribosomaldatabaseproject11.5mgdb

name: bioconductor-ribosomaldatabaseproject11.5mgdb
description: Access and query the Ribosomal Database Project (RDP) version 11.5 16S rRNA database. Use this skill when performing taxonomic assignment, sequence alignment, or phylogenetic analysis in R using the MgDb-class framework for Bacteria and Archaea.

# bioconductor-ribosomaldatabaseproject11.5mgdb

## Overview
The `ribosomaldatabaseproject11.5MgDb` package provides a specialized `MgDb-class` object containing sequence and taxonomic data from the Ribosomal Database Project (RDP) Release 11.5. It is designed for use with the `metagenomeFeatures` ecosystem, allowing users to efficiently query 16S rRNA sequences and their associated hierarchical taxonomies for Bacteria and Archaea.

## Usage Guidance

### Loading the Database
The package automatically creates an object named `rdp11.5MgDb` upon loading.

```r
library(ribosomaldatabaseproject11.5MgDb)

# View object summary
rdp11.5MgDb
```

### Core Workflows
Since the object is a `MgDb` class, you interact with it primarily using functions from the `metagenomeFeatures` package.

#### 1. Exploring Taxonomy
You can retrieve the taxonomic hierarchy or specific levels stored within the database.

```r
# List available taxonomic slots
mgDb_taxa(rdp11.5MgDb)
```

#### 2. Querying the Database
Use `mgDb_select` to retrieve specific sequences or taxonomic information based on keys (e.g., RDP IDs or specific taxa).

```r
# Example: Select data for a specific genus
# Note: requires metagenomeFeatures package
library(metagenomeFeatures)

query_results <- mgDb_select(rdp11.5MgDb, 
                             type = "taxa", 
                             keys = "Bacteroides", 
                             keytype = "Genus")
```

#### 3. Sequence Retrieval
You can extract the DNA sequences associated with specific database entries.

```r
# Retrieve sequences for specific IDs
seqs <- mgDb_select(rdp11.5MgDb, 
                    type = "seq", 
                    keys = c("RDP_ID_1", "RDP_ID_2"))
```

### Key Object: rdp11.5MgDb
- **Data Source**: RDP Release 11.5.
- **Content**: 16S rRNA sequences for Bacteria and Archaea.
- **Format**: `MgDb` (Metagenome Database) object, which integrates a SQLite database for taxonomy and a `Biostrings` object for sequences.

## Tips
- Ensure the `metagenomeFeatures` package is installed to access the full API for `MgDb` objects.
- Use `ls('package:ribosomaldatabaseproject11.5MgDb')` to verify the available objects in the namespace.
- The database is optimized for memory efficiency by keeping taxonomy in a database backend and loading sequences only when requested.

## Reference documentation
- [ribosomaldatabaseproject11.5MgDb Reference Manual](./references/reference_manual.md)