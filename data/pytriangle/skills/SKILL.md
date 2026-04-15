---
name: pytriangle
description: pytriangle generates 2D meshes and Constrained Delaunay Triangulations from point sets and Planar Straight Line Graphs. Use when user asks to create 2D meshes, define boundaries and holes, refine mesh density, or interpolate point attributes.
homepage: https://github.com/pletzer/pytriangle
metadata:
  docker_image: "quay.io/biocontainers/pytriangle:1.0.9--py312h0fa9677_10"
---

# pytriangle

## Overview
The `pytriangle` skill provides a procedural workflow for generating 2D meshes from point sets and Planar Straight Line Graphs (PSLG). It allows for the definition of boundaries, internal holes, and point attributes that are automatically interpolated during the triangulation process. This tool is particularly effective when you need to control mesh density via maximum area constraints or refine existing triangulations to improve element quality.

## Core Workflow

### 1. Initialization and Point Definition
Start by creating a `Triangle` instance and defining your coordinate sets.
- **Boundary Points**: Use a marker value of `1`.
- **Internal Points**: Use a marker value of `0`.

```python
import triangle
t = triangle.Triangle()

# Define coordinates and markers
points = [(0, 0), (1, 0), (1, 1), (0, 1), (0.5, 0.5)]
markers = [1, 1, 1, 1, 0] 
t.set_points(points, markers=markers)
```

### 2. Defining Topology (Segments and Holes)
To create a Constrained Delaunay Triangulation (CDT), define segments that the triangulator must respect.
- **Outer Boundary**: Define segments in **counterclockwise** order.
- **Holes**: Define internal segments in **clockwise** order.
- **Hole Points**: Provide a single coordinate located anywhere inside the empty region to designate it as a hole.

```python
# Connect points 0-1, 1-2, 2-3, 3-0
segments = [(0, 1), (1, 2), (2, 3), (3, 0)]
t.set_segments(segments)

# Define a hole at a specific coordinate
t.set_holes([(0.2, 0.2)])
```

### 3. Triangulation and Refinement
Execute the triangulation by specifying constraints.
- **Area Constraint**: Use the `area` parameter to set the maximum size of any single triangle.
- **Refinement**: Use `refine` with an `area_ratio` to add points and improve mesh density.

```python
# Initial triangulation
t.triangulate(area=0.01)

# Further refinement
t.refine(area_ratio=1.5)
```

### 4. Extracting Results
Retrieve the generated mesh data for further processing or visualization.
- `get_points()`: Returns `[[(x, y), marker], ...]`
- `get_triangles()`: Returns `[[(v0, v1, v2), (n0, n1, n2), [attr0, ...]], ...]` where `v` are vertex indices and `n` are optional node indices.

## Best Practices
- **Attribute Interpolation**: If you have physical values (like temperature or pressure) at specific points, use `set_point_attributes(attributes)`. TRIANGLE will automatically interpolate these values to the new points created during triangulation.
- **Marker Consistency**: Always ensure boundary markers are consistently applied to help distinguish between exterior edges and interior edges in post-processing.
- **Hole Placement**: When defining holes, ensure the hole coordinate does not lie exactly on a segment or vertex, as this can cause ambiguity in the triangulation logic.

## Reference documentation
- [pytriangle README](./references/github_com_pletzer_pytriangle.md)