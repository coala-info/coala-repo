---
name: bioconductor-olin
description: This tool performs optimized local intensity-dependent normalization for two-color microarray data to correct spatial and intensity biases. Use when user asks to normalize two-channel microarrays, perform iterative local regression, or visualize spatial dye biases using MXY-plots.
homepage: https://bioconductor.org/packages/release/bioc/html/OLIN.html
---

# bioconductor-olin

name: bioconductor-olin
description: Optimized Local Intensity-dependent Normalization (OLIN) for two-color microarray data. Use this skill to identify and correct intensity-dependent and spatial dye biases using iterative local regression (LOCFIT) and model selection (GCV). It includes tools for visual inspection (MA-plots, MXY-plots), statistical assessment of normalization efficiency (ANOVA, permutation tests), and between-array scaling.

# bioconductor-olin

## Overview

The `OLIN` package provides advanced normalization schemes for two-channel microarray data. Unlike standard linear or global normalization, OLIN uses iterative local regression and generalized cross-validation (GCV) to optimize smoothing parameters, effectively removing non-linear intensity-dependent and spatial (location-dependent) artifacts.

## Core Workflow

### 1. Data Preparation and Inspection
OLIN typically works with `marrayRaw` or `marrayNorm` objects from the `marray` package.

```R
library(OLIN)
data(sw) # Example dataset (SW480/620)

# Visual inspection of foreground/background
fgbg.visu(sw[,3])

# MA-plot for intensity bias
plot(maA(sw[,3]), maM(sw[,3]), xlab="A", ylab="M")

# MXY-plot for spatial bias (using row/column indices)
mxy.plot(maM(sw)[,3], Ngc=maNgc(sw), Ngr=maNgr(sw), Nsc=maNsc(sw), Nsr=maNsr(sw))

# MXY-plot using physical coordinates (if available)
# mxy2.plot(maM(sw)[,3], X=sw.xy$X[,3], Y=sw.xy$Y[,3], ...)
```

### 2. Optimized Normalization (OLIN & OSLIN)
The `olin` function is the primary interface for both standard and scaled normalization.

*   **OLIN**: Corrects for intensity and location bias.
*   **OSLIN**: Performs OLIN followed by optimized scaling of the log-ratio (M) range across the array.

```R
# Standard OLIN normalization
# X and Y are matrices of spot coordinates
norm.olin <- olin(sw[,3], X=sw.xy$X[,3], Y=sw.xy$Y[,3], iter=3)

# OSLIN (with local scaling)
norm.oslin <- olin(sw[,3], X=sw.xy$X[,3], Y=sw.xy$Y[,3], OSLIN=TRUE)
```

**Key Parameters:**
*   `alpha`: Vector of smoothing parameters to test (default: `seq(0.05, 1, 0.1)`).
*   `scale`: Vector of scale parameters for spatial smoothing (X vs Y).
*   `weights`: Used to exclude spots (e.g., controls) or focus on housekeeping genes.
*   `genepix`: Set to `TRUE` if using GenePix quality weights where negative values indicate excluded spots.

### 3. Between-Array Scaling
To adjust the distribution of M-values across multiple arrays in a batch:

```R
# Scale arrays to have equal variance, MAD, or quantiles
sw.scaled <- bas(norm.olin, mode="var") # Options: "var", "mad", "qq"
```

### 4. Assessing Normalization Efficiency
Use statistical tests to verify that biases have been removed.

*   **Correlation Analysis**: High correlation between a spot and its neighborhood indicates remaining bias.
```R
# Check intensity-dependent correlation
Mav <- ma.vector(maA(sw[,3]), maM(sw[,3]), av="median", delta=50)
cor(Mav, maM(sw[,3]), use="pairwise.complete.obs")
```

*   **ANOVA Models**: Test for significant differences in M-means across intensity intervals, spatial blocks, pins, or plates.
```R
anovaint(norm.olin, index=1, N=10)      # Intensity bias
anovaspatial(norm.olin, index=1, xN=8, yN=8) # Spatial bias
anovapin(norm.olin, index=1)            # Pin/Print-tip bias
```

*   **Permutation Tests**: Non-parametric assessment of bias using False Discovery Rate (FDR).
```R
# Assess spatial bias significance
FDR <- fdr.spatial(v2m(maM(sw)[,3], ...), delta=2, N=100)
sigxy.plot(FDR$FDRp, FDR$FDRn, color.lim=c(-5,5))
```

## Usage Tips
*   **Assumptions**: OLIN assumes most genes are not differentially expressed and are randomly spotted. If these are violated, increase the minimum `alpha` to prevent over-fitting.
*   **Artifacts**: Localized artifacts (scratches, bubbles) should be flagged/masked using `sig.mask` before normalization, as local regression assumes a smooth bias.
*   **Iterations**: Usually 2-3 iterations are sufficient for convergence.

## Reference documentation
- [Introduction to OLIN package](./references/OLIN.md)