---
name: bioconductor-manor
description: This tool performs normalization and quality assessment of array-CGH data to correct for spatial biases and experimental artifacts. Use when user asks to import spot-level microarray data, apply filtering flags, perform spatial normalization, or calculate quality scores for genomic profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/MANOR.html
---


# bioconductor-manor

name: bioconductor-manor
description: Normalization of array-CGH (Comparative Genomic Hybridization) data. Use this skill to import spot-level microarray data, apply filtering flags (exclusion and correction), perform spatial normalization to correct for local bias or global gradients, and calculate quality scores for genomic profiles.

# bioconductor-manor

## Overview

The `MANOR` package provides a framework for the normalization of array-CGH data. It is designed to separate biologically relevant signals from experimental artifacts, such as spatial biases (local "edge" effects or global gradients). The package utilizes an `arrayCGH` class (extending the `GLAD` package) and introduces two core formalisms:
1.  **Flags**: Objects used to filter data by either excluding unreliable spots/clones or correcting signal values.
2.  **Qscores**: Quality scores used to quantify the reliability of an array after normalization.

## Core Workflow

### 1. Data Import
Import data from image analysis software (e.g., GenePix or SPOT) into an `arrayCGH` object.

```r
library(MANOR)
dir.in <- system.file("extdata", package="MANOR")

# Import from 'spot' files
spot.names <- c("LogRatio", "RefFore", "RefBack", "DapiFore", "DapiBack", "SpotFlag", "ScaledLogRatio")
clone.names <- c("PosOrder", "Chromosome")
edge <- import(paste(dir.in, "/edge.txt", sep=""), type="spot", 
               spot.names=spot.names, clone.names=clone.names, add.lines=TRUE)
```

### 2. Defining Flags
Flags can be **exclusion** (removing spots) or **correction** (modifying values). They can also be **permanent** or **temporary** (e.g., ignoring X/Y chromosomes during scaling but keeping them in the final data).

```r
# Define a Signal-to-Noise Ratio (SNR) exclusion flag
SNR.FUN <- function(arrayCGH, var.FG, var.BG, snr.thr) {
  which(arrayCGH$arrayValues[[var.FG]] < arrayCGH$arrayValues[[var.BG]]*snr.thr)
}
SNR.flag <- to.flag(SNR.FUN, char="B", args=alist(var.FG="REF_F_MEAN", var.BG="REF_B_MEAN", snr.thr=3))

# Define a spatial correction flag (using arrayTrend)
spatial.flag <- to.flag(function(arrayCGH, var) {
    Trend <- arrayTrend(arrayCGH, var, span=0.03, degree=1, iterations=3)
    arrayCGH$arrayValues[[var]] <- Trend$arrayValues[[var]] - Trend$arrayValues$Trend
    arrayCGH
}, args=alist(var="LogRatio"))
```

### 3. Normalization
Apply a list of flags to the data using the `norm` function.

```r
data(flags) # Load pre-defined flags
data(spatial) # Load spatial bias detection flags

flag.list <- list(spatial=local.spatial.flag, spot=spot.corr.flag, snr=ref.snr.flag)
edge.norm <- norm(edge, flag.list=flag.list, FUN=median, na.rm=TRUE)
edge.norm <- sort(edge.norm, position.var="PosOrder")
```

### 4. Quality Assessment
Evaluate the success of normalization using quality scores.

```r
data(qscores)
qscore.list <- list(smoothness=smoothness.qscore, 
                    replicates=var.replicate.qscore, 
                    dynamics=dynamics.qscore)

edge.norm$quality <- qscore.summary.arrayCGH(edge.norm, qscore.list)
print(edge.norm$quality)
```

### 5. Visualization and Reporting
Generate genomic profiles and spatial plots to inspect the data.

```r
# Plot signal along the genome
genome.plot(edge.norm, chrLim="LimitChr")

# Combined report: array image + genomic profile
report.plot(edge.norm, chrLim="LimitChr", zlim=c(-1,1))

# Generate an HTML report
html.report(edge.norm, dir.out=".", array.name="Sample_Array", file.name="report")
```

## Key Functions
- `import()`: Loads raw data into `arrayCGH` objects.
- `to.flag()`: Creates a flag object for filtering or correction.
- `norm()`: Executes the normalization pipeline using a list of flags.
- `arrayTrend()`: Estimates spatial trends on the array surface.
- `genome.plot()`: Visualizes log-ratios across chromosomes.
- `qscore.summary.arrayCGH()`: Computes multiple quality metrics.

## Reference documentation
- [Overview of the MANOR package](./references/MANOR.Rmd)
- [MANOR: Micro-Array NORmalization of array-CGH data](./references/MANOR.md)