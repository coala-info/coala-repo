---
name: bioconductor-bioseqclass
description: BioSeqClass provides a comprehensive framework for sequence-based biological classification and feature extraction in R. Use when user asks to perform homolog reduction, extract numerical features from DNA or protein sequences, select informative features, or build and evaluate machine learning models for biological sequence classification.
homepage: https://bioconductor.org/packages/3.8/bioc/html/BioSeqClass.html
---

# bioconductor-bioseqclass

name: bioconductor-bioseqclass
description: Sequence-based biological classification using the BioSeqClass R package. Use this skill when you need to perform homolog reduction, extract numerical features from DNA/RNA/protein sequences (feature coding), perform feature selection, or build and evaluate classification models for biological sequences.

## Overview
BioSeqClass provides a comprehensive framework for sequence-based classification in R. It covers the entire bioinformatics workflow: reducing sequence redundancy, converting biological sequences into numerical feature vectors (using various schemas like binary, k-mer, or physicochemical properties), selecting the most informative features, and training/evaluating machine learning models (SVM, Random Forest, etc.).

## Core Workflow

### 1. Data Preparation and Homolog Reduction
To prevent overestimation of model accuracy, remove highly similar sequences.
- `hr(seqs, identity)`: General function for homolog reduction.
- `cdhitHR(saveFile, identity)`: Uses CD-HIT (requires external installation) for clustering.
- `aligndisHR(seqs, identity)`: Stepwise elimination based on residue distance for aligned sequences.

### 2. Feature Extraction (Feature Coding)
Convert sequences into numerical matrices. Most functions take a character vector of sequences and return a matrix.

**Common Coding Functions:**
- `featureBinary(seq, elements("aminoacid"))`: 0-1 binary coding for each position.
- `featureFragmentComposition(seq, k, elements("aminoacid"))`: Frequency of k-mer fragments.
- `featureGapPairComposition(seq, g, elements("aminoacid"))`: Frequency of g-spaced element pairs.
- `featureCKSAAP(seq, g, elements("aminoacid"))`: Composition of k-spaced amino acid pairs (k from 0 to g).
- `featureCTD(seq, class)`: Composition, Transition, and Distribution of properties.
- `featureAAindex(seq, indexNames)`: Physicochemical properties from the AAindex database.

### 3. Model Building and Evaluation
The `classify` function is the primary interface for training and testing.

```r
# Basic classification with 5-fold cross-validation
results <- classify(data, classifyMethod = "libsvm", cv = 5, svm.kernel = "linear")

# Access performance metrics
results$totalPerformance
```

### 4. Feature Selection
Reduce dimensionality to improve performance and speed.
- `classify(..., evaluator = "CfsSubsetEval", search = "BestFirst")`: Integrated feature selection using WEKA (requires rJava/RWeka).
- `selectFFS(data, accCutoff, classifyMethod)`: Feature Forward Selection based on model performance.

## Practical Example: PTM Site Prediction
To predict Post-Translational Modification (PTM) sites like acetylation:
1. Use `getTrain(fastaFile, siteFile, aa = "K", w = 7)` to extract flanking peptides around a central residue.
2. Apply `featureBinary` or `featureGapPairComposition` to the peptides.
3. Combine features and labels into a data frame.
4. Run `classify` to evaluate the predictive power.

## Tips for Success
- **Sequence Length:** Many feature coding methods (like `featureBinary`) require sequences of equal length (e.g., flanking windows).
- **External Tools:** Functions like `featurePSSM` (PSI-BLAST) or `predictPROTEUS` (Secondary Structure) require external software or web connectivity.
- **Performance Metrics:** The package automatically calculates Accuracy (acc), Sensitivity (sn), Specificity (sp), and Matthews Correlation Coefficient (mcc).

## Reference documentation
- [BioSeqClass](./references/BioSeqClass.md)