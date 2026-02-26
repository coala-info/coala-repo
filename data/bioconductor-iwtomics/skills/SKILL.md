---
name: bioconductor-iwtomics
description: The IWTomics package implements interval-wise testing for functional data analysis to identify significant differences in genomic features across different locations and scales. Use when user asks to statistically evaluate differences in genomic features along the genome, perform non-parametric permutation-based testing on functional data, or visualize significant genomic regions at multiple resolutions.
homepage: https://bioconductor.org/packages/release/bioc/html/IWTomics.html
---


# bioconductor-iwtomics

## Overview
The `IWTomics` package implements an extended version of Interval-Wise Testing (IWT) for functional data analysis specifically designed for "Omics" data. It allows for the statistical evaluation of differences in genomic features along the genome. Key advantages include being non-parametric (permutation-based), location-free, and scale-free—meaning it can identify both *where* a difference occurs and at *what resolution* (scale) the difference is significant.

## Typical Workflow

### 1. Data Import and Initialization
Data is managed using the `IWTomicsData` S4 class. You can import data from BED files or tables.

```r
library(IWTomics)

# Define region datasets and feature files
# regions: chr, start, end
# features: chr, start, end, value (fixed window size)
regionsFeatures <- IWTomicsData(
  regionFiles, 
  featureFiles, 
  alignment = 'center', # 'left', 'right', 'center', or 'scale'
  id_regions = c('case', 'control'),
  id_features = c('feature1', 'feature2')
)
```

### 2. Visual Inspection
Before testing, visualize the distribution and roughness of the data.

```r
# Pairwise correlation between features
plot(regionsFeatures, type = 'pairs')

# Plot individual curves and mean curves
plot(regionsFeatures, type = 'curves', id_features_subset = 'feature1')

# Pointwise boxplots (quartile curves)
plot(regionsFeatures, type = 'boxplot', id_features_subset = 'feature1')
```

### 3. Statistical Testing (IWT)
The `IWTomicsTest` function performs one-sample or two-sample tests.

```r
# Two-sample test comparing 'case' vs 'control'
# statistics: 'mean' (default), 'median', 'variance', or 'quantile'
result <- IWTomicsTest(
  regionsFeatures,
  id_region1 = 'case', 
  id_region2 = 'control',
  B = 1000 # Number of permutations
)

# Access adjusted p-values
pvals <- adjusted_pval(result)
```

### 4. Visualizing Results
Interpret the significance across locations and scales.

```r
# Detailed test plot: Heatmap of scales, p-value curve, and data
plotTest(result, alpha = 0.05, scale_threshold = 10)

# Summary heatmap for multiple tests or features
plotSummary(result, groupby = 'feature', alpha = 0.05)
```

## Advanced Operations

### Scaling and Smoothing
If regions have different lengths and you use `alignment = 'scale'`, or if data is noisy, use the `smooth` function.

```r
# Smooth curves using local polynomials
smoothedData <- smooth(
  regionsFeatures, 
  type = 'locpoly', 
  bandwidth = 5
)
```

### Handling Missing Data (NA)
`IWTomics` handles NAs, but if a window has too many NAs such that one group has no measurements in a permutation, the p-value may not be fully computable. Check the pointwise sample sizes using `plot(..., type = 'boxplot', size = TRUE)`.

## Tips for Success
- **Reproducibility**: Always use `set.seed()` before `IWTomicsTest` because it relies on random permutations.
- **Scale Selection**: Use the `plotTest` heatmap to identify the "relevant scale." If the blue band (low p-values) is only present at the bottom of the heatmap, the effect is local/fine-scale. If it extends to the top, the effect is consistent across the whole region.
- **Resolution**: For discrete data (e.g., exon counts), use a medium-high resolution window so the signal appears continuous rather than binary (0/1).

## Reference documentation
- [IWTomics](./references/IWTomics.md)