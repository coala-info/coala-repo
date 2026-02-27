---
name: bioconductor-pcagopromoter
description: The pcaGoPromoter package interprets high-dimensional biological data by combining principal component analysis with functional enrichment of Gene Ontology terms and transcription factor targets. Use when user asks to perform PCA on microarray data, identify biological signals through GO term enrichment, or find over-represented transcription factor binding sites.
homepage: https://bioconductor.org/packages/3.6/bioc/html/pcaGoPromoter.html
---


# bioconductor-pcagopromoter

## Overview
The `pcaGoPromoter` package is designed for the interpretation of high-dimensional biological data, specifically Affymetrix microarray results. It provides a streamlined workflow to move from raw expression matrices to biological insights by combining PCA with functional enrichment. It identifies the probes contributing most to the variance in specific principal components and maps them to GO terms and transcription factor (TF) targets.

## Core Workflow

### 1. Data Preparation
The package expects an expression matrix (probes as rows, samples as columns) and a factor vector defining experimental groups.

```r
library(pcaGoPromoter)
library(serumStimulation)
data(serumStimulation)

# Define groups for the samples
groups <- as.factor(c(rep("control", 5), rep("serumInhib", 5), rep("serumOnly", 3)))
```

### 2. Principal Component Analysis
You can perform a standard PCA and visualize the separation of groups.

```r
# Run PCA
pcaOutput <- pca(serumStimulation)

# Plot PCA results
plot(pcaOutput, groups=groups)
```

### 3. Automated "All-in-One" Analysis
For a quick overview, `pcaInfoPlot` generates a PCA plot and automatically annotates the axes with over-represented GO terms and transcription factors.

```r
pcaInfoPlot(eData=serumStimulation, groups=groups)
```

### 4. Functional Annotation (GO Terms)
To investigate specific biological signals, extract the top-ranked probe IDs from a specific principal component and run a Gene Ontology analysis.

```r
# Get the top 2.5% (e.g., 1365) probes from the negative direction of PC2
loadsNegPC2 <- getRankedProbeIds(pcaOutput, pc=2, decreasing=FALSE)[1:1365]

# Generate GO tree
GOtreeOutput <- GOtree(input = loadsNegPC2)

# Visualize and inspect
plot(GOtreeOutput, legendPosition = "bottomright")
head(GOtreeOutput$sigGOs, n=10)
```

### 5. Transcription Factor Analysis
The `primo` function identifies transcription factors that may be regulating the genes associated with the selected probes.

```r
# Find over-represented transcription factors
TFtable <- primo(loadsNegPC2)
head(TFtable$overRepresented)

# Retrieve specific probe IDs associated with a TF (using its ID)
probeIds <- primoHits(loadsNegPC2, id = 9343)
```

## Usage Tips
- **Probe Selection**: When using `getRankedProbeIds`, the `decreasing` parameter determines the direction on the PC axis. Use `TRUE` for the positive direction and `FALSE` for the negative direction.
- **Visualization**: GO trees can become complex; use `dev.copy2pdf(file="output.pdf")` to save high-resolution versions for detailed inspection.
- **Data Requirements**: Ensure that the input to `GOtree` and `primo` consists of valid Affymetrix probe IDs compatible with the organism's annotation packages.

## Reference documentation
- [pcaGoPromoter](./references/pcaGoPromoter.md)