---
name: bioconductor-assorthead
description: This package provides a centralized collection of high-performance C++ header-only libraries for Bioconductor R package development. Use when user asks to integrate standardized C++ dependencies like tatami or Eigen, manage matrix operations, perform single-cell analysis in C++, or avoid manual vendoring of header libraries.
homepage: https://bioconductor.org/packages/release/bioc/html/assorthead.html
---


# bioconductor-assorthead

name: bioconductor-assorthead
description: Use this skill when developing or maintaining Bioconductor R packages that require high-performance C++ header-only libraries. It provides guidance on integrating 'assorthead' to access standardized versions of libraries like tatami, Eigen, Annoy, and various single-cell analysis components (libscran) without manual vendoring.

## Overview

The `assorthead` package serves as a central Bioconductor repository for header-only C++ libraries. Its primary purpose is to prevent "vendor bloat"—where multiple R packages each include their own copies of the same C++ headers—by providing a single source for these dependencies. This ensures version consistency across the Bioconductor ecosystem and simplifies the maintenance of packages that rely on advanced C++ frameworks for matrix handling (tatami), nearest neighbor search (knncolle), or linear algebra (Eigen).

## Integration Workflow

### 1. Package Configuration
To use the libraries provided by `assorthead` in an R package, you must declare the dependency in your `DESCRIPTION` file. This allows the R build system to include the appropriate header paths during compilation.

```
LinkingTo: assorthead
```

### 2. C++ Implementation
Once the dependency is declared, you can include any of the bundled headers directly in your package's C++ source files (`src/`).

**Common Include Patterns:**
- **Linear Algebra:** `#include "Eigen/Dense"`
- **Matrix API:** `#include "tatami/tatami.hpp"`
- **Nearest Neighbors:** `#include "annoy/annoylib.h"` or `#include "knncolle/knncolle.hpp"`
- **Single-cell Utilities:** `#include "scran_qc/scran_qc.hpp"`

### 3. Working with External Pointers
`assorthead` is designed to work seamlessly with other Bioconductor infrastructure packages that pass C++ objects back to R as external pointers (`SEXP`).

- **beachmat:** Use `assorthead` headers to operate on `tatami::Matrix` objects initialized via `beachmat::initializeCpp()`.
- **BiocNeighbors:** Use `assorthead` headers to interact with neighbor search indices built via `BiocNeighbors::buildIndex()`.

This approach allows your package to leverage the full functionality of these frameworks (e.g., handling HDF5 or TileDB backed matrices) without needing to re-compile the entire library stack yourself.

## Available Library Categories

- **Matrix Management:** `tatami` (and extensions for R, HDF5, TileDB, and chunked matrices).
- **Linear Algebra & Stats:** `Eigen`, `irlba`, `powerit`, `kmeans`, `WeightedLowess`.
- **Nearest Neighbors:** `annoy`, `hnswlib`, `knncolle`.
- **Single-cell Analysis (libscran):** QC, normalization, PCA, graph-based clustering, marker detection, and MNN batch correction.
- **Data Formats:** `millijson` (JSON), `uzuki2` (R lists in HDF5/JSON).
- **Parallelization:** `subpar`.

## Tips for Developers

- **Minimal Dependencies:** `assorthead` is intentionally minimalistic. Linking to it adds very little overhead to your package's dependency tree.
- **Version Coordination:** If you require a specific version of a library or wish to contribute a new header-only library, modifications should be proposed to the `inst/fetch.R` file in the `assorthead` GitHub repository.
- **Avoid Redundant Vendoring:** Before adding a C++ library to your own package's `inst/include` or `src/` directory, check if it is already available in `assorthead`.

## Reference documentation

- [User's Guide (Rmd)](./references/userguide.Rmd)
- [User's Guide (Markdown)](./references/userguide.md)