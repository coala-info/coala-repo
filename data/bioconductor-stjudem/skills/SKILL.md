---
name: bioconductor-stjudem
description: The stjudem package provides a specialized gene expression dataset from pediatric acute lymphoblastic leukemia patients formatted for Microarray Analysis of Chromosomal Aberrations. Use when user asks to access the Yeoh et al. leukemia dataset, perform MACAT analysis, or investigate chromosomal regions of differential expression in ALL subtypes.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/stjudem.html
---


# bioconductor-stjudem

## Overview
The `stjudem` package provides a specialized dataset for Microarray Analysis of Chromosomal Aberrations (MACAT). It contains gene expression data from 327 pediatric acute lymphoblastic leukemia (ALL) patients. The data has been preprocessed using variance stabilizing normalization (vsn) and median polish summarization. It is uniquely structured to include chromosomal locations for each probe set, making it ideal for identifying regions of differential expression across the genome.

## Data Structure
The primary object in this package is `stjude`, which is a list of class `MACATData`. It contains the following components:

*   `expr`: The expression matrix (rows = genes/probe sets, columns = samples).
*   `labels`: A factor indicating the leukemia subtype for each sample (e.g., BCR-ABL, E2A-PBX1, Hyperdiploid, MLL, T-ALL, TEL-AML1).
*   `geneName`: Identifiers for the genes or probe sets.
*   `chromosome`: The chromosome assigned to each gene.
*   `geneLocation`: The physical location (base pairs from 5' end) of the gene on the chromosome.
*   `chip`: The microarray platform used (Affymetrix HG-U95av2).

## Typical Workflow

### 1. Loading the Data
To begin analysis, load the package and the dataset:
```r
library(stjudem)
data(stjude)
```

### 2. Data Exploration
Examine the structure and summary of the MACATData object:
```r
# View summary of the dataset
summary(stjude)

# Check the available leukemia subtypes
table(stjude$labels)

# Inspect the expression matrix dimensions
dim(stjude$expr)
```

### 3. Accessing Specific Components
Since the data is stored as a list, you can access specific genomic or expression information directly:
```r
# Get expression values for the first 5 genes across all samples
stjude$expr[1:5, ]

# View chromosomal mapping for the first 10 genes
data.frame(
  Gene = stjude$geneName[1:10],
  Chr = stjude$chromosome[1:10],
  Location = stjude$geneLocation[1:10]
)
```

## Usage Tips
*   **MACAT Integration**: This package is specifically designed to be used with the `MACAT` library. Functions in `MACAT` (like `evalScoring` or `plotChrom`) expect the `MACATData` list format provided by `stjude`.
*   **Subtype Analysis**: The `labels` component is essential for supervised analysis. Use it to group columns in the `expr` matrix for differential expression testing between ALL subtypes.
*   **Coordinate System**: Note that negative numbers in `geneLocation` denote genes located on the antisense strand.

## Reference documentation
- [Microarray Data from Yeoh et al. in MACAT format](./references/reference_manual.md)