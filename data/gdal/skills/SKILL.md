---
name: gdal
description: GDAL is a translator library and command-line toolkit used to process, convert, and manipulate geospatial raster and vector data. Use when user asks to inspect spatial metadata, translate between file formats, reproject datasets to different coordinate systems, or perform spatial subsetting and filtering.
homepage: https://github.com/OSGeo/gdal
---


# gdal

## Overview

GDAL is the foundational translator library for geospatial data, handling raster (GDAL) and vector (OGR) formats through a unified abstract data model. This skill enables the efficient use of GDAL's command-line interface (CLI) to perform complex spatial operations—such as warping images to new projections, converting between formats like GeoTIFF and Shapefile, or extracting specific layers and features—without requiring custom programming. It is particularly useful for data preprocessing, ETL (Extract, Transform, Load) workflows, and inspecting unknown spatial datasets.

## Core CLI Utilities and Patterns

### Metadata Inspection
Before processing, always inspect the dataset to understand its projection, extent, and data types.
*   **Raster**: `gdalinfo input.tif`
    *   Use `-stats` to calculate pixel statistics.
    *   Use `-wkt_format WKT1_ESRI` for ESRI-compatible coordinate system strings.
*   **Vector**: `ogrinfo -al -so input.shp`
    *   `-al`: List all layers.
    *   `-so`: Summary only (prevents dumping every feature to the console).
    *   Use `-fid <id>` to inspect a specific feature by its ID.

### Format Translation and Subsetting
*   **Raster (gdal_translate)**: Convert formats or extract sub-windows.
    *   `gdal_translate -of GTiff -co "COMPRESS=LZW" input.nc output.tif`
    *   `-projwin <ulx> <uly> <lrx> <lry>`: Subset by geographic coordinates.
    *   `-outsize <x>% <y>%`: Rescale the image.
*   **Vector (ogr2ogr)**: The "Swiss Army Knife" for vector data.
    *   `ogr2ogr -f "GeoJSON" output.json input.shp`
    *   `-where "population > 100000"`: Filter features by attribute.
    *   `-clipsrc <xmin> <ymin> <xmax> <ymax>`: Clip vector data to a bounding box.

### Reprojection and Warping
*   **gdalwarp**: Used for reprojecting rasters and mosaicking.
    *   `gdalwarp -t_srs EPSG:4326 input.tif output_wgs84.tif`
    *   `--like <template_ds>`: Match the extent and resolution of a reference dataset (useful for aligning layers).
    *   `-r bilinear`: Specify resampling method (near, bilinear, cubic, cubicspline, lanczos, average, mode).

### Virtual Datasets (VRT)
Use VRTs to create "virtual" mosaics or transformations without duplicating the underlying data.
*   `gdalbuildvrt mosaic.vrt *.tif`: Creates a single virtual file representing all input TIFFs.

## Expert Tips

*   **Cloud Optimized GeoTIFF (COG)**: When creating rasters for web use, use the COG driver:
    `gdal_translate input.tif output.tif -of COG -co COMPRESS=DEFLATE`
*   **Batch Processing**: Use `/vsimem/` (virtual file system in memory) for intermediate steps to avoid disk I/O overhead.
*   **Environment Variables**: 
    *   `GDAL_CACHEMAX`: Increase memory for large operations (e.g., `--config GDAL_CACHEMAX 512`).
    *   `CPL_DEBUG ON`: Enable verbose debugging to troubleshoot driver or projection issues.
*   **SQL Queries**: `ogr2ogr` supports OGR SQL or SQLite dialects for complex filtering:
    `ogr2ogr -sql "SELECT name, area FROM layers WHERE area > 500" output.shp input.shp`

## Reference documentation
- [GDAL Project Overview](./references/github_com_OSGeo_gdal.md)
- [Recent CLI Enhancements and Issues](./references/github_com_OSGeo_gdal_issues.md)
- [Latest CLI Feature Commits](./references/github_com_OSGeo_gdal_commits_master.md)