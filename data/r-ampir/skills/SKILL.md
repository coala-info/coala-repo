---
name: r-ampir
description: "A toolkit to predict antimicrobial peptides from protein sequences on a genome-wide scale.     It incorporates two support vector machine models (\"precursor\" and \"mature\") trained on publicly available antimicrobial peptide data using calculated     physico-chemical and compositional sequence properties described in Meher et al."
homepage: https://cran.r-project.org/web/packages/ampir/index.html
---

# r-ampir

## Overview
The `ampir` (Antimicrobial Peptide Prediction in R) package provides a fast, toolkit for predicting antimicrobial peptides from protein sequences. It uses Support Vector Machine (SVM) models trained on physico-chemical and compositional sequence properties. It includes two built-in models:
- `precursor`: Best for full-length proteins.
- `mature`: Best for small mature proteins (< 60 amino acids).

## Installation
```R
install.packages("ampir")
library(ampir)
```

## Core Workflow: Predicting AMPs
The standard input is a `data.frame` with sequence names in the first column and protein sequences in the second column.

### 1. Load Data
Use `read_faa` to import FASTA files into the required data frame format.
```R
my_proteins <- read_faa("path/to/file.fasta")
```

### 2. Predict Probabilities
Use `predict_amps` to calculate the probability (0 to 1) of a sequence being an AMP.
```R
# Using the default precursor model
predictions <- predict_amps(my_proteins, model = "precursor")

# Using the mature model for short sequences
predictions_mature <- predict_amps(my_proteins, model = "mature")
```
*Note: Sequences < 10 amino acids or those containing non-standard amino acids return `NA` by default.*

### 3. Filter and Export
```R
# Filter for high confidence hits (e.g., > 0.8)
amp_hits <- predictions[predictions$prob_AMP > 0.8, ]

# Write results back to FASTA
df_to_faa(amp_hits, "predicted_amps.fasta")
```

## Advanced Usage: Custom Models
You can train custom models using the `caret` package and pass them to `predict_amps`.

### Feature Calculation
If training a custom model, use `calculate_features` to generate the numerical descriptors used by the SVM.
```R
features <- calculate_features(my_proteins)
```

### Training a Model (Brief)
1. Prepare a labeled dataset (Positive and Negative).
2. Clean sequences using `remove_nonstandard_aa`.
3. Calculate features.
4. Train using `caret::train` (typically `method = "svmRadial"`).
5. Pass the resulting object to the `model` argument in `predict_amps`.

```R
# Applying a custom trained model
my_custom_results <- predict_amps(my_proteins, model = my_trained_svm_object)
```

## Tips and Constraints
- **Sequence Length**: The default minimum length is 10. For shorter peptides, adjust the `min_len` parameter in `predict_amps`.
- **Standard Amino Acids**: Models are trained on the 20 standard amino acids. Use `remove_nonstandard_aa` to clean datasets before prediction or training to avoid errors.
- **Memory**: For genome-wide scales, `ampir` is designed for speed, but ensure the input data frame fits in memory.

## Reference documentation
- [Introduction to ampir](./references/ampir.Rmd)
- [How to train your model](./references/train_model.Rmd)