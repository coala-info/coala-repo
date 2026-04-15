---
name: bioconductor-flowclean
description: bioconductor-flowclean performs quality control on flow cytometry data by identifying and filtering out technical artifacts and fluctuations in fluorescent intensity over time. Use when user asks to clean FCS files, detect problematic time segments in flow cytometry experiments, or filter out cellular populations with non-uniform collection.
homepage: https://bioconductor.org/packages/release/bioc/html/flowClean.html
---

# bioconductor-flowclean

name: bioconductor-flowclean
description: Quality control of flow cytometry data using compositional data analysis. Use this skill to identify and filter out cellular populations that exhibit non-uniform collection over time, specifically for detecting technical artifacts or fluctuations in fluorescent intensity during an experiment.

# bioconductor-flowclean

## Overview

The `flowClean` package provides a robust method for performing quality control on flow cytometry datasets (FCS files). It works by discretizing collection time into periods and analyzing the frequencies of cell populations using centered log ratio (CLR) transformation and changepoint analysis. The primary goal is to identify "bad" time segments where the data deviates significantly from the expected uniform distribution, often caused by clogs, pressure changes, or laser fluctuations.

## Typical Workflow

### 1. Load Data and Libraries
Load the package along with `flowCore` for handling flowFrame objects.

```r
library(flowClean)
library(flowCore)

# Load your flowFrame
# fcs <- read.FCS("your_file.fcs")
data(synPerturbed) # Example data
```

### 2. Run Quality Control
The `clean` function is the main entry point. It adds a new parameter to the flowFrame called `GoodVsBad`.

```r
# vectMarkers: indices of markers to analyze (exclude scatter and time)
cleaned_fcs <- clean(synPerturbed, 
                     vectMarkers = c(5:16), 
                     filePrefixWithDir = "output_name", 
                     ext = "fcs", 
                     diagnostic = TRUE)
```

### 3. Interpret Results
- **GoodVsBad Parameter**: Cells in "Good" time periods are assigned a value < 10,000. Cells in "Bad" time periods are assigned a value ≥ 10,000.
- **Console Output**: The function will print which time bins were identified as problematic.

### 4. Filter "Bad" Cells
Use standard `flowCore` gating to remove the problematic events.

```r
# Create a gate for 'Good' cells
rect_gate <- rectangleGate(filterId="GoodEvents", list("GoodVsBad"=c(0, 9999)))

# Apply filter and subset
idx <- filter(cleaned_fcs, rect_gate)
final_fcs <- Subset(cleaned_fcs, idx)
```

## Key Function: clean()

| Argument | Description |
| :--- | :--- |
| `fFrame` | The `flowFrame` object to be cleaned. |
| `vectMarkers` | Numeric vector specifying the indices of the markers to be used for QC. |
| `binSize` | Number of events per bin (default is calculated based on 100 bins). |
| `n_p` | Number of populations to track (default is 100). |
| `filePrefixWithDir` | String for the output file name/path. |
| `ext` | File extension (usually "fcs"). |
| `diagnostic` | Boolean; if TRUE, prints identified problematic bins to the console. |

## Tips and Best Practices
- **Marker Selection**: When defining `vectMarkers`, exclude scatter parameters (FSC/SSC) and the Time parameter itself. Focus on the fluorescent channels.
- **Discretization**: By default, the collection time is split into 100 periods. If your file has very few events, you may need to adjust the binning logic, though the default works for most standard experiments.
- **Visualization**: You can plot `GoodVsBad` vs `Time` using `flowViz` or `ggcyto` to visually inspect where the errors occurred.
- **Downstream Analysis**: Always perform `flowClean` early in your pipeline, typically after compensation and transformation but before formal gating of specific cell subsets.

## Reference documentation
- [flowClean](./references/flowClean.md)