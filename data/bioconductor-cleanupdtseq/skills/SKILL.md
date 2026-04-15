---
name: bioconductor-cleanupdtseq
description: This package uses a Naive Bayes classifier to distinguish true polyadenylation sites from false positives caused by internal priming. Use when user asks to identify true polyadenylation sites, filter internal priming artifacts, or classify peak data using genomic sequence features.
homepage: https://bioconductor.org/packages/release/bioc/html/cleanUpdTSeq.html
---

# bioconductor-cleanupdtseq

## Overview

The `cleanUpdTSeq` package provides a Naive Bayes classifier to distinguish between true polyadenylation (pA) sites and false positives caused by internal priming of oligo(dT) primers to adenine-rich genomic regions. While trained on Zebrafish data, the classifier is effective across multiple species including human, mouse, and rat. The workflow involves converting peak data to GRanges, building feature vectors based on surrounding genomic sequences, and applying the classifier to predict the probability of a site being a true pA site.

## Workflow and Functions

### 1. Data Import and Preprocessing
Convert BED files or data frames into the required `GRanges` format.

```r
library(cleanUpdTSeq)

# Load data from a BED6 file (with or without sequence columns)
testFile <- "path/to/your/peaks.bed"
peaks <- BED6WithSeq2GRangesSeq(file = testFile, skip = 1L, withSeq = FALSE)
```

### 2. Building Feature Vectors
Generate the numerical features required for the Naive Bayes classifier. This step requires a `BSgenome` object if sequences are not already provided in the input.

```r
# Example using Zebrafish genome
library(BSgenome.Drerio.UCSC.danRer7)

testSet.NaiveBayes <- buildFeatureVector(
    peaks,
    genome = Drerio,
    upstream = 40L,      # Sequence length upstream of pA site
    downstream = 30L,    # Sequence length downstream of pA site
    wordSize = 6L,       # k-mer size for feature extraction
    alphabet = "ACGT",
    method = "NaiveBayes",
    fetchSeq = TRUE      # Set to FALSE if sequences are already in 'peaks'
)
```

### 3. Classification and Prediction
Use the pre-built classifier or provide training data to identify true pA sites.

```r
# Load the pre-built classifier (optimized for upstream=40, downstream=30, wordSize=6)
data(classifier)

# Predict pA sites
testResults <- predictTestSet(
    testSet.NaiveBayes = testSet.NaiveBayes,
    classifier = classifier,
    outputFile = "results.tsv", # Optional: write to file
    assignmentCutoff = 0.5,     # Probability threshold for 'true' class
    return_sequences = TRUE
)

# Results include:
# prob_fake_pA: Probability of internal priming
# prob_true_pA: Probability of true polyadenylation
# pred_class: 1 for true pA, 0 for false/internal priming
head(testResults)
```

## Key Considerations

*   **Parameter Matching**: If using the pre-built `classifier` object, you **must** use `upstream = 40`, `downstream = 30`, and `wordSize = 6` in `buildFeatureVector`.
*   **Species Compatibility**: Although trained on Zebrafish, the sequence features (polyA signals and downstream AT-richness) are conserved enough for use in other vertebrates.
*   **Input Format**: `BED6WithSeq2GRangesSeq` expects a specific format. If your data is already in R as a data frame, ensure it has columns for `upstream` and `downstream` sequences if you intend to skip the `fetchSeq` step.
*   **Custom Training**: If the pre-built classifier is unsuitable, you can build a new one using `buildClassifier` by providing positive and negative training sets (available in `data(data.NaiveBayes)`).

## Reference documentation

- [cleanUpdTSeq User Guide](./references/cleanUpdTSeq.md)