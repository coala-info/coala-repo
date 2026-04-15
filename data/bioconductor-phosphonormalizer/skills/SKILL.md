---
name: bioconductor-phosphonormalizer
description: This package performs pairwise normalization for label-free mass spectrometry phosphoproteomics by calculating factors from overlapping peptides in enriched and non-enriched fractions. Use when user asks to normalize phosphoproteomics data, correct enrichment bias in mass spectrometry, or use the phosphonormalizer R package.
homepage: https://bioconductor.org/packages/release/bioc/html/phosphonormalizer.html
---

# bioconductor-phosphonormalizer

## Overview

The `phosphonormalizer` package implements a pairwise normalization strategy for label-free mass spectrometry (MS) phosphoproteomics. Standard global median normalization often fails in phosphoproteomics because the enrichment process can mask large, unidirectional biological changes. This package corrects such bias by calculating normalization factors based on phosphopeptides that are present in both the enriched and non-enriched (total proteome) fractions of the same samples.

## Workflow and Usage

### 1. Data Requirements
*   **Enriched Data**: Data frame or `MSnSet` containing phosphopeptide abundances after enrichment.
*   **Non-enriched Data**: Data frame or `MSnSet` containing abundances from the same samples without enrichment.
*   **Pre-normalization**: Input abundances should be pre-normalized using standard median normalization.
*   **Common Peptides**: There must be overlapping phosphopeptides between the two datasets; otherwise, normalization cannot be performed.

### 2. Key Function: `normalizePhospho`
The primary function is `normalizePhospho()`. It requires mapping the columns for abundances, sequences, and modifications.

```r
library(phosphonormalizer)

# 1. Define abundance columns (e.g., columns 3 to 17 in both dataframes)
samplesCols <- data.frame(enriched = 3:17, non.enriched = 3:17)

# 2. Define sequence and modification columns (e.g., columns 1 and 2)
modseqCols <- data.frame(enriched = 1:2, non.enriched = 1:2)

# 3. Define technical replicates (as a factor)
techRep <- factor(x = c(1,1,1, 2,2,2, 3,3,3, 4,4,4, 5,5,5))

# 4. (Optional) Setup plotting parameters to visualize fold changes
# Compares sample group 3 against control group 1
plot.param <- list(control = c(1), samples = c(3))

# 5. Execute normalization
norm_results <- normalizePhospho(
    enriched = enriched.rd, 
    non.enriched = non.enriched.rd,
    samplesCols = samplesCols, 
    modseqCols = modseqCols, 
    techRep = techRep,
    plot.fc = plot.param
)
```

### 3. Internal Logic
*   **Aggregation**: Phosphopeptides quantified multiple times are summed.
*   **Ratio Calculation**: For each overlapping peptide, the ratio of (non-enriched / enriched) abundance is calculated.
*   **Outlier Removal**: Peptides with ratios exceeding 1.5x the interquartile range (IQR) of the overall fold change are excluded.
*   **Factor Derivation**: The median of the remaining ratios serves as the pairwise normalization factor applied to the enriched samples.

## Tips and Troubleshooting
*   **Column Mapping**: Ensure `samplesCols` and `modseqCols` data frames have the exact column names `enriched` and `non.enriched`.
*   **Data Types**: Sequence and Modification columns must be `character` format; Abundance columns must be `numeric`.
*   **MSnSet Support**: If using the `MSnbase` workflow, you can pass `MSnSet` objects directly to the function.
*   **Error: "No common phosphopeptides"**: This occurs if the intersection of (Sequence + Modification) between the two datasets is empty. Check for formatting inconsistencies in the modification strings.

## Reference documentation
- [phosphonormalizer](./references/phosphonormalizer.md)
- [vignette](./references/vignette.md)