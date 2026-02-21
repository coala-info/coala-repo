---
name: bioconductor-deeppincs
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DeepPINCS.html
---

# bioconductor-deeppincs

## Overview

DeepPINCS (Protein Interactions and Networks with Compounds based on Sequences) is a deep learning framework for predicting molecular interactions. It transforms discrete symbolic data—SMILES strings for compounds and amino acid sequences for proteins—into vector representations using various neural network encoders. The package supports binary classification (interaction vs. no interaction) and multiclass problems, making it suitable for drug-target interaction (DTI) screening and drug repurposing studies.

## Core Workflow

### 1. Data Preparation
Data should be organized into character vectors for sequences and numeric/factor vectors for outcomes.
- **Compounds**: Represented as SMILES strings.
- **Proteins**: Represented as Amino Acid (AA) sequences.
- **Labels**: Typically 1 for interaction, 0 for none.

### 2. Model Configuration (`net_args`)
Define the architecture by passing a list to the `net_args` parameter. You must specify encoders for the inputs and the structure of the final dense layers.

Available Encoders:
- `gcn_in_out`: Graph Convolutional Network (Compounds only; requires `compound_type = "graph"`).
- `cnn_in_out`: Convolutional Neural Network.
- `rnn_in_out`: Recurrent Neural Network (supports GRU/LSTM).
- `mlp_in_out`: Multilayer Perceptron (Fully connected).

Example configuration:
```r
net_args <- list(
  compound = "gcn_in_out",
  compound_args = list(gcn_units = c(128, 64), fc_units = c(10)),
  protein = "cnn_in_out",
  protein_args = list(cnn_filters = c(32), cnn_kernel_size = c(3), fc_units = c(10)),
  fc_units = c(1),
  fc_activation = c("sigmoid"),
  loss = "binary_crossentropy",
  optimizer = keras::optimizer_adam(),
  metrics = "accuracy"
)
```

### 3. Training the Model (`fit_cpi`)
The `fit_cpi` function handles preprocessing and training. Key parameters include:
- `compound_type`: "graph", "sequence", or "fingerprint".
- `compound_max_atoms`: Required for GCN.
- `protein_length_seq`: Maximum length for padding/truncating sequences.
- `protein_ngram_max`: For n-gram feature extraction.

```r
model_fit <- fit_cpi(
  smiles = train_smiles,
  AAseq = train_aa,
  outcome = train_label,
  compound_type = "graph",
  net_args = net_args,
  epochs = 20,
  batch_size = 64
)
```

### 4. Prediction (`predict_cpi`)
Use the trained object to predict interactions on new data.
```r
pred <- predict_cpi(model_fit, smiles = test_smiles, AAseq = test_aa)
# Access probabilities
probabilities <- pred$values
```

## Specialized Tasks

### Chemical-Chemical Interaction (CCI)
To predict interactions between two compounds (e.g., Drug-Drug Interactions), provide a two-column matrix/dataframe to the `smiles` argument.
```r
fit_cpi(smiles = example_cci[, 1:2], outcome = example_cci[, 3], compound_type = "fingerprint", ...)
```

### Protein-Protein Interaction (PPI)
Provide a two-column matrix/dataframe of amino acid sequences to the `AAseq` argument.
```r
fit_cpi(AAseq = example_ppi[, 1:2], outcome = example_ppi[, 3], ...)
```

### Single Entity Modeling
You can model properties of single compounds or proteins by providing only one input type (e.g., only `smiles` or only `AAseq`). This is useful for solubility prediction or protein classification.

## Tips for Success
- **Keras/TensorFlow**: Ensure a valid python environment with `keras` and `tensorflow` is installed via `reticulate`.
- **Sequence Lengths**: Set `compound_max_atoms` and `protein_length_seq` based on the distribution of your data to avoid losing critical structural information.
- **Early Stopping**: Always use `keras::callback_early_stopping` to prevent overfitting, especially with small datasets.
- **N-grams**: For proteins, using `protein_ngram_max = 2` or `3` often improves performance over single amino acid embeddings.

## Reference documentation
- [DeepPINCS](./references/DeepPINCS.md)