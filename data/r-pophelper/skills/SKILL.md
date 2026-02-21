---
name: r-pophelper
description: R package pophelper (documentation from project home).
homepage: https://cran.r-project.org/web/packages/pophelper/index.html
---

# r-pophelper

## Overview
The `pophelper` package is a comprehensive R-based tool for processing and visualizing population genetic admixture data. It facilitates the transition from raw output files (from STRUCTURE, ADMIXTURE, etc.) to formatted data frames and high-quality plots. Key features include file parsing, cluster alignment (using CLUMPP logic), and extensive customization of barplots.

## Installation
To install the package from CRAN:
```R
install.packages("pophelper")
```
To install the development version from GitHub:
```R
# install.packages("devtools")
devtools::install_github("royfrancis/pophelper")
```

## Core Workflow

### 1. Reading Data
Use `readQ()` to import output files from various programs. It automatically detects the format.
```R
library(pophelper)

# Load files (e.g., STRUCTURE or ADMIXTURE output)
sfiles <- list.files(path="path/to/files", full.names=TRUE)
qlist <- readQ(sfiles)

# Check data structure
head(qlist[[1]])
```

### 2. Summarizing and Tabulating
Generate statistics about the loaded runs, such as K values and log-likelihoods.
```R
# Tabulate metadata
stats <- tabulateQ(qlist)

# Summarize across K values
summary_stats <- summarizeQ(stats)
```

### 3. Aligning and Merging Clusters
When multiple runs exist for the same K, clusters may be permuted. Use `alignK()` to align clusters across runs and `mergeQ()` to average them.
```R
# Align clusters across runs for the same K
aligned_list <- alignK(qlist)

# Merge multiple runs of the same K into a single table
merged_list <- mergeQ(aligned_list)
```

### 4. Visualization
The `plotQ()` function is the primary tool for creating barplots. It supports multi-panel figures, custom colors, and labels.
```R
# Basic plot
plotQ(qlist[1], imgoutput="sep")

# Advanced plot with labels and custom colors
plotQ(qlist[1], 
      showindlab=T, 
      useindlab=T, 
      clustercol=c("red","blue","green"),
      basis="all",
      outputfilename="admixture_plot",
      imgtype="png")
```

## Tips for Success
- **File Formats**: `readQ` supports `.out` (STRUCTURE), `.Q` (ADMIXTURE), `.meanQ` (fastSTRUCTURE), and TESS files.
- **Labeling**: To add population or individual labels, ensure your label vector matches the number of rows in your Q matrix. Use the `grplab` argument in `plotQ` for grouping by population.
- **Exporting**: By default, `plotQ` can export directly to files (png, pdf, etc.). Set `returnplot=TRUE` if you wish to manipulate the ggplot object further in R.
- **Sorting**: Use `orderind` within `plotQ` to sort individuals by cluster proportion or by a specific metadata column.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [index.md](./references/index.md)
- [wiki.md](./references/wiki.md)