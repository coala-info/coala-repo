---
name: bioconductor-biocancer
description: This tool provides an interactive interface for visualizing and analyzing multi-OMICS cancer data from cBioPortal. Use when user asks to access cancer genomics data, perform gene classification by disease subtype, cluster cancer studies, or generate functional interaction networks with multi-OMICS overlays.
homepage: https://bioconductor.org/packages/release/bioc/html/bioCancer.html
---

# bioconductor-biocancer

name: bioconductor-biocancer
description: Interactive multi-OMICS cancer data visualization and analysis using the bioCancer package. Use this skill to access cBioPortal data, perform gene classification, cluster cancer studies, and generate functional interaction networks with multi-OMICS overlays.

# bioconductor-biocancer

## Overview
The `bioCancer` package provides a graphical user interface (Shiny-based) and a set of R functions to interact with cancer genomics data from cBioPortal. It enables researchers to visualize multi-OMICS data (CNA, mRNA, Mutation, Methylation, miRNA, RPPA) across 105+ cancer studies. Key capabilities include gene classification by disease subtype, circular layouts for multi-matrix visualization, and functional interaction network enrichment.

## Core Workflow

### Launching the Interface
The primary way to use `bioCancer` is through its interactive Shiny application.
```r
library(bioCancer)
bioCancer()
```

### Data Acquisition and Management
While the GUI is the main entry point, the package handles several data types:
- **Cancer Studies**: Metadata for available studies (Identity, Name, Description).
- **Clinical Data**: Patient-level information (Age, Gender, etc.).
- **Genetic Profiles**: OMICS data for specific gene lists across cases.
- **Datasets**: Internal storage for processed data frames (e.g., `xCNA`, `xmRNA`).

### Key Analysis Modules

#### 1. Multi-OMICS Circular Layout (Circomics)
Visualizes multiple matrices of OMICS data simultaneously using a circular layout.
- **Availability**: Check which dimensions (e.g., CNA, mRNA) are available for a study.
- **Loading**: Merges profiles by study into datasets like `xCNA` or `xMut` for downstream analysis.

#### 2. Gene Classification
Uses the `geNetClassifier` method to rank and classify genes by disease subtype based on mRNA expression.
- **Process**: Select studies -> Set sample size/posterior probability -> Run Classifier.
- **Output**: A ranking table associating genes with specific studies/classes and their expression sign (`exprsUpDw`).

#### 3. Enrichment and Clustering
- **Gene/Disease Association**: Predicts diseases involved in a gene list using `DisGeNET` annotations.
- **Ontology Clustering**: Performs Disease Ontology (DO), Gene Ontology (GO), and KEGG pathway enrichment analysis using `clusterProfiler`.

#### 4. Functional Interaction (FI) Networks
Constructs networks where nodes are genes and edges are functional interactions.
- **Node Attributes**: Size can represent the number of interactions; color can represent mRNA expression or study association.
- **Linkers**: Option to include non-input genes to connect the user's gene list.
- **Layouts**: Supports `dot`, `neato`, `twopi`, and `circo` engines.

## Data Transformation Tips
The package includes a "Processing" panel that leverages `dplyr` for data manipulation:
- **Joins**: Supports `inner_join`, `left_join`, `full_join`, `semi_join`, and `anti_join` to combine clinical and profile data.
- **Mutations**: Use the `Create` or `Transform` functions to log-transform, standardize, or recode variables.
- **Filtering**: Use R-style logic (e.g., `FreqMut > 10 & FreqMut < 20`) to subset data.

## Reference documentation
- [bioCancer: Interactive Multi-OMICS Cancers Data Visualization and Analysis](./references/bioCancer.md)
- [bioCancer Vignette Source](./references/bioCancer.Rmd)