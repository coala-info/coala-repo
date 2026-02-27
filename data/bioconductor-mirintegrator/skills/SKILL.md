---
name: bioconductor-mirintegrator
description: This tool integrates microRNA-target interactions into signaling pathways for joint pathway analysis. Use when user asks to augment signaling pathways with miRNA interactions, visualize augmented pathway networks, or perform integrated pathway analysis using mRNA and miRNA expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/mirIntegrator.html
---


# bioconductor-mirintegrator

name: bioconductor-mirintegrator
description: Integrating microRNAs (miRNAs) into signaling pathways for joint pathway analysis. Use this skill when you need to augment standard signaling pathways (KEGG, Reactome) with miRNA-target interactions, visualize augmented pathways, or perform integrated pathway analysis using both mRNA and miRNA expression data.

## Overview

The `mirIntegrator` package facilitates the integration of miRNA-target interactions into existing signaling pathways. This allows researchers to perform pathway analysis that accounts for the regulatory role of miRNAs on their target genes. The package supports augmenting `graphNEL` objects, visualizing the resulting networks, and preparing data for topology-based pathway analysis (specifically compatible with `ROntoTools`).

## Core Workflow

### 1. Data Preparation
To integrate miRNAs, you need two primary components:
- **Pathways**: A list of `graphNEL` objects (e.g., from KEGG or Reactome).
- **miRNA-Target Interactions**: A data frame with columns `miRNA` and `Target.ID`. 

*Note: Ensure the `Target.ID` uses the same nomenclature (e.g., Entrez ID) as the nodes in your pathway graphs.*

```R
library(mirIntegrator)
data(kegg_pathways) # Example KEGG pathways
data(mirTarBase)    # Example miRNA-target interactions
```

### 2. Integrating miRNAs
Use `integrate_mir` to add miRNA nodes and their repressive interactions to the pathways.

```R
# Augment a subset of pathways
augmented_pathways <- integrate_mir(kegg_pathways[1:5], mirTarBase)

# Access a specific augmented pathway
pathway_id <- "path:hsa04122"
g <- augmented_pathways[[pathway_id]]
```

### 3. Visualization
The package provides tools to visualize the changes in pathway structure.

```R
# Plot a single augmented pathway showing genes and miRNAs
data(names_pathways)
plot_augmented_pathway(kegg_pathways[[pathway_id]], 
                       augmented_pathways[[pathway_id]], 
                       names_pathways[pathway_id])

# Plot the change in the number of nodes across all pathways
plot_change(kegg_pathways, augmented_pathways, names_pathways)

# Export multiple plots to a PDF
pathways2pdf(kegg_pathways[1:3], augmented_pathways[1:3], 
             names_pathways[1:3], "augmented_plots.pdf")
```

### 4. Integrated Pathway Analysis
The primary use case is performing Impact Analysis using both mRNA and miRNA expression levels. This is typically done in conjunction with the `ROntoTools` package.

```R
library(ROntoTools)

# Prepare combined fold change vector
# Both mRNA and miRNA names must match the node IDs in augmented_pathways
combined_fc <- c(lfoldChangeMRNA, lfoldChangeMiRNA)

# Run Pathway Analysis (pe)
# nboot should be >= 2000 for publication-quality results
peRes <- pe(x = combined_fc, 
            graphs = augmented_pathways, 
            nboot = 200, 
            verbose = FALSE)

# Summarize results
summ <- Summary(peRes)
```

## Tips and Best Practices
- **ID Consistency**: The most common error is a mismatch between the `Target.ID` in the miRNA data and the node names in the pathway graphs. Always verify `nodes(pathway[[1]])` against your interaction table.
- **Negative Interactions**: `mirIntegrator` automatically models miRNA-target interactions as repressions (negative edges).
- **Memory Management**: Augmenting the entire KEGG database can be memory-intensive. Process only the pathways relevant to your study if resources are limited.

## Reference documentation
- [mirIntegrator](./references/mirIntegrator.md)