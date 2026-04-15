---
name: bioconductor-rrdp
description: This tool provides an R interface to the Ribosomal Database Project Naive Bayesian Classifier for taxonomic assignment of 16S rRNA sequences. Use when user asks to classify ribosomal RNA sequences into taxonomic ranks, train custom RDP classifiers with specific training sets, or evaluate classification accuracy using Greengenes-formatted data.
homepage: https://bioconductor.org/packages/release/bioc/html/rRDP.html
---

# bioconductor-rrdp

name: bioconductor-rrdp
description: Interface to the Ribosomal Database Project (RDP) Naive Bayesian Classifier for 16S rRNA sequences. Use this skill when you need to classify ribosomal RNA sequences into taxonomic ranks, train custom RDP classifiers with specific training sets, or evaluate classification accuracy using Greengenes-formatted data.

## Overview

The `rRDP` package provides an R interface to the RDP Classifier, a naive Bayesian tool for rapid taxonomic assignment of 16S rRNA sequences. It supports using the default RDP training set (via the `rRDPData` package) or creating custom models.

## System Requirements and Setup

The package relies on Java. Ensure `rJava` is configured correctly.

```r
library(rRDP)
# If Java path is not found on Windows:
# Sys.setenv(JAVA_HOME = "C:\\Program Files\\Java\\jdk-XX")
```

Required companion packages:
- `Biostrings`: For handling sequence data.
- `rRDPData`: Contains the default 16S rRNA training set.

## Classification Workflow

### 1. Load Sequences
Sequences should be loaded as `DNAStringSet` or `RNAStringSet` objects.

```r
seqs <- readRNAStringSet("path/to/sequences.fasta")
# Clean names if they contain extra metadata
names(seqs) <- sapply(strsplit(names(seqs), " "), "[", 1)
```

### 2. Predict Taxonomy
Use the `predict()` function with an RDP classifier object.

```r
# Use default classifier
classifier <- rdp()
pred <- predict(classifier, seqs)

# View results (data.frame of taxonomic ranks)
head(pred)

# Access confidence scores
conf <- attr(pred, "confidence")
```

### 3. Evaluation
If sequences have known Greengenes-formatted annotations, you can calculate accuracy.

```r
# Decode Greengenes strings to data.frame
actual <- decode_Greengenes(annotation_strings)

# Calculate accuracy at a specific rank (e.g., "genus")
accuracy(actual, pred, rank = "genus")

# Generate confusion table
confusionTable(actual, pred, rank = "genus")
```

## Custom Classifier Training

You can train RDP on your own reference sequences.

### 1. Prepare Training Data
Training sequences must have names formatted as:
`"<ID> <Kingdom>;<Phylum>;<Class>;<Order>;<Family>;<Genus>"`

### 2. Train and Use
```r
# Train and save to a directory
custom_model <- trainRDP(trainingSequences, dir = "my_custom_model")

# Predict using the custom model
pred_custom <- predict(custom_model, testSequences)

# Load an existing custom model later
old_model <- rdp(dir = "my_custom_model")

# Remove model files from disk
removeRDP(custom_model)
```

## Tips
- **Memory**: Large sequence sets or complex custom models may require increasing Java heap space *before* loading the library: `options(java.parameters = "-Xmx4g")`.
- **Ranks**: Standard ranks used are domain, phylum, class, order, family, and genus.
- **Confidence**: Always check the `confidence` attribute; low scores (e.g., < 0.8) suggest unreliable assignments at that specific rank.

## Reference documentation
- [rRDP: Interface to the RDP Classifier](./references/rRDP.md)
- [rRDP Vignette Source](./references/rRDP.Rmd)