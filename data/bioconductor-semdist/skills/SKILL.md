---
name: bioconductor-semdist
description: This tool evaluates multi-label protein function predictors using information-theoretic metrics like Remaining Uncertainty and Misinformation based on Gene Ontology structures. Use when user asks to calculate semantic distance, evaluate GO term prediction performance, generate RU-MI curves, or compute information accretion for ontologies.
homepage: https://bioconductor.org/packages/release/bioc/html/SemDist.html
---


# bioconductor-semdist

name: bioconductor-semdist
description: Use this skill to evaluate the performance of multi-label protein function predictors using information-theoretic metrics from the SemDist R package. It is specifically designed for Gene Ontology (GO) or custom ontologies structured as Directed Acyclic Graphs (DAGs). Use this skill to calculate Remaining Uncertainty (RU), Misinformation (MI), Semantic Distance, and Semantic Similarity based on information accretion.

## Overview

The `SemDist` package provides tools to assess predictors of multi-label annotations where labels are drawn from an ontology. Unlike simple precision/recall, `SemDist` uses "information accretion" (IA) to weight terms based on their specificity within the ontology. Its primary metrics are **Remaining Uncertainty (RU)** (missing true information) and **Misinformation (MI)** (incorrectly predicted information). The "Semantic Distance" is the minimum distance from the origin on a RU-MI curve, providing a single robust value for ranking algorithms.

## Installation

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SemDist")
library(SemDist)
```

## Core Workflow

### 1. Prepare Input Files
The package requires two tab-delimited text files:
- **True Annotations**: Two columns (Sequence ID, GO ID).
- **Predictions**: Three columns (Sequence ID, GO ID, Confidence Score [0-1]).

### 2. Obtain Information Accretion (IA) Values
IA values represent the conditional probability of a term given its parents. You can use built-in data or compute your own.

```R
# Use built-in IA data for mouse Cellular Component
data("Info_Accretion_mouse_CC", package="SemDist")
# IAccr is now loaded in the environment

# Or compute IA for a specific organism and ontology (e.g., Human Molecular Function)
# Requires the corresponding org.db package (e.g., org.Hs.eg.db)
IAccr_human <- computeIA("MF", "human", evcodes=c("EXP", "IC"))
```

### 3. Calculate RU and MI for a Single Threshold
Use `findRUMI` to evaluate a predictor at a specific confidence cutoff (e.g., 0.75).

```R
# truefile and predfile are paths to your text files
rumiTable <- findRUMI("MF", "human", 0.75, truefile, predfile, IAccr = IAccr_human)

# Calculate averages
avgRU <- mean(rumiTable$RU)
avgMI <- mean(rumiTable$MI)
```

### 4. Generate RU-MI Curves and Semantic Distance
Use `RUMIcurve` to calculate metrics across a range of thresholds (e.g., increments of 0.05).

```R
# Returns a list of data frames (one per prediction file)
rumi_list <- RUMIcurve("MF", "human", 0.05, truefile, predfile)
curve_data <- rumi_list[[1]]

# Plot the RU-MI curve
plot(curve_data$RU, curve_data$MI, xlab="Remaining Uncertainty", ylab="Misinformation")

# Calculate Semantic Distance (Euclidean distance to origin)
sem_dist <- min(sqrt(curve_data$MI^2 + curve_data$RU^2))
```

## Advanced Metrics
You can request additional metrics like Precision, Recall, and Specificity by setting flags in `RUMIcurve`.

```R
rumi_extended <- RUMIcurve("MF", "human", 0.05, truefile, predfile, 
                           add.prec.rec = TRUE, 
                           add.weighted = TRUE)
# Results include columns: SS (Semantic Similarity), Prec, Rec, Spec, WRU, WMI
```

## Custom Ontologies
If not using standard GO, provide a parent-child relationship file and a custom annotations file to `computeIA`.

```R
IA_custom <- computeIA("my", "values", 
                       specify.ont = TRUE, myont = "ontology_edges.txt",
                       specify.annotations = TRUE, annotfile = "labels.txt")
```

## Tips for Interpretation
- **RU (Remaining Uncertainty)**: High values mean the predictor is missing many true annotations.
- **MI (Misinformation)**: High values mean the predictor is making many false positive claims.
- **Semantic Distance**: Lower values indicate better overall performance.
- **Semantic Similarity (SS)**: Measures the shared information between true and predicted sets.

## Reference documentation
- [An Introduction to the SemDist package](./references/introduction.md)