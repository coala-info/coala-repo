---
name: pycsg
description: pycsg is a Python library for performing constructive solid geometry operations to create complex 3D shapes from simpler meshes. Use when user asks to perform boolean operations on 3D solids, create primitive shapes like cubes or spheres, or generate manifold geometry programmatically.
homepage: https://github.com/timknip/pycsg
metadata:
  docker_image: "quay.io/biocontainers/pycsg:0.3.12--py36_0"
---

# pycsg

## Overview
pycsg is a Python port of the csg.js library, providing an elegant implementation of Constructive Solid Geometry. It allows for the creation of complex 3D shapes by applying boolean logic to simpler meshes. The library is particularly robust at handling edge cases, such as overlapping coplanar polygons, making it a reliable choice for generating manifold 3D geometry programmatically.

## Core API Usage
The library operates primarily through the `CSG` class. Most workflows involve creating primitive solids and then chaining boolean operations.

### Basic Operations
Perform boolean logic between two CSG objects (`a` and `b`):
- **Union**: `a.union(b)` — Combines both solids into one.
- **Subtraction**: `a.subtract(b)` — Removes the volume of `b` from `a`.
- **Intersection**: `a.intersect(b)` — Leaves only the volume where both `a` and `b` overlap.

### Creating Primitives
While the library allows for custom polygon definitions, it typically provides helpers for standard shapes:
- `CSG.cube(center=[0, 0, 0], radius=[1, 1, 1])`
- `CSG.sphere(center=[0, 0, 0], radius=1, slices=16, stacks=8)`
- `CSG.cylinder(start=[0, -1, 0], end=[0, 1, 0], radius=1, slices=16)`

## Expert Tips and Best Practices

### Handling Complex Geometry
For highly complex models with deep BSP trees, you may encounter recursion depth limits.
- **Tip**: Increase the Python recursion limit if you receive a `RuntimeError: maximum recursion depth exceeded`.
  ```python
  import sys
  sys.setrecursionlimit(100000)
  ```

### Mesh Conversion
To interface with other 3D libraries (like PyOpenGL or STL exporters), use the polygon and vertex accessors:
- Use `csg_object.toPolygons()` to retrieve the raw list of polygons.
- Each polygon contains a list of vertices, and each vertex has `pos` (position) and `normal` vectors.

### Performance Optimization
- **Coplanar Polygons**: pycsg handles coplanar polygons correctly, but they are computationally more expensive than simple intersections. Try to align faces perfectly or offset them slightly if performance is a bottleneck.
- **Point Merging**: When converting back to vertices and polygons, the library can merge points that are extremely close to each other to ensure mesh integrity.

### Visualization
To preview your CSG results, the library includes examples using PyOpenGL.
- **Command**: `python examples/pyopengl`
- **Requirement**: Ensure `PyOpenGL` and `PyOpenGL_accelerate` are installed in your environment.

## Reference documentation
- [pycsg Main Repository](./references/github_com_timknip_pycsg.md)
- [Commit History and Versioning](./references/github_com_timknip_pycsg_commits_master.md)