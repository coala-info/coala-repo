---
name: r-crisprcleanr
description: CRISPRcleanR is an R package for identifying and correcting gene-independent responses and copy number biases in pooled genome-wide CRISPR-Cas9 screens. Use when user asks to normalize log fold changes, correct for genomic location biases, or derive corrected guide counts for downstream essentiality analysis.
homepage: https://cran.r-project.org/web/packages/crisprcleanr/index.html
---


# r-crisprcleanr

name: r-crisprcleanr
description: Specialized R package for unsupervised identification and correction of gene-independent cell responses (e.g., copy number bias) in pooled genome-wide CRISPR-Cas9 screens. Use this skill when analyzing CRISPR essentiality profiles to normalize log fold changes (logFCs), correct for genomic location biases, and derive corrected guide counts for downstream analysis.

# r-crisprcleanr

## Overview
CRISPRcleanR is designed to process pooled genome-wide CRISPR-Cas9 essentiality profiles. It addresses the "copy number effect" where sgRNAs targeting amplified genomic regions show a loss-of-fitness effect regardless of the gene's actual essentiality. It uses a circular binary segmentation algorithm to identify and mean-center these biased genomic regions, improving the accuracy of essential gene identification.

## Installation
```R
# Install from CRAN
install.packages("CRISPRcleanR")

# Or install the development version from GitHub
# devtools::install_github("francescojm/CRISPRcleanR")
```

## Core Workflow

### 1. Data Preparation and Normalization
Load your sgRNA count data and library annotations. CRISPRcleanR provides native support for several libraries (KY, Whitehead, Brunello, GeCKO v2, MiniLibCas9).

```R
library(CRISPRcleanR)

# Load example data (e.g., KY library)
data(KY_Library_v1.0)
data(HT29_counts)

# Normalize counts and calculate log fold changes (logFC)
# method can be 'ScalingByTotalReads' (default) or 'MedianRatios'
norm_logFC <- ccr.NormfoldChanges(data = HT29_counts, 
                                  libraryAnnotation = KY_Library_v1.0,
                                  method = 'ScalingByTotalReads')
```

### 2. Correcting Gene-Independent Responses
The core function `ccr.GWclean` applies circular binary segmentation to identify and correct biased genomic segments.

```R
# Correct logFCs
corrected_data <- ccr.GWclean(norm_logFC, 
                              libraryAnnotation = KY_Library_v1.0)
```

### 3. Deriving Corrected Counts
To use tools like MAGeCK or BAGEL, you can back-calculate corrected treatment counts from the cleaned logFCs.

```R
corrected_counts <- ccr.getCorrectedCounts(norm_logFC,
                                           corrected_data,
                                           libraryAnnotation = KY_Library_v1.0)
```

### 4. Gene-Level Summarization
Collapse sgRNA-level data to gene-level essentiality scores.

```R
gene_summary <- ccr.geneSummary(corrected_data)
```

## Key Functions
- `ccr.NormfoldChanges`: Normalizes raw counts and computes logFCs between treatment and control (T0).
- `ccr.GWclean`: The main correction algorithm. It identifies clusters of sgRNAs in contiguous genomic regions with similar logFCs and centers them.
- `ccr.getCorrectedCounts`: Inverse transformation to produce a count matrix compatible with mean-variance modeling tools.
- `ccr.geneSummary`: Averages logFCs per gene and identifies significantly depleted genes based on a user-defined FDR threshold of non-essential genes.

## Tips for Success
- **Library Annotation**: Ensure your library annotation contains `CODE`, `SYMBOL`, `CHRM`, and `POS` columns. CRISPRcleanR relies on the genomic coordinates of the guides.
- **Positive/Negative Controls**: Use the built-in functions to visualize the classification of known essential and non-essential genes before and after correction to verify performance.
- **Method Selection**: In `ccr.NormfoldChanges`, use `method = 'ScalingByTotalReads'` for standard library size normalization.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)