---
name: r-rebird
description: Skill for using the CRAN R package r-rebird.
homepage: https://cloud.r-project.org/web/packages/rebird/index.html
---

# r-rebird

## Overview
The `rebird` package provides a programmatic interface to the eBird database, the world's largest biodiversity-related citizen science project. It allows users to search for bird occurrences, find notable sightings, and explore birding hotspots globally.

## Installation
```r
install.packages("rebird")
library(rebird)
```

## Authentication
eBird API requests require an API key. 
1. Obtain a key at: https://ebird.org/api/keygen
2. Set it in your session: `Sys.setenv(EBIRD_KEY = 'your_key_here')`
3. Or pass it to the `key` argument in functions.

## Core Workflows

### Species Codes
Most functions require a `speciesCode` (e.g., "amegfi") rather than a scientific name.
```r
# Convert scientific name to species code
s_code <- species_code('Spinus tristis')
```

### Searching Sightings
Search for recent observations (up to 30 days) using coordinates or region codes.

```r
# By Latitude/Longitude
ebirdgeo(lat = 42, lng = -76, dist = 10)

# By Region (e.g., US, US-NY, US-NY-109)
ebirdregion(loc = 'US-NY', species = 'amegfi')

# Notable sightings (rare/unusual birds)
ebirdnotable(lat = 42, lng = -76)

# Nearest observations of a specific species
nearestobs(species_code('Branta canadensis'), 42, -76)
```

### Historical Data
Retrieve sightings for a specific date in the past.
```r
# Observations on a specific date
ebirdhistorical(loc = 'US-VA-003', date = '2019-02-14')
```

### Taxonomy and Regions
```r
# Get latest eBird taxonomy
tax <- ebirdtaxonomy()

# List subregions within a country (e.g., states in the US)
states <- ebirdsubregionlist("subnational1", "US")

# List hotspots in a region
hotspots <- ebirdhotspotlist("CA-NS-HL")

# Get info about a specific region or hotspot
info <- ebirdregioninfo("L196159")
```

## Tips
- **Region Codes**: Follow the ISO 3166 format (e.g., `US` for country, `US-NY` for state, `US-NY-109` for county).
- **Hotspot IDs**: Hotspot IDs start with "L" followed by numbers (e.g., `L99381`).
- **Distance**: The `dist` parameter in `ebirdgeo` and `ebirdhotspotlist` is in kilometers (max 50km).
- **Caching**: The taxonomy is stored internally as `rebird:::tax`, but use `ebirdtaxonomy()` to ensure you have the most recent version.

## Reference documentation
- [Introduction to the rebird package](./references/rebird_vignette.Rmd)