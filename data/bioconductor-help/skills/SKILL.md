---
name: bioconductor-help
description: The package contains a modular pipeline for analysis of HELP microarray data, and includes graphical and mathematical tools with more general applications.
homepage: https://bioconductor.org/packages/release/bioc/html/HELP.html
---

# bioconductor-help

name: bioconductor-help
description: Analysis of HELP (HpaII tiny fragment Enrichment by Ligation-mediated PCR) microarray data. Use this skill to import Roche NimbleGen .pair files, perform quality control, calculate probe melting temperatures (Tm) and GC content, apply single-sample quantile normalization, and summarize probe-level data into methylation measures.

# bioconductor-help

## Overview

The `HELP` package provides a modular pipeline for analyzing DNA methylation microarrays, specifically those using the Roche NimbleGen format and the HELP assay protocol. It handles the dual-channel data where Cy3 (532nm) typically represents the reference (MspI) and Cy5 (635nm) represents the experimental (HpaII) sample. The package includes tools for data import, spatial quality control, density-dependent normalization, and data summarization.

## Core Workflow

### 1. Data Import
Import matched `.pair` files into an `ExpressionSet` object.

```R
library(HELP)

# Identify pair files
msp1.files <- dir(data.path, pattern="532[._]pair", full.names=TRUE)
hpa2.files <- dir(data.path, pattern="635[._]pair", full.names=TRUE)

# Import files iteratively
pairs <- readPairs(msp1.files[1], hpa2.files[1])
for (i in 2:length(msp1.files)) {
    pairs <- readPairs(msp1.files[i], hpa2.files[i], pairs)
}

# Apply sample names via a sample key
chips <- readSampleKey(file="sample.key.txt", chips=basename(msp1.files))
sampleNames(pairs) <- chips
```

### 2. Design and Sequence Information
Link probe identifiers to genomic positions and sequences using `.ndf` and `.ngd` files.

```R
pairs <- readDesign("HELP.ndf.txt", "HELP.ngd.txt", pairs)

# Calculate sequence properties
tm_values <- calcTm(getFeatures(pairs, "SEQUENCE"))
gc_content <- calcGC(getFeatures(pairs, "SEQUENCE"))
```

### 3. Quality Control
Visualize spatial variation and fragment size biases.

```R
# Spatial plot for a specific sample
plotChip(pairs, sample="Brain1")

# Fragment size vs. signal intensity (identifies methylation populations)
plotFeature(pairs[,"Brain1"])

# Calculate prototypical signal across arrays for comparison
prototypes <- calcPrototype(pairs, center=TRUE)
```

### 4. Single-Sample Quantile Normalization
Correct for fragment size bias (LM-PCR bias) using density-dependent sliding windows.

```R
# Define background thresholds using random probes
rand_idx <- which(getFeatures(pairs, "TYPE") == "RAND")
msp_fail <- median(exprs(pairs)[rand_idx,]) + 2.5 * mad(exprs(pairs)[rand_idx,])

# Normalize MspI (reference) channel
norand <- which(getFeatures(pairs, "TYPE") == "DATA")
size <- as.numeric(getFeatures(pairs, "SIZE"))[norand]
msp_vals <- exprs(pairs)[norand, "Brain1"]
msp_norm <- msp_vals
msp_norm[msp_vals > msp_fail] <- quantileNormalize(msp_vals[msp_vals > msp_fail], size[msp_vals > msp_fail])
```

### 5. Data Summarization
Group probe-level data into fragment-level methylation measures.

```R
# Summarize using weighted mean (weighted by MspI intensity)
data_summary <- combineData(
    data = getSamples(pairs, element="exprs2"), 
    group = getFeatures(pairs, 'SEQ_ID'), 
    weight = getSamples(pairs, element="exprs"), 
    trim = 0.2
)

# Pairwise sample comparison
plotPairs(pairs, element="exprs2")
```

## Tips and Best Practices
- **Channel Mapping**: Ensure Cy3 is mapped to MspI (reference) and Cy5 to HpaII (experimental).
- **Background Handling**: Always use the random probes (`TYPE=="RAND"`) to define the noise floor before normalization.
- **Normalization Strategy**: Normalize HpaII signals separately for those within the background distribution versus those above it to preserve biological methylation signals.
- **Summarization**: Use `trim=0.2` in `combineData` to reduce the impact of outlier probes within a fragment.

## Reference documentation
- [HELP Microarray Analytical Tools](./references/HELP.md)