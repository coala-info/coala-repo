---
name: bioconductor-prolocdata
description: This package provides a comprehensive collection of mass-spectrometry based spatial proteomics data sets for analysis and exploration. Use when user asks to access example organelle proteomics data, load spatial proteomics data sets like LOPIT or hyperLOPIT, or reproduce protein localization studies.
homepage: https://bioconductor.org/packages/release/data/experiment/html/pRolocdata.html
---


# bioconductor-prolocdata

name: bioconductor-prolocdata
description: Access and explore a comprehensive collection of mass-spectrometry based spatial proteomics data sets. Use when you need example data for organelle proteomics, protein localization analysis, or to reproduce studies from major spatial proteomics publications (e.g., LOPIT, PCP, hyperLOPIT).

# bioconductor-prolocdata

## Overview
The `pRolocdata` package is a data-only experiment package that accompanies the `pRoloc` software suite. It provides a wide range of mass-spectrometry based spatial proteomics data sets from various species (Human, Mouse, Arabidopsis, Drosophila, etc.) and experimental designs (LOPIT, hyperLOPIT, PCP, and protein complex separation). Most data sets are stored as `MSnSet` objects from the `MSnbase` package.

## Core Workflow

### 1. List Available Data Sets
To see all available data sets in the package:
```r
library(pRolocdata)
pRolocdata()
```

### 2. Load a Specific Data Set
Data sets are loaded using the standard R `data()` function.
```r
# Load the 2015 Mouse Stem Cell hyperLOPIT data
data(hyperLOPIT2015)

# Inspect the object
hyperLOPIT2015
```

### 3. Inspect Metadata
Use `pRolocmetadata` to extract experimental details associated with the data.
```r
pRolocmetadata(hyperLOPIT2015)
```

### 4. Access Data Components
Since most objects are `MSnSet` class, use `MSnbase` accessors:
```r
# Quantitative data (intensities/ratios)
head(exprs(hyperLOPIT2015))

# Feature metadata (protein markers, descriptions, SVM scores)
head(fData(hyperLOPIT2015))

# Sample metadata (fraction info, TMT tags)
pData(hyperLOPIT2015)
```

## Common Data Sets
- **hyperLOPIT2015**: Mouse E14TG2a embryonic stem cells (Christoforou et al. 2016). High-resolution map.
- **dunkley2006**: Arabidopsis thaliana LOPIT data (Dunkley et al. 2006).
- **andy2011**: Human HEK293T cells (Breckels et al. 2013).
- **E14TG2a**: Mouse embryonic stem cells (Breckels et al. 2016).
- **yeast2018**: Saccharomyces cerevisiae hyperLOPIT data.

## Integration with pRoloc
These data sets are designed to be used directly with `pRoloc` for visualization and machine learning:
```r
library(pRoloc)

# Visualize the data in 2D (PCA by default)
plot2D(hyperLOPIT2015)
addLegend(hyperLOPIT2015, where = "topright", cex = 0.6)

# Check marker distribution
table(fData(hyperLOPIT2015)$markers)
```

## Tips
- **Missing Values**: Some older data sets (e.g., `foster2006`) contain missing values. Use `MSnbase::filterNA()` or `pRoloc::filterBinMSnSet()` to handle them before analysis.
- **Markers**: The `markers` column in `fData` typically contains the curated set of proteins with known sub-cellular localization used for training classifiers.
- **Versions**: Some data sets have multiple versions (e.g., `r1`, `r2` for replicates, or `_se` for `SummarizedExperiment` format).

## Reference documentation
- [pRolocdata](./references/reference_manual.md)