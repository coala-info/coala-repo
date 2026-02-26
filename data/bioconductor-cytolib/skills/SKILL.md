---
name: bioconductor-cytolib
description: This package provides the core C++ data structures and headers for representing and managing gated cytometry data. Use when user asks to link to C++ cytometry infrastructure, develop high-performance flow cytometry tools, or manage GatingSet data structures in R packages.
homepage: https://bioconductor.org/packages/release/bioc/html/cytolib.html
---


# bioconductor-cytolib

## Overview
`cytolib` is a fundamental Bioconductor package that provides the core C++ data structures and headers for representing gated cytometry data. It serves as the backbone for the `GatingSet` object, which is the standard format for hierarchical gating in the R flow cytometry ecosystem. While users rarely call functions from `cytolib` directly in an R session, it is a critical "LinkingTo" dependency for developers building high-performance cytometry tools.

## Developer Workflow

### Linking to cytolib
To use the C++ infrastructure provided by `cytolib` in a custom R package, you must configure your `DESCRIPTION` file to include it in the `LinkingTo` field. This allows the compiler to locate the necessary headers during the build process.

```
LinkingTo: 
    cytolib,
    Rcpp
```

### Implementation Pattern
1. **C++ Headers**: Include the relevant headers in your C++ source files to interact with `GatingSet` objects.
2. **Reference Implementation**: The `flowWorkspace` package is the primary reference for how to correctly implement and extend the classes defined in `cytolib`.
3. **Portability**: The package is designed to be cross-platform, providing a consistent C++ API across Windows, macOS, and Linux.

## Usage Tips
* **Dependency Management**: If you encounter compilation errors related to missing cytometry data structures in other Bioconductor packages, ensure `cytolib` is correctly installed and updated.
* **Performance**: Use `cytolib` when R-level processing of large-scale flow cytometry experiments (GatingSets) becomes a bottleneck and requires C++ optimization.
* **Integration**: It is almost always used in conjunction with `flowCore` (for FCS data) and `flowWorkspace` (for gating hierarchies).

## Reference documentation
- [Using cytolib](./references/cytolib.md)