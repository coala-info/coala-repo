---
name: bioconductor-platecore
description: This tool analyzes high-throughput flow cytometry data organized in 96 or 384-well plate formats. Use when user asks to manage flowPlate objects, perform automated gating based on negative controls, apply background correction for cell size, or summarize results across multiple plates.
homepage: https://bioconductor.org/packages/3.8/bioc/html/plateCore.html
---


# bioconductor-platecore

name: bioconductor-platecore
description: Analysis of high-throughput flow cytometry data in plate formats (96 or 384-well). Use this skill to manage flowPlate objects, perform automated gating based on negative controls, apply background correction for cell size (FSC), and summarize results across multiple plates.

## Overview

The `plateCore` package extends `flowCore` and `flowViz` to handle large-scale flow cytometry datasets organized in plates. It simplifies the management of well annotations, matching test samples to negative controls (isotypes), and automating the gating process across hundreds of samples.

## Core Workflow

### 1. Data Initialization
A `flowPlate` requires a `flowSet` (from `flowCore`), a well annotation data frame, and a unique plate name.

```r
library(plateCore)
data(plateCore) # Loads example pbmcPlate, wellAnnotation, and compensationSet

# Create the flowPlate
pbmcFP <- flowPlate(pbmcPlate, wellAnnotation, plateName="PBMC.001")
```

**Well Annotation Requirements:**
The annotation data frame must contain at least:
- `Well.Id`: Unique identifier (e.g., "A01", "B05").
- `Sample.Type`: "Unstained", "Test", "Negative.Control", or "Isotype".
- `Ab.Name`: Antibody name or descriptor.
- `Channel`: The fluorescence channel (e.g., "FL1-H").
- `Negative.Control`: The `Well.Id` of the corresponding negative control for that test well.

### 2. Pre-processing and Gating
Standard `flowCore` filters can be applied to `flowPlate` objects using `Subset()`.

```r
# Define gates for population of interest (e.g., Lymphocytes)
rectGate <- rectangleGate("FSC-H"=c(300,700), "SSC-H"=c(50,400))
normGate <- norm2Filter("SSC-H", "FSC-H", scale.factor=1.5)

# Subset the plate
pbmcFP.lymph <- Subset(pbmcFP, rectGate & normGate)
```

### 3. Background Correction
`fixAutoFl` corrects for the effects of cell size (FSC) on background fluorescence by fitting a log-log linear model to unstained wells.

```r
pbmcFPbgc <- fixAutoFl(pbmcFP.lymph, fsc="FSC-H", chanCols=c("FL1-H", "FL2-H", "FL4-H"))
```

### 4. Automated Control Gating
`plateCore` automates the definition of positive/negative thresholds based on negative control wells.

```r
# Set gates based on Median + N * MAD (Median Absolute Deviation)
pbmcFPbgc <- setControlGates(pbmcFPbgc, gateType="Negative.Control", numMads=5)

# Apply the calculated gates to the test wells
pbmcFPbgc <- applyControlGates(pbmcFPbgc)
```

### 5. Summarizing and Extracting Results
`summaryStats` populates the `wellAnnotation` slot with metrics like `Percent.Positive`, `MFI`, and `MFI.Ratio`.

```r
pbmcFPbgc <- summaryStats(pbmcFPbgc)

# View results
head(wellAnnotation(pbmcFPbgc))

# Export results
write.csv(wellAnnotation(pbmcFPbgc), file="plate_results.csv")
```

## Visualization

`plateCore` integrates with `lattice` via `flowViz`. Use `xyplot` to visualize gates and populations.

```r
# Plot specific wells with gates
# Use filter="Negative.Control" to show the automated gates
xyplot(transform("FL1-H"=log10) %on% pbmcFPbgc[c("A03", "B03")], 
       displayFilter=TRUE, 
       filter="Negative.Control",
       flowStrip=c("Well.Id", "Ab.Name", "Percent.Positive"))
```

## Working with Multiple Plates
Combine multiple `flowPlate` objects into a single virtual plate for cross-plate analysis.

```r
# Combine plates
virtPlate <- fpbind(plate1, plate2, plate3)

# Plot results conditioned by plate
densityplot(~ `FL2-H` | as.factor(plateName), 
            virtPlate[c("A01", "A02")], 
            filterResult="Negative.Control")
```

## Quality Assessment
- **Event Counts**: Check `Total.Count` in `wellAnnotation` to ensure sufficient events per well.
- **Fluidic Stability**: Use `flowViz::ecdfplot(~ `FSC-H` | as.factor(Column.Id), data=plateSet(fp))` to check for row/column effects or bubbles.
- **Gating Consistency**: Use `mfiPlot(fp)` to plot MFI Ratio vs. Percent Positive. Outliers from the robust regression line may indicate failed gates or experimental artifacts.

## Reference documentation
- [Analysis of High Throughput Flow Cytometry Data using plateCore](./references/plateCoreVig.md)