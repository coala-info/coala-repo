---
name: copernicusmarine
description: The copernicusmarine tool provides a streamlined workflow for discovering, authenticating, and retrieving authoritative marine data from Copernicus services. Use when user asks to search the ocean product catalogue, download native data files, or retrieve spatial and temporal subsets of marine datasets.
homepage: https://github.com/pepijn-devries/CopernicusMarine
metadata:
  docker_image: "quay.io/biocontainers/copernicusmarine:2.3.0"
---

# copernicusmarine

## Overview

The `copernicusmarine` skill provides a streamlined workflow for accessing authoritative marine data. It facilitates the discovery of ocean products, authentication with Copernicus services, and the retrieval of datasets. Unlike the official Python CLI, this R-based approach allows for direct integration into data science pipelines, supporting both full "native" downloads and precise spatial/temporal subsetting to minimize bandwidth and storage requirements.

## Installation and Setup

The package is available on CRAN and requires GDAL (>= 3.11) with BLOSC support for certain compressed data formats.

```r
# Install from CRAN
install.packages("CopernicusMarine")

# Authentication (requires a Copernicus Marine account)
library(CopernicusMarine)
cms_login(username = "your_username", password = "your_password")
```

## Data Discovery

Before downloading, use these functions to explore available products and their specific layers.

- **List Products**: Use `cms_products_list()` to search the catalogue.
- **Get Details**: Use `cms_product_details("product_id")` to see available layers, variables, and services (e.g., OPeNDAP, WMS).
- **Metadata**: Use `cms_product_metadata("product_id")` for technical specifications.

## Data Retrieval Patterns

### Subsetting Data
Subsetting is the most efficient way to retrieve data. You can define spatial bounds, time ranges, and specific variables.

```r
# Example: Subset sea surface temperature
data <- cms_download_subset(
  destination        = "sst_subset.nc",
  product            = "SST_GLO_SST_L4_NRT_OBSERVATIONS_010_001",
  layer              = "METOFFICE-GLO-SST-L4-NRT-GBL-OSTIA-SST-v2",
  variable           = "analysed_sst",
  longitude          = c(-10, 5),
  latitude           = c(45, 60),
  time               = c("2023-01-01", "2023-01-05")
)
```

### Native Downloads
Use `cms_download_native()` when you require the original, un-subsetted files as provided by the data producer.

```r
cms_download_native(
  product     = "product_id",
  destination = "./data_folder"
)
```

## Expert Tips

- **Coordinate Systems**: Always verify the coordinate range of the product (e.g., 0 to 360 vs -180 to 180) before defining your subset bounds.
- **Service Selection**: If a product supports multiple services, `cms_download_subset` will attempt to use the most efficient one available.
- **Citation**: Use `cms_cite_product("product_id")` to generate the correct citation for your research or reports.
- **Visualization**: Use `cms_wmts()` to integrate Copernicus layers into interactive maps (e.g., using the `leaflet` package).



## Subcommands

| Command | Description |
|---------|-------------|
| copernicusmarine describe | Retrieve and parse the metadata information from the Copernicus Marine catalogue. |
| copernicusmarine login | Create a configuration file with your Copernicus Marine credentials under the ``$HOME/.copernicusmarine`` directory. |
| copernicusmarine subset | Extract a subset of data from a specified dataset using given parameters. |
| copernicusmarine_get | Download originally produced data files. |

## Reference documentation

- [Main Repository and README](./references/github_com_pepijn-devries_CopernicusMarine_blob_master_README.md)
- [Package Index and Overview](./references/pepijn-devries_github_io_CopernicusMarine_index.html.md)
- [Subsetting Reference](./references/pepijn-devries_github_io_CopernicusMarine_reference_cms_download_subset.html.md)
- [Native Download Reference](./references/pepijn-devries_github_io_CopernicusMarine_reference_cms_download_native.html.md)