---
name: bioconductor-ngscopy
description: NGScopy detects copy number variations in next-generation sequencing data by calculating relative copy number ratios and performing segmentation on BAM files. Use when user asks to detect CNVs in targeted panel or whole exome sequencing data, process normal and tumor BAM files, calculate copy number ratios, or perform genomic segmentation and visualization.
homepage: https://bioconductor.org/packages/3.8/bioc/html/NGScopy.html
---

# bioconductor-ngscopy

name: bioconductor-ngscopy
description: Detection of copy number variations (CNV) in next-generation sequencing (NGS) data, including Targeted Panel Sequencing (TPS), Whole Exome Sequencing (WES), and Whole Genome Sequencing (WGS). Use this skill to process BAM files, generate relative copy number ratios (CNR) between tumor and normal samples, perform segmentation, and visualize genomic alterations.

## Overview
NGScopy implements a "restriction-imposed windowing" approach to detect CNVs by generating windows with balanced read counts from a control sample. This method is particularly robust for TPS data, which is often sparse and inhomogeneous. The package uses a Reference Class (`NGScopy`) to manage the analysis workflow, from read counting to segmentation and visualization.

## Core Workflow

### 1. Initialization
Create an `NGScopy` object by providing paths to BAM files and library sizes.

```R
library(NGScopy)
library(NGScopyData)

obj <- NGScopy$new(
    outFpre = "output_prefix",
    inFpathN = "normal.bam",
    inFpathT = "tumor.bam",
    libsizeN = 5777087, # Total reads in normal BAM
    libsizeT = 4624267, # Total reads in tumor BAM
    mindepth = 20,      # Min reads per window
    minsize = 20000,    # Min window size (bp)
    regions = NULL,     # NULL for whole genome, or use read_regions()
    segtype = "mean.norm",
    pcThreads = 1
)
```

### 2. Processing and Analysis
The analysis can be run in steps or using wrapper methods.

**The Quick Method:**
```R
obj$write_cn()    # Processes normal/tumor, calculates ratios, and saves to file
obj$write_segm()  # Performs segmentation and saves to file
obj$plot_out()    # Generates PDF visualization
```

**The Step-by-Step Method:**
```R
obj$proc_normal() # Build windows and count normal reads
obj$proc_tumor()  # Count tumor reads in windows
obj$calc_cn()     # Calculate relative copy number ratios
obj$calc_segm()   # Perform segmentation
```

### 3. Accessing Results
Retrieve data frames for custom analysis within R.

```R
# Get Copy Number Ratios
cn_data <- obj$get_data.cn()
head(cn_data) # Columns: chr, start, end, size, pos, depthN, depthT, cnr

# Get Segmentation Results
seg_data <- obj$get_data.segm()
head(seg_data) # Columns: chr, win.from, win.to, start, end, mean, segtype
```

## Key Parameters and Functions

### Windowing Parameters
- `mindepth`: Minimal depth of reads per window. Increase for higher confidence; decrease for higher resolution.
- `minsize`: Minimal size of a window. TPS usually requires larger values (e.g., 20000) than WGS/WES.

### Segmentation Types (`segtype`)
NGScopy supports multiple algorithms via the `changepoint` package:
- `mean.norm`: Normal distribution, change in mean.
- `meanvar.norm`: Normal distribution, change in mean and variance.
- `mean.cusum`: Cumulative sums, change in mean.
- `var.css`: Cumulative sums of squares, change in variance.

### Working with Regions
To analyze specific genomic intervals, use `read_regions`:
```R
# Format: "chr start end" (zero-based, half-open)
my_regions <- read_regions("chr6 41000000 81000000")
obj$set_regions(my_regions)
```

### Multi-Sample Analysis
If comparing multiple tumors to a single normal sample, process and save the normal sample once to save time:
```R
# In first object
obj$proc_normal()
obj$save_normal()

# In subsequent objects
obj_new$load_normal("path/to/saved_normal")
obj_new$proc_tumor()
```

## Reference documentation
- [Bioconductor NGScopy: User’s Guide](./references/NGScopy-vignette.md)