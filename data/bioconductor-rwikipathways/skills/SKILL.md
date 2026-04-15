---
name: bioconductor-rwikipathways
description: This tool provides an R interface to the WikiPathways API for querying, retrieving, and analyzing biological pathway data. Use when user asks to search for pathways by keyword or identifier, retrieve pathway components like genes and metabolites, download pathway models, or perform functional enrichment analysis and network visualization.
homepage: https://bioconductor.org/packages/release/bioc/html/rWikiPathways.html
---

# bioconductor-rwikipathways

name: bioconductor-rwikipathways
description: Expert guidance for using the rWikiPathways R package to interface with the WikiPathways API. Use this skill when you need to query biological pathways, retrieve pathway information (WPIDs, names, URLs), download pathway data (GPML, GMT, SVG), or perform functional enrichment analysis and visualization in R. This skill includes workflows for identifier mapping with BridgeDbR and network visualization with RCy3/Cytoscape.

# bioconductor-rwikipathways

## Overview
The `rWikiPathways` package provides a programmatic interface to the WikiPathways database. It allows users to search for pathways by keywords or identifiers (Xrefs), retrieve pathway components (genes, proteins, metabolites), and download pathway models for downstream analysis. It is frequently used in conjunction with `clusterProfiler` for enrichment analysis and `RCy3` for Cytoscape-based visualization.

## Core Workflows

### 1. Exploration and Search
Identify available species and pathways using keywords or specific identifiers.
```r
library(rWikiPathways)

# List supported organisms
listOrganisms()

# Search pathways by keyword
hs_pathways <- findPathwaysByText("lung cancer")
human_only <- hs_pathways[hs_pathways$species == "Homo sapiens", ]

# Search pathways by specific gene/metabolite (Xref)
# System codes: 'H' for HGNC, 'En' for Ensembl, 'L' for Entrez Gene
tnf_pathways <- findPathwayIdsByXref('TNF', 'H')
```

### 2. Retrieving Pathway Data
Extract specific information or lists of entities from a known WikiPathways ID (WPID).
```r
wpid <- "WP554"

# Get general info (URL, name, species)
info <- getPathwayInfo(wpid)

# Get all Entrez Gene IDs ('L') from a pathway
genes <- getXrefList(wpid, systemCode = 'L')

# Get all ChEBI metabolites ('Ce')
metabolites <- getXrefList(wpid, systemCode = 'Ce')
```

### 3. Pathway Analysis (ORA and GSEA)
Integrate with `clusterProfiler` to find enriched pathways in differential expression results.
```r
library(clusterProfiler)

# Over-representation Analysis (ORA)
ewp <- enrichWP(
    gene = c("1017", "1018", "60"), # Entrez IDs
    organism = "Homo sapiens",
    pvalueCutoff = 0.05
)

# Convert IDs to readable symbols
library(DOSE)
ewp <- setReadable(ewp, org.Hs.eg.db, keyType = "ENTREZID")
dotplot(ewp)
```

### 4. Cytoscape Integration
Visualize pathways and overlay experimental data using `RCy3`.
```r
library(RCy3)

# Import a pathway as a visual model
commandsRun('wikipathways import-as-pathway id=WP179')

# Import as a functional network (better for analysis)
commandsRun('wikipathways import-as-network id=WP179')

# Map data onto the network
# Ensure 'lung.expr' has a column matching the 'Ensembl' column in Cytoscape
loadTableData(lung.expr, data.key.column = "GeneID", table.key.column = "Ensembl")
setNodeColorMapping("log2FC", colors=paletteColorBrewerRdBu, style.name = "WikiPathways")
```

### 5. Downloading Archives
Download bulk data for offline analysis.
```r
# Download latest GMT file for Mouse
downloadPathwayArchive(organism = "Mus musculus", format = "gmt")

# Download a specific version by date
downloadPathwayArchive(date = "20231010", organism = "Homo sapiens", format = "gpml")
```

## Tips and Best Practices
- **System Codes**: WikiPathways uses BridgeDb system codes. Common ones include `H` (HGNC), `En` (Ensembl), `L` (Entrez Gene), `Ce` (ChEBI), and `W` (UniProt). Use `BridgeDbR::getSystemCode()` if unsure.
- **Organism Names**: Always use the full scientific name (e.g., "Homo sapiens") in functions like `listPathways` or `enrichWP`.
- **Network vs. Pathway**: In Cytoscape, `import-as-pathway` preserves the manual layout of the wiki, while `import-as-network` creates a simplified graph structure suitable for topological analysis.
- **Identifier Mapping**: If your data uses Ensembl IDs but the pathway uses Entrez, use `clusterProfiler::bitr` or `BridgeDbR` to convert identifiers before enrichment.

## Reference documentation
- [Overview](./references/Overview.md)
- [Pathway Analysis](./references/Pathway-Analysis.md)
- [rWikiPathways and BridgeDbR](./references/rWikiPathways-and-BridgeDbR.md)
- [rWikiPathways and RCy3](./references/rWikiPathways-and-RCy3.md)