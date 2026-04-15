---
name: bioconductor-hom.dr.inp.db
description: This Bioconductor package provides orthology and paralogy mappings for Zebrafish using Inparanoid data. Use when user asks to identify orthologous genes between Zebrafish and other species, perform cross-species gene ID conversions, or map Zebrafish protein IDs to predicted paralogs.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/hom.Dr.inp.db.html
---

# bioconductor-hom.dr.inp.db

name: bioconductor-hom.dr.inp.db
description: Orthology and paralogy mapping for Danio rerio (Zebrafish) using Inparanoid data. Use when needing to identify orthologous genes between Zebrafish and other species (Human, Mouse, etc.) or performing cross-species gene ID conversions.

## Overview

The hom.Dr.inp.db package is a Bioconductor annotation data package providing orthology mappings for Zebrafish (*Danio rerio*). It utilizes data from the Inparanoid algorithm to map Zebrafish gene identifiers to their predicted paralogs and orthologs in dozens of other organisms. These mappings are filtered to include only high-confidence paralogs (Inparanoid score of 100).

## Getting Started

Load the package and explore available mapping objects:

library(hom.Dr.inp.db)
# List all available maps
ls("package:hom.Dr.inp.db")
# Check the organism name
hom.Dr.inpORGANISM

## Mapping Orthologs

Mappings are provided as R objects named using the "INPARANOID style": the first three letters of the genus followed by the first two letters of the species (e.g., HOMSA for Homo sapiens).

### Basic Retrieval
To find orthologs for Zebrafish genes in another species (e.g., Honeybee - APIME):

# Get the mapping object
x <- hom.Dr.inpAPIME
# Get Zebrafish IDs that have mappings
mapped_IDs <- mappedkeys(x)
# Convert to a list to see Zebrafish ID to Honeybee ID mappings
xx <- as.list(x[mapped_IDs])
# Access specific mappings
xx[1:5]

### Reverse Mapping
To map from another species back to Zebrafish, use the revmap function:

# Map Honeybee IDs back to Zebrafish
x_rev <- revmap(hom.Dr.inpAPIME)
xx_rev <- as.list(x_rev)

## Cross-Species ID Conversion Workflow

Inparanoid typically uses Ensembl protein IDs. To convert between Entrez Gene IDs across species, combine this package with organism-specific annotation packages (org.db).

Example workflow (Zebrafish to Human):
1. Use org.Dr.eg.db to map Zebrafish Entrez IDs to Ensembl Protein IDs.
2. Use hom.Dr.inpHOMSA to map Zebrafish Protein IDs to Human Protein IDs.
3. Use org.Hs.eg.db to map Human Protein IDs back to Human Entrez IDs.

## Database Utilities

Access underlying metadata and database connections:

# Get number of mapped keys for all maps
hom.Dr.inpMAPCOUNTS

# Get DB connection or file path
hom.Dr.inp_dbconn()
hom.Dr.inp_dbfile()

# View database schema
hom.Dr.inp_dbschema()

## Reference documentation

- [hom.Dr.inp.db Reference Manual](./references/reference_manual.md)