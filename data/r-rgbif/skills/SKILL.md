---
name: r-rgbif
description: This tool provides an R interface to the Global Biodiversity Information Facility (GBIF) API for accessing biodiversity data. Use when user asks to search for species occurrence records, match taxonomic names to the GBIF backbone, download large biodiversity datasets, or retrieve occurrence statistics and maps.
homepage: https://cloud.r-project.org/web/packages/rgbif/index.html
---

# r-rgbif

name: r-rgbif
description: Interface to the Global Biodiversity Information Facility (GBIF) API. Use this skill when you need to search, filter, and download biodiversity occurrence data, taxonomic information, or dataset metadata from GBIF using R. It supports species occurrence downloads (unlimited records), quick searches (up to 100k), taxonomic name matching to the GBIF backbone, and SQL-based queries.

## Overview

The `rgbif` package provides a comprehensive R interface to the GBIF API. It is primarily used for retrieving species occurrence records (lat/lon points), matching taxonomic names to the GBIF backbone, and accessing biodiversity metadata.

## Installation

```r
install.packages("rgbif")
library(rgbif)
```

## Authentication

Most functions for searching work without credentials, but **downloads** (`occ_download`) require a GBIF account. Set these in your `.Renviron` file for security:

```r
# Run this to edit your Renviron
usethis::edit_r_environ()

# Add these lines:
GBIF_USER="your_username"
GBIF_PWD="your_password"
GBIF_EMAIL="your_email@example.com"
```

## Taxonomic Name Matching

Always match names to the GBIF backbone to get a `usageKey` (taxonKey) before searching for occurrences.

```r
# Match a single name
name_backbone(name = "Calopteryx splendens")

# Match a list of names
names <- c("Cirsium arvense", "Puma concolor", "Calopteryx splendens")
name_backbone_checklist(names)
```

## Getting Occurrence Data

### 1. Small/Quick Searches (occ_search)
Use for exploration or testing. Limited to 100,000 records.
```r
# Search by name
occ_search(scientificName = "Calopteryx splendens", limit = 10)

# Search by taxonKey (preferred)
occ_search(taxonKey = 1427067, country = "DK", limit = 50)
```

### 2. Large/Research Downloads (occ_download)
The standard for research. Requires credentials and provides a citable DOI.
```r
# 1. Request the download
# Use pred_default() to filter for records with coordinates and no major issues
res <- occ_download(
  pred_default(),
  pred("taxonKey", 1427067),
  format = "SIMPLE_CSV"
)

# 2. Wait for GBIF to process (can take minutes)
occ_download_wait(res)

# 3. Retrieve and import
d <- occ_download_get(res) %>% occ_download_import()
```

## Occurrence Counts and Statistics

Use `occ_count` for fast statistics without downloading records.
```r
occ_count(taxonKey = 212) # Total bird records
occ_count(country = "DK") # Records in Denmark
occ_count(facet = "year") # Records grouped by year
```

## Mapping

For small datasets, use `ggplot2`. For massive datasets, use the GBIF Maps API via `map_fetch`.
```r
# Fetch a static PNG map from GBIF
map_fetch(taxonKey = 212, style = "scaled.circles", base_style = "gbif-light")
```

## SQL Downloads (Experimental)

For complex aggregations (e.g., species counts per grid cell) without downloading raw data.
```r
sql <- "SELECT specieskey, COUNT(*) as n FROM occurrence WHERE countryCode = 'DK' GROUP BY specieskey"
occ_download_sql(sql)
```

## Best Practices

- **Citations**: Always cite the DOI provided by `occ_download`. Use `gbif_citation()` to retrieve citation info for a download key.
- **TaxonKeys**: Use `usageKey` from `name_backbone` instead of strings in search functions to avoid ambiguity.
- **Filters**: Use `pred_default()` in downloads to automatically filter out fossils, living specimens (zoos), and records without coordinates.
- **Large Lists**: To download data for thousands of species, use `pred_in("taxonKey", key_vector)` within `occ_download`.

## Reference documentation

- [Introduction to rgbif](./references/rgbif.md)
- [Getting Occurrence Data From GBIF](./references/getting_occurrence_data.md)
- [Working With Taxonomic Names](./references/taxonomic_names.md)
- [Set Up Your GBIF Username and Password](./references/gbif_credentials.md)
- [Effectively using occ_search](./references/effectively_using_occ_search.md)
- [Getting Occurrence Counts From GBIF](./references/occ_counts.md)
- [Citing GBIF Mediated Data](./references/gbif_citations.md)
- [GBIF SQL Downloads](./references/gbif_sql_downloads.md)
- [Creating maps from occurrences](./references/creating_maps_from_occurrences.md)
- [Downloading A Long Species List](./references/downloading_a_long_species_list.md)
- [Getting Dataset Metadata From GBIF](./references/getting_dataset_info.md)
- [Multiple Values](./references/multiple_values.md)