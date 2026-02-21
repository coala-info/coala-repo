---
name: r-rvertnet
description: Retrieve, map and summarize data from the 'VertNet.
homepage: https://cloud.r-project.org/web/packages/rvertnet/index.html
---

# r-rvertnet

name: r-rvertnet
description: Access and search vertebrate specimen records from the VertNet database. Use this skill when you need to retrieve biodiversity data for vertebrates (Aves, Mammalia, Amphibia, Reptilia, etc.) using specific terms (taxa, location, date), spatial coordinates, or full-text search. Supports both small-scale data retrieval and large-scale email-based downloads.

# r-rvertnet

## Overview
The `rvertnet` package is an R client for interacting with VertNet (vertnet.org), a global network of vertebrate specimen databases. It allows users to query millions of records for mammals, birds, reptiles, amphibians, and fish. Most search functions return a list containing two elements: `meta` (query metadata) and `data` (a tibble of specimen records).

## Installation
Install the stable version from CRAN:
```r
install.packages("rvertnet")
library(rvertnet)
```

## Core Search Functions

### Search by Term
Use `searchbyterm()` to query specific Darwin Core fields. Common parameters include `genus`, `specificepithet`, `class`, `stateprovince`, and `country`.

```r
# Search for Aves in California
res <- searchbyterm(class = "Aves", state = "California", limit = 10)

# Access the data
df <- res$data

# Search with multiple criteria and boolean logic
res <- searchbyterm(genus = "Mustela", specificepithet = "nigripes", state = "(wyoming OR south dakota)")
```

### Spatial Search
Use `spatialsearch()` to find records within a specific radius (in meters) of a geographic point. All three parameters (`lat`, `lon`, `radius`) are required.

```r
res <- spatialsearch(lat = 33.529, lon = -105.694, radius = 2000)
```

### Global Full-Text Search
Use `vertsearch()` for a simple full-text search across all available fields.

```r
res <- vertsearch(taxon = "aves", state = "california", limit = 10)
```

## Advanced Workflows

### Handling Large Result Sets
VertNet limits individual API requests to 1000 records. However, `rvertnet` functions automatically handle pagination. If you set `limit` higher than 1000, the package will perform multiple requests internally to fetch the requested amount.

### Filtering by Coordinate Uncertainty
You can filter results based on the precision of the geographic data using the `error` parameter in `searchbyterm()`.

```r
# Records with coordinate uncertainty less than 25 meters
res <- searchbyterm(class = "Aves", stateprovince = "Nevada", error = "<25")
```

### Large Data Requests (Email)
For extremely large datasets that exceed standard API limits, use `bigsearch()`. This triggers a server-side process that sends a download link to your email.

```r
bigsearch(genus = "ochotona", rfile = "my_pika_data", email = "yourname@example.com")
```

### Data Manipulation with dplyr
Since the `data` slot returns a tibble, you can pipe results directly into `dplyr` for analysis.

```r
library(dplyr)
out <- searchbyterm(genus = "Ochotona", limit = 500)
summary <- out$data %>%
  group_by(scientificname) %>%
  summarise(count = n()) %>%
  arrange(desc(count))
```

## Tips
- **Messages**: By default, functions print progress messages. Use `messages = FALSE` to suppress them.
- **Metadata**: Always check `res$meta` to see the total number of matching records (`matching_records`) and the query version.
- **Field Names**: The package returns Darwin Core compliant fields (e.g., `decimallatitude`, `eventdate`, `catalognumber`).

## Reference documentation
- [Introduction to rvertnet](./references/rvertnet.Rmd)