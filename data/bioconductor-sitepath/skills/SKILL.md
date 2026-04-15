---
name: bioconductor-sitepath
description: The sitePath package identifies evolutionary shifts and fixation sites in viral sequences by analyzing phylogenetic trees and sequence alignments. Use when user asks to identify lineage paths, detect fixation sites, find parallel mutations, or visualize evolutionary shifts in viral sequences.
homepage: https://bioconductor.org/packages/release/bioc/html/sitePath.html
---

# bioconductor-sitepath

## Overview

The `sitePath` package provides a framework for identifying evolutionary shifts in viral sequences. It works by dividing a phylogenetic tree into "lineage paths" and then using a minimal entropy algorithm to detect sites where mutations have become fixed or have occurred in parallel across different lineages. This is particularly useful for identifying adaptive selection and functional maintenance in viral evolution.

## Core Workflow

### 1. Data Import and Initialization
The package requires a rooted phylogenetic tree (S3 `phylo` object) and a multiple sequence alignment (MSA).

```r
library(sitePath)
library(ape)

# Load tree and alignment
tree <- read.tree("path/to/tree.newick")
# addMSA matches sequence names between tree and alignment
paths <- addMSA(tree, msaPath = "path/to/alignment.fasta", msaFormat = "fasta")
```

### 2. Identifying Phylogenetic Pathways
Before finding mutations, you must define the lineages. This is controlled by a threshold parameter.

*   **Assessment:** Use `sneakPeek` to visualize how different thresholds affect the number of identified paths.
*   **Definition:** Use `lineagePath` to set the threshold and resolve lineages.

```r
# Preview thresholds
preassessment <- sneakPeek(paths, makePlot = TRUE)

# Choose a threshold (e.g., 18) based on the stability shown in sneakPeek
paths <- lineagePath(preassessment, threshold = 18)
plot(paths) # Visualize the resolved paths on the tree
```

### 3. Finding Fixation and Parallel Mutations
Once paths are defined, use entropy minimization to find significant sites.

```r
# Step 1: Calculate entropy for all sites
minEntropy <- sitesMinEntropy(paths)

# Step 2: Identify fixation sites
fixations <- fixationSites(minEntropy)
allSitesName(fixations) # List all identified site indices

# Step 3: Identify parallel mutations
# mutMode can be "all", "exact", "pre", or "post"
paraSites <- parallelSites(minEntropy, minSNP = 1, mutMode = "exact")
```

## Visualization and Extraction

### Inspecting Specific Sites
You can visualize the distribution of amino acids/nucleotides for a specific site across the tree.

```r
# Plot a single site's evolution
plotSingleSite(fixations, site = 139)

# Extract specific data for a site
sp_data <- extractSite(fixations, site = 139)
tips <- extractTips(fixations, site = 139) # Get tip names involved in fixation
```

### Global Summaries
```r
# Overview of all fixation transitions
plot(fixations)

# Overview of all parallel mutations
plot(paraSites)
```

## Tips for Success
*   **Rooting:** Ensure the input tree is rooted. `sitePath` assumes the tree is rooted; unrooted trees or trees with extremely long branches can lead to incorrect pathway division.
*   **Multiprocessing:** For large datasets, set `options(list("cl.cores" = N))` where N is the number of CPU cores to speed up `addMSA`.
*   **Threshold Selection:** The "stable" region in the `sneakPeek` plot (where the number of paths doesn't change much as the threshold varies) is usually the best choice for `lineagePath`.
*   **SNP Prediction:** Use `SNPsites(paths)` to identify potential sites that might undergo fixation in the future.

## Reference documentation
- [Use sitePath to find fixation and parallel sites](./references/sitePath.md)
- [sitePath Vignette Source](./references/sitePath.Rmd)