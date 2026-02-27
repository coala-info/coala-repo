---
name: bioconductor-paxtoolsr
description: The paxtoolsr package provides an R interface to the Paxtools Java library and Pathway Commons database for analyzing biological pathways in BioPAX format. Use when user asks to query the Pathway Commons database, convert BioPAX models to simplified interaction networks, perform graph queries like finding paths between genes, or prepare pathway data for gene set enrichment analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/paxtoolsr.html
---


# bioconductor-paxtoolsr

## Overview

The `paxtoolsr` package provides an R interface to the Paxtools Java library and the Pathway Commons (PC) database. It allows users to interact with biological pathways represented in the BioPAX (Biological Pathway Exchange) format. Key capabilities include querying the Pathway Commons web service, converting complex BioPAX models into simplified binary interaction networks (SIF), and integrating pathway data with other Bioconductor analysis workflows like `igraph` or `clusterProfiler`.

## Core Workflows

### Initial Setup and Memory Management

Because `paxtoolsr` relies on `rJava`, you must set the Java heap size **before** loading the library if you are working with large BioPAX files.

```r
options(java.parameters = "-Xmx2048m") # Set to 2GB or more
library(paxtoolsr)
```

### Searching and Retrieving Data from Pathway Commons

You can search for pathways or specific entities directly from the Pathway Commons database.

```r
# Search for pathways related to a keyword
searchResults <- searchPc(q = "glycolysis", type = "pathway")

# Extract URIs from search results using XML/XPath
library(XML)
uris <- xpathSApply(searchResults, "/searchResponse/searchHit/uri", xmlValue)

# Download a specific pathway in BioPAX (OWL) format
biopaxXml <- getPc(uri = uris[1], format = "BIOPAX")
```

### Graph Queries

Perform neighborhood or paths-between queries to find biological connections.

```r
# Get the neighborhood of a gene in SIF format
sif <- graphPc(source = "BDNF", kind = "neighborhood", format = "SIF")

# Find paths between a set of genes
genes <- c("AKT1", "IRS1", "MTOR")
paths <- graphPc(source = genes, kind = "PATHSBETWEEN", format = "SIF")
```

### Handling Local BioPAX Files

`paxtoolsr` can manipulate local `.owl` files, including merging multiple datasets or validating them against BioPAX standards.

```r
# Merge two BioPAX files
mergedFile <- mergeBiopax(file1 = "pathway1.owl", file2 = "pathway2.owl")

# Summarize contents (counts of Catalysis, Interactions, etc.)
summaryInfo <- summarize("pathway.owl")

# Convert BioPAX to Simple Interaction Format (SIF) for network analysis
sifDf <- toSif("pathway.owl")
```

### Network Analysis and Visualization

Convert SIF data frames to `igraph` objects for visualization and statistics.

```r
library(igraph)

# Create graph (columns 1 and 3 are participants in SIF)
g <- graph.edgelist(as.matrix(sifDf[, c(1, 3)]), directed = FALSE)

# Calculate network stats
deg <- degree(g)
diam <- diameter(g)

# Plot the network
plot(g, layout = layout.fruchterman.reingold)
```

### Gene Set Enrichment Analysis (GSEA)

Convert BioPAX pathways to GMT format for use in enrichment tools.

```r
# Convert BioPAX to a gene set (GSEA format)
gseaData <- toGSEA(inputFile = "pathway.owl", outputFile = "pathway.gmt", 
                   idType = "HGNC Symbol")

# Use with clusterProfiler
library(clusterProfiler)
# Assuming geneList is your vector of interest
# enricher() can use the data frame returned by readGmt()
```

## Tips and Troubleshooting

*   **Return Types**: Most functions return either a `data.frame` (for SIF/table data) or an `XMLInternalDocument` (for raw BioPAX/Search results).
*   **File Paths**: Always use full, absolute file paths. Relative paths (e.g., `./data.owl`) often fail within the underlying Java calls.
*   **ID Mapping**: Pathway Commons often uses URIs or specific database identifiers. Use `clusterProfiler::bitr` or `biomaRt` to map these to Symbols or Entrez IDs for downstream R analysis.
*   **SIF Interaction Types**: Common types include `controls-state-change-of`, `in-complex-with`, and `reacts-with`. Filter the SIF `data.frame` to focus on specific interaction categories.

## Reference documentation

- [Using PaxtoolsR: A BioPAX and Pathway Commons Tutorial in R](./references/using_paxtoolsr.Rmd)
- [Using PaxtoolsR: A BioPAX and Pathway Commons Tutorial in R (Markdown Version)](./references/using_paxtoolsr.md)