---
name: r-dartr
description: The r-dartr package imports, filters, and analyzes SNP and SilicoDART genomic data for population genetic studies. Use when user asks to import DArT or VCF files, perform quality control filtering, visualize population structure via PCoA, or export data to software like Structure and NewHybrids.
homepage: https://cran.r-project.org/web/packages/dartr/index.html
---

# r-dartr

name: r-dartr
description: Specialized R package for importing, filtering, and analyzing SNP and SilicoDART genomic data, particularly from Diversity Arrays Technology (DArT). Use this skill when performing population genetic analyses, including data quality control (CallRate, heterozygosity), PCoA visualizations, spatial mapping, and interfacing with 3rd party software like Structure or NewHybrids.

## Overview

The `dartR` package provides a comprehensive suite of tools for genomic analysis of SNP and presence/absence data. It utilizes the `genlight` object format from the `adegenet` package for memory-efficient storage of large genomic datasets and associated metadata. Key capabilities include data filtering based on various quality metrics, population genetic statistics, visualization, and simulation of SNP dynamics.

## Installation

To install the package from CRAN:

```R
install.packages("dartR")
library(dartR)
```

Note: `dartR` depends on several Bioconductor packages (e.g., `SNPRelate`). If installation fails, ensure BiocManager is used to install dependencies.

## Core Workflows

### 1. Data Import
`dartR` is designed to import DArT files directly, but can also handle VCF and other formats.

```R
# Import DArT SNP data (.csv) and metadata
gl <- gl.read.dart(filename = "SNP_data.csv", ind.metafile = "metadata.csv")

# Import from VCF
gl <- gl.read.vcf("data.vcf")
```

### 2. Data Filtering (Quality Control)
Filtering is typically performed in a sequence to remove low-quality loci or individuals.

```R
# Common filtering sequence
gl_filtered <- gl %>%
  gl.filter.callrate(threshold = 0.95, method = "loc") %>% # Filter loci by call rate
  gl.filter.reproducibility(threshold = 0.99) %>%         # Filter by RepAvg
  gl.filter.monomorphs() %>%                              # Remove monomorphic loci
  gl.filter.secondaries()                                 # Keep only one SNP per sequence tag
```

### 3. Population Genetics & Visualization
Perform standard analyses and visualize population structure.

```R
# Calculate basic statistics by population
stats <- gl.report.heterozygosity(gl_filtered)

# Principal Coordinate Analysis (PCoA)
pca <- gl.pcoa(gl_filtered)
gl.pcoa.plot(pca, gl_filtered, ellipse = TRUE)

# Calculate Fst
fst <- gl.fst.pop(gl_filtered, nboots = 100)
```

### 4. Exporting to 3rd Party Software
`dartR` acts as a bridge to many specialized genetic programs.

```R
# Export to Structure format
gl2structure(gl_filtered, outfile = "project_structure.str")

# Export to NewHybrids
gl2nhyb(gl_filtered, outfile = "project_nhyb.txt")

# Export to fastsimcoal
gl2fastsimcoal(gl_filtered, outfile = "project_fsc.tpl")
```

## Tips for Success
- **Genlight Objects**: Always remember that `dartR` functions operate on and return `genlight` objects. You can access the SNP matrix using `as.matrix(gl)`.
- **Reporting**: Most filtering functions have a corresponding `gl.report.xxx` function. Run the report first to determine the appropriate threshold before applying the filter.
- **Population Assignment**: Ensure your metadata file correctly assigns individuals to populations using `pop(gl) <- metadata$Population`. Many functions will fail or produce aggregate results if populations are not defined.
- **Large Datasets**: For very large datasets, use `gl.subsample.loci()` to create a smaller test set while refining your workflow.

## Reference documentation
- [dartR Home Page](./references/home_page.md)