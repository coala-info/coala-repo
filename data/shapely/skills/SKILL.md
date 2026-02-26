---
name: shapely
description: Shapely is a Python library for the manipulation and analysis of planar geometric objects. Use when user asks to manipulate geometric shapes, perform spatial operations like buffering and intersections, check spatial predicates, or serialize geometries to WKT and GeoJSON.
homepage: https://github.com/shapely/shapely
---


# shapely

## Overview
Shapely is the industry-standard Python library for the manipulation and analysis of planar geometric objects. It provides a Pythonic interface to the GEOS C++ library, allowing for complex spatial operations like buffering, simplifying, and calculating intersections. It is designed for Cartesian (planar) coordinates and is a core component of the Python GIS ecosystem, often used alongside NumPy for high-performance spatial data processing.

## Core Usage Patterns

### Scalar Geometry Interface
For individual geometric operations, use the object-oriented interface:

```python
from shapely import Point, Polygon

# Create a point and buffer it to create a circular polygon
point = Point(0.0, 0.0)
patch = point.buffer(10.0)

# Calculate properties
print(patch.area)
print(patch.centroid)

# Create a bounding box
bbox = shapely.box(0, 0, 2, 2)
```

### Vectorized Operations (ufuncs)
For processing large collections of geometries, use the vectorized interface which operates on NumPy arrays. This is significantly faster than iterating over geometries in a Python loop.

```python
import shapely
import numpy as np

# Create an array of points
geoms = np.array([Point(0, 0), Point(1, 1), Point(2, 2)])
polygon = shapely.box(0, 0, 2, 2)

# Perform a vectorized spatial predicate check
mask = shapely.contains(polygon, geoms)
```

### Serialization and Integration
Shapely does not handle file I/O directly but provides robust tools for serializing geometries into standard formats:

*   **WKT (Well-Known Text)**: `shapely.wkt.dumps(geom)` and `loads(text)`
*   **WKB (Well-Known Binary)**: `shapely.wkb.dumps(geom)` and `loads(binary)`
*   **GeoJSON**: Use `shapely.geometry.mapping(geom)` to create a dictionary or `shape(dict)` to create a geometry from a dictionary.

## Expert Tips and Best Practices

*   **Performance**: Always prefer `shapely.*` functions (like `shapely.intersects(a, b)`) over calling methods on objects (like `a.intersects(b)`) when working with arrays, as the former are implemented as NumPy ufuncs.
*   **Multithreading**: Shapely releases the Global Interpreter Lock (GIL) during heavy GEOS operations. You can use standard Python `threading` to perform spatial analysis in parallel within a single process.
*   **Coordinate Systems**: Remember that Shapely operates in the Cartesian plane. It does not handle geographic (lat/long) projections or coordinate transformations. Use libraries like `pyproj` to project data to a planar CRS before using Shapely.
*   **Memory Efficiency**: When working with large datasets, use `shapely.from_wkb` or `shapely.from_wkt` to bulk-load geometries into NumPy arrays.
*   **Spatial Indexing**: For "point-in-polygon" or "nearest neighbor" queries across large datasets, use `shapely.STRtree` to create a spatial index for high-speed lookups.

## Reference documentation
- [Shapely README](./references/github_com_shapely_shapely.md)