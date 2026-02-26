---
name: bioconductor-gosorensen
description: This tool performs equivalence testing and calculates functional dissimilarity between gene lists based on Gene Ontology enrichment and the Sorensen-Dice index. Use when user asks to calculate functional dissimilarity between gene lists, perform equivalence testing to prove biological similarity, generate irrelevance-threshold dissimilarity matrices, or visualize gene list relationships via dendrograms and MDS biplots.
homepage: https://bioconductor.org/packages/release/bioc/html/goSorensen.html
---


# bioconductor-gosorensen

name: bioconductor-gosorensen
description: Statistical method for comparing gene lists using equivalence tests based on the Sorensen-Dice dissimilarity and Gene Ontology (GO) enrichment. Use this skill when you need to: (1) Calculate functional dissimilarity between gene lists, (2) Perform equivalence testing to prove biological similarity, (3) Generate irrelevance-threshold dissimilarity matrices, or (4) Visualize gene list relationships via dendrograms and MDS biplots.

## Overview

The `goSorensen` package provides an inferential framework to compare gene lists based on their functional profiles in the Gene Ontology. Unlike descriptive methods, it uses equivalence testing to determine if the biological difference between lists is negligible (below a user-defined "irrelevance limit" $d_0$). It supports Biological Process (BP), Cellular Component (CC), and Molecular Function (MF) ontologies across various GO levels.

## Core Workflow

### 1. Setup and Data Preparation
You must provide a gene universe (all genes in the species) and the gene lists (Entrez IDs).

```r
library(goSorensen)
library(org.Hs.eg.db)

# Get the gene universe for the species (e.g., Human)
humanEntrezIDs <- keys(org.Hs.eg.db, keytype = "ENTREZID")

# Example data: a list of character vectors containing Entrez IDs
data("allOncoGeneLists")
```

### 2. Building Enrichment Contingency Tables
Before testing, the package identifies enriched GO terms and builds $2 \times 2$ contingency tables.

```r
# For a specific ontology and level
cont_tabs <- buildEnrichTable(allOncoGeneLists,
                              geneUniverse = humanEntrezIDs,
                              orgPackg = "org.Hs.eg.db",
                              onto = "BP",
                              GOLevel = 4)

# For multiple ontologies and levels (3 to 10)
all_cont_tabs <- allBuildEnrichTable(allOncoGeneLists,
                                     geneUniverse = humanEntrezIDs,
                                     orgPackg = "org.Hs.eg.db",
                                     ontos = c("BP", "CC", "MF"),
                                     GOLevels = 3:10)
```

### 3. Equivalence Testing
Test if the Sorensen-Dice dissimilarity $d_S$ is significantly less than an irrelevance limit $d_0$. Common $d_0$ values are 0.4444 or 0.2857.

```r
# Perform tests on the contingency tables
eq_tests <- equivTestSorensen(cont_tabs, d0 = 0.4444, conf.level = 0.95)

# Access results
getPvalue(eq_tests)
getDissimilarity(eq_tests)
```

### 4. Irrelevance-Threshold Dissimilarity Matrix
This matrix quantifies the smallest equivalence threshold required to declare two lists equivalent, adjusted for multiple testing (default: Holm's method).

```r
# Compute the matrix
diss_matrix <- sorenThreshold(cont_tabs)

# For multiple levels
all_diss_matrices <- allSorenThreshold(all_cont_tabs)
```

### 5. Visualization and Interpretation
Visualize the relationships between gene lists using the dissimilarity matrix.

```r
# Dendrogram
clust <- hclustThreshold(diss_matrix)
plot(clust)

# Multidimensional Scaling (MDS) Biplot
mds <- as.data.frame(cmdscale(diss_matrix, k = 2))
# Plot using ggplot2 to see clusters of functionally similar lists
```

## Key Functions and Parameters

- `enrichedIn`: Identifies enriched GO terms for one or more lists.
- `equivTestSorensen`: Main testing function. Use `boot = TRUE` for bootstrap distribution if joint enrichment is low.
- `upgrade`: Quickly update a test object with new parameters (e.g., different $d_0$ or `conf.level`) without recomputing enrichment.
- `getDissimilarity`, `getPvalue`, `getSE`, `getUpper`: Accessor functions for test results.
- `sorenThreshold`: Generates the inferential dissimilarity matrix.

## Tips for AI Agents
- **Species Annotation**: Always ensure the correct `org.XX.eg.db` package is loaded for the species being analyzed.
- **Efficiency**: If performing multiple operations (testing and matrix generation), build the contingency tables once using `buildEnrichTable` and pass that object to subsequent functions.
- **GO Levels**: Functional similarity is highly dependent on the GO level. Levels 4-6 are often the most informative for Biological Process.
- **Indeterminacy**: `NaN` p-values usually occur when there is zero joint enrichment ($n_{11} = 0$) between two lists.

## Reference documentation
- [Working with the Irrelevance-threshold Matrix of Dissimilarities](./references/Dissimilarities_Matrix.md)
- [An Introduction to the goSorensen R Package](./references/goSorensen_Introduction.md)