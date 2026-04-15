---
name: bioconductor-rdavidwebservice
description: This tool provides an R interface to the DAVID web service for automated functional annotation and gene enrichment analysis. Use when user asks to perform Gene Ontology analysis, map gene lists to biological categories, generate functional annotation clusters, or retrieve enrichment reports programmatically.
homepage: https://bioconductor.org/packages/3.8/bioc/html/RDAVIDWebService.html
---

# bioconductor-rdavidwebservice

name: bioconductor-rdavidwebservice
description: Use this skill to perform functional annotation and gene enrichment analysis using the DAVID (Database for Annotation, Visualization and Integrated Discovery) web service via R. This skill is essential for mapping gene lists to biological categories, performing Gene Ontology (GO) analysis, generating functional annotation clusters, and visualizing gene-term relationships. Use it when you need to programmatically interact with DAVID, upload gene lists, retrieve enrichment reports, or generate GO direct acyclic graphs (DAGs) from R.

# bioconductor-rdavidwebservice

## Overview

The `RDAVIDWebService` package provides a class-based interface to the DAVID web service. It allows for automated functional interpretation of large gene lists without manual interaction with the DAVID website. Key features include gene ID mapping, functional annotation clustering, and advanced visualization of Gene Ontology (GO) terms using GOstats-based directed acyclic graphs (DAGs).

## Core Workflow

### 1. Connection and Authentication
To use the service, you must have a registered email with DAVID.
```R
library(RDAVIDWebService)
# Initialize the connection
david <- DAVIDWebService$new(email="user@inst.org")
```

### 2. Uploading Gene Lists
Upload your gene identifiers (e.g., Affymetrix IDs, Entrez Gene IDs) to the DAVID server.
```R
# Example using a demo list
data(demoList1)
result <- addList(david, demoList1, 
                  idType="AFFYMETRIX_3PRIME_IVT_ID", 
                  listName="myList", 
                  listType="Gene")

# Check mapping results
print(result$inDavid) # Percentage of genes mapped
print(result$unmappedIds) # IDs not recognized
```

### 3. Configuring Analysis
Select the species, background, and annotation categories (e.g., GO terms, KEGG pathways).
```R
# Set specific GO categories
setAnnotationCategories(david, c("GOTERM_BP_ALL", "GOTERM_MF_ALL", "GOTERM_CC_ALL"))

# View current status of the connection
david
```

### 4. Retrieving Reports
You can retrieve reports directly into R objects or save them as local files.
```R
# Functional Annotation Clustering
termCluster <- getClusterReport(david, type="Term")

# Save report to a file for offline use
getClusterReportFile(david, type="Term", fileName="termClusterReport.tab")
```

## Exploration and Visualization

### Functional Annotation Clustering
Analyze clusters of related functional terms to reduce redundancy.
```R
# Summary of clusters
head(summary(termCluster))

# 2D Visualization of a specific cluster (e.g., cluster 2)
plot2D(termCluster, 2)
```

### Gene Ontology DAGs
Map enrichment results into a Direct Acyclic Graph to see the biological hierarchy.
```R
# Create a GO DAG for a specific cluster
# members(termCluster)[[2]] extracts the terms for the second cluster
davidGODag <- DAVIDGODag(members(termCluster)[[2]], pvalueCutoff=0.1, "CC")

# Plot the graph
plotGOTermGraph(g=goDag(davidGODag), r=davidGODag, max.nchar=40, node.shape="ellipse")
```

## Troubleshooting

### Connection Timeouts
If the DAVID server is busy, increase the timeout (default is 30000ms).
```R
getTimeout(david)
setTimeout(david, 50000)
```

### Protocol Errors
If you encounter "Transport error: 501 Not Implemented", switch the HTTP protocol version.
```R
setHttpProtocolVersion(david, "HTTP/1.0")
```

## Reference documentation
- [RDAVIDWebService: a versatile R interface to DAVID](./references/RDavidWS-vignette.md)