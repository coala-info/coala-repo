---
name: bioconductor-subcellbarcode
description: This tool maps protein subcellular localization and identifies differential relocalization using mass spectrometry-based fractionation data. Use when user asks to classify protein compartments, perform marker protein quality control, visualize spatial distributions via t-SNE, or analyze protein relocalization between experimental conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/SubCellBarCode.html
---

# bioconductor-subcellbarcode

name: bioconductor-subcellbarcode
description: Proteome-wide mapping and differential localization analysis of proteins using the SubCellBarCode R package. Use this skill to classify protein subcellular localization from mass spectrometry-based fractionation data, perform quality control on marker proteins, visualize spatial distributions via t-SNE, and identify protein relocalization between experimental conditions.

# bioconductor-subcellbarcode

## Overview

SubCellBarCode is an R package designed for the high-resolution mapping of the human proteome into subcellular compartments. It uses a robust classification workflow based on Support Vector Machines (SVM) and a standardized set of marker proteins. The package supports both gene-centric and transcript/exon-centric analysis, allowing for the detection of localization changes driven by alternative splicing or post-translational modifications.

## Core Workflow

### 1. Data Preparation
Input data should be a `data.frame` with protein identifiers (Gene Symbols) as rownames and columns representing fractions. Replicates must follow the naming convention `.A.` and `.B.`.

```r
library(SubCellBarCode)

# Load and log2 transform data
df <- loadData(protein.data = hcc827Ctrl)

# Optional: Convert identifiers if not using Gene Symbols
# df <- convert2symbol(df = df, id = "UNIPROT")
```

### 2. Marker Protein Quality Control
The package relies on 3365 predefined marker proteins. You must assess their coverage and quality within your specific dataset.

```r
# Calculate coverage (recommend >20% per compartment)
c.prots <- calculateCoveredProtein(proteinIDs = rownames(df), 
                                   markerproteins = markerProteins[,1])

# Filter markers based on replicate correlation (>0.8) and profile similarity
r.markers <- markerQualityControl(coveredProteins = c.prots, protein.data = df)
```

### 3. Visualization and Model Building
Visualize the separation of marker proteins using t-SNE before training the SVM classifier.

```r
# t-SNE Visualization (3D recommended)
tsne.map <- tsneVisualization(protein.data = df, markerProteins = r.markers, dims = 3)

# Train SVM and classify
set.seed(4)
cls <- svmClassification(markerProteins = r.markers, 
                         protein.data = df, 
                         markerprot.df = markerProteins)
```

### 4. Thresholding and Merging
Apply probability thresholds to distinguish high-confidence classifications from "Unclassified" proteins at both the compartment and neighborhood levels.

```r
# Estimate and apply thresholds for compartments
t.c.df <- computeThresholdCompartment(test.repA = cls[[1]]$svm.test.prob.out, 
                                       test.repB = cls[[2]]$svm.test.prob.out)
c.cls.df <- applyThresholdCompartment(all.repA = cls[[1]]$all.prot.pred, 
                                       all.repB = cls[[2]]$all.prot.pred, 
                                       threshold.df = t.c.df)

# Estimate and apply thresholds for neighborhoods
t.n.df <- computeThresholdNeighborhood(test.repA = cls[[1]]$svm.test.prob.out, 
                                        test.repB = cls[[2]]$svm.test.prob.out)
n.cls.df <- applyThresholdNeighborhood(all.repA = cls[[1]]$all.prot.pred, 
                                        all.repB = cls[[2]]$all.prot.pred, 
                                        threshold.df = t.n.df)

# Merge results
final.cls <- mergeCls(compartmentCls = c.cls.df, neighborhoodCls = n.cls.df)
```

## Differential Localization Analysis

To compare two conditions (e.g., Control vs. Treated), use Sankey plots and candidate filtering to identify proteins that change their "Neighborhood" or "Compartment".

```r
# Visualize global shifts
sankeyPlot(sampleCls1 = final.cls, sampleCls2 = treatedClass)

# Filter for high-confidence relocalization candidates
# Requires PSM counts and quantification data for both conditions
candidates <- candidateRelocatedProteins(sampleCls1 = final.cls, 
                                         s1PSM = ctrlPSM, 
                                         s1Quant = hcc827Ctrl,
                                         sampleCls2 = treatedClass, 
                                         s2PSM = treatedPSM, 
                                         s2Quant = hcc827Treated,
                                         min.psm = 3, 
                                         pearson.cor = 0.8)
```

## Visualization Tools

*   **plotBarcode**: Visualizes the fractionation profile and classification probability for a single protein.
*   **plotMultipleProtein**: Compares the localization distribution of a list of proteins (e.g., members of a protein complex).

## Reference documentation

- [SubCellBarCode](./references/SubCellBarCode.md)