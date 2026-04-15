---
name: bioconductor-psmatch
description: The PSMatch package manages and analyzes proteomics identification data by handling peptide-spectrum matches and modeling peptide-protein relationships. Use when user asks to load PSM data from mzid files, filter decoy or rank matches, create adjacency matrices for protein groups, or calculate and visualize MS2 fragment ions.
homepage: https://bioconductor.org/packages/release/bioc/html/PSMatch.html
---

# bioconductor-psmatch

## Overview

The `PSMatch` package is designed for the management and analysis of proteomics identification data. It provides the `PSM` class to store peptide-spectrum matches in a tabular format, tools for rigorous filtering, and advanced modeling of peptide-protein relations using adjacency matrices. It also includes utilities for predicting and visualizing MS2 fragment ions, supporting both fixed and variable modifications.

## Core Workflows

### 1. Handling PSM Data

Load identification data from `mzid` files into a `PSM` object.

```r
library(PSMatch)

# Load data (default parser is "mzR")
f <- msdata::ident(full.names = TRUE, pattern = "TMT")
id <- PSM(f)

# Basic exploration
nrow(id)
names(id)
table(id$isDecoy)

# Reduce PSMs to group multiple matches by spectrum
id_reduced <- reducePSMs(id, id$spectrumID)
```

### 2. Filtering PSMs

Clean the data by removing low-quality or ambiguous matches.

```r
# Individual filters
id <- filterPsmDecoy(id)    # Remove decoy hits
id <- filterPsmRank(id)     # Keep only rank 1 matches
id <- filterPsmShared(id)   # Remove peptides matching multiple proteins

# All-in-one filtering
id <- filterPSMs(PSM(f))
```

### 3. Adjacency Matrices and Protein Groups

Model the relationship between peptides and proteins to understand protein groups.

```r
# Create adjacency matrix (peptides as rows, proteins as columns)
adj <- makeAdjacencyMatrix(id)

# Compute connected components (protein groups)
cc <- ConnectedComponents(adj)

# Explore specific components
# Get a specific adjacency matrix for a group
cx <- connectedComponents(cc, index = 1082)

# Visualize the group (proteins as blue squares, peptides as white circles)
plotAdjacencyMatrix(cx)

# Prioritize complex components for manual inspection
cctab <- prioritiseConnectedComponents(cc)
head(cctab)
```

### 4. MS2 Fragment Ions

Calculate and visualize theoretical fragments for a peptide sequence.

```r
# Calculate fragments with modifications
# Default: fixed_modifications = c(C = 57.02146)
frags <- calculateFragments("SCALITDGR", 
                            variable_modifications = c(T = 79.966))

# Visualization on a Spectra object (requires Spectra package)
# plotSpectraPTM shows matched b and y ions and delta M/Z
plotSpectraPTM(sp[index], 
               fixed_modifications = c(C = 57.02146),
               variable_modifications = c(M = 15.9949))
```

## Tips and Best Practices

- **Parsers**: `PSM(f, parser = "mzR")` is faster (Proteowizard-based), while `parser = "mzID"` is a more robust XML-based backup if `mzR` fails.
- **Quantitative Data**: You can create adjacency matrices from quantitative objects like `SummarizedExperiment` by passing the protein group strings to `makeAdjacencyMatrix(prots, split = ";")`.
- **Visualization**: Use the `protColors` argument in `plotAdjacencyMatrix()` to color-code proteins by name similarity (string distance), helping identify isoforms or homologous groups.
- **Integration**: `PSM` objects are compatible with `Spectra::joinSpectraData()` for annotating raw MS data with identification results.

## Reference documentation

- [Understanding protein groups with adjacency matrices](./references/AdjacencyMatrix.md)
- [MS2 fragment ions](./references/Fragments.md)
- [Working with PSM data](./references/PSM.md)