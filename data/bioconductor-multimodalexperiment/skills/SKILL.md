---
name: bioconductor-multimodalexperiment
description: The MultimodalExperiment package provides a storage-efficient S4 class for integrating and managing diverse biological data types through a hierarchical annotation system. Use when user asks to store multi-omic data, link metadata across biological scales, or synchronize experiment matrices via propagation and harmonization.
homepage: https://bioconductor.org/packages/release/bioc/html/MultimodalExperiment.html
---


# bioconductor-multimodalexperiment

## Overview

The `MultimodalExperiment` package provides a storage-efficient S4 class for integrating diverse biological data types. It uses a hierarchical annotation system (Experiment -> Subject -> Sample -> Cell) and relational maps to link metadata to underlying experiment data. A key feature is its "opt-in" coordination, which defers expensive data alignment operations until the user explicitly calls for propagation or harmonization.

## Installation

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MultimodalExperiment")
```

## Core Workflow

### 1. Construction
Initialize an empty object and populate it with experiments. Experiments are stored in an `ExperimentList`.

```R
library(MultimodalExperiment)

# Initialize
ME <- MultimodalExperiment()

# Add Bulk Data
bulkExperiments(ME) <- ExperimentList(pbRNAseq = pb_matrix)

# Add Single-Cell Data
singleCellExperiments(ME) <- ExperimentList(
    scADTseq = adt_matrix,
    scRNAseq = scrna_matrix
)
```

### 2. Establishing Relationships (Mapping)
Define how experiments, subjects, samples, and cells relate to one another by modifying the map slots.

*   **subjectMap**: Links experiments to subjects.
*   **sampleMap**: Links subjects to samples.
*   **cellMap**: Links samples to cells.

```R
# Example: Link all cells to a specific sample
cellMap(ME)[["sample"]] <- "SAMPLE-1"

# View the joined relational structure
joinMaps(ME)
```

### 3. Coordination
Because coordination is opt-in, you must manually trigger index alignment.

*   **`propagate(ME)`**: Adds missing indices to annotation tables by taking the union of all indices in the maps. Use this after adding new data or maps.
*   **`harmonize(ME)`**: Removes extraneous indices by taking the intersection of all tables. Use this after filtering metadata to ensure the underlying experiment matrices are subset accordingly.

### 4. Managing Annotations
Access and modify metadata at different biological scales:

```R
# Set subject-level metadata
subjectData(ME)[["condition"]] <- "healthy"

# Set sample-level metadata
sampleData(ME)[["tissue"]] <- "PBMC"

# Set cell-level metadata (e.g., from a specific experiment)
cellData(ME)[["cellType"]] <- apply(experiment(ME, "scADTseq"), 2, some_classifier_function)
```

## Manipulation and Subsetting

### Filtering Data
To filter the entire object based on metadata, subset the annotation slot and then call `harmonize()`.

```R
# Filter for Monocytes only
isMonocyte <- cellData(ME)[["cellType"]] == "Monocyte"
cellData(ME) <- cellData(ME)[isMonocyte, , drop = FALSE]

# Sync the experiment matrices to only include Monocyte columns
ME <- harmonize(ME)
```

### Direct Subsetting
Standard R subsetting `[i, j]` acts on the rows (features) and columns (samples/cells) of the underlying experiments.

```R
# Subset first 10 features of all experiments
ME_sub <- ME[1:10, ]
```

## Key Functions Reference

| Function | Purpose |
| :--- | :--- |
| `MultimodalExperiment()` | Constructor for the main class. |
| `ExperimentList(...)` | Constructor for the list of experiment matrices. |
| `bulkExperiments(ME)` | Accessor for experiments labeled as "bulk". |
| `singleCellExperiments(ME)` | Accessor for experiments labeled as "single-cell". |
| `experiment(ME, i)` | Extract a specific experiment by name or index. |
| `joinAnnotations(ME)` | Merges all annotation layers into one DataFrame. |
| `joinMaps(ME)` | Merges all map layers to visualize relationships. |

## Reference documentation

- [MultimodalExperiment](./references/MultimodalExperiment.md)