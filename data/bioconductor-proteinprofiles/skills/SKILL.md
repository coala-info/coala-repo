---
name: bioconductor-proteinprofiles
description: This tool analyzes protein abundance profiles to identify groups of proteins with similar expression patterns over time or across replicates. Use when user asks to filter protein features by missing values, identify protein groups based on annotations, compute profile similarity distances, or perform permutation tests to assess the statistical significance of protein co-regulation.
homepage: https://bioconductor.org/packages/release/bioc/html/proteinProfiles.html
---


# bioconductor-proteinprofiles

name: bioconductor-proteinprofiles
description: Analysis of protein abundance profiles over time or across replicates. Use this skill to identify groups of proteins with similar time courses, compute distance measures between protein profiles, and assess the statistical significance of these similarities using permutation tests.

## Overview

The `proteinProfiles` package is designed for high-throughput proteomics data where protein abundance is measured across multiple time points or conditions. It provides a workflow to group proteins based on annotation, calculate their average profile similarity (Euclidean distance), and determine if a specific group of proteins is more tightly co-regulated than expected by chance.

## Typical Workflow

### 1. Data Preparation
The package requires two main components:
- **Abundance Matrix**: A numeric matrix where rows are proteins and columns are time points or replicates.
- **Annotation Data Frame**: A data frame containing metadata (Gene names, GO terms, KEGG pathways) with row names matching the abundance matrix.

```r
library(proteinProfiles)
data(ips_sample) # Loads 'ratios' and 'annotation'

# Filter features with too many missing values (e.g., > 30% NA)
ratios_filtered <- filterFeatures(ratios, 0.3, verbose = TRUE)
```

### 2. Defining Protein Groups
Use `grepAnnotation` to identify proteins belonging to a specific functional group or naming pattern using regular expressions.

```r
# Find proteins where 'Protein.Name' starts with '28S'
index_28S <- grepAnnotation(annotation, pattern = "^28S", column = "Protein.Name")

# Find proteins associated with 'Ribosome' in KEGG column
index_ribosome <- grepAnnotation(annotation, pattern = "Ribosome", column = "KEGG")
```

### 3. Computing Profile Distances
The `profileDistance` function calculates the mean Euclidean distance ($d_0$) for the group and compares it against $n$ randomly sampled groups of the same size to generate a p-value.

```r
# Compute distance and significance
# nSample defaults to 1000; increase for better p-value resolution
result <- profileDistance(ratios, index_ribosome, nSample = 2000)

# Access results
result$d0       # Mean distance of the group
result$p.value  # Significance (probability of seeing d0 or smaller by chance)
```

### 4. Visualization
Visualize the cumulative distribution of distances from the null model (random samples) compared to the observed distance of your group.

```r
plotProfileDistance(result)
```

## Key Functions

- `filterFeatures(data, threshold)`: Removes rows where the fraction of `NA` values exceeds the threshold (0 to 1).
- `grepAnnotation(annotation, pattern, column)`: Returns row identifiers matching a regex pattern in a specific metadata column.
- `profileDistance(data, index, nSample)`: Core analysis function for distance calculation and permutation testing.
- `plotProfileDistance(z)`: Generates an ECDF plot of sampled distances with the observed distance marked.

## Tips for Analysis
- **Missing Data**: Always run `filterFeatures` before distance calculation, as Euclidean distance is sensitive to `NA` values.
- **P-value Interpretation**: A low p-value (e.g., < 0.05) indicates that the proteins in your group have significantly more similar profiles than a random set of proteins, suggesting coordinated regulation.
- **Sample Size**: For publication-quality p-values, increase `nSample` to 5000 or 10000.

## Reference documentation
- [The proteinProfiles package](./references/proteinProfiles.md)