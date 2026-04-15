---
name: bioconductor-meshsim
description: This tool calculates semantic similarity between MeSH terms, tree nodes, and MEDLINE documents using path-based and information content-based measures. Use when user asks to calculate similarity between PubMed articles, compare MeSH headings or tree numbers, and retrieve hierarchical information from the MeSH tree.
homepage: https://bioconductor.org/packages/3.5/bioc/html/MeSHSim.html
---

# bioconductor-meshsim

name: bioconductor-meshsim
description: Calculate semantic similarity between MeSH (Medical Subject Headings) terms, nodes, and MEDLINE documents. Use this skill when you need to perform biomedical text mining tasks such as measuring the relatedness of PubMed articles (PMIDs), comparing MeSH headings, or retrieving hierarchical information from the MeSH tree.

## Overview

The `MeSHSim` package provides tools for semantic similarity calculation using both path-based and Information Content (IC)-based measures. It supports two frameworks: **node-based** (projecting headings onto the tree structure) and **heading-based** (treating headings as basic elements).

## Core Workflows

### 1. MeSH Node Similarity
Calculate similarity between specific tree numbers (e.g., "B03.440.400").

```r
library(MeSHSim)

# Single pair similarity
nodeSim("B03.440.400.425.340", "B03.440.400.425.117.800", method="SP")

# Similarity matrix for lists
list1 <- c("B03.440.450.425.800.200", "B03.440.450.900.859.225")
list2 <- c("B03.440.400.425.340", "B03.440.400.425.117.800")
mnodeSim(list1, list2, method="Lin")
```

### 2. MeSH Heading Similarity
Compare descriptive terms (e.g., "Lumbosacral Region").

```r
# Compare two headings
headingSim("Lumbosacral Region", "Body Regions", method="WP", frame="node")

# Compare sets of headings (Average Maximum Match)
set1 <- c("Body Regions", "Abdomen")
set2 <- c("Lumbosacral Region", "Body Regions")
headingSetSim(set1, set2, method="JC")
```

### 3. MEDLINE Document Similarity
Compare PubMed articles directly using their PMIDs.

```r
# Similarity between two PMIDs
docSim("1111113", "1111111", method="LC", major=FALSE)

# Use major=TRUE to restrict calculation to major MeSH headings only
docSim("1111113", "1111111", method="Resnik", major=TRUE)
```

### 4. Information Retrieval
Retrieve hierarchy or document metadata.

```r
# Get MeSH heading hierarchy
termInfo("Rhode Island", brief=TRUE)

# Get document info (Title, Abstract, MeSH Headings)
docInfo("1111111", verbose=TRUE)
```

## Parameters and Methods

### Similarity Methods (`method`)
*   **Path-based:** `"SP"` (Shortest Path - default), `"WL"` (Weighted Links), `"WP"` (Wu and Palmer), `"LC"` (Leacock and Chodorow), `"Li"` (Li et al.).
*   **IC-based:** `"Lord"`, `"Resnik"`, `"Lin"`, `"JC"` (Jiang and Conrath).

### Frameworks (`frame`)
*   `"node"`: Node-based framework (default). Projects headings to tree nodes.
*   `"heading"`: Heading-based framework. Treats headings as basic elements.

## Tips
*   **Dependencies:** Functions like `docInfo` and `docSim` require `RCurl` and `XML` to fetch data from PubMed.
*   **Normalization:** Resnik similarity is automatically normalized by the maximum IC in the hierarchy to keep values between 0 and 1.
*   **Data:** The package includes pre-calculated datasets; the `env` parameter usually does not need to be set manually.

## Reference documentation
- [MeSHSim](./references/MeSHSim.md)