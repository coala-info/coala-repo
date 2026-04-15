---
name: bioconductor-ppidata
description: This package retrieves and transforms protein-protein interaction data from the IntAct repository into structured R formats. Use when user asks to collect IntAct experiment data, create bait-prey lists, or generate adjacency matrices and graph objects for network analysis.
homepage: https://bioconductor.org/packages/3.6/data/experiment/html/ppiData.html
---

# bioconductor-ppidata

name: bioconductor-ppidata
description: A data package for protein-protein interaction (PPI) data from the IntAct repository. Use this skill to collect, parse, and transform empirical PPI data (Yeast 2-Hybrid and AP-MS) into R-friendly formats like adjacency matrices and graph objects.

# bioconductor-ppidata

## Overview

The `ppiData` package provides tools to interact with protein-protein interaction (PPI) data stored in the IntAct repository. It allows users to retrieve data for specific experiments using IntAct Accession (AC) codes and convert that data into structured R objects. This is particularly useful for analyzing Yeast 2-Hybrid (Y2H) systems and Affinity Purification - Mass Spectrometry (AP-MS) data.

## Core Workflow

### 1. Collecting Data from IntAct
Use `collectIntactPPIData` to retrieve data for specific experiments. You must provide the IntAct AC codes (e.g., "EBI-531419").

```r
library(ppiData)

# Example AC codes for awasthi-2001-1, cagney-2001-1, and zhao-2005-2
ac_codes <- c("EBI-531419", "EBI-698096", "EBI-762635")
dataList <- collectIntactPPIData(ac_codes)

# Explore the returned list
names(dataList) 
# Returns: "allBaits", "allPreys", "baitsSystematic", "preysSystematic", "indexSetAll", "shortLabel"
```

### 2. Creating a Sparse Matrix Representation (BPList)
The raw data is often difficult to manipulate. Convert it into a "Bait-Prey List" (a sparse matrix representation) using `createBPList`.

```r
bpList <- createBPList(
    dataList[["indexSetAll"]], 
    dataList[["baitsSystematic"]], 
    dataList[["preysSystematic"]]
)

# Access a specific experiment's interactions
# bpList$experiment_name$bait_protein returns a vector of detected preys
```

### 3. Generating Adjacency Matrices
To perform statistical tests or mathematical modeling, convert the `bpList` into an adjacency matrix using `bpMatrix` (from the `ppiStats` package, often used in conjunction).

```r
# Example: Create a binary, unweighted adjacency matrix
bpMats <- lapply(bpList, function(x) {
    bpMatrix(x, 
             symMat = FALSE, 
             homodimer = FALSE, 
             baitAsPrey = FALSE, 
             unWeighted = TRUE)
})
```

**Matrix Parameters:**
- `homodimer`: Set `TRUE` to include self-interactions.
- `unWeighted`: Set `TRUE` for binary (0/1) presence/absence.
- `onlyRecip`: Set `TRUE` to only include interactions where both proteins acted as bait and prey for each other.
- `baitsOnly`: Set `TRUE` to restrict the matrix to the bait population only.

### 4. Creating Graph Objects
Convert adjacency matrices into `graphNEL` objects for network analysis using `genBPGraph`.

```r
# Ensure symMat = TRUE in bpMatrix for graph generation
bpGraphs <- lapply(bpMats, function(x) {
    genBPGraph(x, directed = TRUE, bp = FALSE)
})
```

## Key Terminology
- **Viable Bait**: A protein used as a bait that detected at least one prey in the experiment.
- **Viable Prey**: A protein detected as a prey at least once in the experiment.
- **AC Codes**: Unique identifiers used by IntAct (e.g., "EBI-XXXXXX").

## Reference documentation
- [ppiData](./references/ppiData.md)