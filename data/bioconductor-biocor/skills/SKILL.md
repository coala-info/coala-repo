---
name: bioconductor-biocor
description: "BioCor calculates functional similarity between genes, pathways, and clusters based on shared pathway membership. Use when user asks to calculate biological correlation, compare gene clusters using Dice similarity, or integrate functional similarities with gene co-expression network analysis."
homepage: https://bioconductor.org/packages/release/bioc/html/BioCor.html
---


# bioconductor-biocor

name: bioconductor-biocor
description: Functional similarity analysis for genes, pathways, and clusters using pathway/gene set information. Use when calculating biological correlation (BioCor) based on shared pathway membership, integrating functional similarities with WGCNA, or comparing gene clusters using Dice similarity.

# bioconductor-biocor

## Overview
BioCor calculates functional similarities between pathways, gene sets, genes, and clusters of genes. Unlike semantic similarity packages that rely on Gene Ontology (GO) structures, BioCor uses pathway membership (e.g., KEGG, Reactome) and the Sørensen-Dice index to quantify how biologically related two entities are based on shared components. It is particularly useful for enhancing gene co-expression network analysis (WGCNA) by incorporating known functional relationships.

## Installation
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BioCor")
```

## Data Preparation
BioCor requires a named list where names are genes (e.g., Entrez IDs) and elements are character vectors of pathways/sets they belong to.

```R
library(BioCor)
library(org.Hs.eg.db)

# Example: Creating a gene-to-pathway list from org.Hs.eg.db
genes2path <- as.list(org.Hs.egPATH)
# Remove genes with no pathway info
genes2path <- genes2path[!is.na(genes2path)]
```

## Core Functions

### Pathway Similarity
Calculate similarity between specific pathways based on gene overlap.
```R
# Similarity between two pathways
pathSim("04120", "03440", genes2path)

# Matrix for multiple pathways
pathways <- c("04120", "03440", "05200")
mpathSim(pathways, genes2path)
```

### Gene Similarity
Calculate similarity between genes based on the pathways they share.
```R
# Compare two genes (using Entrez IDs)
geneSim("672", "675", genes2path, method = "max")

# Matrix for multiple genes
genes <- c("672", "675", "10")
mgeneSim(genes, genes2path, method = "BMA")
```

### Cluster Similarity
Compare groups of genes (clusters) using two distinct strategies:
1.  **By Pathways (`clusterSim`)**: Combines all pathways from each cluster and compares the sets.
2.  **By Genes (`clusterGeneSim`)**: Calculates gene-to-gene similarities first, then aggregates.

```R
cluster1 <- c("672", "675")
cluster2 <- c("100", "10", "1")

# Pathway-based comparison
clusterSim(cluster1, cluster2, genes2path)

# Gene-based comparison (requires two methods: one for pathways, one for genes)
clusterGeneSim(cluster1, cluster2, genes2path, method = c("max", "BMA"))
```

## Advanced Workflows

### Combining Information Sources
Merge pathway data from different databases (e.g., KEGG and Reactome) or combine multiple similarity matrices.
```R
# Merge two pathway lists
combined_info <- combineSources(kegg_list, reactome_list)

# Merge similarity matrices (e.g., Expression correlation + Functional similarity)
sim_list <- list(exp = cor_matrix, func = functional_sim_matrix)
final_sim <- similarities(sim_list, weighted.sum, w = c(0.7, 0.3))
```

### Integration with WGCNA
Use BioCor to create a hybrid adjacency matrix that considers both expression correlation and functional similarity.
```R
# 1. Calculate expression correlation
expr_sim <- WGCNA::cor(expression_data)

# 2. Calculate functional similarity for the same genes
func_sim <- mgeneSim(colnames(expression_data), genes2path)

# 3. Combine and create adjacency
combined <- similarities(list(expr_sim, func_sim), mean, na.rm = TRUE)
adj <- adjacency.fromSimilarity(combined, power = 6)
```

## Tips and Troubleshooting
*   **Method Selection**: "max" is generally recommended for combining pathway scores to find the strongest functional link. "BMA" (Best-Match Average) is standard for gene-level and cluster-level aggregation.
*   **Namespace Conflicts**: BioCor shares function names with `GOSemSim` (e.g., `geneSim`, `mgeneSim`). If both are loaded, use `BioCor::geneSim()` to ensure the correct method is called.
*   **ID Mapping**: Ensure the gene IDs in your pathway list match the IDs used in your experimental data (e.g., all Entrez or all Symbols).
*   **Dice vs Jaccard**: BioCor uses Dice by default. Use `D2J()` to convert a Dice similarity matrix to Jaccard, or `J2D()` for the reverse.

## Reference documentation
- [About BioCor](./references/BioCor_1_basics.md)
- [Advanced usage of BioCor](./references/BioCor_2_advanced.md)