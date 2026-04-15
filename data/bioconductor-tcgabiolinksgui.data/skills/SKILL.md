---
name: bioconductor-tcgabiolinksgui.data
description: This package provides supporting reference data, gene annotations, and pre-trained machine learning models for the TCGAbiolinksGUI ecosystem. Use when user asks to access hg19/hg38 gene annotations, classify glioma subtypes using DNA methylation models, or retrieve GDC project metadata.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TCGAbiolinksGUI.data.html
---

# bioconductor-tcgabiolinksgui.data

name: bioconductor-tcgabiolinksgui.data
description: Provides supporting data for the TCGAbiolinksGUI package, including gene annotations (hg19/hg38), pre-trained Random Forest models for glioma classification, GDC project lists, and linkedOmics metadata. Use when performing cancer genomics analysis that requires these specific reference datasets or when using the TCGAbiolinksGUI workflow.

# bioconductor-tcgabiolinksgui.data

## Overview
The `TCGAbiolinksGUI.data` package is a data-only experiment package designed to support the `TCGAbiolinksGUI` ecosystem. It centralizes reference datasets, genomic annotations, and pre-trained machine learning models used for classifying cancer subtypes (specifically gliomas) and navigating the Genomic Data Commons (GDC).

## Installation
Install the package using `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("TCGAbiolinksGUI.data")
```

## Data Objects
The package provides several key objects accessible via the `data()` function.

### Gene Annotation and TSS
These objects provide genomic coordinates for genes and Transcription Start Sites (TSS) for different genome builds.
- `gene.location.hg38` / `gene.location.hg19`: Gene coordinates.
- `gene.location.hg38.tss` / `gene.location.hg19.tss`: TSS coordinates.

### Glioma Classification Models
Pre-trained `caret` Random Forest models based on DNA methylation signatures (Ceccarelli et al., 2016).
- `glioma.idh.model`: Classifies between IDHmut and IDHwt.
- `glioma.idhmut.model`: Classifies IDHmut specific clusters (K1, K2, K3).
- `glioma.gcimp.model`: Classifies between G-CIMP-low and G-CIMP-high.
- `glioma.idhwt.model`: Classifies IDHwt specific clusters (K1, K2, K3).

### GDC and Project Metadata
- `GDCdisease`: A named vector of available GDC projects (TCGA and TARGET).
- `maf.tumor`: A list of tumors with available open-access MAF files in GDC.
- `linkedOmics.data`: Parsed metadata and download links for the linkedOmics database.

### Platform Specific Data
- `probes2rm`: A character vector of Illumina EPIC array probes recommended for removal due to library version differences.

## Usage Examples

### Loading and Inspecting Data
To use any dataset, load the package and call `data()`:

```r
library(TCGAbiolinksGUI.data)

# Load GDC disease list
data("GDCdisease")
head(GDCdisease)

# Load gene locations for hg38
data("gene.location.hg38")
```

### Using Glioma Models
The models are `train` objects from the `caret` package. You can use them to predict subtypes for new DNA methylation data.

```r
data("glioma.idh.model")

# Inspect model details
print(glioma.idh.model)

# Predict using new data (requires matching probe signatures)
# predictions <- predict(glioma.idh.model, newdata = your_methylation_matrix)
```

### Filtering EPIC Probes
Use the `probes2rm` list to clean methylation datasets:

```r
data("probes2rm")
# Assuming 'meth' is a matrix with probe IDs as rownames
meth_filtered <- meth[!rownames(meth) %in% probes2rm, ]
```

## Reference documentation
- [Supporting data for the TCGAbiolinksGUI package](./references/vignettes.md)