---
name: gdal
description: GDAL is a translator library for raster and vector geospatial data that provides a single abstract data model for diverse formats. Use when user asks to convert geospatial file formats, reproject data between coordinate reference systems, inspect metadata, or perform spatial operations like clipping, tiling, and merging.
homepage: https://github.com/OSGeo/gdal
---


# gdal

## Overview

GDAL (Geospatial Data Abstraction Library) is the foundational translator library for raster and vector geospatial data. It provides a single abstract data model for all supported formats, allowing users to interact with diverse datasets—from GeoTIFFs and Shapefiles to Cloud Optimized GeoTIFFs (COG) and GeoPackages—using a consistent set of command-line tools. 

Use this skill to perform high-performance spatial data engineering tasks, including:
- Converting between geospatial file formats.
- Reprojecting data between different Coordinate Reference Systems (CRS).
- Inspecting metadata, spatial extents, and band statistics.
- Clipping, tiling, and merging large datasets.
- Accessing data directly from cloud storage or compressed archives using virtual file systems.

## Common CLI Patterns

### Raster Operations (GDAL)

**Inspect Metadata**
Use `gdalinfo` to view CRS, extent, and band information.
```bash
gdalinfo input.tif
```

**Format Conversion**
Use `gdal_translate` to convert between formats or create subsets.
```bash
gdal_translate -of GTiff input.asc output.tif
```

**Reprojection**
Use `gdalwarp` to change the coordinate system.
```bash
gdalwarp -t_srs EPSG:4326 input.tif output_wgs84.tif
```

**Cloud Optimized GeoTIFF (COG) Generation**
Create a web-optimized raster with internal tiling and overviews.
```bash
gdal_translate input.tif output_cog.tif -of COG -co COMPRESS=LZW
```

### Vector Operations (OGR)

**Inspect Vector Data**
Use `ogrinfo` to see layers and feature counts.
```bash
ogrinfo -ro -so input.gpkg
```

**Vector Conversion and Reprojection**
Use `ogr2ogr` to convert formats (e.g., Shapefile to GeoJSON) and reproject.
```bash
ogr2ogr -f "GeoJSON" output.json input.shp -t_srs EPSG:4326
```

**Filtering by Attribute or Spatial Extent**
```bash
ogr2ogr -where "population > 100000" output.shp input.shp
```

## Expert Tips and Best Practices

### Virtual File Systems
GDAL can read data directly from URLs or inside archives without manual extraction using prefixes:
- **Network files**: `/vsicurl/https://example.com/data.tif`
- **ZIP archives**: `/vsizip/path/to/file.zip/internal_file.tif`
- **GZip files**: `/vsigzip/file.gz`

### Creation Options (`-co`)
Most drivers support specific creation options to control output quality and structure.
- For GeoTIFFs, use `-co TILED=YES` for faster random access.
- For compression, use `-co COMPRESS=DEFLATE` or `-co COMPRESS=LZW`.

### Handling Large Datasets
- **Overviews**: Use `gdaladdo` to build internal "pyramids" for faster rendering of large rasters.
- **VRT (Virtual Format)**: Use `gdalbuildvrt` to create a virtual mosaic of many files without duplicating the underlying data.

### Driver-Specific Configuration
Some drivers require specific environment variables or configuration options. For example, the `AAIGrid` driver allows forcing cell size output:
```bash
gdal_translate input.tif output.asc -of AAIGrid --config FORCE_CELLSIZE YES
```



## Subcommands

| Command | Description |
|---------|-------------|
| gdal_ogrinfo | Prints detailed information about OGR data sources and layers. |
| gdal_translate | Translate a raster file to another format, with optional resampling, scaling, etc. |
| gdalbuildvrt | Builds a virtual raster (VRT) from a list of input GDAL datasets. |
| gdalinfo | Prints information about a GDAL dataset. |
| gdalwarp | Reprojects a raster dataset to match a given projection, resolution and extent. |
| ogr2ogr | Convert data between vector formats |

## Reference documentation
- [GDAL Documentation Index](./references/gdal_org_en_stable_index.html.md)
- [GDAL Programs/Utilities](./references/gdal_org_en_stable_programs_index.html.md)
- [Raster Drivers](./references/gdal_org_en_stable_drivers_raster_index.html.md)
- [Vector Drivers](./references/gdal_org_en_stable_drivers_vector_index.html.md)