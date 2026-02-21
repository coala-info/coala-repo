---
name: bioconductor-greengenes13.5mgdb
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/greengenes13.5MgDb.html
---

# bioconductor-greengenes13.5mgdb

name: bioconductor-greengenes13.5mgdb
description: Access and query the Greengenes 16S rRNA database (version 13.5) within R. Use this skill to retrieve 16S rRNA sequences, taxonomic information, and metadata from the Greengenes reference database for metagenomic and microbiome analysis.

# bioconductor-greengenes13.5mgdb

## Overview
The `greengenes13.5MgDb` package is a Bioconductor annotation data package that provides a `MgDb-class` object containing the Greengenes database version 13.5. It allows users to programmatically interact with 16S rRNA reference data, facilitating taxonomic assignment and sequence comparison. The package relies on the `metagenomeFeatures` package for its core functionality and API.

## Basic Usage

### Loading the Database
To use the database, load the package. The primary object, `gg13.5MgDb`, is automatically instantiated.

```r
library(greengenes13.5MgDb)

# View the object details
gg13.5MgDb
```

### Exploring the Object
The `gg13.5MgDb` object contains taxonomic data, sequences, and metadata. You can check the available columns and taxonomic levels.

```r
# List available taxonomic levels/columns
colnames(mgDb_taxa(gg13.5MgDb))
```

## Common Workflows

### Querying Taxonomy and Sequences
The `metagenomeFeatures` package provides the methods to interact with this object. The most common functions are `mgDb_select`, `mgDb_taxa`, and `mgDb_seq`.

#### Selecting Specific Taxa
Use `mgDb_select` to retrieve data based on specific criteria (e.g., a specific genus or OTU ID).

```r
library(metagenomeFeatures)

# Select data for a specific genus
res <- mgDb_select(gg13.5MgDb, 
                   type = "taxa", 
                   keys = "g__Bacteroides", 
                   keytype = "Genus")
```

#### Retrieving Sequences
You can retrieve sequences for specific IDs or taxonomic groups.

```r
# Retrieve sequences for specific OTU IDs
ids <- c("1111101", "1111102")
seqs <- mgDb_select(gg13.5MgDb, 
                    type = "seq", 
                    keys = ids, 
                    keytype = "Keys")
```

### Integration with Other Tools
The data retrieved from `gg13.5MgDb` is typically returned as `DataFrame` or `DNAStringSet` objects, making it compatible with standard Bioconductor workflows (e.g., `Biostrings`, `phyloseq`).

## Tips
- **Memory Management**: The `MgDb` object uses a SQLite database backend for taxonomy and an integrated sequence store, making it more memory-efficient than loading the entire Greengenes fasta file into memory.
- **Method Discovery**: Since `gg13.5MgDb` is an `MgDb-class` object, refer to the `metagenomeFeatures` documentation for advanced filtering and data manipulation methods.
- **Version Specificity**: This package is specific to Greengenes 13.5. If your analysis requires a different version (e.g., 13.8), you must use the corresponding MgDb package.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)