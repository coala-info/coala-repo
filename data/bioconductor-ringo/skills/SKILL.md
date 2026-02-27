---
name: bioconductor-ringo
description: bioconductor-ringo provides a modular framework for the primary analysis of two-color ChIP-chip data from platforms like NimbleGen and Agilent. Use when user asks to read raw intensity files, perform variance-stabilizing normalization, smooth probe intensities, or identify ChIP-enriched regions.
homepage: https://bioconductor.org/packages/3.18/bioc/html/Ringo.html
---


# bioconductor-ringo

name: bioconductor-ringo
description: Analysis of ChIP-chip data using the Ringo package. Use this skill for processing two-color oligonucleotide microarrays (specifically NimbleGen and Agilent), including data read-in, quality assessment, normalization (VSN), smoothing, and identifying ChIP-enriched regions (chers).

## Overview
Ringo is designed for the primary analysis of ChIP-chip data. It provides a modular framework to handle raw intensity files, map probes to genomic coordinates, and identify regions of enrichment. It integrates closely with the `limma` package (using `RGList` objects) and `Biobase` (using `ExpressionSet` objects).

## Typical Workflow

### 1. Data Loading
Ringo can read NimbleGen "pair" files or general two-color data via `limma`.

```R
library(Ringo)

# For NimbleGen data
# Requires a targets file and a spottypes file
exRG <- readNimblegen("targets.txt", "spottypes.txt", path="data_dir")

# For Agilent or other platforms (using limma)
RG <- read.maimages(arrayfiles, source="agilent", path=agiDir)
```

### 2. Probe Annotation
Mapping reporters to genomic coordinates is handled by `probeAnno` objects.

```R
# Create probeAnno from a POS file or data.frame
# pos-information should contain: chromosome, start, end, and probe ID
pA <- posToProbeAnno(posData, genome="hg18", microarray="platform_name")

# For Agilent, can often extract from systematic names
pA <- extractProbeAnno(RG, "agilent", genome="mouse")
```

### 3. Quality Assessment
Visualize spatial distributions and probe correlations.

```R
# Spatial plot of intensities
image(exRG, 1, channel="green")

# Autocorrelation to check fragment size/probe spacing impact
exAc <- autocor(exRG, probeAnno=pA, chrom="9", lag.max=1000)
plot(exAc)
```

### 4. Preprocessing and Normalization
The default is variance-stabilizing normalization (VSN).

```R
# Returns an ExpressionSet
exampleX <- preprocess(exRG, method="vsn")

# Alternative: NimbleGen-style Tukey-biweight scaling
exampleX.NG <- preprocess(exRG, method="nimblegen")
```

### 5. Smoothing and Visualization
Smoothing reduces noise from individual probe response variability.

```R
# Compute running medians
smoothX <- computeRunningMedians(exampleX, probeAnno=pA, winHalfSize=400)

# Visualize intensities along a chromosome
plot(exampleX, pA, chrom="9", xlim=c(start, end), gff=exGFF)
```

### 6. Finding Enriched Regions (Chers)
Identify "ChIP-enriched regions" based on smoothed thresholds.

```R
# 1. Determine threshold (non-parametric symmetric null approach)
y0 <- apply(exprs(smoothX), 2, upperBoundNull)

# 2. Find regions
chersX <- findChersOnSmoothed(smoothX, probeAnno=pA, thresholds=y0, distCutOff=600)

# 3. Relate to genes (requires a GFF-style data.frame)
chersX <- relateChers(chersX, exGFF)

# 4. Convert to data.frame for export
chersXD <- as.data.frame(chersX)
```

## Key Functions
- `readNimblegen`: Specialized reader for NimbleGen pair files.
- `posToProbeAnno` / `extractProbeAnno`: Create the mapping between probes and the genome.
- `preprocess`: Normalizes raw intensities into log-ratios.
- `computeRunningMedians`: Slides a window to smooth probe intensities.
- `upperBoundNull`: Estimates a threshold for enrichment from the data distribution.
- `findChersOnSmoothed`: The main peak-calling (region-calling) algorithm.
- `chipAlongChrom`: (or `plot`) Visualizes data and genomic features.

## Tips
- **Memory**: `probeAnno` objects are more memory-efficient than large data.frames for genomic lookups.
- **Thresholding**: If the non-parametric `upperBoundNull` fails due to sparse data, try `twoGaussiansNull`.
- **GFF**: Providing a GFF data.frame to `plot` or `relateChers` allows you to see gene models alongside ChIP signal.

## Reference documentation
- [Ringo - R Investigation of NimbleGen Oligoarrays](./references/Ringo.md)