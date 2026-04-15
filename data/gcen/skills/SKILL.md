---
name: gcen
description: gcen is a toolkit for constructing gene co-expression networks and predicting gene functions from RNA-Seq data. Use when user asks to build co-expression networks, identify functional gene modules, or predict the functions of uncharacterized genes like lncRNAs.
homepage: https://www.biochen.com/gcen/
metadata:
  docker_image: "quay.io/biocontainers/gcen:0.6.3--h9f5acd7_3"
---

# gcen

## Overview
gcen is a specialized command-line toolkit designed to bridge the gap between raw RNA-Seq expression data and biological insights. It streamlines the complex process of building co-expression networks, identifying clusters of co-regulated genes (modules), and predicting the functions of uncharacterized genes, particularly lncRNAs. It is optimized for performance through multithreading and is suitable for researchers who need a modular, efficient pipeline for systems biology.

## Usage Guidelines

### Core Pipeline Stages
The gcen workflow typically follows these four sequential steps:
1.  **Data Pretreatment**: Cleaning and normalizing input expression matrices.
2.  **Network Construction**: Calculating correlation coefficients and establishing links between gene pairs.
3.  **Module Identification**: Clustering genes into functional modules based on network topology.
4.  **Function Annotation**: Assigning biological roles to modules or specific genes (e.g., lncRNAs) based on guilt-by-association.

### Best Practices
- **Multithreading**: Always leverage the multithreaded implementation for large RNA-Seq datasets to reduce computation time during the correlation and network construction phases.
- **Input Format**: Ensure expression data is formatted as a matrix where rows represent genes and columns represent samples/conditions.
- **lncRNA Annotation**: When using gcen for lncRNA annotation, include well-characterized protein-coding genes in your network construction to facilitate functional prediction via co-expression.
- **Modular Integration**: Since gcen is modular, you can extract specific outputs (like module membership) to use in downstream visualization tools or alternative enrichment analysis suites.

### Installation
The tool is available via Bioconda. To set up the environment:
```bash
conda install bioconda::gcen
```

## Reference documentation
- [gcen Overview](./references/anaconda_org_channels_bioconda_packages_gcen_overview.md)