---
name: bioconductor-metapone
description: This tool conducts metabolic pathway enrichment analysis from untargeted metabolomics data using weighted schemes to handle matching uncertainties. Use when user asks to perform pathway testing on untargeted metabolomics data, combine positive and negative ionization modes, or resolve one-to-many metabolite matching problems using weighted penalties.
homepage: https://bioconductor.org/packages/release/bioc/html/metapone.html
---

# bioconductor-metapone

name: bioconductor-metapone
description: Conducts metabolic pathway testing from untargeted metabolomics data. Use this skill when you need to perform pathway enrichment analysis that combines positive and negative ionization modes, accounts for metabolite-feature matching uncertainties using weighted schemes, or utilizes the integrated SMPDB and Mummichog database.

## Overview

The `metapone` package provides a robust framework for pathway testing in untargeted metabolomics. It addresses the "one-to-many" matching problem (where one m/z feature matches multiple metabolites) by applying a weighted penalty system. It is particularly effective for studies where both positive and negative mode data are available, as it can analyze them simultaneously to increase statistical power.

## Typical Workflow

### 1. Data Preparation
Input data must be a matrix or data frame containing at least three columns: `mz` (mass-to-charge ratio), `time` (retention time), and `p-value` (from feature-level tests like case-control or regression).

```r
library(metapone)
data(pos) # Example positive mode data
data(neg) # Example negative mode data

# Combine into lists for the metapone function
dat <- list(pos, neg)
type <- list("pos", "neg")
```

### 2. Defining Adducts
Specify which adduct ions are allowed for matching.

```r
pos.adductlist = c("M+H", "M+NH4", "M+Na", "M+ACN+H", "M+ACN+Na", "M+2ACN+H", "2M+H", "2M+Na", "2M+ACN+H")
neg.adductlist = c("M-H", "M-2H", "M-2H+Na", "M-2H+K", "M-2H+NH4", "M-H2O-H", "M-H+Cl", "M+Cl", "M+2Cl")
```

### 3. Running Pathway Testing
The `metapone` function is the primary interface. Key parameters include:
- `fractional.count.power`: Power term (p) to tune the penalty for multiple-mapped features (weight = (1/m)^p).
- `max.match.count`: Caps the number of matches (m) to limit the penalty.
- `use.fgsea`: If `TRUE`, performs GSEA-type testing; if `FALSE`, uses permutation.
- `use.meta`: If `TRUE` (and `use.fgsea=TRUE`), testing is metabolite-based; otherwise, feature-based.

```r
# Permutation test example
r <- metapone(dat, type, pa, 
              hmdbCompMZ = hmdbCompMZ, 
              pos.adductlist = pos.adductlist, 
              neg.adductlist = neg.adductlist, 
              p.threshold = 0.05, 
              n.permu = 200, 
              fractional.count.power = 0.5, 
              max.match.count = 10, 
              use.fgsea = FALSE)
```

### 4. Interpreting Results
Use helper functions to extract and visualize results:
- `ptable(r)`: Returns the pathway result table (p-values, significant metabolites, etc.).
- `ftable(r)`: Returns the mapped feature tables, showing fractional counts.
- `bbplot1d(r@test.result, threshold)`: 1D visualization of results.
- `bbplot2d(r@test.result, threshold)`: 2D visualization of results.

```r
# View significant pathways
selection <- which(ptable(r)[,1] < 0.05)
ptable(r)[selection, ]

# Plot results
bbplot1d(r@test.result, 0.05)
```

## Tips and Best Practices
- **Penalty Tuning**: Set `fractional.count.power = 0` to disable the multiple-matching penalty. Increase the value to penalize features that match many metabolites more heavily.
- **Database**: The package uses a built-in cleaned database (`pa`) combining SMPDB and Mummichog. Ensure your feature IDs or m/z values are compatible with HMDB-based identification.
- **Mode Integration**: While `metapone` excels at dual-mode integration, it works perfectly well with a single ion mode (just provide a list of length 1 to `dat` and `type`).

## Reference documentation
- [METAbolic pathway testing combining POsitive and NEgative mode data (metapone)](./references/metapone.md)