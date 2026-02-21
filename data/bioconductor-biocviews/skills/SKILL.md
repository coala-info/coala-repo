---
name: bioconductor-biocviews
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/biocViews.html
---

# bioconductor-biocviews

## Overview
The `biocViews` package is a core Bioconductor tool used to infrastructure-level management of R package repositories. It allows developers and administrators to categorize packages using a hierarchical controlled vocabulary, generate web-based navigation interfaces (the "BiocViews" system), and automate the creation of repository metadata files. It bridges the gap between raw package `DESCRIPTION` files and the searchable, categorized web interface found on the Bioconductor website.

## Core Workflows

### 1. Exploring the Vocabulary
The vocabulary is stored as a `graphNEL` object. You can explore the hierarchy to find appropriate terms for a package.

```r
library(biocViews)
data(biocViewsVocab)

# Get sub-terms for a specific category (e.g., Technology)
tech_terms <- getSubTerms(biocViewsVocab, term = "Technology")

# Check if a specific term exists in the vocabulary
"SingleCell" %in% nodes(biocViewsVocab)
```

### 2. Querying a Repository for Views
To generate categorized views, you need a repository URL (containing a `VIEWS` file) and the vocabulary object.

```r
# Define repository and load vocabulary
data(biocViewsVocab)
reposUrl <- "https://bioconductor.org/packages/release/bioc"

# Get views for a specific top-level category (Software, AnnotationData, or ExperimentData)
bv <- getBiocSubViews(reposUrl, biocViewsVocab, topTerm = "Software")

# Inspect a specific view
bv$GeneExpression
```

### 3. Generating HTML Documentation
You can generate the static HTML pages that represent these views locally.

```r
output_dir <- tempdir()
writeBiocViews(bv, dir = output_dir)
```

### 4. Repository Management
If you are hosting a local repository, `biocViews` can automate the creation of the necessary index files.

```r
# 1. Extract vignettes from source packages to a central directory
extractVignettes(reposRoot = "path/to/repo", srcContrib = "src/contrib")

# 2. Generate PACKAGES and VIEWS control files
contribPaths <- c(source = "src/contrib",
                  win.binary = "bin/windows/contrib/4.3",
                  mac.binary = "bin/macosx/contrib/4.3")
genReposControlFiles(reposRoot = "path/to/repo", contribPaths = contribPaths)

# 3. Create the HTML index and package detail pages
writeRepositoryHtml(reposRoot = "path/to/repo", title = "My Local Repo")
```

## Key Functions
- `getBiocSubViews`: Queries a repository and organizes packages into a hierarchy based on the vocabulary.
- `getSubTerms`: Returns all child terms for a given node in the biocViews graph.
- `writeBiocViews`: Writes out the HTML files for the categorized views.
- `genReposControlFiles`: Creates `PACKAGES` and `VIEWS` files required for R repositories.
- `extractVignettes`: Pulls PDF/HTML vignettes from package source files for web display.
- `writeRepositoryHtml`: Generates the "Package Details" HTML pages and the main `index.html`.

## Tips for Success
- **Term Formatting**: When adding or searching for terms, remember that spaces are not allowed; use underscores (e.g., `Gene_Expression`) if manually editing the `.dot` file, though `biocViews` functions often handle the mapping.
- **VIEWS File**: The `VIEWS` file is the "source of truth" for this package. It is essentially a `PACKAGES` file but includes all fields from the `DESCRIPTION` file of every package in the repository.
- **Top-Level Nodes**: Always start your sub-view queries from one of the three main branches: `Software`, `AnnotationData`, or `ExperimentData`.

## Reference documentation
- [HOWTO generate biocViews HTML](./references/HOWTO-BCV.md)
- [HOWTO generate repository HTML](./references/createReposHtml.md)