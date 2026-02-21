---
name: r-minems2
description: R package minems2 (documentation from project home).
homepage: https://cran.r-project.org/web/packages/minems2/index.html
---

# r-minems2

name: r-minems2
description: Annotation of spectral libraries with exact fragmentation patterns using fragmentation graphs and frequent-subgraph mining. Use when Claude needs to: (1) Extract shared m/z differences from MS/MS spectra, (2) Identify frequent fragmentation patterns across spectral subsets, (3) Compute molecular formulas for m/z differences, or (4) Couple fragmentation analysis with GNPS molecular networking.

# r-minems2

## Overview
The `minems2` package implements an innovative strategy to extract frequent fragmentation patterns from MS/MS spectra. Unlike probabilistic approaches, it uses a deterministic graph-based representation where ion peaks are nodes and m/z differences are edges. This allows for the identification of exact fragmentation graphs that are shared across multiple spectra, facilitating the chemical interpretation of metabolites and substructures.

Key features:
- Representation of spectra as fragmentation graphs of m/z differences.
- Efficient frequent-subgraph mining to extract patterns.
- Computation of candidate molecular formulas for m/z differences (typically below 200 Da).
- Integration with GNPS molecular networking to focus on patterns explaining specific network components.

## Installation
To install the package, use the following command in R:
```R
install.packages("r-minems2")
```
*Note: If the package is not yet on CRAN, it can be installed via devtools:*
```R
# devtools::install_github("adelabriere/mineMS2")
```

## Core Workflow

### 1. Pattern Mining
The primary workflow involves converting MS/MS spectra into fragmentation graphs. A pattern is defined as a graph where all m/z differences are present in every spectrum containing that pattern.
- **Frequent Patterns**: Patterns must be detected in at least two spectra to be considered frequent.
- **m/z Differences**: These include neutral losses and differences between ions from distinct fragmentation paths.

### 2. Chemical Interpretation
For each m/z difference identified in a pattern, `minems2` can compute candidate molecular formulas. This helps researchers assign chemical meaning to the edges of the fragmentation graph.

### 3. GNPS Coupling
`minems2` can be coupled with GNPS (Global Natural Products Social Molecular Networking). This allows users to:
- Map identified patterns onto molecular networks.
- Identify which patterns best explain specific clusters or components within the network.
- Prioritize patterns that are biologically or chemically relevant to the study.

## Usage Tips
- **Data Input**: The package typically works with spectral libraries or collections of MS/MS spectra.
- **Pattern Specificity**: Because patterns are exact graphs, they are often more interpretable than probabilistic "topics" found in other tools like MS2LDA.
- **Formula Constraints**: When computing molecular formulas for m/z differences, focus on differences below 200 Da for the most reliable results.

## Reference documentation
- [README](./references/README.md)
- [Articles](./references/articles.md)
- [Home Page](./references/home_page.md)