---
name: ogdf
description: OGDF is a C++ library providing high-performance algorithms and data structures for graph theory and automatic graph visualization. Use when user asks to integrate graph drawing algorithms into C++ projects, perform planarization or crossing minimization, generate specialized layouts like Sugiyama or force-directed drawings, and handle graph input/output operations.
homepage: https://github.com/ogdf/ogdf
metadata:
  docker_image: "quay.io/biocontainers/ogdf:201207--hc9558a2_2"
---

# ogdf

## Overview
OGDF (Open Graph Drawing Framework) is a comprehensive C++ library providing high-performance algorithms and data structures for graph theory and automatic graph visualization. It is particularly powerful for tasks requiring planarization, crossing minimization, and specialized layouts like Sugiyama or force-directed drawings. Use this skill to navigate the library's extensive algorithm suite, configure builds via CMake, or handle graph input/output operations.

## Core Workflows and Best Practices

### Project Integration with CMake
OGDF is best integrated into C++ projects using CMake.
- Use `find_package(OGDF REQUIRED)` in your `CMakeLists.txt`.
- Link the library using `target_link_libraries(your_target PRIVATE OGDF::ogdf)`.
- To minimize build times in external projects, use the CMake option `-DOGDF_FULL_DOC=OFF` to skip documentation generation and focus on library targets.
- For Windows builds, ensure consistency between `/MT` and `/MD` flags to avoid linker errors with MSVC.

### Graph Input/Output (GraphIO)
OGDF supports various formats for reading and writing graphs.
- **SVG/TikZ**: Use `GraphIO::drawSVG` or `GraphIO::drawTikz` for high-quality vector exports suitable for web or LaTeX. Note that `drawSVG` correctly handles dashed arrows and given settings in recent versions.
- **GML/GraphML**: Preferred formats for preserving graph structure and attributes. Use `GraphIO::readGML` or `GraphIO::readGraphML`.
- **yEd Compatibility**: The framework can read yFiles/yEd GraphML files, making it useful for processing manually created diagrams.

### Selecting Layout Algorithms
Choose the layout based on the graph's properties and the desired visual outcome:
- **Trees**: Use `RadialTreeLayout` for planar, circular tree visualizations.
- **Large Graphs**: Use `PivotMDS` or `StressMinimization` for fast, force-directed layouts. Ensure 2D output by calling `setForcing2DLayout(true)` if the graph attributes are set to 3D.
- **Planar Graphs**: Use `PlanarizationLayout` for drawings with minimized crossings.
- **Hierarchical Graphs**: The Sugiyama framework is the standard for directed acyclic graphs (DAGs).

### Algorithmic Modules
OGDF provides specialized modules for advanced graph problems beyond drawing:
- **Minimum Cut**: Use `MinimumCutStoerWagner` for performance-oriented min-cut calculations or `MinimumCutNagamochiIbaraki`.
- **Spanners**: Implement `SpannerBasicGreedy` or `SpannerBaswanaSen` for network topology simplification.
- **Planar Separators**: Use `SeparatorLiptonTarjan` or `SeparatorDual` for partitioning planar graphs.
- **Subgraphs**: Use `MaximumDensitySubgraph` for finding dense clusters within a network.

### Expert Tips
- **Memory Management**: OGDF uses its own memory management for graph objects. Be mindful of the ownership of `node` and `edge` pointers when modifying the graph structure.
- **Python Bindings**: For rapid prototyping or data science workflows, use `ogdf-python` which integrates well with Jupyter Notebooks.
- **Attribute Uniformity**: Use `GraphAttributes::isUniform()` to check if all elements share the same visual properties before batch processing.
- **Geometric Crossing**: For geometric layouts, consider `CrossingMinimalPositionFast` or `GeometricEdgeInsertion` (requires CGAL).

## Reference documentation
- [OGDF README](./references/github_com_ogdf_ogdf.md)
- [Release Notes and Algorithm List](./references/github_com_ogdf_ogdf_tags.md)
- [OGDF Issues and Support](./references/github_com_ogdf_ogdf_issues.md)