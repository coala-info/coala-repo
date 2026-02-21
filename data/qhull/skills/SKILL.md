---
name: qhull
description: Qhull is a robust suite of tools for computing geometric structures based on the Quickhull algorithm.
homepage: https://github.com/qhull/qhull
---

# qhull

## Overview

Qhull is a robust suite of tools for computing geometric structures based on the Quickhull algorithm. It transforms sets of input points into convex hulls or related spatial partitions. The toolset is designed to be modular, with specific executables for different geometric tasks, and relies on standard input/output streams for data processing.

## Core Executables

- **qconvex**: Computes the convex hull of a point set.
- **qdelaunay**: Computes the Delaunay triangulation.
- **qvoronoi**: Computes the Voronoi diagram.
- **qhalf**: Computes the halfspace intersection about a point.
- **rbox**: A generator tool for creating input point sets (cubes, spheres, random points).

## Common CLI Patterns

### Generating and Processing Points
The most common workflow involves piping output from `rbox` into a qhull command:

```bash
# Compute the convex hull of 10 random points
rbox 10 | qconvex

# Compute the Delaunay triangulation of 100 points in 3D
rbox 100 D3 | qdelaunay

# Generate a Voronoi diagram for a 2D grid
rbox G2 | qvoronoi
```

### Output Redirection
Qhull uses a specific `TO` syntax for internal output redirection, which is often preferred over standard shell redirection in Windows environments to ensure errors are captured correctly:

```bash
# Write the summary of a convex hull to a file
rbox 10 | qconvex s TO results.txt

# Write the vertices of a hull in OFF format
rbox 10 | qconvex i TO hull.off
```

### Input Format
If providing your own data, the input format must follow this structure:
1. The first line is the dimension.
2. The second line is the number of points.
3. Subsequent lines contain the coordinates for each point.

Example input file (`points.txt`):
```text
2
3
0 0
1 0
0.5 1
```
Usage: `qconvex < points.txt`

## Expert Tips and Best Practices

- **Handling Coplanar Points**: In 3D Delaunay triangulations or Voronoi diagrams, many coplanar points can lead to expensive facet merges. Use the `Q17` option (previously `Q15`) to check for duplicates and improve performance in these cases.
- **Dimension Limits**: While qhull handles general dimensions, memory usage increases significantly with dimension. For 4D and higher, consider using the 32-bit version if memory is a constraint, as it uses approximately 33% less memory.
- **Precision Control**: Use the `Pp` option to suppress precision warnings if the input is known to be slightly degenerate but acceptable for your use case.
- **Summary Information**: Always start with the `s` flag (e.g., `qconvex s`) to get a high-level summary of the number of facets and vertices before requesting full coordinate outputs.
- **Visualization**: Use the `G` option to generate output for Geomview, which is the standard way to visually inspect qhull results.

## Reference documentation
- [Qhull README](./references/github_com_qhull_qhull.md)
- [Qhull Wiki](./references/github_com_qhull_qhull_wiki.md)