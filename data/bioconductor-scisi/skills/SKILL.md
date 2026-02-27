---
name: bioconductor-scisi
description: This package integrates protein complex data from multiple databases into a unified in silico interactome represented as a bipartite graph. Use when user asks to parse GO or MIPS databases for complexes, resolve redundancies between protein datasets, or merge incidence matrices into a single interactome.
homepage: https://bioconductor.org/packages/3.6/bioc/html/ScISI.html
---


# bioconductor-scisi

## Overview

The `ScISI` package provides tools to integrate multiple sources of protein complex data into a single "In Silico Interactome" (ISI). It allows users to parse the Gene Ontology (GO) and MIPS databases, incorporate experimental AP-MS data, and resolve redundancies (equal complexes or sub-complexes) to create a clean bipartite graph representation where rows are proteins and columns are complexes.

## Core Workflow

### 1. Obtaining Information from Databases

To build an interactome, first extract complex information from GO and MIPS.

```R
library(ScISI)

# Parse GO Cellular Component for complexes
# eCode filters by evidence codes (e.g., IEA, NAS)
go_list = getGOInfo(wantDefault = TRUE, wantAllComplexes = TRUE)
goM = list2Matrix(go_list)

# Parse MIPS database
mips_list = getMipsInfo(wantDefault = TRUE, wantSubComplexes = TRUE)
mipsM = list2Matrix(mips_list)
```

### 2. Comparing and Resolving Redundancy

Before merging, identify overlapping or identical complexes to avoid inflation of the interactome.

```R
# Compare MIPS against GO
comp = runCompareComplex(mipsM, goM)

# Access comparison results
comp$equal        # List of identical complexes
comp$toBeRm       # Character vector of redundant complex IDs
comp$subcomplex   # List of complexes contained within others
comp$toBeRmSubC   # IDs of sub-complexes for optional removal
comp$JC           # Jaccard Coefficients matrix
```

### 3. Building the Interactome

Merge the incidence matrices while removing the redundancies identified in the previous step.

```R
# Merge two bipartite matrices
ISI = mergeBGMat(mipsM, goM, toBeRm = comp$toBeRm)

# The resulting matrix ISI:
# Rows: Union of all proteins (systematic gene names)
# Cols: Union of unique protein complexes
```

### 4. Refining and Exporting Data

You can create specialized objects to browse complex descriptions or generate HTML reports.

```R
# Create metadata dataframes
goDF = createGODataFrame(go_list, goM)

# Instantiate yeastData object for metadata access
goOb = createYeastDataObj(goDF)

# Retrieve specific info
Desc(goOb, "GO:0005830")
getURL(goOb, "GO:0005830")

# Remove specific unwanted complexes manually
ISI_refined = unWantedComp(ISI, unwantedComplex = c("GO:0000262", "GO:0000228"))
```

## Key Functions

- `getGOInfo` / `getMipsInfo`: Scrapers that use regex (e.g., "complex", "some", "ase") to find complexes in databases.
- `list2Matrix`: Converts the hyper-graph list format into a {0,1} bipartite incidence matrix.
- `runCompareComplex`: The engine for calculating Jaccard similarities and identifying subset/superset relationships.
- `mergeBGMat`: Combines two matrices into one, handling row/column alignment and filtering.
- `ScISI2html`: Generates an interactive HTML summary of the complexes with external database links.

## Reference documentation

- [Creating In Silico Interactomes](./references/vignette.md)