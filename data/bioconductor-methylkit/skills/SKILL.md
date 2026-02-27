---
name: bioconductor-methylkit
description: bioconductor-methylkit is an R package for the analysis and annotation of DNA methylation data from bisulfite sequencing experiments. Use when user asks to read methylation calls, perform quality control on coverage, cluster samples, or identify differentially methylated regions.
homepage: https://bioconductor.org/packages/release/bioc/html/methylKit.html
---


# bioconductor-methylkit

## Overview
The `methylKit` package is a comprehensive R-based solution for analyzing DNA methylation at base-pair resolution. It is optimized for Reduced Representation Bisulfite Sequencing (RRBS) but supports Whole Genome Bisulfite Sequencing (WGBS) and 5hmC data (oxBS-Seq/TAB-Seq). The package provides a complete workflow from reading Bismark alignments to identifying differentially methylated regions (DMRs) and annotating them with gene or CpG island features.

## Core Workflow

### 1. Data Input and Object Creation
Methylation calls can be read from text files or directly from Bismark-aligned BAM/SAM files.

```r
library(methylKit)

# Define file list and metadata
file.list <- list("test1.txt", "test2.txt", "ctrl1.txt", "ctrl2.txt")
sample.ids <- list("test1", "test2", "ctrl1", "ctrl2")
treatment <- c(1, 1, 0, 0) # 1 for test, 0 for control

# Read methylation calls (returns methylRawList)
myobj <- methRead(file.list,
                  sample.id = sample.ids,
                  assembly = "hg38",
                  treatment = treatment,
                  context = "CpG",
                  mincov = 10)

# Alternatively, process Bismark BAM files directly
# myobj <- processBismarkAln(location = "sample.bam", sample.id = "s1", assembly = "hg38")
```

### 2. Quality Control and Filtering
Check coverage and methylation statistics to identify biases or PCR duplication.

```r
# Plot statistics for a specific sample
getMethylationStats(myobj[[1]], plot = TRUE, both.strands = FALSE)
getCoverageStats(myobj[[1]], plot = TRUE, both.strands = FALSE)

# Filter by coverage (e.g., min 10x, remove top 0.1% to avoid PCR bias)
filtered.obj <- filterByCoverage(myobj, lo.count = 10, hi.perc = 99.9)

# Normalize coverage between samples
normalized.obj <- normalizeCoverage(filtered.obj)
```

### 3. Comparative Analysis
Merge samples to find common bases and perform clustering/PCA.

```r
# Unite samples (returns methylBase)
# destrand=TRUE merges CpG on both strands for higher coverage
meth <- unite(normalized.obj, destrand = FALSE)

# Correlation and Clustering
getCorrelation(meth, plot = TRUE)
clusterSamples(meth, dist = "correlation", method = "ward", plot = TRUE)
PCASamples(meth)
```

### 4. Differential Methylation
Calculate differences using Fisher's Exact Test (no replicates) or Logistic Regression (with replicates).

```r
# Calculate differential methylation
myDiff <- calculateDiffMeth(meth)

# Get hyper/hypo methylated bases (e.g., >25% diff, q-value < 0.01)
diff25p <- getMethylDiff(myDiff, difference = 25, qvalue = 0.01)
hyper <- getMethylDiff(myDiff, difference = 25, qvalue = 0.01, type = "hyper")
hypo <- getMethylDiff(myDiff, difference = 25, qvalue = 0.01, type = "hypo")
```

### 5. Tiling Windows and Regional Analysis
Summarize methylation over genomic windows or specific regions (e.g., promoters).

```r
# Tiling windows (e.g., 1kb windows)
tiles <- tileMethylCounts(myobj, win.size = 1000, step.size = 1000)

# Regional counts (requires GRanges object, e.g., from genomation)
# promoters <- regionCounts(myobj, promoter.granges)
```

## Advanced Features

### Handling Large Datasets (methylDB)
For large-scale WGBS, use `dbtype = "tabix"` in `methRead` to store data on disk rather than in memory. This creates `methylRawListDB` objects.

### Batch Effect Correction
Use `assocComp` to check if principal components correlate with batch variables, and `removeComp` to remove them.

```r
sampleAnnotation <- data.frame(batch = c("A", "A", "B", "B"))
as <- assocComp(mBase = meth, sampleAnnotation)
newObj <- removeComp(meth, comp = 1)
```

### Annotation
Integrate with the `genomation` package to annotate DMRs.

```r
library(genomation)
gene.parts <- readTranscriptFeatures("refseq.bed")
annotated <- annotateWithGeneParts(as(diff25p, "GRanges"), gene.parts)
plotTargetAnnotation(annotated)
```

## Tips for Success
- **Context Matters**: Always specify `context` ("CpG", "CHG", or "CHH"). `destrand = TRUE` is only valid for CpG context.
- **Replicates**: If you have replicates, `calculateDiffMeth` automatically uses Logistic Regression. To use Fisher's test with replicates, you must first use `pool(meth)`.
- **Overdispersion**: For logistic regression, consider setting `overdispersion = "MN"` in `calculateDiffMeth` to account for higher-than-expected variance.
- **Coercion**: Use `as(obj, "GRanges")` to export methylKit objects for use with other Bioconductor packages.

## Reference documentation
- [methylKit: User Guide](./references/methylKit.Rmd)
- [methylKit: User Guide (Markdown)](./references/methylKit.md)