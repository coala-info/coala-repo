---
name: bioconductor-cliquems
description: This tool annotates LC/MS metabolomics data by grouping features into cliques and identifying isotopes, adducts, and fragments to determine neutral masses. Use when user asks to group features into cliques, identify isotopes and adducts, or annotate untargeted metabolomics data processed with xcms.
homepage: https://bioconductor.org/packages/release/bioc/html/cliqueMS.html
---


# bioconductor-cliquems

name: bioconductor-cliquems
description: Annotate LC/MS metabolomics data by grouping features into cliques and identifying isotopes, adducts, and fragments. Use when processing untargeted metabolomics data from xcms to reduce feature complexity, identify neutral masses, and annotate ion adducts.

# bioconductor-cliquems

## Overview

The `cliqueMS` package provides a pipeline for the annotation of Liquid Chromatography/Mass Spectrometry (LC/MS) untargeted metabolomics data. It addresses the "feature-to-metabolite" problem by grouping features that likely originate from the same metabolite based on coelution similarity networks.

The workflow follows three primary steps:
1. **Feature Grouping**: Dividing features into "cliques" using a similarity network.
2. **Isotope Annotation**: Identifying carbon isotopes within each clique.
3. **Adduct/Fragment Annotation**: Identifying adducts and fragments to estimate the neutral mass of the parent metabolite.

## Core Workflow

### 1. Data Preparation
`cliqueMS` works with `XCMSnExp` or `xcmsSet` objects produced by the `xcms` package.

```r
library(cliqueMS)
library(xcms)

# Example: Load and process raw data with xcms
mzraw <- readMSData(files = "data.mzXML", mode = "onDisk")
cpw <- CentWaveParam(ppm = 15, peakwidth = c(5, 20), snthresh = 10)
mzData <- findChromPeaks(object = mzraw, param = cpw)
```

### 2. Feature Grouping (Cliques)
The `getCliques` function builds a similarity network where nodes are features and edges represent cosine similarity of elution profiles. It uses a probabilistic model to find fully connected components (cliques).

```r
# filter = TRUE is recommended to remove artifact/repeated features
ex.cliqueGroups <- getCliques(mzData, filter = TRUE)
```

### 3. Isotope Annotation
Once cliques are formed, `getIsotopes` identifies isotopes based on mass differences and intensity ratios (monoisotopic peaks must be more intense).

```r
ex.Isotopes <- getIsotopes(ex.cliqueGroups, ppm = 10)
```

### 4. Adduct and Fragment Annotation
The final step identifies adducts and fragments. You must provide an adduct information table and specify the polarity.

```r
# Load default adduct information
data(positive.adinfo) # or negative.adinfo

ex.Adducts <- getAnnotation(ex.Isotopes, 
                            ppm = 10,
                            adinfo = positive.adinfo, 
                            polarity = "positive",
                            normalizeScore = TRUE)
```

## Key Functions and Objects

### The anClique Object
All results are stored in an `anClique` S4 object.
- `createanClique(mzData)`: Manually initialize an object from xcms data.
- `show(object)`: View a summary of cliques, isotopes, and annotations found.

### Result Extraction
- `getPeaklistanClique(object)`: Returns a data frame containing the original feature data plus annotation columns (`an1`, `mass1`, etc., representing the top 5 scoring annotations).
- `getlistofCliques(object)`: Returns a list where each element contains the indices of features belonging to that clique.

## Tips for Effective Annotation

- **Adduct Lists**: The package provides `positive.adinfo` and `negative.adinfo`. You can customize these data frames if you expect specific fragments or rare adducts.
- **Scoring**: `getAnnotation` scores combinations of neutral masses and adducts. A `normalizeScore` of 100 indicates a high-confidence match where features align with frequent adducts.
- **Computational Efficiency**: For very large cliques, parameters like `topmasstotal` and `topmassf` control how many candidate neutral masses are evaluated to prevent long runtimes.
- **Filtering**: Always use `filter = TRUE` in `getCliques` unless you have already performed rigorous feature filtering in `xcms`, as redundant features can distort the network logic.

## Reference documentation
- [Annotating LC/MS data with cliqueMS](./references/annotate_features.md)
- [Annotating LC/MS data with cliqueMS (RMarkdown)](./references/annotate_features.Rmd)