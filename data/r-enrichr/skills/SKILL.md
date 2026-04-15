---
name: r-enrichr
description: The r-enrichr tool provides an R interface to the Enrichr database for performing gene set enrichment analysis across various organisms and libraries. Use when user asks to perform enrichment analysis, query gene-set libraries, or visualize enriched biological pathways and terms.
homepage: https://cran.r-project.org/web/packages/enrichr/index.html
---

# r-enrichr

## Overview
The `enrichR` package provides an R interface to the Enrichr database, a comprehensive resource for gene set enrichment analysis. It allows users to query hundreds of gene-set libraries (including GO, KEGG, ChEA, and more) for various organisms including humans, flies, worms, yeast, fish, and oxen.

## Installation
Install the package from CRAN:

```R
install.packages("enrichR")
```

## Core Workflow

### 1. Initialize Connection
By default, the package connects to the human Enrichr site. Use `setEnrichrSite` to specify the organism.

```R
library(enrichR)

# Check available sites
listEnrichrSites()

# Set site (e.g., "Enrichr" for Human, "FlyEnrichr", "WormEnrichr")
setEnrichrSite("Enrichr")
```

### 2. Select Gene-Set Libraries
Enrichr contains hundreds of databases. List them to find the exact names for your analysis.

```R
dbs <- listEnrichrDbs()
# View available libraries
head(dbs$libraryName)

# Select specific libraries
selected_dbs <- c("GO_Biological_Process_2023", "KEGG_2021_Human", "MSigDB_Hallmark_2020")
```

### 3. Perform Enrichment Analysis
The `enrichr` function returns a list of data frames, one for each database queried.

```R
# Basic analysis
genes <- c("Nsun3", "Polrmt", "Nlrx1", "Sfxn5", "Zc3h12c")
enriched <- enrichr(genes, selected_dbs)

# Analysis with background genes (Speedrichr API)
# include_overlap = TRUE adds the 'Overlap' column to background-corrected results
enriched_bg <- enrichr(genes, selected_dbs, background = my_background_vector, include_overlap = TRUE)

# Access results for a specific database
go_results <- enriched[["GO_Biological_Process_2023"]]
```

### 4. Visualize and Export
The package includes built-in functions for plotting and saving results.

```R
# Plot top terms
plotEnrich(enriched[[1]], showTerms = 20, numChar = 40, y = "Count", orderBy = "P.value")

# Export to text files (creates one file per database)
printEnrich(enriched, prefix = "enrichr_results")

# Export to a single Excel file with multiple sheets
printEnrich(enriched, outFile = "excel", fileName = "enrichr_results.xlsx")
```

## Tips and Best Practices
- **Gene Symbols**: Ensure input genes are provided as gene symbols (e.g., HGNC symbols for human).
- **Connection Issues**: If working behind a proxy, set `RCurlOptions` using `options(RCurlOptions = list(proxy = '...'))`.
- **Database Versions**: Enrichr frequently updates libraries (e.g., `GO_Biological_Process_2021` vs `2023`). Always check `listEnrichrDbs()` for the most recent version.
- **Background Sets**: Using a background set (the "universe" of genes measured in your experiment) provides more accurate p-values for specific experimental contexts.

## Reference documentation
- [An R interface to the Enrichr database](./references/README.html.md)
- [enrichR: Provides an R Interface to 'Enrichr'](./references/home_page.md)