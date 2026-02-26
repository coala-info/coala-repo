---
name: r-spocc
description: The r-spocc tool provides a unified R interface to retrieve and standardize species occurrence data from multiple biodiversity repositories like GBIF and iNaturalist. Use when user asks to search for species records across multiple databases, retrieve biodiversity occurrence data with standardized parameters, or convert multi-source search results into a unified data frame.
homepage: https://cloud.r-project.org/web/packages/spocc/index.html
---


# r-spocc

name: r-spocc
description: Programmatic interface to multiple species occurrence data sources including GBIF, iNaturalist, eBird, iDigBio, VertNet, OBIS, and ALA. Use this skill when you need to retrieve, combine, and standardize biodiversity occurrence records from multiple repositories using a unified R API.

## Overview

The `spocc` package provides a seamless search experience across major biodiversity databases. It allows users to query multiple sources simultaneously using standardized parameters, returning a unified `occdat` object. This is particularly useful for species distribution modeling, conservation planning, and biodiversity research where data aggregation is required.

## Installation

```r
install.packages("spocc")
library(spocc)
```

## Core Workflow

### 1. Querying Occurrences
The primary function is `occ()`. It searches across specified sources.

```r
# Search for a single species across GBIF and iNaturalist
results <- occ(query = 'Accipiter striatus', 
               from = c('gbif', 'inat'), 
               limit = 100)

# Search for multiple species
species <- c("Pinus contorta", "Abies lasiocarpa")
results_multi <- occ(query = species, from = 'gbif')
```

### 2. Standardized Parameters
`spocc` surfaces common parameters to work across all sources:
- `query`: Scientific taxon name.
- `limit`: Number of records to retrieve.
- `geometry`: Spatial filter (Bounding box or WKT string).
- `has_coords`: Logical; if `TRUE`, only returns records with lat/long.
- `date`: Date range for observations.

### 3. Source-Specific Options
To use features unique to a specific database, use the `[source]opts` arguments:
- `gbifopts`, `inatopts`, `ebirdopts`, `vertnetopts`, `idigbioopts`, `alaopts`, `obisopts`.

```r
# Example: Passing specific arguments to GBIF
occ(query = 'Pinus contorta', from = 'gbif', 
    gbifopts = list(country = 'US'))
```

### 4. Data Transformation
The `occ()` function returns a complex S3 object. Use `occ2df()` to create a standardized, flat data frame suitable for analysis or mapping.

```r
df <- occ2df(results)
# Columns: name, longitude, latitude, prov (provider), date, key
```

## Handling Duplicates and Names

- **Duplicates:** Many providers (like VertNet or iDigBio) feed into GBIF. Querying multiple sources often results in duplicate records. Use `?spocc_duplicates` for guidance.
- **Taxonomic Cleaning:** Different sources may use different name variants (e.g., with or without authorities). 
- **Mapping:** For visualization, use the `mapr` package which is designed to work directly with `spocc` outputs.

## Reference documentation

- [spocc introduction](./references/spocc.Rmd)
- [cleaning names](./references/fixnames.Rmd)
- [README](./references/README.md)