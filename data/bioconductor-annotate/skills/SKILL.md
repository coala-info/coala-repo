---
name: bioconductor-annotate
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/annotate.html
---

# bioconductor-annotate

name: bioconductor-annotate
description: Interface and utility functions for Bioconductor metadata packages. Use this skill when you need to: (1) Retrieve biological annotations (Entrez ID, GO, Symbol) from manufacturer probe IDs, (2) Work with Gene Ontology (GO) data including evidence codes and DAG structures, (3) Model chromosomal locations using chromLocation objects, (4) Generate hyperlinked HTML reports for gene lists, or (5) Query web services like NCBI/PubMed for gene-specific information.

# bioconductor-annotate

## Overview
The `annotate` package serves as the primary interface for extracting data from Bioconductor metadata packages (e.g., `.db` packages). It provides a standardized set of functions to map manufacturer-specific identifiers (like Affymetrix probe IDs) to biological information, handles GO term hierarchies, and facilitates the creation of annotated reports.

## Core Workflows

### 1. Basic Annotation Retrieval
To get data out of a metadata package (e.g., `hgu95av2.db`), use the `get*` family of functions or standard environment accessors.

```r
library(annotate)
library(hgu95av2.db)

# Get Entrez IDs for a set of probes
probes <- c("1000_at", "1001_at")
entrez_ids <- getEG(probes, "hgu95av2")

# Get Gene Symbols
symbols <- getSYMBOL(probes, "hgu95av2")

# Standard accessor for specific mappings
# Equivalent to: hgu95av2ENTREZID[["1000_at"]]
id <- get("1000_at", env = hgu95av2ENTREZID)
```

### 2. Working with Gene Ontology (GO)
The package provides tools to filter GO mappings by ontology (BP, MF, CC) or evidence codes.

```r
# Retrieve GO mappings for a probe
go_list <- hgu95av2GO[["39613_at"]]

# Filter by Ontology (e.g., Biological Process)
bp_terms <- getOntology(go_list, "BP")

# Filter by Evidence Code (e.g., remove IEA - Inferred from Electronic Annotation)
filtered_go <- dropECode(go_list, code = "IEA")

# Get evidence codes for a list
ev_codes <- getEvidence(go_list)
```

### 3. Chromosomal Locations
Use the `chromLocation` class to model and access gene positions on chromosomes.

```r
# Build a chromLocation object from a metadata package
cloc <- buildChromLocation("hgu95av2")

# Access slots
org <- organism(cloc)
chroms <- nChrom(cloc)
# Map a probe to its chromosome
chr_name <- get("32972_at", probesToChrom(cloc))
```

### 4. Generating HTML Reports
Create hyperlinked tables for gene lists to facilitate downstream exploration.

```r
# Example: Create an HTML page with links to LocusLink (Entrez) and GenBank
genes <- featureNames(sample.ExpressionSet)[1:10]
ll_ids <- getEG(genes, "hgu95av2")
gb_ids <- get(genes, hgu95av2ACCNUM)

# Generate HTML file "mygenes.html"
htmlpage(list(ll_ids, gb_ids), 
         filename = "mygenes.html", 
         title = "My Gene List", 
         othernames = list(genes), 
         table.head = c("Entrez ID", "GenBank", "Probe ID"),
         repository = list("en", "gb"))
```

## Tips for Developers
- **Use `get*` functions**: When building tools, use `getEG`, `getGO`, etc., instead of accessing environments directly. This ensures your code remains compatible even if the underlying metadata package structure changes.
- **Missing Data**: Functions like `htmlpage` automatically convert non-numeric LocusLink IDs to HTML non-breaking spaces (`&nbsp;`), but GenBank or Affy IDs may require manual cleaning of "---" or `NA` values before report generation.
- **GO.db**: For structural GO queries (parents/children), ensure `GO.db` is loaded.

## Reference documentation
- [Basic GO Usage](./references/GOusage.md)
- [Annotation Package Overview](./references/annotate.md)
- [Build and use chromosomal information](./references/chromLOC.md)
- [Pretty HTML output for gene lists](./references/prettyOutput.md)