---
name: bioconductor-biocpkgtools
description: BiocPkgTools provides a tidy data interface for accessing and analyzing Bioconductor package metadata, download statistics, and dependency networks. Use when user asks to retrieve package metadata, analyze download statistics, monitor build health, or visualize package dependency graphs.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocPkgTools.html
---

# bioconductor-biocpkgtools

name: bioconductor-biocpkgtools
description: Access and analyze Bioconductor package metadata, including download statistics, build reports, dependency graphs, and package details. Use this skill when you need to perform data mining on the Bioconductor ecosystem, search for packages by biocViews, or evaluate package dependency burdens and maintainer information.

# bioconductor-biocpkgtools

## Overview
The `BiocPkgTools` package provides a tidy data interface to the rich metadata surrounding the Bioconductor project. It allows users to programmatically retrieve information that is otherwise only available via HTML reports or disparate JSON/text files. Key capabilities include analyzing package popularity (downloads), monitoring build health, visualizing complex dependency networks, and assessing the "burden" of package dependencies.

## Core Workflows

### 1. Package Discovery and Metadata
To get a comprehensive list of all Bioconductor packages and their DESCRIPTION file metadata:
```r
library(BiocPkgTools)
pkg_list <- biocPkgList()
# Returns a tibble with columns like Package, Version, Depends, biocViews, etc.
```
To find packages that import a specific package (e.g., "GEOquery"):
```r
library(dplyr)
pkg_list %>%
    filter(Package == "GEOquery") %>%
    pull(importsMe) %>%
    unlist()
```

### 2. Download Statistics
Retrieve download counts for all Bioconductor packages (Software, Annotation, and Experiment):
```r
stats <- biocDownloadStats()
# Includes Year, Month, Nb_of_distinct_IPs, and Nb_of_downloads.
```
For packages also distributed via Conda:
```r
conda_stats <- anacondaDownloadStats()
```

### 3. Build Reports and Health
Monitor the build status (ERROR, WARNING, OK) across different platforms:
```r
report <- biocBuildReport()
# Filter for specific problems
problems <- report %>% filter(result %in% c("ERROR", "WARNING"))
```
For developers checking their own packages or downstream impacts:
```r
# Open an interactive HTML report for a specific author
problemPage(authorPattern = "Surname, Name")

# Check if changes in a package (e.g., "limma") broke downstream dependencies
problemPage(dependsOn = "limma")
```

### 4. Dependency Analysis
`BiocPkgTools` can convert dependency information into graph objects for network analysis.

**Creating a graph:**
```r
dep_df <- buildPkgDependencyDataFrame()
g <- buildPkgDependencyIgraph(dep_df)
```

**Visualizing a neighborhood (e.g., around "GEOquery"):**
```r
library(visNetwork)
# Get subgraph of degree 1
sub_g <- subgraphByDegree(g, "GEOquery")
data <- toVisNetworkData(sub_g)
visNetwork(nodes = data$nodes, edges = data$edges) %>% 
    visEdges(arrows = 'from')
```

### 5. Dependency Burden
Evaluate how much a package relies on its dependencies and identify potential bloat:
```r
# 1. Build the reference data frame (Bioc + CRAN)
depdf <- buildPkgDependencyDataFrame(repo=c("BioCsoft", "CRAN"), 
                                     dependencies=c("Depends", "Imports"))

# 2. Calculate metrics for a specific package
metrics <- pkgDepMetrics("BiocPkgTools", depdf)
# Columns include Usage (fraction of functions used) and DepGainIfExcluded.
```

## Tips and Best Practices
- **Tidy Data**: Most functions return `tibbles`, making them compatible with `dplyr`, `ggplot2`, and the rest of the tidyverse.
- **Interactive Exploration**: Use `biocExplore()` to launch a Shiny-based bubble plot for interactive package searching based on `biocViews` and download volume.
- **ORCID Integration**: Use `get_cre_orcids()` and `orcid_table()` to retrieve verified maintainer information from the ORCID API.
- **Caching**: Some functions (like `biocPkgList`) fetch large amounts of data from the web; consider caching results if performing iterative analysis.

## Reference documentation
- [Overview of BiocPkgTools](./references/BiocPkgTools.md)