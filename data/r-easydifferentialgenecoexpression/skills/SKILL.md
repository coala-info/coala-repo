---
name: r-easydifferentialgenecoexpression
description: This package performs differential gene coexpression analysis by automating data retrieval from GEO and identifying gene pairs with significant correlation changes between conditions. Use when user asks to perform differential coexpression analysis, download and preprocess GEO expression data, or map gene symbols to platform-specific probesets for correlation studies.
homepage: https://cran.r-project.org/web/packages/easydifferentialgenecoexpression/index.html
---

# r-easydifferentialgenecoexpression

## Overview
The `easyDifferentialGeneCoexpression` package provides a streamlined workflow for performing differential coexpression analysis. It automates the retrieval of gene expression data from GEO, maps gene symbols to platform-specific probesets, and identifies pairs of genes whose correlation significantly changes between two defined conditions. It is specifically designed to be accessible for users with limited R experience.

## Installation
To install the package from CRAN:
```R
install.packages("easyDifferentialGeneCoexpression")
library(easyDifferentialGeneCoexpression)
```

## Main Function
The package primarily operates through a single, comprehensive function:

### easyDifferentialGeneCoexpression()
This function performs the entire pipeline: data download, preprocessing, and differential coexpression calculation.

**Arguments:**
- `inputGeneList`: A vector of microarray probesets or gene symbols.
- `geoCode`: The GEO accession code (e.g., "GSE16237").
- `conditionFeature`: The name of the metadata column in the GEO dataset that discriminates the two conditions.
- `conditionValue1`: The value in `conditionFeature` representing the first group (e.g., "Disease").
- `conditionValue2`: The value in `conditionFeature` representing the second group (e.g., "Control").
- `verbose`: Boolean (TRUE/FALSE) to toggle progress messages.

## Workflow Example
To analyze a specific set of probesets in a GEO dataset:

```R
library(easyDifferentialGeneCoexpression)

# 1. Define inputs
probesets <- c("200738_s_at", "217356_s_at", "206686_at", "226452_at")
dataset_id <- "GSE16237"
metadata_column <- "outcome of the patient:ch1"

# 2. Run analysis
# This will download the dataset, filter for the probesets, 
# and compare "Died of disease" vs "Alive"
results <- easyDifferentialGeneCoexpression(
  inputGeneList = probesets,
  geoCode = dataset_id,
  conditionFeature = metadata_column,
  conditionValue1 = "Died of disease",
  conditionValue2 = "Alive",
  verbose = TRUE
)

# 3. Inspect results
# The function returns a data frame of significant gene pairs
print(head(results))
```

## Supported Platforms
The package includes built-in support for mapping gene symbols for several common Affymetrix and Illumina platforms, including:
- GPL80, GPL96, GPL570, GPL571
- GPL6102, GPL6104, GPL6883, GPL6884
- GPL8300, GPL1293, GPL6480, GPL14550

## Tips
- **Metadata Discovery**: Before running the main function, use `GEOquery` to inspect the metadata of your target GSE to find the exact string for `conditionFeature` and its values.
- **Gene Symbols**: If you provide gene symbols instead of probesets, the package uses `jetset` and `org.Hs.eg.db` to select the best-performing probeset for each gene.
- **Data Source**: Data is fetched directly from the NCBI GEO FTP servers. Ensure you have an active internet connection.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)