---
name: bioconductor-acme
description: ACME identifies regions of enrichment in high-density oligonucleotide tiling array data using a sliding window algorithm. Use when user asks to process tiling array data, calculate enrichment p-values, identify genomic regions of interest, or export results to SGR and bedGraph formats.
homepage: https://bioconductor.org/packages/release/bioc/html/ACME.html
---

# bioconductor-acme

## Overview

ACME (Algorithm for Capturing Microarray Enrichment) is designed to process high-density oligonucleotide tiling array data. It uses a sliding window of a user-defined size and a quantile-based threshold to identify probes that show significant enrichment. The algorithm calculates a p-value for each probe based on the number of observed positive probes within the window compared to the expected number.

## Core Workflow

### 1. Data Loading
ACME uses the `ACMESet` class to store tiling array data. You can read data from GFF files (commonly used by platforms like NimbleGen).

```r
library(ACME)

# Locate example data or specify your own directory
datdir <- system.file('extdata', package='ACME')
fnames <- dir(datdir, pattern = "gff$")

# Read GFF files into an ACMESet object
example.agff <- read.resultsGFF(fnames, path = datdir)
```

### 2. Calculating Enrichment
The `do.aGFF.calc` function performs the sliding window analysis.

```r
# window: size in base pairs (usually 2-3x expected fragment size)
# thresh: quantile threshold (e.g., 0.95 means top 5% of probes are "positive")
calc_results <- do.aGFF.calc(example.agff, window = 1000, thresh = 0.95)
```

### 3. Visualizing Results
You can plot the raw signal intensities (grey) alongside the calculated -log10 p-values (red).

```r
# Plot a specific chromosome and sample
plot(calc_results, chrom = 'chr1', sample = 1)
```

### 4. Identifying Regions of Interest
To extract the specific genomic coordinates of enriched regions:

```r
regs <- findRegions(calc_results)
# View the first few identified regions
head(regs)
```

## Exporting Data

ACME supports exporting results for visualization in external genome browsers like IGB or UCSC.

### Simple Genome Report (SGR) Format
```r
# Generates .sgr files for both raw and calculated p-values
write.sgr(calc_results)

# Generate only the calculated p-value files
write.sgr(calc_results, raw = FALSE)
```

### UCSC bedGraph Format
```r
# Generates .bed files compatible with UCSC Genome Browser
write.bedGraph(calc_results)
```

## Usage Tips
- **Window Size**: Ensure the window is large enough to include at least 10 probes for stable chi-square calculations.
- **P-values**: The p-values generated are not corrected for multiple comparisons; they should be treated as a ranking guide for regions of interest rather than absolute statistical significance.
- **Thresholding**: The `thresh` parameter is relative to the data distribution. A threshold of 0.95 always designates the top 5% of probes as positive, regardless of the absolute signal intensity.

## Reference documentation
- [Using the ACME package](./references/ACME.md)