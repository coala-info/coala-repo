---
name: bioconductor-dexus
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/dexus.html
---

# bioconductor-dexus

## Overview
The `dexus` package implements a statistical model for identifying differentially expressed transcripts in RNA-Seq data. It models read counts as a finite mixture of negative binomial distributions. A key strength of `dexus` is its ability to work in an unsupervised mode, detecting differential expression even when sample groups or conditions are unknown. It provides an Informative/Non-Informative (I/NI) value to rank transcripts and can also perform supervised analysis when group labels are provided.

## Core Workflow

### 1. Data Preparation
DEXUS accepts a numeric matrix of raw read counts (transcripts as rows, samples as columns) or a `CountDataSet` object (from the `DESeq` package).

```R
library(dexus)
data(dexus) # Loads example datasets like countsBottomly

# Input should be a matrix of integers
count_matrix <- countsBottomly[1:1000, ]
```

### 2. Running DEXUS
The primary function is `dexus()`. It operates in two modes based on the `labels` argument.

**Unsupervised Mode (Unknown Conditions):**
Use this when you do not know the sample groups. DEXUS will estimate the conditions for each transcript.
```R
result <- dexus(count_matrix)
```

**Supervised Mode (Known Conditions):**
Use this for case-control or multi-group studies.
```R
# Provide a vector of labels corresponding to columns
sample_labels <- c(rep("A", 10), rep("B", 11))
result_sup <- dexus(count_matrix, labels = sample_labels)
```

### 3. Extracting and Filtering Results
The result is a `DEXUSResult` object. You can sort it and filter for "informative" transcripts.

```R
# Sort by I/NI value (unsupervised) or p-value (supervised)
sorted_res <- sort(result)

# Filter for informative transcripts using a threshold (default is 0.1)
# Higher thresholds (e.g., 0.1) provide higher specificity
informative <- INI(result, threshold = 0.1)

# Convert to data frame for export
res_df <- as.data.frame(sorted_res)
```

### 4. Visualization
DEXUS provides a specialized heatmap function to visualize the top transcripts and the identified or provided conditions.

```R
# Plot the top ranked transcripts
plot(result)

# Plot specific transcripts by index
plot(result, idx = 1:20)
```

## Key Parameters
- `normalization`: Choices are `"RLE"`, `"upperquartile"`, or `"none"`.
- `nclasses`: Number of conditions to model (default is 2).
- `G`: Dirichlet prior weight. Higher values lead to fewer transcripts being called differentially expressed (more conservative).
- `threshold`: The I/NI value cutoff. 0.05 is generally a good balance; 0.1 is very specific.

## Result Object Structure
The `DEXUSResult` object contains:
- `INIValues`: Evidence for differential expression (unsupervised).
- `pvals`: Significance values (supervised).
- `responsibilities`: Matrix indicating the condition assignment for each sample/transcript.
- `means` / `dispersions`: Estimated parameters for the negative binomial distributions.

## Reference documentation
- [dexus](./references/dexus.md)