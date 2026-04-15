---
name: bioconductor-struct
description: The struct package provides an object-oriented framework for building standardized, reproducible multivariate statistical workflows and metabolomics data pipelines in R. Use when user asks to create DatasetExperiment objects, define and apply statistical models, build model sequences, perform cross-validation, or generate diagnostic charts.
homepage: https://bioconductor.org/packages/release/bioc/html/struct.html
---

# bioconductor-struct

name: bioconductor-struct
description: Use when performing multivariate statistical analysis, metabolomics data processing, or building modular data analysis workflows in R using the struct package. This skill covers creating DatasetExperiment objects, defining and applying statistical models, building model sequences (pipelines), and generating diagnostic charts.

# bioconductor-struct

## Overview
The `struct` package (STatistics in R using Class-based Templates) provides an S4 object-oriented framework for creating standardized, reproducible statistical workflows. It separates data containers, analysis methods, and visualization tools into distinct classes, making it easier to chain operations together into complex pipelines.

## Core Workflow

### 1. Data Organization
All `struct` methods expect data in a `DatasetExperiment` object, which extends `SummarizedExperiment`. It requires samples in rows and variables in columns.

```r
library(struct)

# Create a DatasetExperiment
DE <- DatasetExperiment(
  data = my_data_frame,          # Samples (rows) x Variables (cols)
  sample_meta = my_sample_metadata, 
  variable_meta = my_variable_metadata,
  name = "Study Name",
  description = "Brief description"
)

# Access data using dollar syntax
head(DE$data)
head(DE$sample_meta)
```

### 2. Using Models
Models are the building blocks for filtering, normalization, and statistics.

*   **Initialization**: Create a model instance, optionally setting parameters.
*   **Training**: Use `model_train(M, DE)` to calculate parameters (e.g., means, loadings).
*   **Prediction**: Use `model_predict(M, DE)` to apply the trained model to data.
*   **Apply**: Use `model_apply(M, DE)` to perform both steps at once (autoprediction).

```r
# Example: Mean centering (if defined)
M <- mean_centre()
M <- model_apply(M, DE)

# Access outputs
centered_data <- M$centred
```

### 3. Model Sequences (Pipelines)
You can chain multiple models together using the `+` operator. Data flows automatically from the `predicted` slot of one model to the input of the next.

```r
# Create a pipeline: Mean Center -> PCA
pipeline <- mean_centre() + PCA(number_components = 2)

# Run the entire pipeline
pipeline <- model_apply(pipeline, DE)

# Get the final result
final_res <- predicted(pipeline)
```

### 4. Iterators and Metrics
Iterators are used for resampling methods like Cross-Validation or Permutation tests. They wrap around models or sequences.

```r
# Nest a model in an iterator
I <- iterator_cv(folds = 5) * (mean_centre() + PCA())
# Run the iterator
# I <- run(I, DE) 
```

### 5. Visualization
Charts are generated using `chart_plot`, which typically takes a chart object and a trained model/iterator.

```r
# Create a chart object
C <- pca_scores_plot(factor_name = 'Group')

# Plot using a trained PCA model
chart_plot(C, my_trained_pca) + theme_bw()
```

## Creating Custom Templates
If a specific method is not available, you can define new ones using helper functions:

*   `set_struct_obj()`: Define a new class (model, chart, etc.).
*   `set_obj_method()`: Define the logic for `model_train`, `model_predict`, or `chart_plot`.
*   `entity()`: Define input parameters with metadata (name, description, type).

## Tips for AI Agents
*   **Slot Access**: Use `$` to get or set parameters and outputs (e.g., `M$number_components = 5`).
*   **Ontology**: Use `ontology(obj)` to retrieve semantic definitions for models and parameters.
*   **Subsetting**: `DatasetExperiment` objects support standard R subsetting: `DE[rows, cols]`.
*   **Sequencing**: When building a `model_seq`, ensure the `predicted` slot of the preceding model matches the expected input of the next (usually `DatasetExperiment`).

## Reference documentation
- [Introduction to STRUCT - STatistics in R using Class-based Templates](./references/struct_templates_and_helper_functions.md)