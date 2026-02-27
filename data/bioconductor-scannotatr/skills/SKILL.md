---
name: bioconductor-scannotatr
description: scAnnotatR performs automated cell type identification and classification for single-cell RNA-sequencing data using pretrained or custom Support Vector Machine models. Use when user asks to classify cells in Seurat or SingleCellExperiment objects, load pretrained immune cell models, or train custom classification models using marker genes.
homepage: https://bioconductor.org/packages/release/bioc/html/scAnnotatR.html
---


# bioconductor-scannotatr

name: bioconductor-scannotatr
description: Cell type prediction and classification for single-cell RNA-sequencing data using pretrained SVM models. Use this skill to annotate immune and other cell types in Seurat or SingleCellExperiment objects, or to train custom classification models based on specific marker genes.

## Overview

scAnnotatR provides a robust framework for automated cell type identification in scRNA-seq datasets. It utilizes Support Vector Machines (SVM) trained on marker gene expression to classify cells. The package includes a library of pretrained models for common immune cells (B cells, T cells, NK cells, etc.) and allows for the creation of hierarchical "child" models to refine classifications (e.g., identifying Plasma cells as a subset of B cells).

## Basic Workflow: Cell Classification

To classify cells in an existing `Seurat` or `SingleCellExperiment` object using pretrained models:

1. **Load Models**: Access the default library of classifiers.
   ```R
   library(scAnnotatR)
   default_models <- load_models("default")
   ```

2. **Classify Cells**: Use the `classify_cells` function.
   ```R
   # For a Seurat object
   seurat_obj <- classify_cells(classify_obj = seurat_obj, 
                                assay = 'RNA', 
                                slot = 'counts',
                                cell_types = 'all', 
                                path_to_models = 'default')
   ```

3. **Interpret Results**: The function adds metadata columns to the object:
   - `predicted_cell_type`: Contains assignments (including ambiguous ones like "NK/T cells").
   - `most_probable_cell_type`: The single most likely cell type.
   - `[celltype]_p`: The probability score for each specific cell type.

## Training Custom Models

You can train new classifiers using labeled data and a set of marker genes.

### Training a Basic Model
```R
# marker_genes: a character vector of gene symbols
# tag_slot: the metadata column containing ground truth labels
classifier_B <- train_classifier(train_obj = train_set, 
                                 cell_type = "B cells", 
                                 marker_genes = c("CD19", "MS4A1", "CD79A"),
                                 assay = 'counts', 
                                 tag_slot = 'cell_labels')
```

### Training a Child Model
Child models are trained only on cells already classified as the parent type (e.g., training a CD4 T cell model using the T cell model as a parent).
```R
classifier_child <- train_classifier(train_obj = train_set, 
                                     marker_genes = child_markers, 
                                     cell_type = "CD4 T cells", 
                                     parent_cell = "T cells",
                                     assay = 'counts', 
                                     tag_slot = 'sub_labels')
```

## Testing and Saving Models

1. **Test Performance**: Evaluate a trained model on a test dataset.
   ```R
   test_results <- test_classifier(classifier = classifier_B, 
                                   test_obj = test_set,  
                                   assay = 'counts', 
                                   tag_slot = 'cell_labels')
   # Plot ROC curve
   plot(plot_roc_curve(test_results))
   ```

2. **Save Models**: Store custom models in a local directory for future use.
   ```R
   save_new_model(new_model = classifier_B, 
                  path_to_models = "path/to/my_models",
                  include.default = FALSE)
   ```

## Tips for Success

- **Data Normalization**: Ensure the assay and slot (e.g., 'counts' or 'data') provided to `classify_cells` match the data used during training.
- **Ambiguity**: If a cell meets the probability threshold (default 0.5) for multiple models, it is labeled with both (e.g., "B cells/Plasma cells"). Use `ignore_ambiguous_result = TRUE` in `classify_cells` to simplify output to the most specific child cell type.
- **Balancing**: `train_classifier` automatically performs down-sampling to balance positive and negative classes. Use `set.seed()` for reproducibility.

## Reference documentation

- [Introduction to scAnnotatR](./references/classifying-cells.md)
- [Training basic model classifying a cell type from scRNA-seq data](./references/training-basic-model.md)
- [Training model classifying a cell subtype from scRNA-seq data](./references/training-child-model.md)