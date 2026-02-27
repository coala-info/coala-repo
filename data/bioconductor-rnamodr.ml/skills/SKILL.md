---
name: bioconductor-rnamodr.ml
description: This tool detects post-transcriptional RNA modifications by integrating machine learning models into the RNAmodR framework. Use when user asks to define custom ModifierML classes, extract training data from sequencing datasets, integrate ranger or keras models into RNAmodR workflows, or evaluate model performance using ROC analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/RNAmodR.ML.html
---


# bioconductor-rnamodr.ml

name: bioconductor-rnamodr.ml
description: Use when detecting post-transcriptional RNA modifications using machine learning models within the RNAmodR framework. This skill is applicable for: (1) Defining custom ModifierML classes for specific modifications, (2) Extracting training data from high-throughput sequencing datasets, (3) Integrating ranger or keras models into the RNAmodR workflow, and (4) Evaluating model performance using ROC analysis.

# bioconductor-rnamodr.ml

## Overview

The `RNAmodR.ML` package extends the `RNAmodR` framework by providing machine learning (ML) capabilities to detect RNA modifications. While classical methods rely on simple thresholds or ratios, `RNAmodR.ML` allows for the training of models (such as Random Forests via `ranger` or Neural Networks via `keras`) on complex patterns in sequencing data (Pileup and Coverage) to identify modified positions like Dihydrouridine (D).

## Core Workflow

### 1. Define a Custom ModifierML Class
Create a class that inherits from `RNAModifierML`. Specify the modification type, the score column name, and the required data types.

```r
library(RNAmodR.ML)

setClass("ModMLExample",
         contains = c("RNAModifierML"),
         prototype = list(mod = c("D"),
                          score = "score",
                          dataType = c("PileupSequenceData", "CoverageSequenceData"),
                          mlModel = character(0)))

# Constructor
ModMLExample <- function(x, annotation, sequences, ...){
  RNAmodR:::Modifier("ModMLExample", x = x, annotation = annotation,
                     sequences = sequences, ...)
}
```

### 2. Gather Training Data
Use known modified and unmodified coordinates to extract features from an aggregated `Modifier` object.

```r
# Initialize object (without model initially to aggregate data)
me <- ModMLExample(files, annotation, sequences)

# Extract training data using GRanges coordinates
# coord should contain known modified and unmodified positions
tData <- trainingData(me, coord)
tData <- unlist(tData, use.names = FALSE)
tData$labels <- as.integer(tData$labels)
```

### 3. Train and Wrap the Model
Train a model using standard R packages and wrap it in a `ModifierMLModel` class (e.g., `ModifierMLranger`).

```r
library(ranger)
rf_model <- ranger(labels ~ ., data.frame(tData))

# Create the wrapper class
setClass("MyMLModel",
         contains = c("ModifierMLranger"),
         prototype = list(model = rf_model))

my_ml_model <- new("MyMLModel")
```

### 4. Apply the Model for Detection
Set the model to the modifier object and implement the `useMLModel` and `findMod` methods to generate scores and identify modifications.

```r
# Assign model
setMLModel(me) <- my_ml_model

# Implement useMLModel to populate the 'score' column
setMethod(f = "useMLModel",
          signature = signature(x = "ModMLExample"),
          definition = function(x){
            predictions <- useModel(getMLModel(x), x)
            data <- getAggregateData(x)
            unlisted_data <- unlist(data, use.names = FALSE)
            unlisted_data$score <- unlist(predictions)
            x@aggregate <- relist(unlisted_data, data)
            x
          })

# Run aggregation and modification calling
me <- aggregate(me, force = TRUE)
mods <- modifications(me)
```

## Performance Evaluation

Use the `plotROC` function to evaluate how well the model distinguishes between modified and unmodified positions based on the prediction scores.

```r
# Plot ROC curve using known modification coordinates
plotROC(me, known_dmod_coords)
```

## Tips and Best Practices

- **Feature Engineering**: Use the `aggregateData` method to perform feature engineering. If using deep learning (e.g., `keras`), you may prefer to pass raw sequence data as tensors.
- **Flanking Sequences**: When using `trainingData`, providing a flanking value can convert 2D tensors (sample, values) into 3D tensors (sample, position, values) for convolutional neural networks.
- **Model Refinement**: If the model identifies noise as modifications, retrain the model by including those false-positive positions in the training set as "unmodified" labels.
- **ModifierSets**: Combine multiple models or samples into a `ModifierSet` to analyze average performance across different conditions.

## Reference documentation

- [RNAmodR.ML: detecting patterns of post-transcriptional modifications using machine learning](./references/RNAmodR.ML.md)