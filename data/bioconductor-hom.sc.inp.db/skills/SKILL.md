---
name: bioconductor-hom.sc.inp.db
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/hom.Sc.inp.db.html
---

# bioconductor-hom.sc.inp.db

name: bioconductor-hom.sc.inp.db
description: Orthology and paralogy mapping for Saccharomyces cerevisiae (yeast) using Inparanoid data. Use when Claude needs to: (1) Map S. cerevisiae genes to orthologs in other species (e.g., Human, Mouse, Rat), (2) Perform reverse mappings from other species back to yeast, (3) Access underlying SQLite database connections for custom queries, or (4) Identify available species mappings within the Inparanoid framework.

## Overview

The `hom.Sc.inp.db` package is a Bioconductor annotation data package providing detailed orthology information for *Saccharomyces cerevisiae*. It utilizes the Inparanoid algorithm to identify paralogs and orthologs between yeast and a wide variety of other organisms. Mappings are filtered to include only those with an Inparanoid score of 100 (the "seed" status).

## Core Usage

### Loading and Exploration

Load the package and list available mapping objects:

```r
library(hom.Sc.inp.db)
# List all available maps
ls("package:hom.Sc.inp.db")
# Check the organism name
hom.Sc.inpORGANISM
```

### Mapping Yeast to Other Species

Mappings use a 5-letter "INPARANOID style" abbreviation (3 letters for Genus, 2 for Species). For example, `HOMSA` for *Homo sapiens* or `MUSMU` for *Mus musculus*.

```r
# Map yeast IDs to Human (HOMSA)
x <- hom.Sc.inpHOMSA
# Get mapped keys
mapped_ids <- mappedkeys(x)
# Convert to list for inspection
as.list(x[mapped_ids[1:5]])
```

### Reverse Mapping

To map from another species back to *Saccharomyces cerevisiae*, use the `revmap` function:

```r
# Map from Honeybee (APIME) back to Yeast
x_rev <- revmap(hom.Sc.inpAPIME)
# Convert to list
as.list(x_rev[1:5])
```

## Species Abbreviations

Common species codes available in this package include:
- `HOMSA`: Homo sapiens (Human)
- `MUSMU`: Mus musculus (Mouse)
- `RATNO`: Rattus norvegicus (Rat)
- `DANRE`: Danio rerio (Zebrafish)
- `DROME`: Drosophila melanogaster (Fruit fly)
- `CAEEL`: Caenorhabditis elegans (Nematode)
- `ARATH`: Arabidopsis thaliana (Thale cress)

## Advanced Workflows

### Cross-referencing with OrgDb Packages

Inparanoid uses Ensembl Protein IDs. To work with Entrez Gene IDs, you must combine this package with organism-specific `org.db` packages.

```r
library(org.Hs.eg.db)
library(hom.Sc.inp.db)

# Example: Get Human Entrez IDs for Yeast proteins
# 1. Get Yeast to Human protein mapping
human_prots <- as.list(hom.Sc.inpHOMSA)
# 2. Use org.Hs.eg.db to map Human Protein IDs to Entrez IDs
# Note: Use the appropriate map like org.Hs.egENSEMBLPROT2EG
```

### Database Connectivity

Access the underlying SQLite database for complex SQL queries:

```r
# Get database connection
conn <- hom.Sc.inp_dbconn()
# Query metadata
dbGetQuery(conn, "SELECT * FROM metadata")
# Get database file path
hom.Sc.inp_dbfile()
```

## Reference documentation

- [hom.Sc.inp.db Reference Manual](./references/reference_manual.md)