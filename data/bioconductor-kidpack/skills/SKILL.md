---
name: bioconductor-kidpack
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/kidpack.html
---

# bioconductor-kidpack

name: bioconductor-kidpack
description: Expert assistance for the Bioconductor package 'kidpack', a data package containing gene expression data from renal cell cancer biopsies. Use this skill to access, explore, and analyze the Sültmann kidney cancer dataset, including processed ExpressionSets and raw spotting/hybridization metadata.

# bioconductor-kidpack

## Overview
The `kidpack` package provides a specialized dataset from a 2002 study by Holger Sültmann at the German Cancer Research Centre (DKFZ). It contains cDNA microarray data from approximately 74 renal cell cancer (RCC) biopsies, covering three subtypes: clear cell (ccRCC), papillary (pRCC), and chromophobe (chRCC). The package is essential for researchers looking to benchmark classification algorithms or study differential expression in kidney cancer.

## Data Objects
The package contains five primary data objects. Load them using `data()` after loading the library.

### Processed Data
- `eset`: An `ExpressionSet` object containing processed expression values for 74 samples and 4224 clones (spotted in duplicate).
- `cloneanno`: A data frame providing annotation for the 4224 clones (e.g., GenBank accession numbers, descriptions, and vendor info).

### Raw Data
- `qua`: A 3D array (8704 spots x 13 variables x 175 hybridizations) containing raw intensity data (e.g., `fg.green`, `bg.green`).
- `hybanno`: Metadata for the 175 hybridizations (filenames, patient IDs, slide IDs).
- `spotanno`: Mapping between the 8704 spots on the array and the 4224 clones.

## Typical Workflows

### 1. Accessing Phenotype Data
The `eset` object contains clinical variables useful for classification:
```r
library(kidpack)
data(eset)

# View available clinical variables
varLabels(eset)

# Access cancer subtypes
subtypes <- pData(eset)$type 
# Values: "ccRCC", "pRCC", "chRCC"

# Access survival data
survival_time <- pData(eset)$survival.time
metastasis_status <- pData(eset)$m
```

### 2. Gene-Specific Analysis
To find and plot expression for specific genes (e.g., Fibronectin 1):
```r
data(cloneanno)

# Search for clones by description
sel <- grep("fibronectin 1", cloneanno$description, ignore.case = TRUE)
clones <- cloneanno[sel, ]

# Extract expression values from eset for these clones
eo <- eset[sel, ]
expression_matrix <- exprs(eo)

# Plot expression grouped by subtype
plot(exprs(eo)[1, ], col=as.factor(pData(eo)$type), main="FN1 Expression")
```

### 3. Linking Clones to Raw Spot Data
The `cloneanno` object contains indices (`spot1`, `spot2`) that refer to rows in the raw `qua` and `spotanno` objects.
```r
data(qua)
data(cloneanno)

# Get spot indices for a specific clone
s1 <- cloneanno$spot1[1]
s2 <- cloneanno$spot2[1]

# Access raw green foreground intensity for the first 3 hybridizations
raw_vals <- qua[s1, "fg.green", 1:3]
```

## Tips and Best Practices
- **Duplicate Spots**: Remember that each clone is spotted twice. The `eset` object represents processed data where these duplicates are typically handled, but `qua` contains the individual spot measurements.
- **Subtype Visualization**: When plotting, use the `type` variable from `pData(eset)` to color-code samples, as expression is strongly associated with the RCC subtype.
- **Missing Data**: Be aware that while 175 chips were scanned, the `eset` object contains a filtered set of 74 high-quality representative chips.

## Reference documentation
- [Overview over the DKFZ kidney data package](./references/kidpack.md)