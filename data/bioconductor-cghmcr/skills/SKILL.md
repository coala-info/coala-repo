---
name: bioconductor-cghmcr
description: This tool identifies recurrent genomic regions of gain or loss across multiple samples using segmented copy number data. Use when user asks to identify minimum common regions, calculate segment gain or loss scores, or analyze recurrent copy number alterations across a cohort.
homepage: https://bioconductor.org/packages/release/bioc/html/cghMCR.html
---

# bioconductor-cghmcr

name: bioconductor-cghmcr
description: Identify genomic regions of interest (ROI) showing common gains or losses across multiple samples using copy number data (arrayCGH/SNP). Use when analyzing segmented DNA copy number data to find Minimum Common Regions (MCR) or calculating Segment Gain Or Loss (SGOL) scores across a cohort.

# bioconductor-cghmcr

## Overview

The `cghMCR` package identifies genomic regions showing recurrent gains or losses across multiple samples. It is designed to work with segmented data (e.g., from the `DNAcopy` package) rather than probe-level data, making it efficient for high-density arrays. It provides two primary workflows:
1.  **SGOL (Segment Gain Or Loss):** A modified GISTIC-like approach that calculates scores for genes or regions based on the frequency and magnitude of alterations.
2.  **MCR (Minimum Common Regions):** A heuristic approach that identifies the smallest contiguous genomic spans showing a specific recurrence rate across a cohort.

## Typical Workflow

### 1. Data Preparation
`cghMCR` requires segmented data. If starting from raw log-ratios, use the `DNAcopy` package to generate a `DNAcopy` object.

```r
library(DNAcopy)
# Assuming 'cna' is a CNA object from DNAcopy
segData <- segment(smooth.CNA(cna))
```

### 2. Identifying Segment Gain Or Loss (SGOL)
This method requires converting the segment list into a matrix format where rows represent genomic features (genes or fragments) and columns represent samples. This is typically done using the `CNTools` package.

```r
library(CNTools)
library(cghMCR)

# Convert segment data to a gene-centric matrix
# geneInfo is a data frame with chrom, start, end, and gene symbols
convertedData <- getRS(CNSeg(sampleData), by = "gene", geneMap = geneInfo, what = "median")

# Calculate SGOL scores
# threshold: values below -0.2 are losses, above 0.2 are gains
SGOLScores <- SGOL(convertedData, threshold = c(-0.2, 0.2), method = sum)

# Visualize and extract regions of interest
plot(SGOLScores)
gains <- SGOLScores[which(as.numeric(unlist(gol(SGOLScores[, "gains"]))) > 20), "gains"]
```

### 3. Identifying Minimum Common Regions (MCR)
The MCR approach uses heuristics to join altered segments and identify overlapping regions across samples.

```r
# Initialize the cghMCR object
# gapAllowed: max distance (bp) to join adjacent segments
# alteredLow/High: percentile thresholds for defining an alteration
cghmcr_obj <- cghMCR(segData, gapAllowed = 500, alteredLow = 0.9, alteredHigh = 0.9, recurrence = 50)

# Identify MCRs
mcrs <- MCR(cghmcr_obj)

# Optional: Merge probe IDs into the MCR results
mcrs_with_probes <- mergeMCRProbes(mcrs, as.data.frame(segData[["data"]]))
```

## Key Functions

- `cghMCR()`: Constructor for the cghMCR class. Takes a `DNAcopy` object or a data frame of segments.
- `MCR()`: Extracts the minimum common regions from a `cghMCR` object.
- `SGOL()`: Calculates Segment Gain Or Loss scores.
- `gol()`: Accessor for gain/loss scores within an SGOL object.
- `mergeMCRProbes()`: Maps specific probe identifiers back to the identified MCR regions.

## Tips for Success

- **Input Format:** Ensure your segment data contains the standard columns: `ID`, `chrom`, `loc.start`, `loc.end`, `num.mark`, and `seg.mean`.
- **Thresholding:** The `alteredLow` and `alteredHigh` parameters in `cghMCR` are **percentiles** (0 to 1), not absolute log-ratio values. For example, `0.9` means the top 10% of segments are considered gains.
- **SGOL Matrix:** When using `SGOL`, the `convertedData` must be a `ReducedSegment` object (from `CNTools`). Ensure the `geneMap` matches the genome build of your data.
- **Recurrence:** The `recurrence` parameter in `cghMCR` is an integer representing the minimum number of samples that must share the alteration.

## Reference documentation

- [findMCR](./references/findMCR.md)