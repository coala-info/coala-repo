---
name: bioconductor-dmrcatedata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/DMRcatedata.html
---

# bioconductor-dmrcatedata

name: bioconductor-dmrcatedata
description: Data support for the DMRcate R package, providing probe filtering resources (cross-hybridization and SNPs) for Illumina 450K, EPICv1, and EPICv2 arrays, as well as transcript annotation objects (hg19, hg38, mm10) and example datasets for differential methylation analysis. Use this skill when performing DNA methylation workflows that require filtering problematic probes or annotating genomic ranges.

# bioconductor-dmrcatedata

## Overview

The `DMRcatedata` package is a specialized data experiment package designed to accompany `DMRcate`. It contains essential datasets for filtering Illumina methylation microarrays and providing genomic context for identified Differentially Methylated Regions (DMRs). Its primary utility lies in identifying probes confounded by cross-hybridization or proximal SNPs and providing gene range objects for visualization and extraction.

## Loading Data and Resources

To use the datasets, load the library and use the `data()` function:

```r
library(DMRcatedata)

# Load cross-hybridization filters
data(crosshyb)

# Load SNP information for EPICv1 and 450K
data(snpsall)

# Load SNP information for EPICv2
data(epicv2snps)

# Load example EPICv2 beta values (B-cell vs T-cell ALL)
data(ALLbetas)
```

## Key Datasets and Usage

### Probe Filtering (Internal and Manual)
These objects are typically used by `DMRcate::rmSNPandCH()` but can be inspected manually:
- `crosshyb`: A factor listing probe IDs (EPICv1/450K) prone to cross-hybridization.
- `snpsall`: A data frame of probes (EPICv1/450K) confounded by SNPs/indels, including distance to CpG and minor allele frequency (MAF).
- `epicv2snps`: Similar to `snpsall`, but specifically for the EPICv2 (900K) array.
- `XY.probes`: A vector of probes targeting sex chromosomes.

### Annotation Objects
These objects provide transcript and gene range information for specific genome builds. They are required by `DMRcate` functions like `extractRanges()` and `DMR.plot()`:
- `hg19.grt` / `hg19.generanges`: Ensembl Release 75.
- `hg38.grt` / `hg38.generanges`: Ensembl Release 96.
- `mm10.grt` / `mm10.generanges`: Ensembl Release 96.

### Example Data
- `ALLbetas`: A matrix of beta values from 10 samples (5 B-ALL, 5 T-ALL) using the EPICv2 array. This is the standard dataset for testing EPICv2 DMR calling workflows.

## Typical Workflow Integration

When using `DMRcate`, you do not usually need to call these objects directly, but `DMRcatedata` must be installed for the following commands to work:

```r
# Filtering probes using DMRcatedata resources
# This function accesses crosshyb and snpsall internally
myMs.filtered <- rmSNPandCH(myMs, dist=2, mafcut=0.05)

# Plotting DMRs
# This function accesses the .generanges objects internally
DMR.plot(ranges=results.ranges, dmr=1, CpGs=myMs, phen.col=cols, genome="hg19")
```

## Reference documentation

- [The DMRcatedata package user's guide](./references/DMRcatedata.md)