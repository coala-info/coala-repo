---
name: bioconductor-cager
description: CAGEr analyzes Cap Analysis of Gene Expression (CAGE) data to identify transcription start sites and characterize promoter architecture. Use when user asks to map transcription start sites, cluster tags into promoters, normalize CAGE-seq data, or analyze differential promoter usage.
homepage: https://bioconductor.org/packages/release/bioc/html/CAGEr.html
---


# bioconductor-cager

name: bioconductor-cager
description: Analysis of Cap Analysis of Gene Expression (CAGE) data, including TSS identification, promoter clustering, normalization, and differential promoter usage (shifting). Use this skill when processing CAGE-seq data in R to define transcription start sites (TSS), analyze promoter architecture (width), or perform expression profiling of promoters.

# bioconductor-cager

## Overview
CAGEr is a Bioconductor package for the analysis of Cap Analysis of Gene Expression (CAGE) data. It provides a complete workflow to map transcription start sites (TSS) at single-nucleotide resolution, cluster them into tag clusters (promoters), and perform downstream analyses such as promoter width determination, expression profiling, and detection of differential TSS usage (promoter shifting). It supports various input formats including BAM, BED, and CTSS files.

## Core Workflow

### 1. Object Initialization
The primary data container is the `CAGEexp` object (an extension of `MultiAssayExperiment`).

```r
library(CAGEr)
library(BSgenome.Drerio.UCSC.danRer7)

# Define input files (CTSS, BAM, or BED)
inputFiles <- c("sample1.ctss", "sample2.ctss")

# Create CAGEexp object
ce <- CAGEexp(genomeName = "BSgenome.Drerio.UCSC.danRer7",
              inputFiles = inputFiles,
              inputFilesType = "ctss",
              sampleLabels = c("S1", "S2"))

# Read data into the object
ce <- getCTSS(ce)
```

### 2. Quality Control and Annotation
Annotate TSSs with genomic regions (promoter, exon, intron) using a `GRanges` object of gene models.

```r
# Annotate CTSSs
ce <- annotateCTSS(ce, geneModels = exampleZv9_annot)

# Plot annotation distribution
plotAnnot(ce, "counts")

# Check correlation between samples
plotCorrelation2(ce, samples = "all", method = "pearson")
```

### 3. Normalization
CAGEr supports power-law normalization, which is effective for the distribution of CAGE tags.

```r
# Check power-law distribution
plotReverseCumulatives(ce, fitInRange = c(5, 1000))

# Normalize (T = 10^6 for TPM)
ce <- normalizeTagCount(ce, method = "powerLaw", 
                        fitInRange = c(5, 1000), 
                        alpha = 1.2, T = 10^6)
```

### 4. Promoter Clustering (Tag Clusters)
Group individual TSSs into transcriptional units (Tag Clusters).

```r
# Distance-based clustering (max 20bp apart)
ce <- distclu(ce, maxDist = 20, keepSingletonsAbove = 5)

# Extract clusters for a sample
tc <- tagClustersGR(ce, sample = "S1")
```

### 5. Promoter Width and Consensus Clusters
Analyze promoter architecture (sharp vs. broad) and aggregate clusters across samples for comparison.

```r
# Calculate cumulative distribution and quantiles for width
ce <- cumulativeCTSSdistribution(ce, clusters = "tagClusters")
ce <- quantilePositions(ce, clusters = "tagClusters", qLow = 0.1, qUp = 0.9)

# Plot width histograms
plotInterquantileWidth(ce, clusters = "tagClusters", tpmThreshold = 3)

# Aggregate into consensus clusters across all samples
ce <- aggregateTagClusters(ce, tpmThreshold = 5, maxDist = 100)
```

### 6. Differential Usage and Shifting
Detect "promoter shifting" where the distribution of TSSs within a single promoter changes between conditions.

```r
# Calculate cumulative distribution for consensus clusters
ce <- cumulativeCTSSdistribution(ce, clusters = "consensusClusters")

# Score shifting between two groups
ce <- scoreShift(ce, groupX = "Control", groupY = "Treated", 
                 testKS = TRUE, useTpmKS = FALSE)

# View shifting results
shiftingResults <- consensusClustersGR(ce)
```

### 7. Exporting Results
Export data for visualization in genome browsers (UCSC, IGV).

```r
# Export CTSS as a track
trk <- exportToTrack(CTSSnormalizedTpmGR(ce, "S1"))

# Export Tag Clusters with interquantile width blocks
exportToTrack(ce, what = "tagClusters", qLow = 0.1, qUp = 0.9)
```

## Tips and Best Practices
- **Genome Names**: Ensure the `genomeName` matches an installed `BSgenome` package (e.g., `"BSgenome.Hsapiens.UCSC.hg38"`).
- **Multicore**: Many functions (e.g., `cumulativeCTSSdistribution`) support `useMulticore = TRUE` on Unix-like systems to speed up processing.
- **G-Correction**: Use `getCTSS(ce, correctSystematicG = TRUE)` if your CAGE protocol introduces a systematic G bias at the 5' end.
- **Filtering**: Use `filterLowExpCTSS` to remove low-confidence TSSs before clustering to reduce noise.

## Reference documentation
- [Use of CAGE resources with CAGEr](./references/CAGE_Resources.md)
- [CAGEr Workflow and CAGEexp Analysis](./references/CAGEexp.md)