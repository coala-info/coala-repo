---
name: r-rbison
description: The rbison package provides an R interface to the USGS BISON service for searching and retrieving species occurrence data within the United States. Use when user asks to search for species occurrences by name, filter data by county or spatial constraints, map occurrence points, or query taxonomic information using the BISON Solr API.
homepage: https://cran.r-project.org/web/packages/rbison/index.html
---

# r-rbison

## Overview
The `rbison` package is an R interface to the USGS BISON service. It allows users to search for species occurrence data specifically within the United States. It provides tools for taxonomic name resolution, data provider statistics, and built-in mapping capabilities for states and counties.

**Note:** The BISON API primarily covers US-based data. While it is the US Node of GBIF, it contains several million records not found in GBIF.

## Installation
Install the package from CRAN:
```r
install.packages("rbison")
```

## Core Workflows

### Basic Occurrence Search
Use the `bison()` function to retrieve occurrence data by species name.
```r
library(rbison)

# Search for a species
out <- bison(species = "Helianthus annuus", count = 50)

# Inspect summary and data
out$summary
head(out$points)
head(out$counties)
```

### Spatial Constraints
BISON allows for highly specific geographic filtering:

*   **By County Name or FIPS:**
    ```r
    # By name
    out <- bison(species = "Helianthus annuus", county = "Los Angeles")
    # By FIPS code (State + County)
    out <- bison(species = "Helianthus annuus", countyFips = "06037")
    ```
*   **By Bounding Box (minx, miny, maxx, maxy):**
    ```r
    out <- bison(species = "Helianthus annuus", aoibbox = '-120.31,35.81,-110.57,40.21')
    ```
*   **By Well-Known Text (WKT) Polygon:**
    ```r
    out <- bison(species = "Helianthus annuus", aoi = "POLYGON((-111.06 38.84, -110.80 39.37, -110.20 39.17, -111.06 38.84))")
    ```

### Mapping Data
The `bisonmap()` function automatically handles map extents for the US.
```r
# Map points
bisonmap(out, tomap = "points")

# Map by state or county density
bisonmap(out, tomap = "state")
bisonmap(out, tomap = "county")
```

### Advanced Solr Queries
For more complex queries, use the Solr endpoints which support faceting and specific field selection.
```r
# Search by TSN (Taxonomic Serial Number)
bison_solr(TSNs = 174670, rows = 10)

# Faceting by State FIPS
bison_solr(scientificName = 'Helianthus annuus', rows = 0, facet = 'true', facet.field = 'computedStateFips')

# Taxonomic name search
bison_tax(query = "*bear", method = "vernacularName", rows = 5)
```

### Data Provider Stats
To see who is providing the data:
```r
# Get stats for a specific provider type
bison_stats(what = 'wms')

# Get provider details
bison_providers(details = TRUE)
```

## Tips and Best Practices
*   **US Focus:** If your search returns points outside the US, `bisonmap` will default to a global map and throw a warning.
*   **FIPS Codes:** State FIPS are the first two digits; County FIPS are the last three.
*   **Partial Names:** If you provide a partial county name to the `county` argument, `rbison` will prompt you to choose from matching candidates.
*   **Solr Fields:** Use the `fl` argument in `bison_solr` to limit returned fields and reduce data transfer size (e.g., `fl = "scientificName,decimalLongitude,decimalLatitude"`).

## Reference documentation
- [README](./references/README.md)
- [Additional rbison functionality](./references/other_functions.Rmd)
- [Introduction to rbison](./references/rbison.Rmd)