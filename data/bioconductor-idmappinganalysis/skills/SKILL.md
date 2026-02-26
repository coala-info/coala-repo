---
name: bioconductor-idmappinganalysis
description: This tool evaluates and compares bioinformatics identifier mapping resources using statistical methods and experimental data. Use when user asks to evaluate ID map quality, compare annotation services like DAVID or Ensembl, validate mappings with experimental data, or perform mixture modeling on correlation data.
homepage: https://bioconductor.org/packages/3.8/bioc/html/IdMappingAnalysis.html
---


# bioconductor-idmappinganalysis

name: bioconductor-idmappinganalysis
description: Analyze and compare identifier (ID) mapping resources in bioinformatics. Use this skill to evaluate the quality of ID maps (e.g., UniProt to Affymetrix), compare different annotation services (NetAffx, DAVID, Ensembl), and validate mappings using experimental data (e.g., mRNA vs. protein correlations) through mixture modeling and regression.

# bioconductor-idmappinganalysis

## Overview

The `IdMappingAnalysis` package provides a framework for critically evaluating identifier maps retrieved from various bioinformatics resources. It is particularly useful when integrating data from different high-throughput platforms (like transcriptomics and proteomics). The package allows users to characterize ID maps, compare them without experimental data, and use experimental results to determine which mapping resource provides the most biologically relevant links through correlation analysis and mixture modeling.

## Core Workflows

### 1. Initializing and Preparing ID Maps
ID maps are typically structured as `IdMap` objects where the first column is the primary ID and the second contains secondary IDs (comma-separated).

```R
library(IdMappingAnalysis)

# Load example data
data(examples)

# Create a JointIdMap from multiple resources
# primaryIDs and secondaryIDs should be vectors of IDs from your experiments
jointIdMap <- JointIdMap(examples$identDfList, primaryIDs, verbose=FALSE)

# View the combined data
head(jointIdMap$as.data.frame())
```

### 2. Characterizing and Comparing Maps
Analyze the distribution of secondary IDs per primary ID and find discrepancies between resources.

```R
# Get counts of secondary IDs per primary ID across services
mapCounts <- getCounts(jointIdMap, idMapNames=c("NetAffx_Q", "DAVID_Q"))
stats <- mapCounts$getStats(summary=TRUE, cutoff=3)

# Compare two specific maps (A vs B)
diffs <- jointIdMap$getDiff("DAVID_Q", "EnVision_Q")
diffCounts <- IdMapDiffCounts(diffs)
diffCounts$summary()
plot(diffCounts)
```

### 3. Data-Driven Evaluation (Correlation Analysis)
Use experimental data (e.g., MS/MS protein counts and mRNA expression) to validate mappings.

```R
# 1. Create UniquePairs and CorrData objects
uniquePairs <- as.UniquePairs(getUnionIdMap(jointIdMap), secondaryIDs)
corrData <- CorrData(uniquePairs, msmsExperimentSet, mrnaExperimentSet)

# 2. Calculate correlations for all ID pairs
corr <- Corr(corrData, method="pearson")

# 3. Plot correlation densities to compare services
jointUniquePairs <- JointUniquePairs(uniquePairs, getIdMapList(jointIdMap))
jointUniquePairs$corr.plot(corr, idMapNames=c("NetAffx_Q", "DAVID_Q"), subsetting=TRUE)
```

### 4. Mixture Modeling and Regression
Identify the "best" mapping resource by fitting a mixture model to correlations (separating noise from signal) and using the posterior probability as a quality measure.

```R
# Fit a 2-component mixture model
mixture <- Mixture(corr, G=2)
plot(mixture)

# Get posterior probabilities for the 'good' correlation component
qualityMeasure <- mixture$getData(G=2)

# Regression: Which service predicts 'good' correlations?
fit <- jointUniquePairs$do.glm(qualityMeasure, idMapNames=c("DAVID_Q", "EnVision_Q", "NetAffx_Q"))
summary(fit)
```

## Key Classes and Methods
- `IdMap`: Basic container for ID mappings. Use `$swapKeys()` to reverse mapping direction.
- `JointIdMap`: Aligns multiple `IdMap` objects.
- `CorrData`: Collates experimental data for rapid correlation calculation.
- `JointUniquePairs`: Tracks which ID maps reported each unique pair; used for group-wise comparisons.
- `Bootstrap`: Used to estimate standard deviations of correlations for weighted regression.

## Tips
- **Interactive Exploration**: Many methods like `jointIdMap$diffCounts.plot("loop")` or `corrData$interactive.plot()` trigger GUI menus for exploratory analysis.
- **Filtering**: Use `DataFilter` to clean experimental data (e.g., `DataFilter$removeNASeries`) before calculating correlations to avoid bias.
- **Reversing Maps**: Reversing a map (Secondary to Primary) is not always a perfect inverse; use `IdMap$swapKeys()` carefully.

## Reference documentation
- [IdMappingAnalysis](./references/IdMappingAnalysis.md)