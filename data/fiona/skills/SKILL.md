---
name: fiona
description: "Fiona is a Python library and CLI tool for reading, writing, and filtering geospatial vector data using simple mappings. Use when user asks to read or write GIS vector layers, convert between spatial file formats, filter features by attribute or bounding box, or process GeoJSON-like records in Python."
homepage: https://github.com/Toblerity/Fiona
---


# fiona

## Overview
Fiona is a high-performance Python library and CLI toolset designed for "no-nonsense" geospatial data handling. It treats GIS vector layers as simple Python mappings (GeoJSON-like) and provides a streamlined interface for reading and writing records. It is particularly effective for batch processing, format conversion, and attribute filtering where complex geometric operations (like those in Shapely) are not the primary focus, but data integrity and speed are.

## Python API Best Practices

### Reading and Filtering
Always use the context manager (`with`) to ensure file handles and GDAL resources are released.
```python
import fiona

with fiona.open("data.gpkg", "r") as src:
    # Filter by bounding box (minx, miny, maxx, maxy)
    for feature in src.filter(bbox=(-107.0, 37.0, -105.0, 39.0)):
        print(feature.properties['name'])
```

### Writing New Files
To create a new file, you must define a `schema` (geometry type and properties) and a `crs`. The easiest way is to copy the `profile` from a source file.
```python
with fiona.open("input.shp") as src:
    profile = src.profile
    profile.update(driver="GPKG") # Change format
    
    with fiona.open("output.gpkg", "w", **profile) as dst:
        for feat in src:
            dst.write(feat)
```

### Virtual File Systems (VFS)
Fiona can read directly from zip files or cloud storage using URI prefixes:
- **Zip**: `zip://path/to/data.zip!folder/file.shp`
- **HTTP/S3**: `zip+https://example.com/data.zip`

## CLI Usage (fio)

The `fio` command line interface is ideal for piping geospatial data through standard Unix utilities.

### Common Patterns
- **Inspect a dataset**: `fio info data.shp`
- **Convert to GeoJSON**: `fio dump data.shp > data.json`
- **Filter by attribute**: `fio cat data.shp --where "POP_CNTRY > 1000000"`
- **Spatial Clipping**: `fio cat data.shp --bbox -107,37,-105,39 | fio load output.shp --driver Shapefile`

### Advanced Transformations
If the `calc` extra is installed, use `fio map` and `fio reduce` for inline transformations:
- **Buffer geometries**: `fio cat input.shp | fio map "buffer g 0.1" | fio load output.shp`
- **Dissolve geometries**: `fio cat input.shp | fio reduce "unary_union c" > dissolved.json`

## Expert Tips
- **Performance**: Fiona copies data into Python objects. If you only need to reproject or perform heavy spatial joins, consider `ogr2ogr`. Use Fiona when you need to manipulate feature properties using Python logic.
- **Coordinate Ordering**: Fiona follows the OGR convention. Ensure your CRS is correctly defined in the profile when writing to avoid axis-order issues (Lat/Long vs Long/Lat).
- **Layer Access**: For multi-layer formats like GeoPackage or FileGDB, use the `layer` keyword in `fiona.open()` or `fio ls` to list available layers.



## Subcommands

| Command | Description |
|---------|-------------|
| cat | Concatenate and print the features of input datasets as a sequence of GeoJSON features. |
| fio | Fiona command line interface. |
| info | Print information about a dataset. |
| load | Load features from JSON to a file in another format. |

## Reference documentation
- [Fiona User Manual](./references/fiona_readthedocs_io_en_stable_manual.html.md)
- [CLI Documentation](./references/fiona_readthedocs_io_en_stable_cli.html.md)
- [API Reference](./references/fiona_readthedocs_io_en_stable_fiona.html.md)