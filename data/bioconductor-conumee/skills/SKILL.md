---
name: bioconductor-conumee
description: This tool performs copy-number variation analysis using Illumina 450k or EPIC DNA methylation array data. Use when user asks to perform CNV analysis on methylation data, normalize intensities against control samples, generate circular binary segmentation results, or create CNV plots.
homepage: https://bioconductor.org/packages/release/bioc/html/conumee.html
---


# bioconductor-conumee

name: bioconductor-conumee
description: Perform copy-number variation (CNV) analysis using Illumina 450k or EPIC DNA methylation arrays. Use this skill when analyzing methylation data (Mset objects) to extract copy-number alterations, normalize intensities against control samples, and generate circular binary segmentation (CBS) results or CNV plots.

# bioconductor-conumee

## Overview

The `conumee` package is designed for copy-number variation (CNV) analysis using Illumina Infinium DNA methylation microarrays (450k and EPIC). It utilizes the combined intensity of methylated and unmethylated channels to estimate copy number. The workflow involves normalizing query samples against a set of flat-genome controls, binning probes to reduce noise, and performing segmentation using the Circular Binary Segmentation (CBS) algorithm.

## Core Workflow

### 1. Data Preparation
The package integrates seamlessly with `minfi`. The preferred input is a `MethylSet` (Mset).

```r
library(minfi)
library(conumee)

# Load raw data and preprocess
# RGset <- read.metharray.exp(base = "path_to_idats")
# Mset <- preprocessIllumina(RGset)

# Example using minfiData
library(minfiData)
data(MsetEx)
```

### 2. Annotation Object Creation
Create an annotation object that defines genomic bins and regions to exclude (e.g., polymorphic sites) or examine in detail (e.g., oncogenes).

```r
data(exclude_regions) # Optional: predefined regions to ignore
data(detail_regions)  # Optional: specific genes/loci for detailed plotting

anno <- CNV.create_anno(array_type = "450k", 
                        exclude_regions = exclude_regions, 
                        detail_regions = detail_regions)
```

### 3. Loading and Fitting
Load the intensities and fit the query sample to control samples using multiple linear regression to calculate log2-ratios.

```r
# Load intensities into conumee format
data_combined <- CNV.load(MsetEx)

# Identify controls (e.g., normal samples)
is_control <- pData(MsetEx)$status == "normal"

# Fit a specific sample (e.g., "GroupB_1") against controls
x <- CNV.fit(data_combined["GroupB_1"], data_combined[is_control], anno)
```

### 4. Binning, Detail Analysis, and Segmentation
Process the fitted object through the remaining pipeline steps.

```r
x <- CNV.bin(x)      # Combine probes into genomic bins
x <- CNV.detail(x)   # (Optional) Extract info for detail_regions
x <- CNV.segment(x)  # Perform CBS segmentation
```

## Visualization and Output

### Plotting
`conumee` provides specialized plotting functions for genome-wide and locus-specific views.

```r
# Genome-wide plot
CNV.genomeplot(x)

# Chromosome-specific plot
CNV.genomeplot(x, chr = "chr7")

# Detailed plot for a specific gene (defined in detail_regions)
CNV.detailplot(x, name = "PTEN")

# Plot all detail regions at once
CNV.detailplot_wrap(x)
```

### Exporting Results
Extract data as data frames or write directly to files for IGV or GISTIC.

```r
# Get segments as a data frame
segs <- CNV.write(x, what = "segments")

# Write to file
# CNV.write(x, what = "probes", file = "sample_probes.igv")
# CNV.write(x, what = "bins", file = "sample_bins.igv")
```

## Tips for Success
- **Control Samples**: The quality of CNV calls depends heavily on the control set. Use at least 10-20 normal control samples processed in the same batch if possible.
- **Array Types**: Ensure `array_type` in `CNV.create_anno` matches your data ("450k" or "EPIC").
- **Detail Regions**: When defining `detail_regions`, provide a `GRanges` object where the metadata columns define the plotting window around the gene of interest.

## Reference documentation
- [The conumee vignette](./references/conumee.md)