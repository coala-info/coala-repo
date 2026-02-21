---
name: bioconductor-eupathdb
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/EuPathDB.html
---

# bioconductor-eupathdb

name: bioconductor-eupathdb
description: Access and query genomic annotations and structural data for eukaryotic pathogens from EuPathDB (e.g., TriTrypDB, PlasmoDB, FungiDB, ToxoDB) via AnnotationHub. Use when needing OrgDb or GRanges objects for pathogens like Leishmania, Trypanosoma, Plasmodium, or Toxoplasma for functional genomics and bioinformatics workflows.

# bioconductor-eupathdb

## Overview
The EuPathDB package provides a standardized interface to access genomic data from the Eukaryotic Pathogen Genomics Resource. It leverages the AnnotationHub framework to deliver two primary resource types: OrgDb (gene-level annotations like GO terms and pathways) and GRanges (genomic coordinates and transcript structure). This allows for seamless integration of pathogen data into standard Bioconductor workflows.

## Getting Started
To use EuPathDB resources, you must first establish a connection to AnnotationHub and query for the relevant pathogen data.

library(AnnotationHub)
ah <- AnnotationHub()

# Search for all available EuPathDB resources
meta <- query(ah, "EuPathDB")

# Filter for a specific organism and data type
# Example: Leishmania major OrgDb
res <- query(ah, c("Leishmania major", "OrgDb", "EuPathDB"))
orgdb <- res[[names(res)[1]]]

## Working with OrgDb Resources
OrgDb objects contain functional annotations. You can interact with them using the standard AnnotationDbi interface.

# List available annotation types
columns(orgdb)

# Retrieve gene IDs
gids <- keys(orgdb, keytype="GID")

# Fetch specific annotations (e.g., Chromosome, Type, and Description)
dat <- select(orgdb, 
              keys = head(gids), 
              columns = c("CHR", "TYPE", "GENEDESCRIPTION"), 
              keytype = "GID")

# Map genes to GO terms or Pathways
gene_go <- select(orgdb, keys = head(gids), columns = "GO_ID", keytype = "GID")
gene_pathway <- select(orgdb, keys = head(gids), columns = "PATHWAY", keytype = "GID")

## Working with GRanges Resources
GRanges objects provide structural information about genes, transcripts, exons, and CDS regions.

# Query and retrieve GRanges
res_gr <- query(ah, c("Leishmania major", "GRanges", "EuPathDB"))
gr <- res_gr[[names(res_gr)[1]]]

# Standard GenomicRanges operations
seqnames(gr)
strand(gr)
width(gr)

# Filter for specific feature types (e.g., only protein coding genes)
genes <- gr[gr$type == "gene"]

## Key Databases Supported
EuPathDB aggregates data from several specialized databases. You can filter your AnnotationHub queries using these provider names:
- AmoebaDB
- CryptoDB
- FungiDB
- GiardiaDB
- MicrosporidiaDB
- PiroplasmaDB
- PlasmoDB
- ToxoDB
- TriTrypDB
- TrichDB

## Tips for Success
- Specificity: When querying, include the strain name (e.g., "Friedlin") if multiple assemblies exist for a species.
- Caching: AnnotationHub caches downloads locally. If you encounter issues, check the hub cache location using `hubCache(ah)`.
- Versioning: EuPathDB resources in AnnotationHub are tied to specific releases (e.g., TriTrypDB 39). Check the `title` or `description` metadata field to verify the version.

## Reference documentation
- [EuPathDB](./references/EuPathDB.md)
- [EuPathDB AnnotationHub Tutorial](./references/EuPathDB_AnnotationHub_Tutorial.Rmd)
- [EuPathDB Developers Guide](./references/EuPathDB_Developers_Guide.Rmd)
- [EuPathDB Package Generation Tutorial](./references/EuPathDB_Package_Generation_Tutorial.Rmd)
- [EuPathDB Trey Playground](./references/EuPathDB_trey_playground.Rmd)