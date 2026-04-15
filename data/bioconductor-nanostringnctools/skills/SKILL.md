---
name: bioconductor-nanostringnctools
description: This tool provides a framework for importing, analyzing, and normalizing NanoString nCounter data using the NanoStringRCCSet class. Use when user asks to import RCC files, perform quality control on imaging or binding density, normalize counts using the nSolver method, or subset data by probe type.
homepage: https://bioconductor.org/packages/release/bioc/html/NanoStringNCTools.html
---

# bioconductor-nanostringnctools

name: bioconductor-nanostringnctools
description: Analysis of NanoString nCounter data (RCC/RLF files) using the NanoStringRCCSet class. Use this skill to import RCC files, perform quality control (imaging, binding density, ERCC linearity), normalize counts (nSolver method), and subset data by probe type (endogenous, housekeeping, negative controls).

# bioconductor-nanostringnctools

## Overview
The `NanoStringNCTools` package provides a specialized framework for handling NanoString nCounter data in R. It centers around the `NanoStringRCCSet` class, which extends the Bioconductor `ExpressionSet` to store count matrices alongside protocol-specific metadata (e.g., FOV counts, binding density) and probe annotations.

## Core Workflow

### 1. Data Import
Load RCC files, RLF (Reporter Library File), and sample annotations into a single object.

```r
library(NanoStringNCTools)

# Define file paths
rcc_files <- list.files(path = "path/to/rcc", pattern = "\\.RCC$", full.names = TRUE)
rlf_file <- "path/to/library.rlf"
sample_anno <- "path/to/metadata.csv"

# Create the NanoStringRCCSet
demoData <- readNanoStringRccSet(rcc_files, 
                                 rlfFile = rlf_file, 
                                 phenoDataFile = sample_anno)
```

### 2. Accessing Data Members
The object uses standard Bioconductor accessors plus package-specific methods:
- `exprs(obj)`: Access the raw count matrix.
- `pData(obj)`: Access sample metadata.
- `fData(obj)`: Access feature/probe metadata (CodeClass, GeneName).
- `sData(obj)`: Combined sample and protocol metadata.
- `design(obj) <- ~ Treatment`: Assign experimental design.

### 3. Quality Control (QC)
Assess technical performance using built-in thresholds for imaging, binding density, and ERCC controls.

```r
# Set QC flags based on default or custom cutoffs
demoData <- setQCFlags(demoData)

# Check flags in protocolData
head(protocolData(demoData)[["QCFlags"]])

# Visualize QC (requires ggplot2/ggiraph)
autoplot(demoData, type = "ercc-linearity")
autoplot(demoData, type = "housekeep-geom")
```

### 4. Subsetting
Filter the dataset by probe type or sample attributes.
- `endogenousSubset(obj)`: Keep only target genes.
- `housekeepingSubset(obj)`: Keep only housekeeper genes.
- `negativeControlSubset(obj)`: Keep only negative controls.
- `controlSubset(obj)`: Keep all control probes.
- `subset(obj, select = Treatment == "Control")`: Filter by metadata.

### 5. Normalization and Transformation
Perform nSolver-style normalization or apply custom functions across the assay data.

```r
# nSolver-style normalization
demoData <- normalize(demoData, type = "nSolver", fromELT = "exprs", toELT = "exprs_norm")

# Apply functions (e.g., log10)
assayDataElement(demoData, "log10_counts") <- 
  assayDataApply(demoData, MARGIN = 2, FUN = log10, elt = "exprs")

# Convert to long-format data frame for plotting
df_long <- munge(demoData, ~ exprs_norm)
```

## Tips for Success
- **CodeClass**: Always check the `CodeClass` column in `fData`. This determines how functions like `normalize` and `setQCFlags` treat specific probes.
- **dimLabels**: Use `dimLabels(obj) <- c("GeneName", "SampleID")` to ensure plots use readable labels instead of file names.
- **Visualizations**: The `autoplot` function is a powerful wrapper for generating heatmaps (`type = "heatmap-genes"`) and boxplots (`type = "boxplot-feature"`) specifically for NanoString objects.

## Reference documentation
- [Introduction to the NanoStringRCCSet Class](./references/Introduction.md)