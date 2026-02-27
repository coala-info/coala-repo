---
name: bioconductor-readqpcr
description: The ReadqPCR package provides a standardized framework for importing raw fluorescence data and quantification cycle values from various RT-qPCR platforms into R. Use when user asks to import Roche LightCycler 480 files, read generic tab-delimited qPCR data, or load Taqman SDS output into qPCRBatch or CyclesSet objects.
homepage: https://bioconductor.org/packages/release/bioc/html/ReadqPCR.html
---


# bioconductor-readqpcr

## Overview

The `ReadqPCR` package provides a standardized way to import raw Real-Time Quantitative PCR (RT-qPCR) data into R. It supports fluorescence data (CyclesSet) and quantification cycle (Cq) values (qPCRBatch). It is designed to work seamlessly with the `NormqPCR` package for subsequent data normalization.

## Core Workflows

### 1. Roche LightCycler 480 (Fluorescence Data)
Use this workflow to read raw fluorescence values from Roche LC480 exported text files.

```r
library(ReadqPCR)

# Read raw fluorescence data
cycData <- read.LC480(file = "LC480_Data.txt")

# Read optional sample information
samInfo <- read.LC480SampleInfo(file = "LC480_SampleInfo.txt")

# Merge data and metadata into a single CyclesSet
cycData_combined <- merge(cycData, samInfo)

# Access data
head(exprs(cycData_combined)) # Fluorescence values
pData(cycData_combined)      # Phenotypic/Sample metadata
```

### 2. Generic qPCR Data (Cq Values)
Use `read.qPCR` for tab-delimited files containing Cq values. The file must contain columns: `Sample`, `Detector`, and `Cq`. Optional columns `Well` and `Plate` enable spatial plotting.

```r
# Read generic tab-delimited qPCR data
qpcr_batch <- read.qPCR("my_data.txt")

# Access Cq values
exprs(qpcr_batch)
```

### 3. Taqman SDS Data
Use `read.taqman` to import data from Sequence Detection Systems (SDS) software used with Taqman Low Density Arrays.

```r
# Read a single SDS file
qpcr_batch <- read.taqman("sds_output.txt")

# Combine multiple SDS files into one qPCRBatch
qpcr_batch_multi <- read.taqman("file1.txt", "file2.txt")
```

## Handling Technical Replicates

Both `read.qPCR` and `read.taqman` automatically detect technical replicates (same Sample and Detector identifiers). 
- The package appends a suffix: `_TechReps.n` (e.g., `GeneA_TechReps.1`, `GeneA_TechReps.2`).
- This ensures the data fits the `assayData` format while allowing users to decide how to aggregate replicates during normalization.

## Data Inspection and Objects

### qPCRBatch Object
This S4 class extends `eSet` and stores Cq values.
- `exprs(object)`: Returns the matrix of Cq values.
- `pData(object)`: Returns sample information.
- `exprs.well.order(object)`: Returns the spatial position (Plate-Well) of each measurement. If `Well` and `Plate` info were missing during import, this returns `NULL`.

### CyclesSet Object
This class stores raw fluorescence data across cycles.
- `exprs(object)`: Returns fluorescence values where rows are cycles and columns are samples/wells.
- `fData(object)`: Contains cycle-specific information like acquisition time and temperature.

## Tips for Successful Import

- **File Format**: Ensure generic files are tab-delimited.
- **Column Names**: For `read.qPCR`, column names are case-sensitive (`Sample`, `Detector`, `Cq`).
- **Plate IDs**: When reading multiple Taqman files, provide unique plate identifiers within the files if possible; otherwise, `ReadqPCR` assigns numeric increments based on the order of files provided.
- **Cq Interpretation**: Remember that lower Cq values indicate higher initial target concentrations.

## Reference documentation

- [ReadqPCR](./references/ReadqPCR.md)