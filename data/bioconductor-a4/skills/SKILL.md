---
name: bioconductor-a4
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/a4.html
---

# bioconductor-a4

name: bioconductor-a4
description: Comprehensive analysis of Affymetrix microarray experiments. Use this skill to perform end-to-end microarray workflows including data preprocessing, unsupervised exploration (spectral maps), differential expression analysis (t-test, limma), class prediction (PAM, Random Forest, LASSO), and specialized gene expression visualizations.

## Overview

The a4 package is a suite of tools (a4Preproc, a4Base, a4Classif, a4Reporting) designed for the analysis of gene expression microarray data. It simplifies complex workflows into high-level functions for filtering, testing, and visualizing genomic data stored in ExpressionSet objects.

## Data Preparation and Exploration

### Initialize Data
Load the package and add essential gene annotation (e.g., Entrez IDs, Symbols) to an ExpressionSet object.

```r
library(a4)
# Add annotation information to the featureData slot
object <- addGeneInfo(object)
```

### Unsupervised Exploration
Use spectral maps to visualize clusters and identify genes contributing to sample variance.

```r
# Generate a spectral map colored by a specific phenotype variable
spectralMap(object = object, groups = "variableName", probe2gene = TRUE)
```

### Filtering
Reduce dimensionality by filtering out genes with low variance or low intensity.

```r
# Filter based on variance and intensity
selObject <- filterVarInt(object = object)
```

## Differential Expression

### Statistical Testing
Perform t-tests or use limma for more complex designs.

```r
# Ordinary t-test
tTestResult <- tTest(selObject, "groupVariable")

# Limma for two groups
limmaResult <- limmaTwoLevels(selObject, "groupVariable")

# Extract top genes
tab <- topTable(limmaResult, n = 10)
```

### Visualization of Results
Evaluate p-value distributions and fold changes.

```r
# Plot p-value histogram to check for signal
histPvalue(tTestResult[,"p"], addLegend = TRUE)

# Create a volcano plot
volcanoPlot(tTestResult, topPValues = 5, topLogRatios = 5)
```

## Class Prediction

The suite provides several wrappers for classification algorithms, all optimized for high-dimensional expression data.

*   **PAM**: `pamClass(selObject, "groupVariable")`
*   **Random Forest**: `rfClass(selObject, "groupVariable")`
*   **LASSO**: `lassoClass(object = selObject, groups = "groupVariable")`
*   **Logistic Regression**: `logReg(geneSymbol = "GENE", object = selObject, groups = "groupVariable")`

Use `plot()` on the resulting objects to visualize misclassification error rates or coefficient paths.

## Visualization of Interesting Genes

### Single and Multiple Gene Plots
Visualize expression levels across samples or groups.

```r
# Plot expression of one gene across samples
plot1gene(probesetId = "ID", object = object, groups = "groupVar")

# Boxplot for group-wise comparison
boxPlot(probesetId = "ID", object = object, groups = "groupVar")

# Plot two genes against each other
plotCombination2genes(geneSymbol1 = "GENE1", geneSymbol2 = "GENE2", object = object, groups = "groupVar")
```

### Log Ratio Plots
Compare treatments against a control across multiple genes or timepoints.

```r
# Compute log ratios relative to a reference level
logRatioEset <- computeLogRatio(object, reference = list(var = "group", level = "control"))

# Plot heatmap-style log ratios
plotLogRatio(e = logRatioEset[topGenes,], colorsColumnsBy = "group")
```

## Pathway Analysis

Integrate with the MLP (Mean Log P) package to identify enriched gene sets.

```r
library(MLP)
# Run MLP analysis on p-values derived from limma/t-test
mlpOut <- MLP(geneSet = geneSet, geneStatistic = pValues)
# Visualize GO graph
plot(mlpOut, type = "GOgraph", nRow = 25)
```

## Reference documentation

- [Using the a4 package](./references/a4vignette.md)