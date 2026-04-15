---
name: bioconductor-multiwgcna
description: This tool analyzes condition-specific gene co-expression networks across multiple biological variables using an extension of the WGCNA framework. Use when user asks to construct combined and sub-networks, compare module preservation across conditions, or perform differential module expression analysis for complex experimental designs.
homepage: https://bioconductor.org/packages/release/bioc/html/multiWGCNA.html
---

# bioconductor-multiwgcna

name: bioconductor-multiwgcna
description: Expert guidance for the multiWGCNA R package to analyze condition-specific gene co-expression networks across multiple biological variables. Use this skill when performing WGCNA-based analysis on datasets with two categorical traits (e.g., Disease vs. Control and different Brain Regions) to identify differentially expressed or differentially co-expressed modules.

# bioconductor-multiwgcna

## Overview
The `multiWGCNA` package extends the Weighted Gene Co-expression Network Analysis (WGCNA) framework for complex experimental designs involving two biological variables. It automates the construction of "combined" networks (all samples) and "sub-networks" (condition-specific), allowing for systematic comparison of module preservation, overlap, and differential expression across conditions.

## Core Workflow

### 1. Data Preparation
Input data should be a `SummarizedExperiment` object or a data frame (genes as rows, samples as columns). A `sampleTable` is required where the first column is "Sample" and subsequent columns represent the two biological traits.

```R
library(multiWGCNA)
# conditions1 and conditions2 should contain unique values of the two traits
conditions1 <- unique(sampleTable$Disease)
conditions2 <- unique(sampleTable$Region)
```

### 2. Network Construction
The `constructNetworks` function builds the combined network and all possible sub-networks based on the provided conditions.

```R
networks <- constructNetworks(se_object, sampleTable, conditions1, conditions2,
                             networkType = "signed", 
                             power = 12, 
                             minModuleSize = 100,
                             mergeCutHeight = 0.1)
```

### 3. Module Comparison and Overlap
Compare modules across different network constructions using hypergeometric overlap tests.

```R
results <- list()
results$overlaps <- iterate(networks, overlapComparisons, plot = FALSE)

# Identify reciprocal best matches between two conditions
matches <- bidirectionalBestMatches(results$overlaps$EAE_vs_WT)
```

### 4. Differential Module Expression (DME)
Test for associations between module eigengenes (ME) and traits using ANOVA or PERMANOVA.

```R
results$diffModExp <- runDME(networks[["combined"]], 
                             sampleTable, 
                             refCondition = "Region", 
                             testCondition = "Disease")

# Visualize expression of a specific module
diffModuleExpression(networks[["combined"]],
                     geneList = topNGenes(networks[["combined"]], "combined_013"),
                     design = sampleTable,
                     test = "ANOVA")
```

### 5. Visualization
`multiWGCNA` provides specialized plots to visualize how modules relate across the three levels of analysis (Combined -> Trait 1 -> Trait 2).

```R
# Draw the multi-level network relationship
drawMultiWGCNAnetwork(networks, results$overlaps, "combined_013", design = sampleTable)

# Plot co-expression lines for top genes in a module
datExpr <- GetDatExpr(networks$combined, genes = topNGenes(networks$EAE, "EAE_015", 20))
coexpressionLineGraph(datExpr, splitBy = 1.5)
```

### 6. Preservation Analysis
Determine if a module identified in one condition (e.g., Disease) is preserved in another (e.g., Control).

```R
# Calculate preservation statistics
results$preservation <- iterate(networks[c("EAE", "WT")], 
                                preservationComparisons, 
                                nPermutations = 10)

# Permutation test for significance of a specific module's preservation
# Note: This is computationally intensive
results$perm_test <- PreservationPermutationTest(networks$combined@datExpr, 
                                                 sampleTable,
                                                 constructNetworksIn = "EAE",
                                                 testPreservationIn = "WT")
```

## Tips for Success
- **Outlier Modules**: Always check for modules driven by a single sample (outliers). `multiWGCNA` identifies these automatically in the network objects.
- **Computational Load**: Network construction and permutation tests are slow. Use `WGCNA::enableWGCNAThreads()` to parallelize where possible.
- **Module Naming**: Modules are prefixed by the network they belong to (e.g., `combined_001`, `EAE_015`).
- **TOM Storage**: Set `saveTOMs = TRUE` in `constructNetworks` if you intend to use `TOMFlowPlot` to visualize gene recruitment between networks.

## Reference documentation
- [Astrocyte Condition-Specific Networks](./references/astrocyte_map_v2.md)
- [Full multiWGCNA Workflow (Autism Dataset)](./references/autism_full_workflow.md)