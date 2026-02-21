---
name: bioconductor-descan2
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DEScan2.html
---

# bioconductor-descan2

## Overview

DEScan2 provides an integrated framework for identifying differentially enriched regions in epigenomic data. Unlike fixed-window peak callers, it uses an adaptive window scan to identify peaks of varying widths. The workflow typically involves three main stages: individual sample peak calling, consensus region alignment across replicates, and read counting for downstream statistical testing (e.g., with edgeR or DESeq2).

## Typical Workflow

### 1. Peak Calling (findPeaks)
Use `findPeaks` to identify enriched regions in individual BAM or BED files. It calculates Z-scores for windows relative to local and chromosomal backgrounds.

```r
library(DEScan2)

# Call peaks for one or more files
peaksGRL <- findPeaks(
  files = c("sample1.bam", "sample2.bam"),
  filetype = "bam",
  genomeName = "mm9",      # Highly recommended for accuracy
  binSize = 50,            # Minimum scanning window step
  minWin = 50,             # Minimum window size
  maxWin = 1000,           # Maximum window size (in units of binSize)
  zthresh = 10,            # Z-score cutoff
  save = TRUE,             # Saves sorted BED files to outputFolder
  outputFolder = "Peaks"
)
```

### 2. Aligning Peaks into Regions (finalRegions)
After calling peaks for all samples, use `finalRegions` to merge overlapping peaks into a consensus set of genomic regions.

```r
# peaksGRL is a GRangesList from findPeaks or loaded from RDS
regionsGR <- finalRegions(
  peakSamplesGRangesList = peaksGRL,
  zThreshold = 20,         # Can be higher than findPeaks threshold
  minCarriers = 3,         # Min replicates required to keep a region
  saveFlag = FALSE
)
```

### 3. Counting Reads (countFinalRegions)
Generate a count matrix by quantifying reads from the original alignment files within the consensus regions. This function wraps `summarizeOverlaps`.

```r
# Returns a SummarizedExperiment object
se <- countFinalRegions(
  regionsGRanges = regionsGR,
  readsFilePath = "path/to/bam/folder",
  fileType = "bam",
  minCarriers = 1          # Filter by carriers again if needed
)

# Extract counts and genomic ranges
counts <- SummarizedExperiment::assay(se)
regions <- SummarizedExperiment::rowRanges(se)
```

## Normalization and Differential Testing

Because epigenetic data often contains "unwanted variation" (batch effects, library prep differences), total library size normalization is often insufficient.

1.  **Normalization**: Use `RUVSeq` (specifically `RUVs`) to remove unwanted variation based on replicate groups.
2.  **Differential Enrichment**: Use `edgeR` with a design matrix that includes the RUV-calculated factors (`W`).

```r
# Example edgeR snippet
design <- model.matrix(~0 + condition + s$W)
y <- edgeR::DGEList(counts = counts, group = condition)
y <- edgeR::estimateDisp(y, design)
fit <- edgeR::glmQLFit(y, design, robust = TRUE)
# ... proceed with testing contrasts
```

## Performance Tips

*   **Parallelization**: DEScan2 uses `BiocParallel`. Register a backend or pass `BPPARAM` to `findPeaks` and `finalRegions`.
    *   `BiocParallel::register(BiocParallel::MulticoreParam(workers = 4))`
    *   On macOS, `DoparParam()` is often more stable than `MulticoreParam()`.
*   **Genome Names**: Always provide a `genomeName` (e.g., "mm10", "hg38") to ensure correct chromosome lengths and standard chromosome filtering.

## Reference documentation

- [DEScan2](./references/DEScan2.md)