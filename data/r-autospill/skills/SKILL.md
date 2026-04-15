---
name: r-autospill
description: The r-autospill package calculates spillover coefficients for flow cytometry data using the AutoSpill algorithm to automate compensation and unmixing. Use when user asks to calculate spillover matrices, refine compensation accuracy, or estimate signal leakage between fluorescence channels using single-color controls.
homepage: https://cran.r-project.org/web/packages/autospill/index.html
---

# r-autospill

name: r-autospill
description: Use this skill when working with the R package 'autospill' to calculate spillover coefficients for flow cytometry data. It is specifically designed for compensating or unmixing high-parameter flow cytometry data using the AutoSpill algorithm.

# r-autospill

## Overview
The `autospill` package implements the AutoSpill algorithm, which provides a robust method for calculating spillover coefficients in flow cytometry. It automates the compensation process by using single-color controls to estimate the leakage of signal between different fluorescence channels, ensuring high accuracy even in high-parameter panels.

## Installation
To install the package from CRAN:
```R
install.packages("autospill")
```

To install the development version from GitHub:
```R
library(devtools)
install_github("carlosproca/autospill")
```

## Main Functions and Workflows

### Core Functions
- `get.marker.spillover`: Calculates the initial spillover matrix from a set of single-color control FCS files.
- `refine.spillover`: Refines an existing spillover matrix to improve compensation accuracy, often used iteratively.

### Basic Workflow
1. **Load Data**: Import your single-color control FCS files using `flowCore`.
2. **Calculate Spillover**: Use `get.marker.spillover` providing the flowSet of controls and the mapping of channels to markers.
3. **Refine (Optional)**: If the compensation requires further adjustment, apply `refine.spillover`.
4. **Apply Compensation**: Use the resulting matrix with `flowCore::compensate()` on your experimental data.

### Tips for Success
- **Control Quality**: Ensure single-color controls have clearly defined positive and negative populations.
- **Iterative Refinement**: The AutoSpill algorithm is designed to be robust, but if over- or under-compensation is observed, check the gate definitions used for the positive populations.
- **Data Transformation**: Ensure data is appropriately transformed (e.g., logicle or arcsinh) before visualization, though AutoSpill typically works on linear scales for coefficient calculation.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)