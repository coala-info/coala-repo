---
name: bioconductor-reusedata
description: ReUseData provides a standardized framework for managing genomic data through workflow-based recipes and a curated local or cloud-based data hub. Use when user asks to search for data recipes, generate curated genomic datasets, manage local data caches with metadata, or download pre-generated resources from the cloud.
homepage: https://bioconductor.org/packages/release/bioc/html/ReUseData.html
---

# bioconductor-reusedata

## Overview

ReUseData is a Bioconductor package designed for standardized data management. It uses "data recipes" (workflow-based scripts) to generate curated genomic data resources. The package provides a unified interface to search for existing recipes, evaluate them to produce data, and manage a local cache of datasets with rich metadata (notes, parameters, and tags). It also provides access to pre-generated cloud data from Google Cloud Storage.

## Core Workflows

### 1. Managing Data Recipes
Recipes are the templates used to generate data.

```r
library(ReUseData)
library(Rcwl)

# Update and search for recipes
recipeUpdate()
recipeSearch("gencode")

# Load a specific recipe
# Use return = FALSE to load into the global environment with its original name
recipeLoad("echo_out", return = FALSE) 

# Check required inputs for the loaded recipe
inputs(echo_out)
```

### 2. Generating Data from Recipes
Once a recipe is loaded, assign parameters and evaluate it using `getData()`.

```r
# Assign parameters to the recipe object
echo_out$input <- "Sample Data"
echo_out$outfile <- "sample_result"

# Evaluate recipe and save to a directory
outdir <- file.path(tempdir(), "MyData")
res <- getData(echo_out, 
               outdir = outdir, 
               notes = c("keyword1", "keyword2"))

# Access the generated file path
res$output
```

### 3. Searching and Using Cached Data
ReUseData maintains a local database (`dataHub`) of generated or annotated datasets.

```r
# Sync the local cache with a directory
dh <- dataUpdate(dir = outdir)

# Search for data using keywords
dh_match <- dataSearch(c("keyword1"))

# Retrieve metadata
dataNames(dh_match)
dataPaths(dh_match)
dataNotes(dh_match)

# Export data paths for use in other workflows (JSON/YAML/List)
toList(dh_match, format = "json")
```

### 4. Accessing Cloud Resources
Pre-generated datasets are available for direct download.

```r
# Sync with cloud records
dataUpdate(outdir, cloud = TRUE)

# Search cloud and local data
dh_cloud <- dataSearch(c("GRCh38", "ensembl"))

# Download cloud data to local directory
getCloudData(dh_cloud[1], outdir = outdir)
```

### 5. Annotating Existing Local Data
You can add metadata to existing files not created by ReUseData recipes.

```r
local_path <- "/path/to/existing_data"
annData(local_path, notes = c("experimental", "human", "v1"))
dataUpdate(local_path)
```

## Tips for Success
- **Environment Setup**: Ensure `cwltool` is installed. You can use `Rcwl::install_cwltool()` to set up the necessary runner.
- **Cache Paths**: If working across sessions, ensure `Sys.setenv(cachePath = "your/path")` is set consistently so the package can find your `recipeHub` and `dataHub`.
- **Recipe Instructions**: Always check the landing pages (e.g., `https://rcwl.org/dataRecipes/`) for specific recipes to understand valid input values for parameters like `species` or `version`.
- **Metadata**: Use descriptive `notes` during `getData()` or `annData()`. These are the primary keys used by `dataSearch()`.

## Reference documentation

- [ReUseData: Reusable and Reproducible Data Management](./references/ReUseData_data.md)
- [ReUseData: Reusable and Reproducible Data Management - quick start](./references/ReUseData_quickStart.md)
- [ReUseData: Workflow-based Data Recipes for Management of Reusable and Reproducible Data Resources](./references/ReUseData_recipe.md)