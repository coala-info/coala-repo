---
name: bioconductor-moda
description: MODA performs module differential analysis to identify and compare gene co-expression modules across multiple biological conditions. Use when user asks to identify gene modules, compare co-expression networks, or find condition-specific and conserved functional units.
homepage: https://bioconductor.org/packages/release/bioc/html/MODA.html
---


# bioconductor-moda

name: bioconductor-moda
description: Module Differential Analysis (MODA) for weighted gene co-expression networks. Use this skill to identify, compare, and analyze gene modules across multiple biological conditions or networks to find conserved and condition-specific functional units.

# bioconductor-moda

## Overview
MODA (MOdule Differential Analysis) is an R package designed to identify and compare gene co-expression modules across multiple networks. Unlike standard differential expression which looks at individual genes, MODA focuses on higher-level functional modules. It supports various module detection methods including hierarchical clustering, community detection (Louvain, Spectral), and optimization-based approaches (AMOUNTAIN). It is particularly useful for identifying modules that are specific to a certain condition (e.g., a specific stress or disease state) versus those that are conserved across all conditions.

## Core Workflow

### 1. Data Preparation
MODA requires gene expression matrices where rows are genes and columns are samples/replicates.

```r
library(MODA)
data(synthetic) # Example data: datExpr1, datExpr2
ResultFolder = 'MODA_Results'
indicator1 = 'ConditionA'
indicator2 = 'ConditionB'
```

### 2. Module Partitioning
You can partition the network into modules using several different algorithms.

**Hierarchical Clustering (WGCNA-style):**
Uses density or modularity to find the optimal dendrogram cutting height.
```r
intModules1 <- WeightedModulePartitionHierarchical(datExpr1, ResultFolder, 
                                                 indicator1, 'Density')
```

**Community Detection (Louvain):**
Better for capturing network topology and community structures.
```r
GeneNames <- colnames(datExpr1)
intModules <- WeightedModulePartitionLouvain(datExpr1, ResultFolder, 
                                            indicator1, GeneNames)
```

**Optimization-based (AMOUNTAIN):**
Identifies the most significant modules by weight using continuous optimization.
```r
WeightedModulePartitionAmoutain(datExpr1, Nmodule=5, ResultFolder, 
                                indicator1, GeneNames, maxsize=100, minsize=50)
```

### 3. Network Comparison
After identifying modules in individual networks, compare them to find conserved and condition-specific modules.

```r
specificTheta = 0.1  # Jaccard threshold for condition-specific
conservedTheta = 0.1 # Jaccard threshold for conserved

CompareAllNets(ResultFolder, intModules1, indicator1, intModules2, 
               indicator2, specificTheta, conservedTheta)
```

## Key Functions
- `WeightedModulePartitionHierarchical`: Partitions a weighted network using hierarchical clustering with automated parameter selection.
- `WeightedModulePartitionLouvain`: Uses the Louvain algorithm for modularity-based community detection.
- `WeightedModulePartitionSpectral`: Applies spectral clustering to find gene communities.
- `WeightedModulePartitionAmoutain`: Extracts active modules one-by-one using the AMOUNTAIN optimization approach.
- `CompareAllNets`: The primary function for differential module analysis; calculates overlap statistics (Jaccard index) between modules of different networks.

## Tips for Analysis
- **Result Storage**: MODA automatically creates subdirectories in your `ResultFolder` named after your indicators. It saves module memberships as text files and diagnostic plots (like partition density) as PDFs.
- **Condition-Specific Networks**: If you lack sufficient replicates for a specific condition, use the "sample-saving" approach: construct a background network from all samples, and a condition-specific network by subtracting samples of that condition.
- **Biological Interpretation**: Once modules are identified (especially condition-specific ones), export the gene lists for Gene Set Enrichment Analysis (GSEA) using tools like DAVID or Enrichr.

## Reference documentation
- [Usage of MODA](./references/MODA.md)