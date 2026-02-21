---
name: bioconductor-estrogen
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/estrogen.html
---

# bioconductor-estrogen

name: bioconductor-estrogen
description: Analysis of Affymetrix microarray data using the estrogen 2x2 factorial design dataset. Use this skill to load CEL files, perform normalization (vsnrma), visualize chip intensities (histograms, boxplots, scatterplots), and conduct ANOVA-based differential expression analysis for estrogen and time effects.

## Overview

The `estrogen` package is a Bioconductor data package containing CEL files and phenotypic data for a 2x2 factorial experiment. It is primarily used as a case study for learning how to handle `AffyBatch` objects, perform normalization with the `vsn` package, and apply linear models to microarray data.

## Typical Workflow

### 1. Data Loading and Preparation
The package contains raw data in its `extdata` directory. You must locate these files and pair them with the provided phenotypic metadata.

```r
library(affy)
library(estrogen)
library(vsn)

# Locate the data directory
datadir <- system.file("extdata", package="estrogen")

# Load phenotypic data (sample info)
pd <- read.AnnotatedDataFrame(file.path(datadir, "estrogen.txt"), 
                              header = TRUE, sep = "", row.names = 1)

# Load CEL files into an AffyBatch object
raw_data <- ReadAffy(filenames = file.path(datadir, rownames(pData(pd))),
                     phenoData = pd)
```

### 2. Normalization
Use `vsnrma` to perform variance stabilizing normalization and robust multi-array analysis. This converts the `AffyBatch` object into a normalized `ExpressionSet`.

```r
# Normalize data
x <- vsnrma(raw_data)
```

### 3. Quality Control and Visualization
Visualizing the data helps identify spatial artifacts or distribution shifts.

- **Spatial Images**: `image(raw_data[, 1])`
- **Histograms**: `hist(raw_data, lty=1)`
- **Boxplots**: `boxplot(raw_data)` (raw) or `boxplot(exprs(x))` (normalized)
- **Scatterplots**: `plot(exprs(x)[, 1:2])`

### 4. Differential Expression Analysis (ANOVA)
To analyze the factorial design (Estrogen x Time), fit a linear model to each gene using `esApply`.

```r
# Define a function to extract coefficients from a linear model
lm.coef <- function(y) lm(y ~ estrogen * time.h)$coefficients

# Apply the model across all genes in the ExpressionSet
eff <- esApply(x, 1, lm.coef)

# 'eff' contains: (Intercept), estrogenpresent, time.h, and the interaction
```

### 5. Annotation and Results
Map the Affymetrix probe IDs to gene symbols or names using the `hgu95av2.db` annotation package.

```r
library(hgu95av2.db)

# Find genes with the highest estrogen effect
highest_estrogen <- sort(eff["estrogenpresent", ], decreasing=TRUE)[1:5]
mget(names(highest_estrogen), hgu95av2GENENAME)
```

## Tips and Best Practices
- **Factorial Design**: Ensure `estrogen` and `time.h` are treated as factors in your linear model to correctly interpret the main effects and the interaction term.
- **Data Access**: Use `exprs(x)` to access the matrix of normalized expression values from the `ExpressionSet`.
- **Variation Filtering**: To focus on the most interesting genes before complex modeling, you can filter by row standard deviation: `rsd <- rowSds(exprs(x))`.

## Reference documentation
- [Working with Affymetrix data: estrogen, a 2x2 factorial design example](./references/estrogen.md)