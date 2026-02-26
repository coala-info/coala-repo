---
name: bioconductor-infinityflow
description: This package uses machine learning to impute high-dimensional protein expression data from massively parallel flow cytometry experiments. Use when user asks to augment flow cytometry datasets, predict exploratory marker expression from backbone channels, or create high-dimensional single-cell protein expression matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/infinityFlow.html
---


# bioconductor-infinityflow

## Overview
The `infinityFlow` package implements a machine learning-based approach to augment flow cytometry data. In "massively parallel" experiments, a sample is split into many aliquots, each stained with a common "Backbone" panel and one unique "Infinity" exploratory antibody. This package uses the Backbone data to train regression models (defaulting to XGBoost) that predict the expression of all Infinity markers for every cell in the dataset, effectively creating a high-dimensional single-cell protein expression matrix.

## Core Workflow

### 1. Data Preparation
You need a directory of FCS files and an annotation data frame.
- **FCS Files**: All files must share the same Backbone channels.
- **Annotation**: A data frame with row names matching FCS file names, containing columns for `Infinity_target` and `Infinity_isotype`.

```r
library(infinityFlow)
library(flowCore)

# Example annotation setup
# rownames(annotation) should match sampleNames of your flowSet/FCS files
targets <- annotation$Infinity_target
names(targets) <- rownames(annotation)
isotypes <- annotation$Infinity_isotype
names(isotypes) <- rownames(annotation)
```

### 2. Marker Specification
You must define which channels are predictors (backbone), targets (exploratory), or should be ignored (discard).
- Use `select_backbone_and_exploratory_markers(fcs_files)` for an interactive selection.
- Save the result as a CSV to pass to the main pipeline.

### 3. Running the Pipeline
The `infinity_flow` function executes the entire pipeline: data parsing, logicle transformation, backbone harmonization, model fitting, and imputation.

```r
imputed_data <- infinity_flow(
    path_to_fcs = "path/to/fcs_folder",
    path_to_output = "path/to/output_folder",
    backbone_selection_file = "backbone_selection.csv",
    annotation = targets,
    isotype = isotypes,
    input_events_downsampling = 1000,      # Events used for training
    prediction_events_downsampling = 500,  # Events per well in final output
    cores = 1L                             # Increase for parallel processing
)
```

### 4. Custom Regression Models
By default, the package uses XGBoost. You can specify multiple models (SVM, Neural Networks, GLMNet) using the `regression_functions` and `extra_args_regression_params` arguments.

```r
# Example: Using SVM and Linear Model
regression_functions <- list(SVM = fitter_svm, LM = fitter_linear)
extra_args_regression_params <- list(
    list(kernel = "radial", cost = 8), # SVM params
    list(degree = 1)                   # LM params
)

# Pass these to infinity_flow()
```

## Output Description
The pipeline populates the `path_to_output` directory with:
- **FCS/**: Augmented FCS files containing both backbone and imputed markers.
- **FCS_background_corrected/**: Imputed data with isotype-control background subtraction.
- **umap_plot_annotated.pdf**: UMAP visualizations of the backbone data colored by imputed marker expression.

## Tips for Success
- **Memory Management**: High `prediction_events_downsampling` or many `cores` can lead to high RAM usage. Start low and scale up.
- **Neural Networks**: If using `fitter_nn`, ensure `keras` and `tensorflow` are configured. Set `cores = 1L` to avoid serialization issues with socketing.
- **Transformations**: The package automatically applies Logicle transformations. If your data is already transformed, ensure the backbone selection reflects the correct channel names.

## Reference documentation
- [Basic usage of the infinityFlow package](./references/basic_usage.md)
- [Training non default regression models](./references/training_non_default_regression_models.md)