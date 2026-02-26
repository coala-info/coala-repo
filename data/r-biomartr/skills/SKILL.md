---
name: r-biomartr
description: The biomartr R package provides a standardized interface for retrieving genomic data and functional annotations from major databases like NCBI, ENSEMBL, and UniProt. Use when user asks to download genomes, proteomes, or GFF files, perform bulk meta-genome retrieval, or map gene identifiers to functional annotations using BioMart.
homepage: https://cran.r-project.org/web/packages/biomartr/index.html
---


# r-biomartr

name: r-biomartr
description: Expert guidance for using the biomartr R package to retrieve genomic data (genomes, proteomes, CDS, GFF, RNA) from NCBI (RefSeq/Genbank), ENSEMBL, and UniProt, as well as performing functional annotation via BioMart. Use this skill when you need to automate large-scale data retrieval, perform meta-genomic downloads, or map gene identifiers to functional annotations in R.

# r-biomartr

## Overview
The `biomartr` package provides a standardized interface for retrieving genomic data and functional annotations. It simplifies the process of finding and downloading data from major databases like NCBI and ENSEMBL by using an organism-centric approach rather than requiring users to know specific database internal structures.

## Installation
```r
install.packages("biomartr")
library(biomartr)
```

## Core Workflows

### 1. Genomic Data Retrieval
Retrieve specific file types for a single organism. Supported databases: `refseq`, `genbank`, `ensembl`.

```r
# Download genome
getGenome(db = "refseq", organism = "Arabidopsis thaliana")

# Download proteome
getProteome(db = "refseq", organism = "Arabidopsis thaliana")

# Download CDS (Coding Sequences)
getCDS(db = "refseq", organism = "Arabidopsis thaliana")

# Download GFF/GTF annotation
getGFF(db = "refseq", organism = "Arabidopsis thaliana")
```

### 2. Meta-Genome Retrieval (Bulk Download)
Download data for entire kingdoms or specific taxonomic groups.

```r
# List available kingdoms
getKingdoms(db = "refseq")

# Download all reference genomes for a kingdom
meta.retrieval(kingdom = "plant", db = "refseq", type = "genome", reference = TRUE)

# Download a specific group (e.g., Gammaproteobacteria)
meta.retrieval(kingdom = "bacteria", group = "Gammaproteobacteria", db = "refseq", type = "genome")
```

### 3. Functional Annotation via BioMart
An organism-centric way to query Ensembl BioMart without manually searching for marts and datasets.

```r
# 1. Find available attributes and filters for an organism
attrs <- organismAttributes("Homo sapiens")
filts <- organismFilters("Homo sapiens")

# 2. Perform the query
result <- biomart(
  genes      = c("GUCA2A", "GUCY2C"),
  mart       = "ENSEMBL_MART_ENSEMBL",
  dataset    = "hsapiens_gene_ensembl",
  attributes = c("hgnc_symbol", "description", "go_id"),
  filters    = "hgnc_symbol"
)

# Quick GO term retrieval
go_terms <- getGO(organism = "Homo sapiens", genes = "GUCA2A", filters = "hgnc_symbol")
```

### 4. NCBI Database Retrieval
Download pre-formatted BLAST databases or specialized NCBI collections.

```r
# List available NCBI databases
listNCBIDatabases(db = "all")

# Download a specific database (e.g., Swissprot)
download.database.all(db = "swissprot", path = "swissprot_db")
```

## Tips for Success
- **Timeout Settings**: For large downloads, increase the R timeout limit: `options(timeout = 30000)`.
- **Scientific Names**: Always use correct scientific names (e.g., "Homo sapiens", not "Human").
- **Caching**: `biomartr` caches dataset lists in `tempdir()`. If names change or queries fail, try `organismAttributes(update = TRUE)`.
- **Data Cleaning**: Use `clean.retrieval()` after `meta.retrieval()` to automatically unzip and rename files for easier downstream processing.

## Reference documentation
- [Ensembl BioMart Examples](./references/BioMart_Examples.Rmd)
- [NCBI Database Retrieval](./references/Database_Retrieval.Rmd)
- [Functional Annotation with biomartr](./references/Functional_Annotation.Rmd)
- [Meta-Genome Retrieval](./references/MetaGenome_Retrieval.Rmd)
- [Sequence Retrieval](./references/Sequence_Retrieval.Rmd)