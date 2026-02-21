---
name: copernicusmarine
description: The `copernicusmarine` skill provides a streamlined interface for accessing the Copernicus Marine Service (CMEMS) data repository without the need for external Python dependencies.
homepage: https://github.com/pepijn-devries/CopernicusMarine
---

# copernicusmarine

## Overview
The `copernicusmarine` skill provides a streamlined interface for accessing the Copernicus Marine Service (CMEMS) data repository without the need for external Python dependencies. It enables R users to programmatically discover products, subset data based on spatial and temporal constraints, and integrate marine layers into interactive maps. This skill is essential for oceanographic research, environmental monitoring, and marine spatial planning tasks that rely on authoritative EU marine data.

## Installation and Setup
To use the package in an R environment:
```r
install.packages("CopernicusMarine")
library(CopernicusMarine)
```
*Note: Accessing most services requires a Copernicus Marine account.*

## Common Usage Patterns

### Subsetting Data to Memory
Use `cms_download_subset()` to fetch specific variables for a defined area and time directly into a `stars` object. This is the most efficient way to work with data without downloading massive files.

```r
# Define region: c(xmin, ymin, xmax, ymax)
my_data <- cms_download_subset(
  product = "GLOBAL_ANALYSISFORECAST_PHY_001_024",
  layer = "cmems_mod_glo_phy-cur_anfc_0.083deg_P1D-m",
  variable = c("uo", "vo"),
  region = c(-1, 50, 10, 55),
  timerange = c("2025-01-01", "2025-01-02"),
  verticalrange = c(0, -0.5)
)
```

### Downloading Native Files
If you require the full dataset in its original format (e.g., NetCDF), use the native file functions.

1. **List available files:**
   ```r
   files <- cms_list_native_files(
     product = "GLOBAL_ANALYSISFORECAST_PHY_001_024",
     layer = "cmems_mod_glo_phy-cur_anfc_0.083deg_P1D-m"
   )
   ```

2. **Download specific files:**
   ```r
   cms_download_native(
     destination = "./data",
     product = "GLOBAL_ANALYSISFORECAST_PHY_001_024",
     layer = "cmems_mod_glo_phy_anfc_0.083deg_PT1H-m",
     pattern = "m_20220630" # Use regex to match specific dates/files
   )
   ```

### Visualizing with WMTS
For quick inspection or presentation, use Web Map Tile Services (WMTS) within a `leaflet` map.

```r
library(leaflet)
leaflet() %>%
  addProviderTiles("Esri.WorldImagery") %>%
  addCmsWMTSTiles(
    product = "GLOBAL_ANALYSISFORECAST_PHY_001_024",
    layer = "cmems_mod_glo_phy-thetao_anfc_0.083deg_P1D-m",
    variable = "thetao"
  )
```

## Expert Tips and Best Practices
- **Memory Management**: Always prefer `cms_download_subset()` over full downloads when working with high-resolution global models to avoid hitting local memory limits.
- **Coordinate Order**: Ensure the `region` argument follows the `xmin, ymin, xmax, ymax` (Longitude/Latitude) order.
- **Citations**: Copernicus data requires proper attribution. Use `cms_cite_product("PRODUCT_ID")` to retrieve the correct DOI and citation string for your publications or reports.
- **Progress Tracking**: For large downloads, keep `progress = TRUE` (default) to monitor the transfer status.

## Reference documentation
- [CopernicusMarine R Package Overview](./references/github_com_pepijn-devries_CopernicusMarine.md)