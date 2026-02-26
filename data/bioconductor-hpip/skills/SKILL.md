---
name: bioconductor-hpip
description: bioconductor-hpip predicts host-pathogen protein-protein interactions using structural and physicochemical descriptors derived from protein sequences. Use when user asks to construct PPI datasets, retrieve protein sequences from UniProt, compute sequence-based numerical descriptors, perform feature selection, train ensemble machine learning models for interaction prediction, or analyze predicted interaction networks.
homepage: https://bioconductor.org/packages/release/bioc/html/HPiP.html
---


# bioconductor-hpip

name: bioconductor-hpip
description: Automated prediction of host-pathogen protein-protein interactions (HP-PPIs) using structural and physicochemical descriptors from protein sequences. Use this skill when you need to: (1) Construct gold-standard positive and negative PPI datasets, (2) Extract protein sequences from UniProt, (3) Compute sequence-based numerical descriptors (AAC, DC, CTD, etc.), (4) Perform feature selection (RFE/Correlation), (5) Train ensemble machine learning models for PPI prediction, or (6) Visualize and analyze predicted HP-PPI networks.

# bioconductor-hpip

## Overview
The `HPiP` package provides a comprehensive pipeline for predicting interactions between host and pathogen proteins using only amino acid sequence information. It transforms protein sequences into fixed-length numerical feature vectors, applies feature selection to handle high-dimensional data, and uses ensemble machine learning (via the `caret` package) to classify potential interactions. It also includes tools for network visualization and functional enrichment of predicted partners.

## Core Workflow

### 1. Data Preparation
Construct positive and negative reference sets.
```r
library(HPiP)
library(dplyr)

# Get positive interactions from BioGRID (requires access key)
# TP <- get_positivePPI(organism.taxID = 2697049, access.key = 'XXXX')

# Generate negative set via negative sampling
# prot1: pathogen proteins, prot2: host proteins, TPset: known positive pairs
# TN <- get_negativePPI(prot1, prot2, TPset)
```

### 2. Sequence Retrieval and Feature Extraction
Retrieve FASTA sequences and convert them into numerical descriptors.
```r
# Retrieve FASTA from UniProt
ids <- c("P0DTC2", "P0DTC5")
fasta_list <- getFASTA(ids)
fasta_df <- data.frame(UniprotID = names(fasta_list), sequence = unlist(fasta_list))

# Calculate descriptors (e.g., Amino Acid Composition, CTD)
aac_feat <- calculateAAC(fasta_df)
ctdc_feat <- calculateCTDC(fasta_df)
# Other descriptors: calculateDC, calculateTC, calculateCTDT, calculateCTDD, calculateKSAAP, calculateCTriad
```

### 3. Feature Selection
Reduce dimensionality by removing redundant or non-informative features.
```r
# Combine host and pathogen features into interaction vectors
# x1_v: pathogen feature matrix, x1_h: host feature matrix
x_combined <- getHPI(x1_v, x1_h, type = "combine")

# Perform feature selection (Correlation-based and Recursive Feature Elimination)
x_FS <- FSmethod(x_combined_df, 
                 type = "both", 
                 cor.cutoff = 0.8, 
                 resampling.method = "cv", 
                 iter = 5)

# Visualize importance
var_imp(x_FS$rf.result$rfProfile)
```

### 4. Ensemble Prediction
Train multiple classifiers and average their results.
```r
# ind_data: data frame with features for both labeled and unlabeled pairs
# gd: gold standard labels (class and PPI columns)
ppi_results <- pred_ensembel(ind_data, 
                             gd, 
                             classifier = c("svmRadial", "glm", "ranger"), 
                             resampling.method = "cv", 
                             ncross = 5, 
                             plots = TRUE)

# Extract high-confidence predictions
predictions <- ppi_results$predicted_interactions %>% 
  filter(ensemble >= 0.7)
```

### 5. Visualization and Analysis
Visualize the resulting network and perform enrichment.
```r
# Plot network for specific pathogen protein
plotPPI(predictions_df, edge.name = "ensemble", node.color = "red")

# Frequency of interactors (degree distribution)
FreqInteractors(predictions_df)

# Functional enrichment of host partners
# enrich_res <- enrichfindP(predictions_df, org = "hsapiens")
```

## Tips and Best Practices
- **Memory Management**: Tripeptide Composition (TC) generates 8,000 features. Use `calculateTC_Sm` (216 features) or `calculateQD_Sm` (1296 features) for a reduced alphabet approach that is more computationally efficient.
- **SummarizedExperiment**: Use `SummarizedExperiment` objects to manage large feature matrices, especially when combining multiple descriptor types.
- **Negative Sampling**: Ensure the ratio of positive to negative samples is 1:1 to prevent model bias during training.
- **Caret Integration**: Since `pred_ensembel` wraps `caret`, you can use any classifier string supported by `caret` (e.g., "xgbTree", "pls").

## Reference documentation
- [Introduction to HPiP](./references/HPiP_tutorial.Rmd)