---
name: bioconductor-cytofqc
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/cytofQC.html
---

# bioconductor-cytofqc

## Overview

The `cytofQC` package provides a model-based approach to cleaning CyTOF data. Unlike simple thresholding, it uses statistical learning to label each event as a cell, bead, debris, doublet, dead event, or "gdpZero" (events with zero values in Gaussian parameters). It is particularly effective at distinguishing between doublets and large cells. The workflow typically involves reading data into a `SingleCellExperiment` object, generating event scores, and applying classification models to assign QC labels.

## Core Workflow

### 1. Data Loading and Preparation
Use `readCytof` to initialize the `SingleCellExperiment` object. You must identify the specific channels used for QC.

```r
library(cytofQC)
library(CATALYST)

# Identify QC variable names if unknown
# x <- prepData("path/to/file.fcs")
# names(int_colData(x))

# Read and initialize
sce <- readCytof("path/to/file.fcs", 
                 beads = c("Bead"),
                 dna = c("DNA1", "DNA2"),
                 event_length = "Event_length",
                 viability = "Live_Dead",
                 gaussian = c("Center", "Offset", "Width", "Residual"))
```

### 2. Automated Quality Control
The `labelQC` function is the primary interface. It performs initial classification and then trains a model (default is SVM) to label all observations.

```r
# Default SVM labeling
sce <- labelQC(sce)

# Alternative models (Random Forest or Gradient Boosting)
# sce <- labelQC(sce, model = "rf", loss = "class")
# sce <- labelQC(sce, model = "gbm", loss = "class")

# Check results
table(label(sce))
```

### 3. Manual/Stepwise Labeling
For finer control, you can run the labeling process for each event type sequentially. The recommended order is: Beads -> Debris -> Doublets -> Dead cells.

```r
# Example: Stepwise Bead labeling
sce <- initialBead(sce)
sce <- svmLabel(sce, type = "bead", n = 500)

# Example: Stepwise Debris labeling
sce <- initialDebris(sce)
sce <- svmLabel(sce, type = "debris", n = 500)
```

### 4. Data Extraction and Visualization
The package provides getter functions to access the QC metadata stored within the `SingleCellExperiment` object.

*   `label(sce)`: Returns the final character vector of labels.
*   `scores(sce, type)`: Returns the raw QC scores for a specific type (e.g., 'bead', 'doublet').
*   `probs(sce, type)`: Returns the model-predicted probability for a label.
*   `tech(sce)`: Returns the transformed data used for modeling.

**Visualizing Scores:**
Use `cytofHist` to inspect how well the labels separate based on their scores.

```r
# Create density plots for comparison
bead_p <- cytofHist(scores(sce, type = 'bead'), label(sce), type = "density", title = "Bead score")
doublet_p <- cytofHist(scores(sce, type = 'doublet'), label(sce), type = "density", title = "Doublet score")
gridExtra::grid.arrange(bead_p, doublet_p, ncol = 1)
```

## Key Data Components
When `readCytof` is called, it adds four specific slots to the object:
- **tech**: `log1p` transformed Gaussian parameters and event length.
- **label**: The final classification (initially "cell" or "GDPzero").
- **scores**: Values used to select training datasets.
- **initial**: Initial "hard" classifications (-1, 0, or 1) used to train the models.
- **probs**: Predicted probabilities from the classification model.

## Tips for Success
- **Order Matters**: Labels are assigned in order. Once an event is classified (e.g., as a bead), it cannot be re-classified as a doublet later in the `labelQC` pipeline.
- **Sample Size**: If a warning appears stating there are not enough events to build a model, `cytofQC` will automatically use a smaller training set or skip that specific label if counts are too low.
- **GDPzero**: Events with a 0 value in any Gaussian parameter or Event_length are automatically labeled "GDPzero" and are not processed by the learning models.

## Reference documentation
- [Complete Guide to cytofQC](./references/cytofQC.Rmd)