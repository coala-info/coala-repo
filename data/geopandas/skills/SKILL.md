---
name: geopandas
description: GeoPandas extends the pandas library to support geographic data by providing specialized data structures for vector-based spatial analysis. Use when user asks to read or write spatial file formats, manage coordinate reference systems, perform spatial joins and overlays, or create geographic visualizations.
homepage: https://github.com/geopandas/geopandas
metadata:
  docker_image: "quay.io/biocontainers/geopandas:1.1.2"
---

# geopandas

## Overview
GeoPandas is a Python library that extends the capabilities of pandas by adding support for geographic data. It introduces specialized data structures—the GeoSeries and GeoDataFrame—which are subclasses of pandas objects that can store and manipulate shapely geometry objects. This skill enables efficient vector-based GIS workflows, allowing you to treat spatial data with the same ease as standard tabular data while maintaining geographic integrity through CRS management.

## Core Data Structures
- **GeoSeries**: A vector where each element is a set of shapes corresponding to a single observation.
- **GeoDataFrame**: A tabular data structure that contains a "geometry" column (a GeoSeries). It inherits all pandas DataFrame methods while adding spatial functionality.

## Essential Workflows

### Data I/O
GeoPandas uses `pyogrio` or `fiona` as engines to interface with GDAL.
- **Reading**: `gdf = geopandas.read_file("data.shp")`
- **Writing**: `gdf.to_file("output.geojson", driver="GeoJSON")`
- **Performance Tip**: For large datasets, use the `pyogrio` engine: `geopandas.read_file(path, engine="pyogrio")`.
- **Cloud Native**: Use `to_parquet()` and `read_parquet()` for the GeoParquet format, which is significantly faster and more storage-efficient than Shapefiles.

### Coordinate Reference Systems (CRS)
Operations between two GeoDataFrames require them to share the same CRS.
- **Check CRS**: `gdf.crs`
- **Set CRS**: `gdf.set_crs(epsg=4326)` (use when the object has no CRS defined).
- **Reproject**: `gdf.to_crs(epsg=3857)` (use to transform coordinates to a new system).
- **Best Practice**: Always reproject to a projected coordinate system (e.g., UTM) before calculating area or distance to ensure units are in meters rather than degrees.

### Spatial Operations
- **Spatial Joins**: Combine two GeoDataFrames based on their spatial relationship.
  `joined_gdf = geopandas.sjoin(points, polygons, how="inner", predicate="intersects")`
- **Dissolve**: Aggregate geometries based on a shared attribute.
  `regions = countries.dissolve(by="continent")`
- **Overlays**: Perform set-theoretic operations (union, intersection, difference).
  `res = geopandas.overlay(df1, df2, how="intersection")`

### Geometric Manipulations
Most methods are vectorized and accessible via the GeoSeries:
- `gdf.geometry.area`: Returns the area of each geometry.
- `gdf.geometry.buffer(distance)`: Creates a buffer zone around geometries.
- `gdf.geometry.centroid`: Returns the geometric center.
- `gdf.geometry.convex_hull`: Returns the smallest convex polygon containing the geometry.

## Visualization
- **Static Plots**: `gdf.plot(column="attribute", legend=True)` (requires matplotlib).
- **Interactive Maps**: `gdf.explore(column="attribute")` (requires folium/mapclassify). This is highly effective for data validation and quick exploration in notebooks.

## Expert Tips
- **Indexing**: Use spatial indexes for performance on large datasets. GeoPandas automatically creates an R-tree index when performing spatial joins.
- **Missing Data**: Be aware that `None` or `np.nan` in a geometry column can cause issues with certain spatial engines. Use `gdf[gdf.geometry.is_valid]` to filter out problematic geometries.
- **Memory Management**: If you only need specific columns or a specific spatial extent, use the `columns` and `bbox` parameters in `read_file` to reduce memory overhead.

## Reference documentation
- [GeoPandas Main README](./references/github_com_geopandas_geopandas.md)
- [GeoPandas Wiki and Notebooks](./references/github_com_geopandas_geopandas_wiki.md)