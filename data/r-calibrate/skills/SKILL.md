---
name: r-calibrate
description: "Package for drawing calibrated scales with tick marks on (non-orthogonal)               variable vectors in scatterplots and biplots. Also provides some functions for biplot creation and 	     for multivariate analysis such as principal coordinate analysis.</p>"
homepage: https://cloud.r-project.org/web/packages/calibrate/index.html
---

# r-calibrate

name: r-calibrate
description: Expert guidance for the R package 'calibrate' to create calibrated axes with tick marks and labels in scatterplots and biplots. Use this skill when you need to add oblique variable axes to scatterplots, perform multivariate analysis (PCA, CA, CCA, RDA) with calibrated biplot axes, or customize plot annotations with non-orthogonal scales.

## Overview

The `calibrate` package provides tools for drawing calibrated scales along variable vectors in scatterplots and biplots. While standard R plots provide perpendicular X and Y axes, `calibrate` allows for the addition of oblique axes representing supplementary variables or biplot dimensions, complete with tick marks, numeric labels, and goodness-of-fit statistics.

## Installation

```R
install.packages("calibrate")
library(calibrate)
```

## Core Workflow: Calibrating a Scatterplot Axis

To add a calibrated axis for a third variable ($X_5$) onto a scatterplot of two variables ($X_1, X_2$):

1.  **Center the data**: Calibration usually requires centered coordinates.
2.  **Calculate regression coefficients**: Obtain the direction of the axis by regressing the target variable onto the plot coordinates.
3.  **Define tick marks**: Create a sequence of values in the original scale and center them.
4.  **Call `calibrate()`**: Draw the axis.

```R
# 1. Setup plot
Xc <- scale(X, center=TRUE, scale=FALSE)
plot(Xc[,1], Xc[,2])

# 2. Get direction (b) for variable X5
b <- solve(t(Xc[,1:2]) %*% Xc[,1:2]) %*% t(Xc[,1:2]) %*% Xc[,5]

# 3. Define ticks
tm <- seq(2, 10, by=1)
tmc <- tm - mean(X[,5])

# 4. Calibrate
calibrate(b, Xc[,5], tmc, Xc[,1:2], tmlab=tm, axislab="X5")
```

## Key Functions

### `calibrate()`
The primary function for drawing calibrated axes.
- `g`: Vector of coordinates (direction) for the axis.
- `y`: The variable values (centered) to be represented.
- `tmc`: Centered tick mark positions.
- `Fr`: Matrix of coordinates of the points in the plot.
- `tmlab`: Labels for the tick marks (original scale).
- `shiftdir`: Shift axis to "left" or "right" to avoid cluttering the data cloud.
- `shiftfactor`: Controls how far the axis is shifted (default 1.05).
- `tl`: Tick length (default 0.05).
- `dp`: Logical; if `TRUE`, draws perpendicular lines from points to the axis.
- `weights`: Diagonal matrix of weights for Weighted Least Squares (common in CA).

### `textxy()`
An improved labeling function that prevents labels from overlapping points.
- `textxy(x, y, labs, m = c(0,0), ...)`
- Use `offset` to control distance from the point.

### `canocor()` and `rda()`
- `canocor(X, Y)`: Performs Canonical Correlation Analysis.
- `rda(X, Y)`: Performs Redundancy Analysis.
Both return objects compatible with biplot calibration.

## Advanced Workflows

### Biplot Calibration (PCA)
When using `princomp`, calibrate the loadings (`Gs`) against the scores (`Fp`).
```R
pca <- princomp(X, cor=FALSE)
# Calibrate variable 3
g <- pca$loadings[3, 1:2]
yc <- X[,3] - mean(X[,3])
ticklab <- seq(5, 30, by=5)
calibrate(g, yc, ticklab - mean(X[,3]), pca$scores[,1:2], tmlab=ticklab)
```

### Double Calibration and Subscales
To create a refined scale (e.g., major and minor ticks), call `calibrate` twice:
1.  First call: Use coarse sequence with `lm=TRUE` (labels) and larger `tl`.
2.  Second call: Use fine sequence with `lm=FALSE` (no labels), `verb=FALSE`, and smaller `tl`.

### Shifting Axes
To keep the center of the plot clean, use `shiftdir`:
```R
calibrate(b, yc, tmc, Xc, tmlab=tm, shiftdir="right", shiftfactor=1.1)
```

## Tips for Success
- **Aspect Ratio**: Always use `asp=1` in your `plot()` call to ensure angles and projections are geometrically correct.
- **Clipping**: If drawing axes in margins, set `par(xpd=TRUE)` before calling `calibrate`.
- **Goodness-of-fit**: The function returns an $R^2$ value. If this is low, the 2D projection does not represent that variable accurately.
- **GLS Calibration**: For CCA or RDA, use the `weights` argument (e.g., `weights=solve(Rxx)`) for mathematically precise biplot recovery.

## Reference documentation
- [CalibrationGuide](./references/CalibrationGuide.md)