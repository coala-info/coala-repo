---
name: r-garnett
description: Garnett is an R package for automated cell type classification of single-cell RNA-seq data using hierarchical marker gene files. Use when user asks to train cell type classifiers, classify cells in a dataset, or validate marker gene files for single-cell analysis.
homepage: https://cran.r-project.org/web/packages/garnett/index.html
---

# r-garnett

name: r-garnett
description: Automated cell type classification for single-cell RNA-seq data. Use this skill when you need to train cell type classifiers using marker genes, apply pre-trained classifiers to new datasets, or integrate cell type labels into Monocle 3 workflows.

# r-garnett

## Overview
Garnett is an R package designed to facilitate automated cell type classification from single-cell RNA-seq (scRNA-seq) data. It uses a hierarchical marker file system to define cell types and trains a machine learning classifier that accounts for noise and technical variation. It is particularly well-integrated with the Monocle 3 ecosystem.

## Installation
To install the garnett package from Bioconductor (as it is primarily hosted there rather than CRAN):

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("garnett")
```

## Core Workflow

### 1. Define Marker Genes
Garnett uses a specific text-based format to define cell types.
Example `markers.txt`:
```text
> Hepatocytes
marker genes: APOA2, ALB
expressed: TTR

> Kupffer cells
marker genes: CD68, MARCO
expressed: VICIC
```

### 2. Train a Classifier
Use a `cds` (CellDataSet) object and your marker file to train a model.

```R
library(garnett)

# Load marker file
marker_file_path <- "markers.txt"

# Train the classifier
# num_unknown is the number of out-group cells to sample
set.seed(260)
classifier <- train_cell_classifier(cds = input_cds,
                                    marker_file = marker_file_path,
                                    db = org.Hs.eg.db,
                                    cds_gene_id_type = "SYMBOL",
                                    marker_file_gene_id_type = "SYMBOL")
```

### 3. Classify Cells
Apply the trained classifier to a new or the same dataset.

```R
input_cds <- classify_cells(input_cds, classifier,
                            db = org.Hs.eg.db,
                            cluster_extend = TRUE,
                            cds_gene_id_type = "SYMBOL")
```

### 4. Access Results
Classification results are stored in the `colData` of the CDS object.

```R
# View classification results
head(pData(input_cds)$cell_type)
head(pData(input_cds)$cluster_ext_type)
```

## Key Functions
- `check_markers`: Validates your marker file against your data to ensure markers are specific and expressed.
- `train_cell_classifier`: Builds the classification model using a marker file and a training CDS.
- `classify_cells`: Assigns cell type labels to a CDS based on a classifier.
- `get_probabilities`: Extracts the raw classification probabilities for each cell type.

## Tips for Success
- **Database (db)**: Ensure the `db` argument matches your species (e.g., `org.Mm.eg.db` for mouse).
- **Gene IDs**: Always verify that `cds_gene_id_type` (e.g., "ENSEMBL" or "SYMBOL") matches the format used in your CDS object.
- **Extensions**: Use `cluster_extend = TRUE` in `classify_cells` to label cells that might be missed by the primary classifier but reside in a cluster dominated by a specific cell type.

## Reference documentation
- [Garnett Home Page](./references/home_page.md)