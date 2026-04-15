---
name: r-ccqtl
description: The r-ccqtl tool analyzes Quantitative Trait Loci (QTL) in Collaborative Cross mouse populations. Use when user asks to perform genetic mapping, calculate genotype probabilities, or visualize QTL scans and founder effects for Collaborative Cross strains.
homepage: https://cran.r-project.org/web/packages/ccqtl/index.html
---

# r-ccqtl

name: r-ccqtl
description: Analyze Quantitative Trait Loci (QTL) in Collaborative Cross (CC) mouse populations. Use when performing genetic mapping, calculating genotype probabilities, or visualizing QTL scans specifically for CC strains.

# r-ccqtl

## Overview
The `ccqtl` package provides specialized tools for Quantitative Trait Loci (QTL) analysis within the Collaborative Cross (CC) mouse population. It simplifies the process of mapping complex traits in multi-parent populations by providing functions for data preparation, genome-wide scanning, and result visualization.

## Installation
To install the package from CRAN:
```R
install.packages("ccqtl")
```

## Main Functions and Workflows

### Data Preparation
Before scanning, ensure your data is formatted for multi-parent population analysis. The package typically works with genotype probabilities and phenotype vectors.

### QTL Scanning
The primary workflow involves scanning the genome to identify significant associations between markers and traits.
- `cc_scan()`: Performs a QTL scan across the genome. It calculates LOD scores for the association between the phenotype and the founder haplotypes at each locus.
- Parameters usually include `pheno` (phenotype data), `probs` (genotype probabilities), and `K` (kinship matrix for mixed model approaches).

### Visualization
Visualizing the results is critical for identifying peaks and interpreting genetic effects.
- `plot_cc()`: Generates a genome-wide plot of LOD scores.
- `plot_effects()`: Visualizes the estimated effects of the eight CC founder strains at a specific QTL peak.

### Summary and Inference
- `summary_cc()`: Provides a summary of the scan results, including significant peaks and their genomic positions.
- `get_peaks()`: Extracts specific genomic coordinates where the LOD score exceeds a defined threshold.

## Tips for Usage
- **Kinship Correction**: When working with CC mice, always account for population structure using a kinship matrix to avoid false positives.
- **Founder Probabilities**: Ensure that genotype probabilities are correctly calculated (often using `qtl2`) before passing them to `ccqtl` functions.
- **Permutation Testing**: Use permutations to determine significance thresholds specific to your dataset.

## Reference documentation
- [README](./references/README.md)
- [home_page](./references/home_page.md)