---
name: fiona
description: Fiona is a Python library and command-line toolset for reading, writing, and managing vector spatial data as GeoJSON-like dictionaries. Use when user asks to inspect spatial metadata, stream geographic features, convert between vector data formats, or perform spatial filtering using bounding boxes.
homepage: https://github.com/Toblerity/Fiona
---


# fiona

## Overview

Fiona is a high-performance Python library and command-line toolset designed for the efficient handling of vector spatial data. It acts as a Pythonic wrapper around the OGR abstraction library (part of GDAL), treating geographic features as standard Python dictionaries modeled after the GeoJSON format. This makes it exceptionally well-suited for developers who need to integrate spatial data into broader data science workflows without the overhead of a full GIS suite. Fiona focuses on data access and "plumbing," leaving complex geometric manipulations to complementary libraries like Shapely.

## Command Line Interface (fio)

The `fio` CLI is the primary tool for quick data inspection and transformation.

### Common Patterns

- **Inspect Metadata**: Use `fio info` to view the driver, coordinate reference system (CRS), schema, and feature count of a dataset.
  ```bash
  fio info data.shp
  ```
- **Stream Features**: Use `fio cat` to output features as a sequence of GeoJSON objects. This is often piped into `jq` for processing.
  ```bash
  fio cat data.gpkg | jq '.properties.NAME'
  ```
- **Spatial Filtering**: Filter features by a bounding box during extraction.
  ```bash
  fio cat data.shp --bbox -107.0 37.0 -105.0 39.0
  ```
- **Data Conversion**: Load GeoJSON data into a different format like a Shapefile.
  ```bash
  fio cat features.json | fio load output.shp --driver "ESRI Shapefile"
  ```

## Python API Best Practices

### Efficient Data Access

Always use context managers to ensure file handles and GDAL resources are properly closed.

```python
import fiona

with fiona.open('data.gpkg', 'r') as src:
    # Access metadata
    print(src.driver)
    print(src.crs)
    
    # Iterate over features
    for feature in src:
        # feature is a GeoJSON-like dictionary
        print(feature['properties'])
```

### Writing Data

When creating a new file, you must define the "profile," which includes the driver, CRS, and schema. It is often easiest to copy and modify the profile of an existing source file.

```python
# Copying a profile for a new file
with fiona.open('source.shp') as src:
    profile = src.profile
    profile.update(driver='GPKG') # Change format to GeoPackage

    with fiona.open('destination.gpkg', 'w', **profile) as dst:
        for feat in src:
            dst.write(feat)
```

### Filtering and Performance

Use the `filter()` method on a collection to perform spatial queries (bounding box) or slice the dataset. This is significantly faster than iterating over the entire collection and checking conditions in Python.

```python
with fiona.open('data.shp') as src:
    # Only process features within the specified bounding box
    for feat in src.filter(bbox=(-107.0, 37.0, -105.0, 39.0)):
        process(feat)
```

## Expert Tips

- **Virtual File Systems (VFS)**: Fiona can read directly from zipped archives or cloud storage by prefixing the path.
  - Zip: `zip://data.zip!folder/file.shp`
  - HTTP/S: `https://example.com/data.geojson`
- **Coordinate Reference Systems**: Fiona uses PROJ.4 strings or EPSG codes. Always verify the `src.crs` before performing spatial operations with other libraries.
- **Geometry Integration**: Since Fiona features are GeoJSON-like, they integrate seamlessly with Shapely using `shapely.geometry.shape()` for analysis and `shapely.geometry.mapping()` for writing.
- **In-Memory Files**: For ephemeral data processing, use `fiona.io.MemoryFile` to avoid disk I/O overhead.

## Reference documentation
- [Fiona README](./references/github_com_Toblerity_Fiona.md)