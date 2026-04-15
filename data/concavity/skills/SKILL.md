---
name: concavity
description: Concavity is a Python spatial analysis tool that generates concave hulls and identifies concave or convex vertices. Use when user asks to generate concave hulls, identify concave or convex vertices, analyze polygon topology, or perform geometric feature recognition.
homepage: https://github.com/mlichter2/concavity
metadata:
  docker_image: "biocontainers/concavity:v0.1dfsg.1-4-deb_cv1"
---

# concavity

## Overview
Concavity is a Python-based spatial analysis tool designed to solve the "gift-wrapping" problem more precisely than standard convex hull algorithms. It uses a k-nearest-neighbors approach to generate concave hulls (alpha shapes) that better represent the actual shape of a point cloud. Beyond boundary generation, it provides specialized functions to analyze the topology of polygons by identifying concave and convex vertices, which is essential for shape simplification, feature recognition, and geometric EDA.

## Core Workflows

### Generating Concave Hulls
The primary function `concavity.concave_hull(coords, k)` requires an array of coordinates and a neighbor parameter `k`.

- **Choosing k**: 
  - **Low k (e.g., 10-15)**: Produces a highly detailed, "tight" boundary. Use this for complex shapes with deep indentations. Note: Too low a value may result in fragmented geometries or errors if the point density is inconsistent.
  - **High k (e.g., 50+)**: Produces a smoother, more generalized boundary. As `k` increases, the result converges toward a convex hull.
- **Performance Note**: The algorithm may experience significant slowdowns on point clouds exceeding 6,500 points. For very large datasets, consider spatial indexing or downsampling before processing.

### Vertex Detection and Analysis
Use `find_concave_vertices` and `find_convex_vertices` to classify points along a polygon's boundary.

- **Angle Threshold**: Set the `angle_threshold` (in degrees) to filter out insignificant deviations. A threshold of `0` captures all vertices that deviate from a straight line.
- **Filter Types**:
  - `filter_type='all'`: Returns every vertex exceeding the threshold.
  - `filter_type='peak'`: Uses peak detection to find only the most extreme points of concavity or convexity in a local neighborhood.
- **Refinement**: Use the `convolve=True` argument with peak detection to smooth the angle calculations, which helps in identifying true geometric features rather than digitization noise.

### Geometry Pre-processing
For better vertex detection results on jagged or digitized polygons, apply smoothing first:
```python
from concavity.utils import gaussian_smooth_geom
smoothed_geom = gaussian_smooth_geom(polygon_obj)
```

## Expert Tips
- **EDA Visualization**: Use `concavity.plot_concave_hull(coords, hull_poly)` to quickly compare the generated concave hull against the original points and the theoretical convex hull.
- **Data Structures**: The tool integrates natively with `shapely` geometries and `geopandas` GeoDataFrames. When using `filter_type='all'`, the output is typically a GeoDataFrame, making it easy to perform immediate spatial joins or exports.
- **Coordinate Systems**: Ensure your coordinates are in a projected coordinate system (e.g., UTM) rather than geographic (lat/lon) for accurate angle and distance calculations.

## Reference documentation
- [Concavity Main Documentation](./references/github_com_mlichter2_concavity.md)
- [Issue Tracker (Performance limits)](./references/github_com_mlichter2_concavity_issues.md)