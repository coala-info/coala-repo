---
name: bioconductor-mdts
description: MDTS is an R package that identifies de novo deletions in targeted sequencing data from trios using a minimum distance metric. Use when user asks to identify de novo deletions, calculate empirical genomic bins, or perform minimum distance analysis on trio sequencing data.
homepage: https://bioconductor.org/packages/release/bioc/html/MDTS.html
---

# bioconductor-mdts

## Overview

MDTS (Minimum Distance Trio Sequencing) is an R package designed to identify de novo deletions in targeted sequencing data from trios (mother, father, and offspring). It improves upon standard methods by using empirical capture-based binning rather than probe coordinates and by utilizing a "Minimum Distance" metric. This metric assumes that a deletion is more likely inherited than de novo if the offspring shares the signal with either parent, effectively filtering out inherited variants and focusing on true de novo events.

## Workflow and Key Functions

### 1. Binning and Metadata
MDTS uses dynamic binning based on actual sequencing coverage. You must first prepare a pedigree/metadata file and define the genomic bins.

```r
library(MDTS)
library(BSgenome.Hsapiens.UCSC.hg19)

# Load pedigree data (must contain subj_id, family_id, father_id, mother_id, bam_path)
pD <- getMetaData("path/to/pedigree.ped")

# Calculate empirical bins
# n: number of samples to subset for bin calculation
# medianCoverage: target median reads per bin (e.g., 150-160)
bins <- calcBins(metaData = pD, 
                 n = 5, 
                 readLength = 100, 
                 minimumCoverage = 5, 
                 medianCoverage = 150, 
                 genome = BSgenome.Hsapiens.UCSC.hg19, 
                 mappabilityFile = "path/to/mappability.bw")
```

### 2. Calculating Coverage
Once bins are defined, calculate the read counts for all samples across those bins.

```r
# rl: sequencing read length
counts <- calcCounts(pD, bins, rl = 100)
```

### 3. Normalization
Normalize the raw count matrix using log2 transformation, median polish, and loess smoothing for GC content and mappability.

```r
# Returns an M-score matrix
# Values: ~0 (2 copies), ~-1 (1 copy), < -4 (0 copies)
mCounts <- normalizeCounts(counts, bins)
```

### 4. Minimum Distance Calculation
Calculate the Minimum Distance (MD) for each trio. For every bin, the MD is the smallest absolute difference between the offspring's M-score and both parents' M-scores.

```r
# md: matrix where rows are bins and columns are trios
md <- calcMD(mCounts, pD)
```

### 5. De Novo Deletion Calling
Use Circular Binary Segmentation (CBS) on the MD matrix to identify segments that deviate from zero, then filter for de novo candidates.

```r
# Segment the Minimum Distance
cbs <- segmentMD(md = md, bins = bins)

# Identify and filter de novo deletions
# This step removes signals in problematic/highly variable bins
denovo <- denovoDeletions(cbs, mCounts, bins)
```

## Interpretation of Results
The `denovoDeletions` function returns a `GRanges` object containing:
*   **Location**: The genomic coordinates of the candidate deletion.
*   **m**: The mean Minimum Distance score for the segment.
*   **famid**: The family ID associated with the call.

A high-confidence de novo deletion typically shows a significant negative M-score in the offspring while both parents maintain M-scores near zero.

## Tips for Success
*   **Mappability File**: Ensure you use a BigWig (.bw) file for mappability that matches your read length (e.g., 100mer).
*   **Reference Genome**: The `BSgenome` object must match the reference used for BAM alignment (e.g., hg19).
*   **Median Coverage**: If you have very high depth, increase `medianCoverage` in `calcBins` to reduce the number of bins and decrease false positives. If depth is low, decrease it to maintain sensitivity.

## Reference documentation
- [MDTS](./references/mdts.md)