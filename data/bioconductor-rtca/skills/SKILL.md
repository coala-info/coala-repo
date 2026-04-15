---
name: bioconductor-rtca
description: This tool imports, transforms, and visualizes real-time cell electrical impedance data from the xCELLigence system. Use when user asks to parse RTCA files, normalize Cell Index values, calculate growth rates, or visualize impedance-based assay results.
homepage: https://bioconductor.org/packages/release/bioc/html/RTCA.html
---

# bioconductor-rtca

name: bioconductor-rtca
description: Import, transform, and visualize real-time cell electrical impedance data from the xCELLigence (RTCA) system. Use this skill when analyzing Cell Index (CI) data, performing normalization (ratio, smooth, interpolation), or calculating growth rates from impedance-based assays.

# bioconductor-rtca

## Overview
The `RTCA` package provides tools for importing and analyzing data from the Roche xCELLigence System. It handles "Cell Index" (CI) values—dimensionless parameters reflecting cell number, viability, and morphology based on electrical impedance. The package extends the `ExpressionSet` class, allowing for seamless integration with other Bioconductor workflows.

## Core Workflow

### 1. Data Import and Annotation
The primary function for data entry is `parseRTCA`, which reads tab-delimited files exported from the xCELLigence software.

```r
library(RTCA)

# Basic import
rtca_obj <- parseRTCA("path/to/exported_data.txt")

# Import with metadata (phenoData)
# phenoData should be an AnnotatedDataFrame mapping wells (A01, A02, etc.) to experimental conditions
pData <- read.csv("metadata.csv", sep="\t", row.names="Well")
phData <- new("AnnotatedDataFrame", data=pData)
rtca_obj <- parseRTCA("data.txt", phenoData=phData)
```

### 2. Managing the Experiment Timeline
You can record experimental events (e.g., compound addition, medium change) directly within the RTCA object to assist in downstream analysis.

```r
# Add events to the timeline
rtca_obj <- addAction(rtca_obj, 22, "transfection")
rtca_obj <- addAction(rtca_obj, 30, "medium change")

# View the timeline
timeline(rtca_obj)

# Update or remove actions
rtca_obj <- updateAction(rtca_obj, 22, "siRNA transfection")
rtca_obj <- rmAction(rtca_obj, 30)
```

### 3. Data Transformation and Normalization
The package offers several methods to transform raw Cell Index data for better comparability or statistical modeling.

*   **Ratio Transformation**: Normalizes CI values relative to a specific "base-time" point (sets base-time value to 1).
    ```r
    # Normalize to the state at hour 35
    rtca_ratio <- ratioTransform(rtca_obj, baseTime = 35)
    ```
*   **Smooth Transformation**: Fits a cubic smoothing spline to reduce noise.
    ```r
    rtca_smooth <- smoothTransform(rtca_obj)
    ```
*   **Interpolation**: Regularizes irregular sampling intervals.
    ```r
    rtca_interp <- interpolationTransform(rtca_obj)
    ```
*   **Derivative Transformation**: Calculates the growth rate (first derivative of CI against time).
    ```r
    rtca_deriv <- derivativeTransform(rtca_obj)
    ```
*   **Relative Growth Rate (RGR)**: Divides the first derivative by the raw value at that time point.
    ```r
    rtca_rgr <- rgrTransform(rtca_obj)
    ```

### 4. Visualization
`RTCA` provides specialized plotting functions to inspect plate-wide or well-specific trends.

```r
# Standard plot for specific wells
plot(rtca_obj[, 1:4], type="l", xlab="Time (h)", ylab="Cell Index")

# Plate-wide overview (96-well layout)
plateView(rtca_obj, col="orange")

# Compare specific samples/controls
controlView(rtca_obj, column=1) # View all wells in column 1
```

## Tips for Analysis
*   **Subsetting**: Since `RTCA` objects extend `ExpressionSet`, you can subset them using standard R syntax: `rtca_obj[features, samples]`.
*   **Base-time Selection**: When using `ratioTransform`, the choice of base-time is critical. It is typically set immediately before a treatment or after a stabilization period (e.g., medium change).
*   **Variance**: Be aware that `ratioTransform` can lead to variance distortion (variance is artificially low near the base-time and increases over time). Consider `derivativeTransform` if homoscedasticity is required for statistical testing.

## Reference documentation
- [Discussion of transformation methods of RTCA data](./references/RTCAtransformation.md)
- [Introduction to the Data Analysis of the Roche xCELLigence System](./references/aboutRTCA.md)