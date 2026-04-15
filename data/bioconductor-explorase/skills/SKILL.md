---
name: bioconductor-explorase
description: This tool provides a framework for the exploratory analysis, visualization, and linear modeling of high-throughput systems biology data. Use when user asks to perform multivariate exploratory data analysis, integrate experimental data with metadata, identify biological patterns, or perform linear modeling with limma.
homepage: https://bioconductor.org/packages/3.9/bioc/html/explorase.html
---

# bioconductor-explorase

name: bioconductor-explorase
description: Exploratory analysis and visualization of systems biology data (transcriptomics, proteomics, metabolomics). Use this skill to perform multivariate exploratory data analysis, integrate experimental data with metadata, perform linear modeling (limma), and identify biological patterns or interesting entities.

## Overview

The `explorase` package provides a framework for the exploratory analysis of high-throughput biological data. It integrates R/Bioconductor statistical methods with interactive visualization (via GGobi). It is designed to handle multiple entity types (genes, proteins, metabolites) and their associated metadata, experimental designs, and list memberships.

## Core Workflow

### 1. Starting the Interface
The primary way to interact with `explorase` is through its Graphical User Interface (GUI).
```R
library(explorase)
explorase()
```

### 2. Data Loading and Project Structure
`explorase` uses a specific file-naming convention to automatically detect data types. Files should be in CSV format.

| Data Type | File Extension | Example |
| :--- | :--- | :--- |
| Experimental Data | `.data` | `sample.gene.data` |
| Entity Metadata | `.info` | `sample.gene.info` |
| Experimental Design | `.design` | `sample.gene.design` |
| Entity Lists | `.list` | `hits.list` |

**Project Loading:** Place all related files in a single directory and use the "Open Project" feature in the GUI to load them simultaneously.

### 3. Data Preprocessing Requirements
`explorase` is not a preprocessing tool. Data must be normalized and log-transformed before loading.
- **Experimental Data:** Matrix with conditions as columns and unique entity IDs as the first column.
- **Design Matrix:** First column must match column names in the experimental data. Factors like `time` and `replicate` have special functional meanings.

### 4. Analysis Methods

#### Finding Interesting Entities
Use the `Analysis` menu to identify entities that differ between conditions:
- **Difference:** Simple subtraction between two conditions.
- **Regression Residuals:** Regress one condition against another.
- **Mahalanobis Distance:** Multivariate distance across conditions.
- **Distance Measures:** Euclidean or Pearson correlation to find entities similar to a target.

#### Pattern Finding and Clustering
- **Pattern Finder:** Identifies entities rising or dropping across transitions (e.g., time courses). Results are displayed as arrows (up/down).
- **Hierarchical Clustering:** Clusters entities based on experimental data; results are shown in an interactive R plot where clicking nodes selects entities in the main table.

#### Linear Modeling
Access these via the `Model` menu:
- **limma:** Fits linear models for experimental treatments and interactions.
- **Temporal Modeling:** Fits polynomial time models using `lm()`.

### 5. Visualization with GGobi
If GGobi is installed, `explorase` synchronizes colors and selections between the metadata table and GGobi plots.
- **Brushing:** Use the Brush tool in the toolbar to color entities.
- **Synchronization:** Colors assigned in the GUI appear on glyphs in GGobi scatterplots or histograms.

## Common Tasks

**Averaging Replicates:**
To simplify analysis, use `Tools -> Average over the replicates`. This calculates means/medians and adds them as new variables for analysis.

**Filtering Data:**
Use the expandable Filter panel above the entity table.
- **Character data:** Supports "starts with", "contains", and regular expressions.
- **Numeric data:** Supports standard comparison operators (`>`, `<`, `==`).

## Reference documentation

- [exploRase: Multivariate exploratory analysis and visualization for systems biology](./references/explorase.md)