---
name: bioconductor-rrdpdata
description: This package provides the RDP Classifier training data required for taxonomic classification with the rRDP package. Use when user asks to classify 16S rRNA sequences, assign taxonomy to bacterial or archaeal sequences, or initialize the default RDP classifier.
homepage: https://bioconductor.org/packages/release/data/experiment/html/rRDPData.html
---


# bioconductor-rrdpdata

## Overview

The `rRDPData` package is an experiment data package for Bioconductor that provides the necessary training data for the `rRDP` package. It contains the RDP Classifier 2.14 training set No. 19, which includes updated bacterial and archaeal taxonomy. This package does not contain functions itself but is a required dependency for the `predict()` method in `rRDP` when using the default classifier.

## Installation

To use this data, both the interface package (`rRDP`) and the data package (`rRDPData`) must be installed.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rRDP")
BiocManager::install("rRDPData")
```

## Typical Workflow

### 1. Load Sequences
Load 16S rRNA sequences (DNA or RNA) using `Biostrings`.

```r
library(rRDP)
library(Biostrings)

# Example: Loading a FASTA file
seqs <- readDNAStringSet("path/to/sequences.fasta")
```

### 2. Initialize the Default Classifier
The `rdp()` function initializes the classifier. By default, it looks for the data provided by `rRDPData`.

```r
# Initialize default classifier using rRDPData
classifier <- rdp()
```

### 3. Perform Classification
Use the `predict()` function to assign taxonomy.

```r
# Predict taxonomy
pred <- predict(classifier, seqs)

# View results (data.frame format)
head(pred)

# Access confidence scores
conf <- attr(pred, "confidence")
head(conf)
```

### 4. Evaluate Results
If actual classifications are known (e.g., in Greengenes format), you can calculate accuracy.

```r
# Example evaluation at Genus level
# actual <- decode_Greengenes(names(seqs))
# accuracy(actual, pred, rank = "genus")
```

## Usage Tips

- **Memory/Java**: `rRDP` uses Java via `rJava`. Ensure `JAVA_HOME` is correctly set if you encounter initialization errors.
- **Data Version**: This package specifically provides Training Set No. 19 (released August 2023). If your analysis requires older versions of the RDP taxonomy, you may need different data resources.
- **Implicit Loading**: You do not usually need to call `library(rRDPData)` directly; the `rRDP` package will find the data automatically when `rdp()` is called without a specific directory argument.

## Reference documentation

- [rRDP: Interface to the RDP Classifier](./references/rRDP.Rmd)