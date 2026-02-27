---
name: bioconductor-ttgsea
description: This tool predicts enrichment scores for gene set tokens and new functional terms using deep learning models trained on existing GSEA results. Use when user asks to predict enrichment scores for novel gene set names, identify the contribution of specific words to biological signals, or resolve redundancy in overlapping gene sets.
homepage: https://bioconductor.org/packages/release/bioc/html/ttgsea.html
---


# bioconductor-ttgsea

name: bioconductor-ttgsea
description: Tokenizing Text of Gene Set Enrichment Analysis (ttgsea). Use this skill to predict enrichment scores for unique tokens or new gene set terms using deep learning (LSTM/GRU) based on existing GSEA results. It is particularly useful for resolving redundancy in overlapping gene sets and coining new functional terms.

## Overview
The `ttgsea` package applies deep learning architectures (via Keras/TensorFlow) to the text found in gene set names. By training on existing GSEA results (e.g., from `fgsea`), it learns to associate specific words or tokens with enrichment scores (NES). This allows researchers to predict the enrichment of novel word combinations or identify the specific contribution of individual tokens to a biological signal.

## Core Workflow

### 1. Prepare GSEA Input
The package typically builds upon results from the `fgsea` package.
```r
library(ttgsea)
library(fgsea)

# Standard fgsea workflow
data(examplePathways)
data(exampleRanks)
fgseaRes <- fgseaSimple(examplePathways, exampleRanks, nperm = 10000)
```

### 2. Fit the Deep Learning Model
Use `fit_model` to train a neural network on the GSEA results. You must specify the column containing the text (pathway names) and the column containing the scores (NES).
```r
# Ensure keras/tensorflow is configured
if (keras::is_keras_available()) {
  ttgseaRes <- fit_model(
    data = fgseaRes,
    text_col = "pathway",
    score_col = "NES",
    model = bi_lstm(num_tokens = 1000, embedding_dim = 50, length_seq = 30, num_units = 32),
    epochs = 10,
    batch_size = 32
  )
}
```
Available model architectures:
- `bi_lstm()`: Bidirectional Long Short-Term Memory.
- `bi_gru()`: Bidirectional Gated Recurrent Unit.

### 3. Predict Scores for New Terms
Use `predict_model` to estimate the enrichment score and a Monte Carlo p-value for arbitrary text strings.
```r
new_terms <- c("Cell Cycle DNA Replication", "TGF-beta receptor")
predictions <- predict_model(ttgseaRes, new_terms)
# Returns a data frame with predicted NES and p-values
```

### 4. Leading Edge Analysis
You can also tokenize the gene symbols within the "leading edge" to predict scores based on gene composition rather than pathway names.
```r
# Collapse leading edge gene lists into strings
fgseaRes$LE <- sapply(fgseaRes$leadingEdge, function(x) paste(x, collapse = " "))

ttgseaRes_LE <- fit_model(fgseaRes, "LE", "NES", model = bi_lstm(1000, 50, 30, 32))
```

## Tips and Best Practices
- **Text Cleaning**: Before fitting, ensure pathway names are human-readable (e.g., replace underscores with spaces) to improve tokenization quality.
- **Tokenization**: The package uses unigram and bigram sequences by default.
- **P-values**: P-values are calculated via Monte Carlo simulation based on the distribution of tokens. If a new term contains no tokens seen during training, the p-value will be `NA`.
- **Keras Requirement**: This package requires a functional Python environment with `keras` and `tensorflow` installed via the `reticulate` package.

## Reference documentation
- [Tokenizing Text of Gene Set Enrichment Analysis](./references/ttgsea.md)