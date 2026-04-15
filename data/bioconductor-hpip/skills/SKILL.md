---
name: bioconductor-hpip
description: The HPiP package provides a pipeline for predicting host-pathogen protein-protein interactions by transforming amino acid sequences into numerical descriptors and applying ensemble machine learning. Use when user asks to extract sequence-based features, train interaction classifiers, predict novel host-pathogen protein pairs, or visualize predicted interaction networks.
homepage: https://bioconductor.org/packages/release/bioc/html/HPiP.html
---

# bioconductor-hpip

## Overview
The `HPiP` package provides a comprehensive pipeline for predicting interactions between host and pathogen proteins. It transforms amino acid sequences into numerical feature vectors using diverse descriptors and employs ensemble machine learning (via the `caret` package) to classify potential interactions. The workflow typically involves data preparation, feature extraction, feature selection, model training/prediction, and downstream network analysis.

## Core Workflow

### 1. Data Preparation
Construct positive and negative interaction sets for training.

```r
library(HPiP)
library(dplyr)

# Get positive PPIs from BioGRID (requires access key)
# TP <- get_positivePPI(organism.taxID = 2697049, access.key = 'XXXX')

# Generate negative PPIs via negative sampling
# prot1: pathogen proteins, prot2: host proteins, TPset: known positive pairs
# TN <- get_negativePPI(prot1, prot2, TPset)

# Load example gold standard (1000 pairs)
data(Gold_ReferenceSet)
```

### 2. Sequence Retrieval and Feature Extraction
Retrieve FASTA sequences and convert them into numerical descriptors.

```r
# Retrieve FASTA from UniProt
ids <- unique(Gold_ReferenceSet$Pathogen_Protein)
fasta_list <- getFASTA(ids)
fasta_df <- data.frame(UniprotID = names(fasta_list), sequence = as.character(unlist(fasta_list)))

# Calculate Descriptors (Examples)
aac <- calculateAAC(fasta_df)      # Amino Acid Composition (20D)
dc  <- calculateDC(fasta_df)       # Dipeptide Composition (400D)
ctdc <- calculateCTDC(fasta_df)    # CTD - Composition (21D)
ksaap <- calculateKSAAP(fasta_df)  # k-Spaced Amino Acid Pairs (400D)
```

### 3. Combining and Processing Features
Merge host and pathogen features into a single interaction vector.

```r
# Combine viral and host features (x1_viral and x1_host are matrices of descriptors)
x <- getHPI(x1_viral, x1_host, type = "combine")

# Feature Selection (Correlation-based and Recursive Feature Elimination)
# xx is a dataframe with 'class' label and features
x_FS <- FSmethod(xx, type = "both", cor.cutoff = 0.8, resampling.method = "cv", iter = 5)

# Visualize feature importance
var_imp(x_FS$rf.result$rfProfile)
```

### 4. Prediction with Ensemble Learning
Train multiple classifiers and aggregate results.

```r
# Predict using ensemble of SVM, GLM, and Random Forest
ppi_results <- pred_ensembel(ind_data, gd_labels,
                             classifier = c("svmRadial", "glm", "ranger"),
                             resampling.method = "cv", ncross = 5)

# Filter high-confidence interactions
predictions <- ppi_results$predicted_interactions %>% filter(ensemble >= 0.7)
```

### 5. Network Visualization and Analysis
Visualize the predicted interactome and perform functional enrichment.

```r
# Plot interaction network for a specific protein
plotPPI(predictions, edge.name = "ensemble", node.color = "red")

# Frequency of interactors (degree distribution)
FreqInteractors(predictions)

# GO Enrichment of host partners
# enrich_res <- enrichfindP(predictions, org = "hsapiens")

# Community detection (Complex prediction)
clusters <- run_clustering(predictions, method = "FC") # Fast-greedy
```

## Key Functions Summary
- `get_positivePPI` / `get_negativePPI`: Build training sets.
- `calculate[Descriptor]`: Functions like `calculateAAC`, `calculateDC`, `calculateCTriad`, `calculateCTDC/T/D`.
- `getHPI`: Merges host and pathogen feature vectors.
- `FSmethod`: Hybrid filter-wrapper feature selection.
- `pred_ensembel`: Main prediction engine using ensemble averaging.
- `run_clustering`: Detects protein complexes/modules in the predicted network.

## Reference documentation
- [Introduction to HPiP](./references/HPiP_tutorial.md)
- [HPiP RMarkdown Source](./references/HPiP_tutorial.Rmd)