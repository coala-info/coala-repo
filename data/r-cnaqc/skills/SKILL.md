---
name: r-cnaqc
description: R package cnaqc (documentation from project home).
homepage: https://cran.r-project.org/web/packages/cnaqc/index.html
---

# r-cnaqc

name: r-cnaqc
description: Quality control (QC) for bulk cancer sequencing data, integrating somatic mutations (SNVs/indels) with allele-specific Copy Number Alterations (CNAs) and purity estimates. Use this skill to validate copy number segmentations, phase mutation multiplicities, estimate Cancer Cell Fractions (CCFs), and identify over-fragmentation in genomic data.

# r-cnaqc

## Overview
CNAqc is an R package designed for the quality control of bulk cancer sequencing data. It integrates somatic mutation data with allele-specific Copy Number Alterations (CNAs) and tumour purity estimates. The package allows users to validate copy number segmentations against variant allele frequencies (VAFs), rank alternative tumour models, phase mutations, and estimate Cancer Cell Fractions (CCFs).

## Installation
To install the development version from GitHub:
```R
# install.packages("devtools")
devtools::install_github("caravagnalab/CNAqc")
```

## Core Workflow

### 1. Data Initialization
Create a CNAqc object by providing mutations, copy number segments, and purity.
```R
library(CNAqc)

# mutations: data.frame with chr, from, to, ref, alt, DP, NV (or VAF)
# cna: data.frame with chr, from, to, Major, minor
# purity: numeric value (0 to 1)
x = init(mutations = my_mutations, cna = my_cna, purity = my_purity)
print(x)
```

### 2. Quality Control (QC)
Validate the consistency between the VAF distribution and the expected VAF based on the CNA segments and purity.
```R
# Run QC on clonal segments
x = analyze_peaks(x)

# Visualize the QC results
plot_peaks_analysis(x)
```

### 3. CCF Estimation
Estimate Cancer Cell Fractions (CCFs) for somatic mutations, accounting for local copy number and purity.
```R
# Compute CCFs
x = compute_ccf(x)

# Plot CCF distribution
plot_ccf(x)
```

### 4. Fragmentation Analysis
Identify chromosome arms that may be over-fragmented (excessively short and numerous segments).
```R
# Test for over-fragmentation
x = analyze_fragmentation(x)
```

## Main Functions
- `init()`: Constructor for the CNAqc object.
- `analyze_peaks()`: Performs the core QC by checking VAF peak alignment with expected clonal states.
- `compute_ccf()`: Calculates CCFs and mutation multiplicities.
- `plot_peaks_analysis()`: Generates diagnostic plots for the peak-based QC.
- `plot_segments()`: Visualizes the CNA segments across the genome.
- `mutate_ccf()`: Adds CCF information to the mutation data frame.

## Tips for Success
- Ensure your CNA segments have `Major` and `minor` allele columns.
- The `init` function expects standard chromosome naming (e.g., "chr1" or "1"); ensure consistency between mutation and CNA data.
- Use `analyze_peaks` to compare different purity/ploidy solutions; a "passed" QC indicates the VAF peaks align with the theoretical expectations for the given purity.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)