---
name: julia-divand
description: The julia-divand skill enables the interpolation of arbitrarily located data points into a smooth, continuous field across multiple dimensions (1D, 2D, 3D, or more).
homepage: https://github.com/gher-uliege/DIVAnd.jl
---

# julia-divand

## Overview

The julia-divand skill enables the interpolation of arbitrarily located data points into a smooth, continuous field across multiple dimensions (1D, 2D, 3D, or more). Unlike standard interpolation methods, it excels at handling complex topologies, such as preventing data from being "smeared" across land masses or through physical barriers. It is the n-dimensional successor to the original DIVA (Data-Interpolating Variational Analysis) tool, offering significantly improved performance and flexibility by leveraging the Julia programming language.

## Installation and Setup

To use the tool within a Julia environment:

```julia
using Pkg
Pkg.add("DIVAnd")
using DIVAnd
```

For system-level installation via Conda:
```bash
conda install bioconda::julia-divand
```

## Core Analysis Workflow

The primary function for performing analysis is `DIVAndrun`. It requires specific inputs to define the geometry and physical constraints of the interpolation.

### Basic Function Signature
```julia
fi, s = DIVAndrun(mask, (pm, pn, ...), (xi, yi, ...), (x, y, ...), f, len, epsilon2);
```

### Parameter Definitions
*   **mask**: A BitArray or Array (typically 1 for sea, 0 for land) defining the valid analysis domain.
*   **metrics (pm, pn, ...)**: A tuple of scale factors for the grid. These define the distance between grid points in each dimension.
*   **output grid (xi, yi, ...)**: A tuple containing the coordinates of the final desired grid.
*   **observation coordinates (x, y, ...)**: A tuple containing the coordinates where observations were actually taken.
*   **f**: The data anomalies (observations minus a background field).
*   **len**: The correlation length, determining the "smoothness" or the range of influence of an observation.
*   **epsilon2**: The error variance of the observations (normalized by the background error variance).

## Expert Tips and Best Practices

### Dimensionality and Memory
*   **Scaling**: While DIVAnd supports n-dimensions, memory (RAM) requirements increase significantly with each added dimension. For 4D analysis (3D space + time), ensure the system has sufficient memory for the resulting sparse matrix inversion.
*   **Curvilinear Grids**: Use curvilinear coordinates for global or large-scale regional models where Earth's curvature or specific flow-following coordinates are necessary.

### Physical and Topological Constraints
*   **Barriers**: The `mask` parameter is the most effective way to handle land-sea boundaries. DIVAnd naturally prevents interpolation across "holes" or "barriers" in the mask.
*   **Periodicity**: If working with global data or circular domains, you can enforce periodicity in specific directions to ensure continuity at the boundaries.

### Parameter Tuning
*   **Non-dimensionalization**: Ensure that the product of your metrics (e.g., `pm`) and the correlation length (`len`) results in a non-dimensional parameter.
*   **Error Mapping**: The second return value of `DIVAndrun` (often denoted as `s`) can be used to estimate the analysis error, which is critical for assessing the reliability of the gridded field in data-sparse regions.

### Troubleshooting
*   **Verification**: Run the built-in test suite to ensure the environment is correctly configured:
    ```julia
    using Pkg
    Pkg.test("DIVAnd")
    ```
*   **Help System**: Access detailed documentation for specific sub-functions directly in the Julia REPL using the `?` prefix:
    ```julia
    ?DIVAndrun
    ```

## Reference documentation
- [github_com_gher-uliege_DIVAnd.jl.md](./references/github_com_gher-uliege_DIVAnd.jl.md)
- [anaconda_org_channels_bioconda_packages_julia-divand_overview.md](./references/anaconda_org_channels_bioconda_packages_julia-divand_overview.md)