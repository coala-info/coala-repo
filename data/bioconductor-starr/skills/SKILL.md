---
name: bioconductor-starr
description: bioconductor-starr analyzes Affymetrix ChIP-chip tiling array data from raw file import through peak detection. Use when user asks to import CEL and bpmap files, perform quality assessment and normalization, find peaks using the CMARRT algorithm, or correlate ChIP signals with genomic features.
homepage: https://bioconductor.org/packages/3.5/bioc/html/Starr.html
---

# bioconductor-starr

name: bioconductor-starr
description: Analysis of Affymetrix ChIP-chip tiling array data. Use this skill for importing CEL and bpmap files, quality assessment (MA-plots, spatial plots), normalization (cyclic loess, vsn, MAT), peak-finding using the CMARRT algorithm, and correlating ChIP signals with genomic features like TSS/TTS.

# bioconductor-starr

## Overview
The `Starr` package is a Bioconductor tool specifically designed for the analysis of Affymetrix tiling arrays. It extends the `Ringo` package's capabilities to Affymetrix platforms, providing a complete workflow from raw data import (CEL/bpmap) to high-level analysis. Key features include automated generation of probe annotations, sequence-specific bias correction, and the CMARRT algorithm for peak detection which accounts for the correlation structure of tiling array data.

## Core Workflow

### 1. Data Import
`Starr` requires two main file types: `.bpmap` (mapping) and `.cel` (intensities).

```r
library(Starr)
library(affxparser)

# Read bpmap file
bpmap <- readBpmap("path/to/file.bpmap")

# Define CEL files and metadata
cels <- c("sample1.cel", "control1.cel")
names <- c("IP_1", "Control_1")
type <- c("IP", "CONTROL")

# Create ExpressionSet
# featureData=T includes genomic coordinates and sequences from bpmap
data <- readCelFile(bpmap, cels, names, type, featureData=TRUE, log.it=TRUE)
```

### 2. Quality Assessment
Before normalization, visualize data to identify technical artifacts or biases.

*   **Spatial Plot:** `plotImage("sample.cel")` reconstructs the array surface.
*   **Distribution:** `plotDensity(data)` and `plotBoxes(data)`.
*   **Correlation:** `plotScatter(data, density=TRUE)` shows pairwise sample correlations.
*   **MA-Plots:** `plotMA(data, ip=ips, control=controls)` identifies saturation-dependent effects.
*   **Sequence Bias:** `plotGCbias(exprs(data)[,1], featureData(data)$seq)` and `plotPosBias(...)` visualize intensity dependencies on GC content and base position.

### 3. Normalization
Normalize to correct systematic errors. Cyclic loess is a common choice for tiling arrays.

```r
# Normalize probes
data_norm <- normalize.Probes(data, method="loess")

# Calculate IP/Control ratio
ips <- data_norm$type == "IP"
controls <- data_norm$type == "CONTROL"
ratio_set <- getRatio(data_norm, ips, controls, "IPvsWT", fkt=median, featureData=TRUE)
```

### 4. Peak Finding with CMARRT
CMARRT is preferred over simple moving averages as it incorporates the correlation structure between neighboring probes.

```r
# Create probeAnno object for mapping
probeAnno <- bpmapToProbeAnno(bpmap)

# Compute p-values using CMARRT
peaks_raw <- cmarrt.ma(ratio_set, probeAnno, frag.length=300)

# Diagnostic plots for CMARRT (QQ-plot and p-value histogram)
plotcmarrt(peaks_raw)

# Identify bound regions (peaks)
peak_list <- cmarrt.peak(peaks_raw, alpha=0.05, method="BH", minrun=4)
```

### 5. Genomic Feature Analysis
Analyze ChIP signals relative to annotated features (e.g., TSS, TTS).

*   **Import Annotation:** Use `read.gffAnno("file.gff")`.
*   **Filter Genes:** `filterGenes(anno, minLength=1000)` to remove short or overlapping features.
*   **Extract Profiles:** `getProfiles(ratio_set, probeAnno, tssAnno, upstream=500, downstream=500)` extracts signal matrices around features.
*   **Visualization:** `plotProfiles(profiles)` creates mean profile plots and quantile-based profile plots.

## Advanced Features

### Probe Remapping
If using an outdated bpmap, remap sequences to a new genome build (FASTA) using the Aho-Corasick algorithm:
```r
new_bpmap <- remap(bpmap, path="path/to/fasta_folder", reverse_complementary=TRUE, return_bpmap=TRUE)
```

### Correlation with External Data
Use `getMeans()` to calculate average ChIP signals over specific genomic windows (defined in a data frame) and `correlationPlot()` to visualize how these signals relate to external metrics like gene expression.

## Reference documentation
- [Starr](./references/Starr.md)