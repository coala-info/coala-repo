---
name: bioconductor-bioimagedbs
description: This tool provides access to curated electron and light microscopy datasets pre-processed as multi-dimensional arrays for R. Use when user asks to retrieve bioimage datasets from ExperimentHub, access 4D or 5D image tensors for deep learning, or download microscopy data for image analysis benchmarking.
homepage: https://bioconductor.org/packages/release/data/experiment/html/BioImageDbs.html
---


# bioconductor-bioimagedbs

name: bioconductor-bioimagedbs
description: Access and use curated bioimage datasets from the Bioconductor BioImageDbs package. Use this skill when you need to retrieve microscopy imaging data (EM, LM) pre-processed as 4D or 5D arrays for machine learning, deep learning (Keras/Tensorflow), or image analysis benchmarking in R.

## Overview
BioImageDbs provides a collection of bioimage datasets (electron microscopy and light microscopy) stored in ExperimentHub. These datasets are pre-processed into R list objects containing 4D or 5D arrays (tensors), making them immediately compatible with deep learning frameworks like Keras or Tensorflow without requiring manual image pre-processing.

## Core Workflow

### 1. Initialize ExperimentHub
The datasets are hosted on ExperimentHub. You must first initialize the hub to query the metadata.

```r
library(BioImageDbs)
library(ExperimentHub)
eh <- ExperimentHub()
```

### 2. Query Datasets
Search for available datasets using the "BioImageDbs" keyword. You can filter by specific IDs (e.g., "EM_id0001") or file types (e.g., ".gif").

```r
# List all records
qr <- query(eh, "BioImageDbs")

# Search for a specific dataset ID
qr_specific <- query(eh, c("BioImageDbs", "EM_id0001"))

# View metadata
qr$title
qr$ah_id
```

### 3. Retrieve Data
Data is retrieved using the ExperimentHub ID (e.g., "EH6874") or by indexing the query object.

```r
# Retrieve by ID
dataset <- eh[["EH6874"]]

# Retrieve by index from query result
dataset <- qr[[1]]
```

### 4. Data Structure and Usage
Datasets are typically returned as R `list` objects containing training and/or test data.

*   **5D Tensors (3D Images):** Dimensions are `[batch, z, y, x, channel]`.
*   **4D Tensors (2D Images):** Dimensions are `[batch, y, x, channel]`.
*   **Channels:** 1 for grayscale, 3 for RGB.

**Example: Preparing for Keras**
```r
# Extract images and labels
train_x <- dataset$Train$Train_Original
train_y <- dataset$Train$Train_GroundTruth

# Check dimensions
dim(train_x)

# Use in Keras model (requires keras package)
# model %>% fit(x = train_x, y = train_y)
```

### 5. Visualization
Many datasets include `.gif` files for quick visualization of the image stacks. Use the `magick` package to view them.

```r
library(magick)
gif_path <- qr_specific[[2]] # Assuming index 2 is the .gif
magick::image_read(gif_path)
```

## Dataset Categories
*   **Electron Microscopy (EM):** Mouse brain (CA1), Drosophila brain, J558L cells, Human T cells, Mouse Kidney, Rat Liver, NB4 cells.
*   **Light Microscopy (LM):** HeLa cells (DIC), U373 cells (PhC), Mouse stem cells (Fluo).

## Tips
*   **Caching:** ExperimentHub caches data locally after the first download.
*   **Metadata:** Use `mcols(qr)` to see detailed information about species, data provider, and image descriptions.
*   **Binary Labels:** Ground truth labels are often provided as binary or multi-value arrays for segmentation tasks.

## Reference documentation
- [The BioImageBbs Datasets](./references/BioImageBbs_Datasets.md)
- [BioImageDbs: Providing Bioimage Dataset for ExperimentHub](./references/BioImageDbs.md)