---
name: bioconductor-adacgh2
description: ADaCGH2 provides parallelized implementations of segmentation algorithms for the analysis of large-scale array Comparative Genomic Hybridization data. Use when user asks to perform parallel segmentation of aCGH data, analyze genomic datasets that exceed available RAM using ff objects, or visualize copy number profiles across the genome.
homepage: https://bioconductor.org/packages/release/bioc/html/ADaCGH2.html
---


# bioconductor-adacgh2

## Overview
ADaCGH2 is a Bioconductor package designed for the analysis of array Comparative Genomic Hybridization (aCGH) data. It is specifically optimized for high-throughput datasets by providing parallelized implementations of several segmentation algorithms (CBS, HMM, BioHMM, GLAD, HaarSeg, CGHseg, and Wavelets). A key feature is its integration with the `ff` package, allowing the analysis of datasets that exceed available RAM by using disk-based storage.

## Core Workflows

### 1. Data Preparation
ADaCGH2 requires data to be organized with probe IDs, chromosomes, and positions in the first three columns, followed by sample data.

```r
library(ADaCGH2)

# Convert data frame or RData to ADaCGH2 format (RAM or ff)
# ff.or.RAM = "ff" is recommended for large datasets
inputToADaCGH(ff.or.RAM = "ff", 
               dataframe = my_cgh_data, 
               path = getwd())
```

### 2. Parallel Segmentation
The package provides `pSegment` functions for different algorithms. Parallelization is controlled by `typeParall` ("fork" for Unix-like systems or "cluster" for socket/MPI clusters).

**Using HaarSeg (Fastest):**
```r
# Using RAM objects and forking
results <- pSegmentHaarSeg(cgh.dat, chrom.dat, 
                           merging = "MAD", 
                           typeParall = "fork", 
                           mc.cores = 4)

# Using ff objects and a cluster
# Note: 'cghData.RData' and 'chromData.RData' are files created by inputToADaCGH
results_ff <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
                              merging = "MAD", 
                              typeParall = "cluster")
```

**Other available methods:**
- `pSegmentDNAcopy` (CBS)
- `pSegmentHMM`
- `pSegmentBioHMM`
- `pSegmentGLAD`
- `pSegmentCGHseg`
- `pSegmentWavelets`

### 3. Visualization
Generate PNG plots for whole-genome or chromosome-specific views.

```r
pChromPlot(outRDataName = "results.RData",
           cghRDataName = "cghData.RData",
           chromRDataName = "chromData.RData",
           posRDataName = "posData.RData",
           typeParall = "fork")
```

## Key Tips
- **Memory Management:** When working with millions of probes, always use `ff.or.RAM = "ff"`. This stores data on disk and only loads chunks into memory during analysis.
- **Parallel Selection:** Use `typeParall = "fork"` on Linux/Mac for lower overhead. Use `typeParall = "cluster"` on Windows or for multi-node distributed computing.
- **Data Input:** The `cutFile` utility is helpful for pre-processing extremely large text files into one-column-per-file formats, which `inputToADaCGH` can read very efficiently in parallel.
- **Integration:** Use `outputToCGHregions` to format ADaCGH2 results for downstream analysis with the `CGHregions` package.

## Reference documentation
- [ADaCGH2-long-examples](./references/ADaCGH2-long-examples.md)
- [ADaCGH2](./references/ADaCGH2.md)
- [benchmarks](./references/benchmarks.md)