---
name: r-ridigbio
description: This tool provides an R interface to the iDigBio Data API for searching and downloading biological specimen records and associated media. Use when user asks to query museum specimen data, retrieve geographic coordinates, access taxonomic information, or download specimen images from the Integrated Digitized Biocollections database.
homepage: https://cloud.r-project.org/web/packages/ridigbio/index.html
---

# r-ridigbio

name: r-ridigbio
description: Interface to the iDigBio Data API for searching and downloading biological specimen records and media. Use this skill when you need to query the Integrated Digitized Biocollections (iDigBio) database for museum specimen data, geographic coordinates, taxonomic information, or associated media (images) using R.

# r-ridigbio

## Overview
The `ridigbio` package provides an R interface to the iDigBio Search and Media APIs. iDigBio is a US project focused on digitizing and serving museum specimen collections. This package allows users to download specimen records as data frames and access metadata via list-based endpoints.

## Installation
To install the package from CRAN:
```r
install.packages("ridigbio")
library(ridigbio)
```

## Core Functions

### Searching Records
Use `idig_search_records()` to retrieve specimen data.
- `rq`: A list defining the record query (e.g., `list(genus = "Acer")`).
- `fields`: A character vector of fields to return. Use `"all"` for all indexed fields.
- `limit`: Maximum records to return (max 100,000).
- `sort`: Fields to sort by.

```r
# Basic search
records <- idig_search_records(rq = list(scientificname = "Galax urceolata"))

# Search with specific fields and limits
records <- idig_search_records(
  rq = list(family = "Diapensiaceae"),
  fields = c("uuid", "institutioncode", "country", "geopoint"),
  limit = 1000
)
```

### Searching Media
Use `idig_search_media()` to find images and other media associated with specimens.
- `mq`: Media query (e.g., `list("data.ac:accessURI" = list("type" = "exists"))`).
- `rq`: Can also filter media based on specimen record properties.

```r
# Find images for a specific genus
media <- idig_search_media(rq = list(genus = "Acer"))
```

### Metadata and Counts
- `idig_count_records(rq)`: Returns the total number of records matching a query.
- `idig_top_records(rq, top_fields, count)`: Returns the most frequent values for specific fields.
- `idig_meta_fields(type, subset)`: Lists available fields for "records" or "media".

```r
# Get count of fossils with coordinates
count <- idig_count_records(rq = list(basisofrecord = "fossilspecimen", 
                                      geopoint = list(type = "exists")))

# Get top 10 scientific names in a genus
top_names <- idig_top_records(rq = list(genus = "Shortia"), 
                              top_fields = "scientificname", 
                              count = 10)
```

## Workflows

### Handling Data Quality Flags
iDigBio applies flags when data is modified or suspicious.
- `rev_geocode_corrected`: Coordinates were adjusted.
- `rev_geocode_flip`: Latitude and longitude were likely swapped.
- `dwc_genus_replaced`: The genus name was standardized.

To compare provider (raw) data vs. aggregator (indexed) data:
```r
df <- idig_search_records(
  rq = list(recordset = "your-uuid"),
  fields = c("uuid", "genus", "data.dwc:genus", "flags")
)
# Raw fields are prefixed with "data.dwc:"
```

### Geographic Bounding Box
Search within a specific geographic area:
```r
rq_input <- list(
  geopoint = list(
    type = "geo_bounding_box",
    top_left = list(lon = -98.16, lat = 48.92),
    bottom_right = list(lon = -64.02, lat = 23.06)
  )
)
res <- idig_search_records(rq_input)
```

### Downloading Media Files
1. Search for media to get `accessuri`.
2. Use `download.file()` to save locally.

```r
media <- idig_search_media(rq = list(genus = "Acer"), fields = c("uuid", "accessuri"))
# Example download
download.file(media$accessuri[1], destfile = paste0(media$uuid[1], ".jpg"))
```

## Tips
- **Field Names**: Raw Darwin Core fields are accessed via `data.dwc:fieldName`. Indexed iDigBio fields are usually lowercase (e.g., `scientificname`).
- **Attribution**: Use `attr(df, "attribution")` on a returned data frame to see the source collection metadata and contact information.
- **Large Queries**: If a query exceeds 100,000 records, use `idig_count_records` first to plan for pagination or filtering.

## Reference documentation
- [Identification of Suspicious Coordinates](./references/BadCoordinateID.Rmd)
- [Introduction to ridigbio](./references/BasicUsage.Rmd)
- [Fields in ridigbio](./references/Fields.Rmd)
- [Tissue Samples Locator Demo](./references/FindTissue.Rmd)
- [Identification of Data Flags](./references/IDDataFlags.Rmd)
- [Media API Demo](./references/MediaAPIDemo.Rmd)
- [Identification of Modified Data](./references/ModifiedDataID.Rmd)
- [Record API Demo](./references/RecordAPIDemo.Rmd)
- [ridigbio Package Overview](./references/ridigbio.Rmd)