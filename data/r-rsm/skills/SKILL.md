---
name: r-rsm
description: The r-rsm tool provides expert guidance for designing experiments and performing response-surface analysis using the R package rsm. Use when user asks to generate experimental designs, fit first- or second-order response-surface models, perform canonical and ridge analysis, or visualize surfaces with contour and perspective plots.
homepage: https://cloud.r-project.org/web/packages/rsm/index.html
---

# r-rsm

name: r-rsm
description: Expert guidance for response-surface analysis using the R package 'rsm'. Use this skill when you need to design experiments (Central Composite, Box-Behnken), fit first- or second-order response-surface models, perform canonical analysis, find paths of steepest ascent/ridge analysis, or visualize surfaces with contour and perspective plots.

# r-rsm

## Overview
The `rsm` package provides tools for the entire Response-Surface Methodology (RSM) workflow. It facilitates the transition from initial screening experiments to optimization through sequential experimentation. Key features include coded data management, standard design generation, model fitting with specialized formula operators, and advanced surface visualization.

## Installation
To use this package in R:
```R
install.packages("rsm")
library(rsm)
```

## Coded Data
RSM requires data to be coded (typically centered at 0 with a range of [-1, 1] for the design portion) to ensure the path of steepest ascent is scale-invariant.
- **Create coded data**: `CR <- coded.data(data, x1 ~ (Time - 85)/5, x2 ~ (Temp - 175)/5)`
- **View coded form**: `as.data.frame(CR)`
- **Decode**: `decode.data(CR)`
- **Convert values**: `code2val()` and `val2code()`

## Generating Designs
- **Box-Behnken (bbd)**: `bbd(k, n0, coding)` - Three-level designs for $k$ factors.
- **Central Composite (ccd)**: `ccd(formula, n0, alpha, blocks)` - Combines a "cube" (factorial) and "star" (axis) points.
- **Picking CCD parameters**: `ccd.pick(k)` helps find $\alpha$ values for rotatability and orthogonality.
- **Building blocks**: Use `cube()`, `star()`, `foldover()`, and `dupe()` to build designs sequentially, then combine with `djoin()`.

## Fitting Models
Use the `rsm()` function, which extends `lm()`. Formulas must use special operators:
- `FO(x1, x2)`: First-order (linear) terms.
- `TWI(x1, x2)`: Two-way interactions.
- `PQ(x1, x2)`: Pure quadratic terms.
- `SO(x1, x2)`: Second-order model (shorthand for `FO + TWI + PQ`).

Example:
```R
model <- rsm(Yield ~ Block + SO(x1, x2), data = my_data)
summary(model)
```

## Analysis and Optimization
- **Steepest Ascent**: For first-order models, use `steepest(model, dist = seq(0, 5, by = 1))` to find the path toward the maximum.
- **Canonical Analysis**: Automatically provided in `summary()` for second-order models. It identifies the stationary point (maximum, minimum, or saddle).
- **Ridge Analysis**: For second-order models where the stationary point is distant or a saddle, use `steepest()` to find the best path from the center.
- **Canonical Path**: Use `canonical.path()` to explore the ridge of a second-order surface.

## Visualization
The package provides S3 methods for `lm` objects to visualize surfaces:
- **Contour Plots**: `contour(model, x2 ~ x1, image = TRUE)`
- **Perspective Plots**: `persp(model, x2 ~ x1, col = "blue", contours = "top")`
- **Slicing**: Use the `at` argument to fix other variables (e.g., `at = xs(model)` to slice at the stationary point).
- **Hooks**: Use the `hook` argument to add annotations (like the stationary point) to multiple plots automatically.

## Reference documentation
- [Response-Surface Methods in R, Using rsm](./references/article-JSS.md)
- [Response-surface illustration](./references/illus.md)
- [Surface Plots in the rsm Package](./references/plots.md)