---
name: r-jetset
description: Skill for using the CRAN R package r-jetset.
homepage: https://cran.r-project.org/web/packages/jetset/index.html
---

# r-jetset

name: r-jetset
description: One-to-one gene-to-probe set mapping for Affymetrix expression microarrays. Use this skill to identify the optimal probe set for a specific Entrez Gene ID or gene symbol across common Affymetrix platforms including hgu133a, hgu133b, hgu133plus2, and u133x3p.

# r-jetset

## Overview
The `jetset` package provides a curated mapping between genes and Affymetrix probe sets. It addresses the "many-to-one" problem where multiple probe sets map to the same gene by scoring each probe set based on specificity, coverage, and robustness. This allows researchers to select the single "best" probe set to represent a gene in downstream analysis.

## Installation
To install the package from CRAN:
```R
install.packages("jetset")
```

## Usage

### Core Function: jetset()
The primary interface is the `jetset` function. It returns the best probe set for a given gene identifier on a specific chip platform.

**Arguments:**
- `chip`: The Affymetrix chip name (e.g., "hgu133plus2", "hgu133a", "hgu133b", "u133x3p").
- `entrez`: Entrez Gene ID (optional).
- `symbol`: Gene Symbol (optional).
- `alias`: Gene Alias (optional).

### Examples

#### Retrieve the best probe set by Gene Symbol
```R
library(jetset)
# Find the best probe set for the gene "EGFR" on the HGU133 Plus 2.0 chip
best_probe <- jetset(chip = "hgu133plus2", symbol = "EGFR")
print(best_probe)
```

#### Retrieve the best probe set by Entrez ID
```R
# Find the best probe set for Entrez ID 1956
best_probe_id <- jetset(chip = "hgu133plus2", entrez = "1956")
```

### Scoring Details
The package pre-calculates scores for every probe set. You can view the underlying data for a specific chip by calling the data object directly (e.g., `scores.hgu133plus2`).

The scores are based on:
1. **Specificity**: How uniquely the probes map to the target transcript.
2. **Coverage**: How well the probes cover the known transcripts of the gene.
3. **Robustness**: The degradation resistance of the probes.

### Supported Platforms
The package currently supports the following Affymetrix platforms:
- `hgu133a`
- `hgu133b`
- `hgu133plus2`
- `u133x3p`

## Tips
- If you provide multiple identifiers (e.g., both `symbol` and `entrez`), the function will prioritize them in the order: `entrez`, `symbol`, `alias`.
- Use this package during the preprocessing stage of microarray analysis to collapse probe-level data to gene-level data without simply averaging (which can introduce noise from poorly performing probe sets).

## Reference documentation
- [Home Page](./references/home_page.md)