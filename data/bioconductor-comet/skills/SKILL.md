---
name: bioconductor-comet
description: bioconductor-comet visualizes omic-wide association scan results by generating multi-panel plots that integrate regional Manhattan plots, genomic annotations, and correlation heatmaps. Use when user asks to visualize EWAS results, create integrated regional association plots, display co-methylation patterns, or generate multi-track genomic visualizations.
homepage: https://bioconductor.org/packages/3.8/bioc/html/coMET.html
---

# bioconductor-comet

## Overview

The `coMET` package is designed to visualize omic-Wide Association Scan (omic-WAS) results, specifically tailored for EWAS. It generates integrated multi-panel plots consisting of:
1. **Upper Panel**: A regional Manhattan plot showing association strength (-log10 P-values).
2. **Middle Panel**: Customizable genomic annotation tracks (genes, CpG islands, chromatin states, etc.).
3. **Lower Panel**: A correlation heatmap (e.g., co-methylation patterns) between features in the region.

The package supports data from human (GRCh37/hg19 and GRCh38/hg38) and can be extended to other species by providing custom annotation tracks via `Gviz`.

## Core Functions

### 1. comet.web()
A pre-customized function that mimics the `coMET` web service. It uses a configuration file to define plot parameters and is optimized for human data.
- **Use case**: Quick generation of standard plots with predefined ENSEMBL/UCSC tracks.

### 2. comet()
The generic, highly customizable plotting function.
- **Use case**: When you need to provide custom `Gviz` tracks, multiple extra data series (e.g., expression and methylation), or specific formatting.

### 3. comet.list()
A utility function to extract correlation values, p-values, and confidence intervals for features that surpass a specific threshold.
- **Use case**: Identifying specific significant co-methylation pairs for downstream analysis.

## Typical Workflow

### Data Preparation
`coMET` requires two main inputs:
- **Info File**: A dataframe or file containing feature IDs, Chromosome, Position (or Start/Stop), and P-values.
- **Correlation Matrix**: A pre-computed correlation matrix or raw data (where correlations are calculated on-the-fly).

```r
library(coMET)

# 1. Load association data
extdata <- system.file("extdata", package="coMET")
mydata <- read.delim(file.path(extdata, "cyp1b1_infofile.txt"))

# 2. Load correlation data (raw matrix)
mycorr <- read.delim(file.path(extdata, "cyp1b1_res37_rawMatrix.txt"))

# 3. Define genomic region
chrom <- "chr2"
start <- 38290160
end <- 38303219
```

### Creating Annotation Tracks
Use the built-in wrappers for `Gviz` to fetch data from Ensembl or UCSC:
```r
# Fetch Ensembl genes
genetrack <- genes_ENSEMBL(genome="hg19", chrom, start, end, showId=TRUE)

# Fetch UCSC CpG Islands
cpgtrack <- cpgIslands_UCSC(genome="hg19", chrom, start, end)

# Combine tracks into a list
listgviz <- list(genetrack, cpgtrack)
```

### Generating the Plot
```r
comet(
  mydata.file = mydata,
  mydata.type = "dataframe",
  cormatrix.file = list(mycorr),
  cormatrix.type = "listdataframe",
  tracks.gviz = listgviz,
  cormatrix.method = "spearman",
  conf.level = 0.05
)
```

## Key Configuration Options

- **mydata.format**: Defines input structure (`site`, `region`, `site_asso`, or `region_asso`). `_asso` formats include effect direction.
- **cormatrix.color.scheme**: Options include `heat`, `bluewhitered`, `cm`, `topo`, `gray`, `bluetored`.
- **disp.pvalueplot / disp.cormatrixmap**: Boolean flags to toggle the Manhattan plot or the heatmap.
- **pval.threshold**: Adds a horizontal significance line to the Manhattan plot.

## Tips for Success
- **Feature Limit**: The correlation heatmap (lower panel) is optimized for a maximum of 120 features. For larger regions, use `comet.list()` to extract data instead of plotting.
- **Coordinate Systems**: Ensure the `genome` parameter (e.g., "hg19" vs "hg38") matches your input data coordinates.
- **Gviz Integration**: Since `coMET` uses `Gviz` for the middle panel, you can add any standard `Gviz` track (e.g., `DataTrack`, `AnnotationTrack`) to the `tracks.gviz` list.
- **Plotting Errors**: If a plot fails to render, run `dev.off()` to clear the graphics device before retrying.

## Reference documentation
- [coMET](./references/coMET.md)