---
name: r-aroma.affymetrix
description: A cross-platform R framework that facilitates processing of any number of Affymetrix microarray samples regardless of computer system.  The only parameter that limits the number of chips that can be processed is the amount of available disk space.  The Aroma Framework has successfully been used in studies to process tens of thousands of arrays.  This package has actively been used since 2006.</p>
homepage: https://cran.r-project.org/web/packages/aroma.affymetrix/index.html
---

# r-aroma.affymetrix

name: r-aroma.affymetrix
description: Analysis of large-scale Affymetrix microarray data sets using the Aroma framework. Use this skill when you need to process, normalize, and analyze Affymetrix data (Gene Expression, SNP, Exon, Copy Number) in R, especially when working with very large datasets that exceed available RAM.

# r-aroma.affymetrix

## Overview

The `aroma.affymetrix` package is a cross-platform R framework designed to process any number of Affymetrix microarray samples. Its primary advantage is a memory-efficient design where the number of chips processed is limited only by disk space, not RAM. It supports a wide range of analyses including RMA, CRMA (v1 and v2), FIRMA, and various normalization techniques for SNP, exon, and expression arrays.

## Installation

```R
# The preferred way to install this package and its dependencies:
source("https://callr.org/install#aroma.affymetrix")

# Alternatively, via CRAN:
install.packages("aroma.affymetrix")
```

## Core Workflow

The Aroma framework follows a strict directory structure. Data must be organized as follows:
`rawData/<dataset_name>/<chip_type>/*.CEL`

### 1. Setup and Data Loading
```R
library(aroma.affymetrix)

# Define the CDF file (Annotation)
cdf <- AffymetrixCdfFile$byChipType("Mapping250K_Nsp", tags="na24")

# Define the CEL set (Raw Data)
cs <- AffymetrixCelSet$byName("MyStudy", cdf=cdf)
```

### 2. Background Correction (RMA)
```R
bc <- RmaBackgroundCorrection(cs)
csBC <- process(bc)
```

### 3. Normalization (Quantile)
```R
qn <- QuantileNormalization(csBC, typesToUpdate="pm")
csQN <- process(qn)
```

### 4. Summarization (Probe-Level Modeling)
```R
plm <- RmaPlm(csQN)
fit(plm)
ces <- getChipEffectSet(plm)
```

### 5. Extraction of Results
```R
# Extracting theta (expression) values as a matrix
data <- extractMatrix(ces)
```

## Specialized Workflows

### CRMA v2 (for SNP and Copy Number)
A high-performance pipeline for estimation of total copy numbers and allele-specific signals.
```R
ds <- AffymetrixCelSet$byName("MyStudy", chipType="GenomeWideSNP_6")
res <- doCRMAv2(ds, combineAlleles=FALSE)
```

### FIRMA (for Alternative Splicing)
Used with Exon arrays to detect alternative splicing.
```R
plm <- ExonRmaPlm(csQN)
fit(plm)
firma <- FirmaModel(plm)
fit(firma)
fs <- getFirmaSet(firma)
```

## Key Classes and Methods

- **AffymetrixCdfFile**: Handles chip definition files.
- **AffymetrixCelSet**: Manages a collection of CEL files.
- **ProbeLevelModel (PLM)**: Abstract class for models like `RmaPlm`, `MbeiPlm`, and `CnPlm`.
- **process()**: The universal method to execute a transformation or normalization object.
- **fit()**: The method to estimate parameters for a Model object.

## Tips for Large Datasets

1. **Disk Space**: Ensure you have several times the size of your raw CEL files available on disk, as intermediate normalized files are created.
2. **Tags**: Use tags (e.g., `AffymetrixCelSet$byName("Study", tags="QN,RMA")`) to keep track of different processing stages.
3. **Parallel Processing**: The package integrates with the `future` framework. Use `future::plan(multisession)` to speed up processing.

## Reference documentation

- [Package ‘aroma.affymetrix’ Reference Manual](./references/reference_manual.md)