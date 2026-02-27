---
name: bioconductor-slgi
description: The bioconductor-slgi package provides tools for analyzing synthetic lethal genetic interactions in yeast by mapping them onto cellular organizational units like protein complexes. Use when user asks to analyze genetic interaction datasets, map interactions to interactomes, or perform statistical tests for significant interactions within protein complexes.
homepage: https://bioconductor.org/packages/3.6/bioc/html/SLGI.html
---


# bioconductor-slgi

## Overview

The SLGI (Synthetic Lethal Genetic Interaction) package provides tools for a systems biology approach to analyzing genetic interactions in *Saccharomyces cerevisiae*. It focuses on identifying relationships between synthetic genetic interactions and cellular organizational units, such as multi-protein complexes or sequence motifs. It bundles several landmark yeast datasets and provides functions to map these interactions onto interactomes.

## Loading Data and Annotation

The package contains several preprocessed datasets from major yeast studies.

```R
library(SLGI)
library(org.Sc.sgd.db)

# Load specific datasets
data(SGA)        # Tong et al. (2004) systematic names
data(Atong)      # Tong et al. (2004) association matrix
data(Boeke2006)  # Pan et al. (2006) incidence matrix
data(gi2005)     # Schuldiner et al. (2005) EMAP data
data(TFmat)      # Transcription factor binding affinities (Lee et al. 2002)
```

## Mapping Interactions to Complexes

A common workflow involves integrating genetic interaction data with protein complex data (typically from the `ScISI` package).

### 1. Aligning Matrices
Use `gi2Interactome` to reduce the genetic interaction matrix and the interactome matrix to a common set of genes.

```R
library(ScISI)
data(ScISIC)
data(Boeke2006)

# Reduce matrices to common genes
Boeke2006red <- gi2Interactome(Boeke2006, ScISIC)
```

### 2. Identifying Interactions
Use `getInteraction` to find interactions within or between complexes.

```R
data(dSLAM) # Array list for Boeke data
interact <- getInteraction(Boeke2006red, dSLAM, ScISIC)

# Summarize complexes sharing at least n interactions
intSummary <- iSummary(interact$bwMat, n=5)
```

## Statistical Analysis

SLGI provides two primary methods to test the significance of observed interactions.

### 1. Graph Theory / Permutation Test
Test if interactions are randomly distributed within the interactome.

```R
# Run permutation model (use perm=100+ for real analysis)
modelBoeke <- modelSLGI(Boeke2006red, universe=dSLAM, interactome=ScISIC, type="intM", perm=100)

# Visualize results
plot(modelBoeke, pch=20)
```

### 2. Hypergeometric Test
Identify multi-protein complexes with an unusual number of synthetic genetic interactions.

```R
# 1. Define the 'tested' universe (all possible interactions)
array <- dSLAM[dSLAM %in% rownames(ScISIC)]
query <- rownames(Boeke2006)[rownames(Boeke2006) %in% rownames(ScISIC)]
allInteract <- matrix(1, nrow=length(query), ncol=length(array), dimnames=list(query, array))
tested <- getInteraction(allInteract, dSLAM, ScISIC)

# 2. Summarize tested vs observed
testedInteract <- test2Interact(iMat=interact$bwMat, tMat=tested$bwMat, interactome=ScISIC)

# 3. Run Hypergeometric test
significant <- hyperG(cbind("Tested"=testedInteract$tested, "Interact"=testedInteract$interact), 
                      sum(Boeke2006), 
                      nrow(Boeke2006red) * length(dSLAM))
```

## Tips and Best Practices
- **Gene Naming**: Always ensure you are using systematic ORF names (e.g., "YJL174W"). Use `org.Sc.sgdCOMMON2ORF` to convert common names if necessary.
- **Interactome Choice**: The `ScISI` package is the standard companion for SLGI. `ScISIC` contains curated data, while the full `ScISI` includes estimated complexes.
- **Permutations**: When using `modelSLGI`, the default `perm` value should be increased (e.g., 100 or 1000) for publication-quality results, though this increases computation time.

## Reference documentation
- [SLGI](./references/SLGI.md)