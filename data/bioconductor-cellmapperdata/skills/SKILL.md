---
name: bioconductor-cellmapperdata
description: This tool provides access to pre-processed microarray expression compendia for cell-type specific gene expression prediction. Use when user asks to retrieve SVD-transformed CellMapperList objects from ExperimentHub or access specialized datasets for the CellMapper package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/CellMapperData.html
---


# bioconductor-cellmapperdata

name: bioconductor-cellmapperdata
description: Access and use pre-processed microarray expression compendia from the CellMapperData package. Use this skill when you need to retrieve specialized CellMapperList objects (SVD-transformed data) from ExperimentHub for use with the CellMapper package's CMsearch function to predict cell-type specific gene expression.

# bioconductor-cellmapperdata

## Overview

CellMapperData provides a collection of large-scale microarray expression datasets that have been pre-processed specifically for use with the `CellMapper` R package. These datasets have undergone Singular Value Decomposition (SVD) and noise filtering (Kaiser’s criterion) to create `CellMapperList` objects. This pre-processing significantly reduces file size and computational time, allowing for rapid gene expression inference in difficult-to-isolate cell types.

## Loading Data

The datasets are hosted on ExperimentHub. To access them, you must query the hub and then retrieve the specific record by its accession number.

```r
library(ExperimentHub)
library(CellMapperData)

# Query ExperimentHub for CellMapperData records
hub <- ExperimentHub()
cm_query <- query(hub, "CellMapper.Data")

# View available datasets
cm_query

# Retrieve a specific dataset (e.g., Allen Brain Atlas)
brain_atlas <- cm_query[["EH170"]]
```

## Available Datasets

The package typically includes the following pre-processed compendia:
- **EH170**: Allen Brain Atlas (Human)
- **EH171**: Affymetrix HG-U133PlusV2 compendium
- **EH172**: Affymetrix HG-U133A platform
- **EH173**: Affymetrix MG-U74Av2 platform (Mouse)
- **EH174**: Human small and large intestine
- **EH175**: Human kidney

## Workflow: Using CellMapperData with CellMapper

The primary use case for these objects is as the `Dataset` argument in the `CMsearch` function from the `CellMapper` package.

```r
library(CellMapper)

# Define your query genes (genes known to be expressed in your target cell type)
# Note: Ensure gene IDs match the format in the CellMapperList (e.g., Entrez IDs)
query_genes <- c("733", "735") 

# Run the search using the pre-processed data
results <- CMsearch(brain_atlas, queryGenes = query_genes)

# View top predicted genes
head(results)
```

## Technical Structure

Each dataset is a `CellMapperList` containing:
- `B`: A matrix of left-singular vectors.
- `d`: A vector of singular values.

Because the SVD is already performed, you do not need to run `CMprep` on these objects; they are ready for immediate search.

## Reference documentation

- [Intro to the CellMapperData Package](./references/CellMapperData.md)