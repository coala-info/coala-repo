---
name: bioconductor-geomxtools
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GeomxTools.html
---

# bioconductor-geomxtools

## Overview

GeomxTools is a Bioconductor package designed for the analysis of NanoString GeoMx Digital Spatial Profiling (DSP) data. It centers around the `NanoStringGeoMxSet` class, which extends the `ExpressionSet` to handle spatial multi-omics data (RNA and Protein). The package provides specialized workflows for data ingestion, segment and probe-level quality control, background subtraction, and normalization.

## Core Workflow

### 1. Data Ingestion
Load DCC (count files), PKC (panel config), and annotation files into a `NanoStringGeoMxSet`.

```r
library(GeomxTools)

# Define paths to files
dcc_files <- dir(datadir, pattern=".dcc$", full.names=TRUE)
pkc_files <- unzip(zipfile = file.path(datadir, "pkcs.zip"))
annotation_file <- "annotations.xlsx"

# Read data (default analyte is "RNA")
demoData <- readNanoStringGeoMxSet(
    dccFiles = dcc_files,
    pkcFiles = pkc_files,
    phenoDataFile = annotation_file,
    phenoDataSheet = "Sheet1",
    phenoDataDccColName = "Sample_ID",
    protocolDataColNames = c("aoi", "cell_line", "region")
)
```

### 2. Quality Control (QC)
QC is performed at both the segment (sample) and probe/target (feature) levels.

```r
# 1. Shift 0 counts to 1 for log transformations
demoData <- shiftCountsOne(demoData, useDALogic=TRUE)

# 2. Segment QC (Flags low saturation, low reads, etc.)
demoData <- setSegmentQCFlags(demoData, qcCutoffs = list(percentSaturation = 45))

# 3. Probe QC (Flags outliers and low probe ratios)
demoData <- setBioProbeQCFlags(demoData)

# 4. Filter object
passedQC <- demoData[!fData(demoData)$QCFlags$LowProbeRatio, 
                     !pData(protocolData(demoData))$QCFlags$LowSaturation]
```

### 3. Data Aggregation and Normalization
For RNA, counts must be aggregated from probe-level to target-level before normalization.

```r
# Aggregate probes to targets
target_data <- aggregateCounts(passedQC)

# Normalization options: "quant" (Quantile), "neg" (Negative), "hk" (Housekeeping)
target_data <- normalize(target_data, norm_method="quant", 
                         desiredQuantile = 0.75, toElt = "q_norm")
```

### 4. Protein-Specific Analysis
Protein data is typically aggregated upon read-in. Use `iggNames()` and `hkNames()` to identify controls.

```r
# Identify controls
igg_names <- iggNames(proteinData)
hk_names <- hkNames(proteinData)

# Visualize signal vs background
fig <- qcProteinSignal(proteinData, neg.names = igg_names)
fig()

# Normalization (Background/Negative is common for protein)
proteinData <- normalize(proteinData, norm_method="neg", toElt = "neg_norm")
```

### 5. Object Coercion
To use Seurat or SpatialExperiment workflows, objects must be at the **Target** level and **Normalized**.

```r
# To Seurat
demoSeurat <- as.Seurat(target_data, normData = "q_norm", ident = "cell_line")

# To SpatialExperiment (include coordinates for spatial plotting)
demoSPE <- as.SpatialExperiment(target_data, normData = "q_norm", 
                                 coordinates = c("x", "y"))
```

## Key Functions Reference
- `readNanoStringGeoMxSet()`: Constructor for the data object.
- `sData()`: Accesses combined phenoData and protocolData.
- `featureType()`: Returns "Probe" or "Target".
- `munge()`: Converts the object to a long-format data frame for ggplot2.
- `esBy()`: Applies functions across groups (e.g., calculating mean per cell line).

## Reference documentation
- [Developer Introduction to the NanoStringGeoMxSet](./references/Developer_Introduction_to_the_NanoStringGeoMxSet.md)
- [GeoMxSet Coercions](./references/GeomxSet_coercions.md)
- [Protein in GeomxTools](./references/Protein_in_GeomxTools.md)