---
name: r-saccharis
description: R package saccharis (documentation from project home).
homepage: https://cran.r-project.org/web/packages/saccharis/index.html
---

# r-saccharis

name: r-saccharis
description: Use this skill when working with the R package 'saccharis' (rsaccharis) to visualize and analyze phylogenetic trees generated from SACCHARIS 2 outputs. It provides guidance on loading .json and .tree files, generating default PDF plots, and managing CAZy metadata.

## Overview

The `saccharis` (or `rsaccharis`) R package is a rendering tool specifically designed to create phylogenetic trees from SACCHARIS 2 output files. It automates the process of mapping CAZy metadata onto trees and produces publication-quality PDF visualizations.

## Installation

To install the package from CRAN:

```R
install.packages("saccharis")
```

To install the development version from GitHub:

```R
# install.packages("devtools")
devtools::install_github("saccharis/rsaccharis")
```

## Workflow

The standard workflow consists of two primary steps: loading the data and generating the plots.

### 1. Loading Data
Ensure your working directory contains the `.json` and `.tree` files produced by SACCHARIS 2.

```R
library(rsaccharis)
A_load_data()
```
*Note: This function will interactively prompt you to enter the filenames for your specific SACCHARIS output files.*

### 2. Generating Plots
Once the data is loaded, use the following function to generate the default suite of phylogenetic plots.

```R
B_plots_all()
```
*Note: All plots are saved as PDF files in the current working directory. These are vector graphics and can be further edited in software like Inkscape or Adobe Illustrator.*

## Key Outputs

- **PDF Plots**: Visual representations of the phylogenetic trees with CAZy annotations.
- **CSV Metadata**: A generated `.csv` file that includes all CAZy metadata merged with the unique Tree IDs assigned during the plotting process.

## Tips for Success

- **Working Directory**: Always set your working directory (`setwd()`) to the folder containing your SACCHARIS results before running `A_load_data()`.
- **Metadata Analysis**: Use the produced `.csv` file for downstream statistical analysis, as it provides the mapping between the tree structure and the functional CAZy data.

## Reference documentation

- [LICENSE.md](./references/LICENSE.md)
- [MAINTENANCE.md](./references/MAINTENANCE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)