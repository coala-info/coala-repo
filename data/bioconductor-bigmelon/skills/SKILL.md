---
name: bioconductor-bigmelon
description: This tool performs memory-efficient analysis of large-scale Illumina DNA methylation data using the Genomic Data Structure format. Use when user asks to convert IDAT files to GDS, perform disk-based normalization, filter high-dimensional microarray data, or predict epigenetic age.
homepage: https://bioconductor.org/packages/release/bioc/html/bigmelon.html
---

# bioconductor-bigmelon

name: bioconductor-bigmelon
description: Specialized for large-scale Illumina methylation data analysis using the bigmelon R package. Use when processing high-dimensional DNA methylation microarrays (450K, EPIC) that require memory-efficient storage (GDS format), normalization (dasen), quality control (outlyx, pfilter), and epigenetic age prediction (agep).

# bioconductor-bigmelon

## Overview

The `bigmelon` package provides a memory-efficient framework for Illumina methylation data analysis by leveraging the Genomic Data Structure (GDS) format. It extends `wateRmelon` functionality to massive datasets that exceed available RAM by performing disk-based operations. This skill guides the conversion of standard Bioconductor objects to GDS, data subsetting, normalization, and downstream analysis.

## Core Workflows

### 1. Data Import and GDS Creation

Convert existing objects or raw IDAT files into a `.gds` file to enable memory-efficient processing.

```R
library(bigmelon)

# From ExpressionSet/MethylSet/RGChannelSet
gfile <- es2gds(melon, 'melon.gds')

# From IDAT files (preferred for large data)
# iadd2 reads a directory; chunksize helps manage memory during import
gfile <- iadd2('path/to/idats', gds = 'data.gds', chunksize = 100)

# From GenomeStudio Final Report
gfile <- finalreport2gds('finalreport.txt', gds = 'data.gds')
```

### 2. Accessing and Subsetting Data

GDS objects behave like S4 objects but require specific indexing. Use `[` notation for familiar matrix-like access.

```R
# Open/Close connections
gfile <- openfn.gds('melon.gds')
# closefn.gds(gfile) # Always close before exiting R

# Explore structure
ls.gdsn(gfile)
print(gfile)

# Access Betas (returns gdsn.class)
b <- betas(gfile)

# Subset data into memory (returns matrix with names)
sub_betas <- gfile[1:10, 1:5, node = 'betas']
sub_meth <- gfile[1:10, 1:5, node = 'methylated']

# Access specific nodes
pvals_node <- index.gdsn(gfile, 'pvals')
```

### 3. Quality Control and Filtering

Perform QC without loading the entire dataset into memory.

```R
# Identify outliers (perc = fraction of data to test if very large)
outliers <- outlyx(gfile, plot = TRUE, perc = 0.01)

# Filter probes and samples
# Note: pfilter on a GDS object is irreversible and requires write-access
pfilter(gfile)

# Backup a node before destructive operations
backup.gdsn(node = index.gdsn(gfile, 'betas'))
```

### 4. Normalization

The `dasen` method is the standard for `bigmelon`. It replaces raw intensities with normalized values on disk.

```R
# Normalize in-place (overwrites raw data)
dasen(gfile)

# Normalize and store in a new node (preserves raw data)
dasen(gfile, node = "normbeta")
```

### 5. Analysis and Back-Porting

Use `apply.gdsn` for efficient margin-based calculations.

```R
# Calculate row means across all samples
row_means <- apply.gdsn(betas(gfile), margin = 1, as.is = 'double', FUN = mean, na.rm = TRUE)

# Epigenetic Age Prediction (Horvath's clock)
data(coef)
age_results <- agep(gfile, coeff = coef)

# Convert back to standard Bioconductor objects for specialized tools
mset <- gds2mset(gfile, anno = "450k")
mlumi <- gds2mlumi(gfile)
```

## Best Practices

- **File Closure**: Always use `closefn.gds(gfile)` before closing the R session to prevent data corruption.
- **Memory Management**: Use `iadd2` with `chunksize` when importing thousands of samples.
- **Node Access**: Use `index.gdsn(gfile, "fData/TargetID")` to reach nested metadata nodes.
- **Read/Write Modes**: Functions like `dasen` and `pfilter` require the GDS file to be opened in write mode (default for new files). Use `openfn.gds(file, readonly = FALSE)` if re-opening for processing.

## Reference documentation

- [The bigmelon Package](./references/bigmelon.md)