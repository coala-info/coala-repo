---
name: bioconductor-snpchip
description: This tool visualizes genome-wide data and SNP-level information through chromosomal idiograms. Use when user asks to plot cytogenetic idiograms, map genomic coordinates to chromosomal bands, or visualize copy number and genotype data across chromosomes.
homepage: https://bioconductor.org/packages/3.6/bioc/html/SNPchip.html
---


# bioconductor-snpchip

name: bioconductor-snpchip
description: Visualization of genome-wide data and SNP-level information. Use this skill to plot cytogenetic idiograms, map genomic coordinates to chromosomal bands, and visualize copy number or genotype data across chromosomes using the SNPchip R package.

## Overview

The `SNPchip` package provides specialized functions for visualizing genomic data in the context of chromosomal idiograms. It is particularly useful for displaying SNP-based analysis results, copy number variations (CNV), and loss of heterozygosity (LOH) across the human genome. While it is a legacy package, it remains a standard for quick, high-quality idiogram generation in R.

## Core Workflows

### Loading the Library
```R
library(SNPchip)
library(oligoClasses) # Often used for genomic coordinate handling
```

### Plotting Idiograms
The primary function is `plotIdiogram()`. It requires a chromosome identifier and a genome build (e.g., "hg19").

**Basic Plot:**
```R
# Plot chromosome 1 with default settings
plotIdiogram("1", build="hg19")
```

**Customizing Appearance:**
- `cex`: Adjusts the text size for cytoband labels.
- `label.cytoband`: Boolean to toggle band labels on/off.
- `new`: Set to `FALSE` to add an idiogram to an existing plot (useful for multi-chromosome layouts).

```R
# Plot without labels and custom text size
plotIdiogram("1", build="hg19", cex=0.8, label.cytoband=FALSE)
```

### Advanced Layouts
To plot multiple chromosomes or custom axes, use `cytoband.ycoords` and `ylim` to control the vertical placement of the idiogram.

**Multi-chromosome Example:**
```R
# Get sequence lengths for hg19
sl <- getSequenceLengths("hg19")[c(paste("chr", 1:22, sep=""), "chrX", "chrY")]

# Define vertical spacing
ybottom <- seq(0, 1, length.out=length(sl)) - 0.01
ytop <- seq(0, 1, length.out=length(sl)) + 0.01

# Loop through chromosomes to stack them
for(i in seq_along(sl)){
  chr <- names(sl)[i]
  if(i == 1){
    plotIdiogram("1", build="hg19", label.cytoband=FALSE, 
                 ylim=c(-0.05, 1.05), cytoband.ycoords=c(ybottom[1], ytop[1]),
                 xlim=c(0, max(sl)))
  } else {
    plotIdiogram(names(sl)[i], build="hg19", label.cytoband=FALSE, 
                 cytoband.ycoords=c(ybottom[i], ytop[i]), new=FALSE)
  }
}
```

## Tips and Best Practices
- **Genome Builds:** Ensure the `build` argument matches your data (e.g., "hg18", "hg19").
- **Coordinate Units:** When adding custom axes, remember that genomic positions are typically handled in base pairs, but labels are often converted to Megabases (Mb) for readability (`position / 1e6`).
- **Integration:** Use `par(mar=...)` to adjust margins before plotting if labels are being cut off.

## Reference documentation
- [Plotting Idiograms](./references/PlottingIdiograms.md)