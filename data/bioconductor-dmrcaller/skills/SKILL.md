---
name: bioconductor-dmrcaller
description: DMRcaller identifies differentially methylated regions (DMRs) from bisulfite sequencing or Oxford Nanopore data. Use when user asks to call DMRs between conditions, analyze methylation profiles across different sequence contexts, or extract methylation counts from BAM files.
homepage: https://bioconductor.org/packages/release/bioc/html/DMRcaller.html
---


# bioconductor-dmrcaller

name: bioconductor-dmrcaller
description: Analysis of Differentially Methylated Regions (DMRs) from Whole Genome Bisulfite Sequencing (WGBS), Reduced Representation Bisulfite Sequencing (RRBS), and Oxford Nanopore (ONT) data. Use when identifying genomic regions with significant methylation differences between conditions, analyzing methylation profiles, or detecting co-methylation and variably methylated domains.

# bioconductor-dmrcaller

## Overview
DMRcaller is a Bioconductor package designed to identify Differentially Methylated Regions (DMRs) between two samples or conditions. It is particularly robust for plant methylomes where non-CG methylation (CHG and CHH) is prevalent, but it works across all species. It supports traditional bisulfite sequencing (Bismark CX reports) and long-read Oxford Nanopore (ONT) data.

## Core Workflow

### 1. Data Import
The package primarily uses `GRanges` objects where metadata columns include `readsM` (methylated) and `readsN` (total).

**From Bismark:**
```r
library(DMRcaller)
# Read a single CX report
methylationData <- readBismark("path/to/report.CX_report")

# Read and pool multiple replicates
methylationDataPool <- readBismarkPool(c("rep1.CX_report", "rep2.CX_report"))
```

**From Oxford Nanopore (ONT):**
Requires a `BSgenome` object and a BAM file with MM/ML tags.
```r
# 1. Select candidate cytosines
gr_cpg <- selectCytosine(genome = BSgenome.Hsapiens.UCSC.hg38, context = "CG", chr = "chr1")

# 2. Extract methylation counts
ontData <- readONTbam(bamfile = "sample.bam", ref_gr = gr_cpg, genome = BSgenome.Hsapiens.UCSC.hg38, modif = "C+m?")
```

### 2. Exploratory Analysis
Before calling DMRs, evaluate the data quality and properties.
*   **Coverage:** `plotMethylationDataCoverage(data1, data2, context = "CG")`
*   **Spatial Correlation:** `plotMethylationDataSpatialCorrelation(data1, context = "CG", distances = c(1, 10, 100, 1000))`
*   **Global Profiles:** `plotMethylationProfileFromData(data1, data2, windowSize = 10000, context = "CG")`

### 3. Calling DMRs
The `computeDMRs` function is the primary interface. It supports three methods:
*   `noise_filter`: Uses a kernel (e.g., "triangular") to smooth reads.
*   `neighbourhood`: Analyzes individual cytosines without smoothing.
*   `bins`: Pools reads into equal-sized genomic bins.

```r
dmrs <- computeDMRs(methylationDataList[["WT"]],
                    methylationDataList[["Mutant"]],
                    context = "CG",
                    method = "noise_filter",
                    test = "score", # or "fisher"
                    pValueThreshold = 0.01,
                    minProportionDifference = 0.4,
                    minCytosinesCount = 4)
```

**For Biological Replicates:**
Use `computeDMRsReplicates` which employs beta regression.
```r
condition <- c("control", "control", "treatment", "treatment")
dmrs_reps <- computeDMRsReplicates(methylationData = pooledData,
                                   condition = condition,
                                   context = "CG",
                                   method = "bins",
                                   test = "betareg")
```

### 4. Specialized ONT Analyses
*   **PMDs (Partially Methylated Domains):** Large regions with intermediate methylation.
    `computePMDs(ontData, context = "CG", minMethylation = 0.4, maxMethylation = 0.6)`
*   **VMDs (Variably Methylated Domains):** Regions with high read-level variability.
    `computeVMDs(ontData, context = "CG", sdCutoffMethod = "EDE.high")`
*   **Co-methylation:** Pairwise association between sites.
    `computeCoMethylatedPositions(ontData, regions = some_regions, test = "fisher")`

### 5. Visualization and Refinement
*   **Merge DMRs:** Join adjacent DMRs if they still meet significance criteria.
    `mergeDMRsIteratively(dmrs, methylationData1, methylationData2, context = "CG", minGap = 200)`
*   **Local Profiles:** Plot specific genomic regions with gene annotation.
    `plotLocalMethylationProfile(data1, data2, region_gr, dmrs_list, GEs = annotation_gr)`

## Tips for Usage
*   **Contexts:** Always specify the context (`"CG"`, `"CHG"`, or `"CHH"`) as methylation dynamics differ significantly between them.
*   **Parallelization:** Most compute-intensive functions support `parallel = TRUE` and `cores = N`. This is highly recommended for whole-genome analyses.
*   **Predefined Regions:** If you only care about methylation at specific features (e.g., promoters), use `filterDMRs()` instead of `computeDMRs()` to save time and increase statistical power.
*   **Memory:** For very large datasets, use `poolTwoMethylationDatasets()` instead of creating a large `GRangesList`.

## Reference documentation
- [Overview of the DMRcaller package](./references/DMRcaller.md)