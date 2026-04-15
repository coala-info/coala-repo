---
name: bioconductor-scrnaseqapp
description: The scRNAseqApp package provides a framework for building interactive Shiny applications to visualize and explore single-cell RNA sequencing data. Use when user asks to initialize a Shiny app for scRNA-seq data, prepare Seurat objects for visualization, or launch a web interface to explore gene expression and cell clustering.
homepage: https://bioconductor.org/packages/release/bioc/html/scRNAseqApp.html
---

# bioconductor-scrnaseqapp

## Overview

The `scRNAseqApp` package provides a framework for building highly interactive Shiny applications to visualize single-cell RNA sequencing (scRNA-seq) data. It is designed to increase the re-usability of scientific findings by allowing researchers to explore gene expression, cell clustering, and metadata through a web interface. It supports administrative data uploads, multi-dataset hosting, and integration with Seurat objects.

## Core Workflow

### 1. Initializing the Application
To set up the necessary directory structure and database for the Shiny app, use `scInit`.

```r
library(scRNAseqApp)
# Define a folder where the app and data will reside
publish_folder <- "path/to/your/app_folder"
scInit(app_path = publish_folder)
```

### 2. Preparing Data via R Session
You can add datasets to the application programmatically by creating a configuration and then processing a Seurat object.

```r
library(Seurat)

# 1. Create configuration
appconf <- createAppConfig(
    title = "My_Dataset_Title",
    destinationFolder = "dataset_subdir", # Folder name within the app's data directory
    species = "Homo sapiens",
    doi = "10.1038/example",
    datatype = "scRNAseq",
    abstract = "Brief description of the study and data."
)

# 2. Create the dataset from a Seurat object
# publish_folder is the path used in scInit()
createDataSet(
    appconf,
    seurat_obj,
    datafolder = file.path(publish_folder, "data")
)
```

### 3. Launching the App
Once initialized and populated with data, launch the interactive interface.

```r
scRNAseqApp(app_path = publish_folder)
```

## Advanced Management

### Administrative Mode
The app includes an administrator interface for managing users and data.
- **Access**: Click the "Switch User" tab and select the "administrator" button (usually bottom-right).
- **Uploads**: You can upload Seurat objects directly through the "UploadData" tab in the UI without writing R code for `createDataSet`.

### Adding Downloadable Assets
To provide users with supplementary files (e.g., raw counts, differential expression tables):
1. Place files in `[app_path]/www/download`.
2. Create a text file named `readme` in the specific folder to provide a description that will appear in the app's download list.

### Deployment to Shiny Server
1. Install `scRNAseqApp` on the server.
2. Run `scInit()` on the server or copy a locally initialized folder to the server's app directory.
3. **Permissions**: Ensure the `www/` folder and `www/database.sqlite` are writable by the `shiny` user. SQLite requires write access to the directory to create temporary journal files.

## Reference documentation

- [scRNAseqApp Guide](./references/scRNAseqApp.md)