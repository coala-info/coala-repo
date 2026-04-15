---
name: bioconductor-scclassifr
description: This tool classifies and annotates cell types in single-cell RNA-sequencing data using pretrained or custom-trained Support Vector Machine models. Use when user asks to automatically annotate immune cells in Seurat or SingleCellExperiment objects, train new SVM-based classifiers for specific cell populations, perform hierarchical cell type classification, or evaluate classifier performance using ROC curves.
homepage: https://bioconductor.org/packages/3.13/bioc/html/scClassifR.html
---

# bioconductor-scclassifr

name: bioconductor-scclassifr
description: Cell type classification and annotation for single-cell RNA-sequencing data using pretrained machine learning models or custom-trained classifiers. Use this skill when you need to: (1) Automatically annotate immune cell types in Seurat or SingleCellExperiment objects, (2) Train new SVM-based classifiers for specific cell populations, (3) Perform hierarchical cell type classification (parent-child models), or (4) Evaluate classifier performance using ROC curves and AUC metrics.

# bioconductor-scclassifr

## Overview

scClassifR is a Bioconductor package designed for the automated identification of cell types in single-cell RNA-seq (scRNA-seq) datasets. It utilizes Support Vector Machine (SVM) models to provide quick annotations for basic immune cells and offers a flexible framework for users to train, test, and save their own classification models. It natively supports `Seurat` and `SingleCellExperiment` objects.

## Core Workflow: Cell Classification

To classify cells using the built-in pretrained models:

```r
library(scClassifR)

# Load your Seurat or SingleCellExperiment object
# data("tirosh_mel80_example") # Example dataset

# Run classification
seurat_obj <- classify_cells(
  classify_obj = seurat_obj,
  cell_types = 'all',       # Use 'all' or specific types like c('B cells', 'T cells')
  path_to_models = 'default' # Uses integrated models
)

# Results are added to metadata:
# - predicted_cell_type: Includes ambiguous assignments (e.g., "B cells/Plasma cells")
# - most_probable_cell_type: The single highest probability type
# - [celltype]_p: Probability scores for each type
```

## Training Custom Models

### 1. Basic Model (Independent Cell Type)
Use this for cell types that do not depend on a parent classification.

```r
# Define features (gene symbols)
features <- c("CD19", "MS4A1", "CD79A")

# Train the classifier
# sce_tag_slot is the metadata column with ground truth labels
clf <- train_classifier(
  train_obj = train_set,
  cell_type = "B cells",
  features = features,
  sce_assay = 'counts',
  sce_tag_slot = 'cell_type_label'
)
```

### 2. Child Model (Subtype Classification)
Use this for subtypes (e.g., Plasma cells) that are children of a parent type (e.g., B cells).

```r
clf_child <- train_classifier(
  train_obj = train_set,
  features = child_features,
  cell_type = "Plasma cells",
  parent_clf = parent_model_object, # Or parent_cell = "B cells"
  sce_tag_slot = 'subtype_label'
)
```

## Evaluation and Persistence

### Testing Performance
Evaluate a trained model on a test dataset:

```r
test_results <- test_classifier(
  test_obj = test_set,
  classifier = clf,
  sce_tag_slot = 'ground_truth'
)

# Plot ROC curve
roc_curve <- plot_roc_curve(test_result = test_results)
plot(roc_curve)
```

### Saving and Loading Models
Manage a local database of custom models:

```r
# Save to current directory
save_new_model(new_model = clf, path.to.models = getwd(), include.default = FALSE)

# Use local models for classification
classified <- classify_cells(
  classify_obj = test_set,
  path_to_models = getwd(),
  cell_types = 'all'
)

# Delete a model
delete_model("B cells", path.to.models = getwd())
```

## Key Parameters and Tips

- **ignore_ambiguous_result**: In `classify_cells`, set to `TRUE` to hide "TypeA/TypeB" results and report the most specific (child) type in hierarchical models.
- **Probability Threshold**: The default is 0.5. You can inspect the threshold using `p_thres(classifier)`.
- **Data Balancing**: `train_classifier` automatically balances positive and negative groups to prevent bias in imbalanced datasets. Use `set.seed()` for reproducibility.
- **Ambiguous Labels**: During training, label cells as "ambiguous" in your metadata to have scClassifR ignore them.

## Reference documentation

- [Introduction to scClassifR and Cell Classification](./references/classifying-cells.md)
- [Training Basic Classification Models](./references/training-basic-model.md)
- [Training Child/Subtype Classification Models](./references/training-child-model.md)