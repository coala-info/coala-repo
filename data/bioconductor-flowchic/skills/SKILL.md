---
name: bioconductor-flowchic
description: This tool analyzes flow cytometric data of microbial communities by converting FCS files into histogram images for comparison. Use when user asks to convert FCS files to images, perform image-based similarity analysis, or visualize community dynamics using NMDS and cluster analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/flowCHIC.html
---


# bioconductor-flowchic

name: bioconductor-flowchic
description: Analyze flow cytometric data of complex microbial communities using the CHIC (Cytometric Histogram Image Comparison) method. Use this skill to convert FCS files into histogram images, perform image-based similarity analysis, and visualize community dynamics via Non-metric Multidimensional Scaling (NMDS) and cluster analysis.

# bioconductor-flowchic

## Overview

The `flowCHIC` package provides a fast, nearly automated method for comparing cytometric datasets by converting histograms into images. This approach avoids manual gate setting and binning, making it ideal for large datasets and monitoring microbial community dynamics over time. The workflow consists of four main stages: image generation from raw FCS data, subsetting to remove noise, image analysis (XOR and overlap calculations), and similarity visualization using NMDS.

## Core Workflow

### 1. Image Generation
Convert raw FCS files into PNG histogram images.

```r
library(flowCHIC)
library(flowCore)

# List FCS files
fcs_files <- list.files(path = "path/to/fcs", full.names = TRUE, pattern = "*.fcs")

# Check channel names to select parameters
frame <- read.FCS(fcs_files[1], alter.names = TRUE)
unname(frame@parameters@data$name)

# Generate images (default channels are FS.Log and FL.4.Log)
# Creates a "chic_images" folder
fcs_to_img(fcs_files, ch1 = "FS.Log", ch2 = "FL.4.Log")
```

### 2. Subsetting and Noise Reduction
Define a rectangular gate to exclude instrumental noise and focus on relevant cell populations.

```r
# Define boundaries (0-4095 for log scale)
# Creates a "chic_subset" folder
img_sub(fcs_files, 
        ch1 = "FS.Log", ch2 = "FL.4.Log",
        x_start = 200, x_end = 3500, 
        y_start = 1000, y_end = 3000, 
        maxv = 160) # maxv: intensity value set to black (130-200 recommended)
```

### 3. Image Analysis
Calculate the overlap area and XOR (difference) intensities between all image pairs.

```r
# List subset images
subsets <- list.files(path = "./chic_subset", full.names = TRUE, pattern = "*.png")

# Calculate similarities
results <- calculate_overlaps_xor(subsets)

# Optional: Save results to text files
# calculate_overlaps_xor(subsets, verbose = TRUE)
```

### 4. Similarity Visualization (NMDS)
Visualize the relationships between samples. Samples closer together in the NMDS plot have higher cytometric similarity.

```r
# Basic NMDS plot
plot_nmds(results$overlap, results$xor)

# Advanced plot with groups and abiotic data
# 'groups' is a data frame with one column assigning samples to numeric IDs (1-25)
# 'abiotic' is a data frame where rows match the sample order
plot_nmds(results$overlap, 
          results$xor, 
          group = my_groups, 
          abiotic = my_abiotic_data,
          p.max = 0.05,        # Significance threshold for abiotic arrows
          show_cluster = TRUE, # Adds a dendrogram
          main = "Community Dynamics")
```

## Tips for Success

- **Calibration:** `flowCHIC` is highly sensitive to instrument adjustment. Ensure the cytometer is calibrated with beads; shifts in adjustment will appear as sample dissimilarities.
- **Event Count:** For accurate comparison, ensure every sample contains approximately the same number of recorded events.
- **Resolution:** The `xbin` parameter in `img_sub` (default 128) controls image resolution. This is optimized for microbial communities with 200k-250k events.
- **Sample Order:** When providing `group` or `abiotic` data, ensure the row order matches the sample order printed to the R console by `plot_nmds`.

## Reference documentation

- [flowCHIC Manual](./references/flowCHICmanual.md)