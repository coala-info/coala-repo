---
name: r-crbhits
description: R package crbhits (documentation from project home).
homepage: https://cran.r-project.org/web/packages/crbhits/index.html
---

# r-crbhits

## Overview
The `crbhits` package is an R reimplementation of the Conditional Reciprocal Best Hit (CRBH) algorithm. It extends traditional Reciprocal Best Hit (RBH) methods by using a fitting model to identify orthologous pairs that might otherwise fall below stringent alignment thresholds. It provides a complete pipeline from sequence comparison to synonymous (Ks) and non-synonymous (Ka) substitution rate calculations.

## Installation
To install the package and its mandatory external dependencies (like LAST), use the following commands in R:

```R
# Install from CRAN
install.packages("crbhits")

# Install development version and build external tools
devtools::install_github("kullrich/CRBHits")
CRBHits::make_last()
CRBHits::make_dagchainer()
```

## Core Workflow

### 1. Calculating CRBHit Pairs
The primary function `cds2rbh()` handles the sequence search and the CRBH fitting.

```R
library(CRBHits)

# Load example data (Coding Sequences)
data("ath", package="CRBHits")
data("aly", package="CRBHits")

# Calculate CRBH pairs
# plotCurve=TRUE visualizes the evalue-based fitting model
crbh_results <- cds2rbh(
    cds1 = ath,
    cds2 = aly,
    plotCurve = TRUE)

summary(crbh_results)
```

### 2. Ka/Ks Calculation
Once ortholog pairs are identified, use `rbh2kaks()` to perform codon alignments and estimate substitution rates.

```R
# Calculate Ka/Ks using the 'Li' model (or 'YN', 'NG86', etc.)
# Supports parallelization via the threads argument
kaks_results <- rbh2kaks(
    rbhpairs = crbh_results,
    cds1 = ath,
    cds2 = aly,
    model = "Li",
    threads = 1)

head(kaks_results)
```

### 3. Visualization
The package includes built-in plotting functions for evolutionary analysis.

```R
# Plot Ka/Ks distribution
plot_kaks(kaks_results)
```

## Advanced Features
*   **Search Tools**: While `last` is the default, `cds2rbh` supports `mmseqs2`, `diamond`, and `lambda3` via the `searchtool` parameter.
*   **Isoform Handling**: Use `longest_isoform()` to filter input sequences before running the CRBH pipeline to avoid redundant hits.
*   **Synteny**: Integrate with DAGchainer using `rbh2dagchainer()` to identify syntenic blocks from the hit pairs.
*   **Tandem Duplicates**: Identify tandemly repeated genes using `rbh2tandem()`.

## Tips for Success
*   **Input Formats**: Ensure input sequences are `DNAStringSet` (for CDS) or `AAStringSet` (for proteins) objects from the `Biostrings` package.
*   **External Paths**: If tools like LAST or MMseqs2 are installed via Conda, provide the path to the binary directory using the `lastpath` or `mmseqs2path` arguments.
*   **Memory Management**: For large genomes, DIAMOND (`searchtool="diamond"`) is often faster and more memory-efficient than LAST.

## Reference documentation
- [CODE_OF_CONDUCT.md](./references/CODE_OF_CONDUCT.md)
- [LICENSE.md](./references/LICENSE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [paper.md](./references/paper.md)
- [wiki.md](./references/wiki.md)