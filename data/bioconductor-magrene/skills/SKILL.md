---
name: bioconductor-magrene
description: The magrene package identifies and analyzes network motifs to quantify how duplicated genes are integrated into regulatory and interaction networks. Use when user asks to find motifs like bifans or deltas, perform significance testing with degree-preserving null networks, or calculate Sorensen-Dice similarity for paralogous pairs.
homepage: https://bioconductor.org/packages/release/bioc/html/magrene.html
---

# bioconductor-magrene

## Overview
The `magrene` package is designed to identify and analyze network motifs in the context of gene duplication. It allows researchers to quantify how duplicated genes (paralogs) are integrated into regulatory and interaction networks. The package provides tools to find specific topological structures, assess their statistical significance using degree-preserving simulated networks, and measure the Sorensen-Dice similarity of interaction partners between paralogous pairs.

## Installation and Setup
Install the package using `BiocManager`:
```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("magrene")
library(magrene)
```

## Data Structures
The package expects networks as edge lists (data frames with at least two columns representing interacting nodes) and paralogs as a two-column data frame.
- **GRN/PPI Edge List:** Columns for `Node1` and `Node2`.
- **Paralogs:** Columns for `duplicate1` and `duplicate2`.

## Finding Motifs
Motifs are identified using specific `find_*` functions. Each returns a character vector of identified motifs.

| Motif Type | Function | Description |
|:---|:---|:---|
| **PPI V** | `find_ppi_v(ppi, paralogs)` | Paralogs sharing a common PPI partner. |
| **V** | `find_v(grn, paralogs)` | Paralogous regulators targeting the same gene. |
| **Lambda** | `find_lambda(grn, paralogs)` | Single regulator targeting two paralogous genes. |
| **Delta** | `find_delta(ppi, lambda_vec)` | Lambda motif where the two targets also interact (PPI). |
| **Bifan** | `find_bifan(paralogs, lambda_vec)` | Two paralogous regulators targeting the same two paralogous targets. |

*Tip: For `find_delta` and `find_bifan`, passing a pre-computed `lambda_vec` significantly improves performance.*

## Significance Testing
To determine if motif counts are higher than expected by chance, generate a null distribution using degree-preserving permutations.

1. **Generate Nulls:**
   ```r
   # n should be >= 1000 for publication-quality results
   null_dist <- generate_nulls(grn, paralogs, ppi, n = 100)
   ```
2. **Calculate Z-scores:**
   ```r
   observed <- list(
     lambda = length(lambda_motifs),
     delta = length(delta_motifs),
     V = length(v_motifs),
     PPI_V = length(ppi_v_motifs),
     bifan = length(bifan_motifs)
   )
   z_scores <- calculate_Z(observed, null_dist)
   ```

## Interaction Similarity
To measure how similar the interaction profiles of paralogous pairs are, use the Sorensen-Dice similarity index:
```r
sim_scores <- sd_similarity(ppi_or_grn, paralogs)
# Returns a data frame with duplicate pairs and their 'sorensen_dice' score (0 to 1)
```

## Reference documentation
- [Introduction to magrene](./references/magrene.md)