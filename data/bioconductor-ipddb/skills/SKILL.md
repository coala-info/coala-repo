---
name: bioconductor-ipddb
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ipdDb.html
---

# bioconductor-ipddb

## Overview
The `ipdDb` package provides an SQLite-based interface to the IPD IMGT/HLA and IPD-KIR databases. It allows users to query allele names, retrieve DNA sequences (as `DNAStringSet`), and obtain gene structures (as `GRanges`). A key feature is its ability to map alleles that are not full-length to their closest available full-length reference allele.

## Core Workflow

### 1. Loading Data
The package uses specific loader functions to initialize the database connection objects.

```r
library(ipdDb)

# Load HLA data
hla <- loadHlaData()

# Load KIR data
kir <- loadKirData()
```

### 2. Exploring Loci and Alleles
Use the object-oriented methods to explore the contents of the database.

```r
# List all available loci (e.g., "HLA-A", "KIR2DL1")
available_loci <- hla$getLoci()

# Get all allele names for a specific locus
alleles_a <- hla$getAlleles("HLA-A")
```

### 3. Retrieving Sequences
Sequences are returned as `Biostrings::DNAStringSet` objects.

```r
# Get sequences for specific alleles
my_alleles <- c("HLA-A*01:01:01:01", "HLA-A*01:01:01:03")
sequences <- hla$getReference(my_alleles)

# Get the closest complete reference for an incomplete allele
# Note: This method typically takes a single allele string
closest <- hla$getClosestComplete("HLA-A*01:01:01:01")
```

### 4. Gene Structure
Retrieve genomic coordinates and structures (exons/introns) as `GenomicRanges::GRanges` objects.

```r
# Get structure for a set of alleles
structures <- hla$getStructure(my_alleles)
```

### 5. Standard Database Queries
Since `ipdDb` objects are compatible with Bioconductor's `AnnotationDbi` interface, you can use standard `select` methods.

```r
# Check available columns and keytypes
columns(hla)
keytypes(hla)

# Perform a custom query
res <- select(hla, 
              keys = "HLA-A*01:01:01:01", 
              columns = c("SYMBOL", "RELEASE"), 
              keytype = "ALLELE")
```

## Tips and Best Practices
- **HLA Limitations**: For HLA data, the package is currently limited to HLA-A, -B, -C, -DPB1, -DQB1, and -DRB1.
- **Object Methods**: Prefer using the `$` methods (e.g., `hla$getAlleles()`) for quick biological queries, as they are specifically optimized for this package's schema.
- **Sequence Handling**: Since sequences are returned as `DNAStringSet`, you will need the `Biostrings` package loaded to perform downstream sequence analysis or exports.

## Reference documentation
- [ipdDb Vignette](./references/Readme.md)
- [ipdDb R Markdown Source](./references/Readme.Rmd)