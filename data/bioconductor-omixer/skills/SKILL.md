---
name: bioconductor-omixer
description: Bioconductor-omixer provides multivariate randomization of samples to technical layouts to minimize batch effects in omics studies. Use when user asks to randomize samples to plates, minimize batch effects, balance biological variables across batches, or handle paired samples in experimental layouts.
homepage: https://bioconductor.org/packages/release/bioc/html/Omixer.html
---

# bioconductor-omixer

name: bioconductor-omixer
description: Multivariate and reproducible randomization of samples to plates/batches to minimize batch effects in omics studies. Use when you need to assign samples to technical layouts (96-well plates, chips, lanes) while ensuring biological factors (age, sex, etc.) are not correlated with technical covariates.

# bioconductor-omixer

## Overview

Omixer is an R package designed to proactively counter batch effects by optimizing sample randomization. Unlike a single random draw, Omixer performs multiple iterations (default 1,000) and selects the layout that minimizes correlations between biological factors and technical variables (like plate, chip, or row). It supports paired samples (keeping them adjacent), custom masking of wells, and generates lab-friendly sample sheets.

## Core Workflow

### 1. Prepare Sample List
Create a data frame containing your sample IDs and the biological variables you want to balance across batches.

```r
library(Omixer)
library(tibble)

# Example sample list
sampleList <- tibble(
  sampleId = sprintf("S%03d", 1:48),
  sex = factor(sample(c("M", "F"), 48, replace = TRUE)),
  age = round(rnorm(48, 30, 8)),
  group = factor(sample(c("Control", "Treat"), 48, replace = TRUE))
)

# Define variables to balance
randVars <- c("sex", "age", "group")
```

### 2. Perform Multivariate Randomization
Use `omixerRand` to generate and test layouts.

```r
# Randomize to a 48-well plate subdivided by row
omixerLayout <- omixerRand(
  sampleList, 
  sampleId = "sampleId",
  randVars = randVars,
  iterNum = 1000,   # Number of iterations to test
  wells = 48,       # 24, 48, or 96
  plateNum = 1,     # Number of plates
  div = "row"       # Batch subdivision: "row", "col", "row-block", "col-block"
)
```

### 3. Handle Paired Samples
If you have paired samples (e.g., timepoints from the same individual) that must stay together, use the `block` argument. Omixer will keep blocks adjacent but randomize their internal order and their position on the plate.

```r
# Assuming 'subjectID' identifies pairs
omixerLayout <- omixerRand(
  sampleList, 
  sampleId = "sampleId",
  block = "subjectID", 
  randVars = randVars,
  wells = 96, 
  div = "col"
)
```

### 4. Masking Wells
To leave specific wells empty (e.g., for controls), provide a mask vector where `1` is masked and `0` is available.

```r
# Mask the last 8 wells of a 96-well plate
mask <- c(rep(0, 88), rep(1, 8))
omixerLayout <- omixerRand(sampleList, ..., mask = mask)
```

### 5. Generate Lab Sheets
Create a PDF layout for the wet lab. You can color-code wells by a specific variable.

```r
omixerSheet(omixerLayout, group = "group")
```

## Reproducibility
Omixer saves the seed of the optimal layout to the working directory (`randomSeed.Rdata`). To regenerate the exact same layout later:

```r
load("randomSeed.Rdata")
.GlobalEnv$.Random.seed <- randomSeed

omixerLayout <- omixerSpecific(
  sampleList, 
  sampleId = "sampleId",
  randVars = randVars,
  wells = 48, 
  div = "row"
)
```

## Technical Layout Options
- **wells**: 24, 48, or 96.
- **div**: 
    - `"none"`: Entire plate is one batch.
    - `"row"` / `"col"`: Each row or column is a batch.
    - `"row-block"` / `"col-block"`: 2-row or 2-column blocks are batches.
- **Custom Layouts**: Pass a data frame to the `layout` argument and specify technical columns in `techVars`.

## Reference documentation
- [Omixer: multivariate and reproducible randomization to proactively counter batch effects in omics studies](./references/omixer-vignette.md)