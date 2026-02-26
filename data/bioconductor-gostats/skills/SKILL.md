---
name: bioconductor-gostats
description: This tool performs functional enrichment analysis using hypergeometric tests for Gene Ontology terms and KEGG pathways. Use when user asks to perform over-representation analysis, conduct conditional GO testing, or identify enriched biological pathways in gene lists.
homepage: https://bioconductor.org/packages/release/bioc/html/GOstats.html
---


# bioconductor-gostats

name: bioconductor-gostats
description: Statistical methods for Gene Ontology (GO) and KEGG pathway association analysis. Use this skill to perform hypergeometric tests for over-representation or under-representation of GO terms and KEGG pathways in gene lists, including conditional testing that accounts for the GO graph structure.

# bioconductor-gostats

## Overview
The `GOstats` package provides tools for testing the association of Gene Ontology (GO) terms and KEGG pathways with a list of genes. It is primarily used for functional enrichment analysis of microarray or RNA-seq data. Its core functionality is the `hyperGTest` function, which supports both standard and conditional hypergeometric tests. The conditional test is particularly useful for GO as it decorrelates the graph structure by conditioning on significant child terms.

## Core Workflow

### 1. Data Preprocessing
Before testing, you must define a **gene universe** (all genes assayed) and a **selected gene list** (e.g., differentially expressed genes).
- Use Entrez Gene IDs for most Bioconductor annotation packages.
- Ensure the universe is filtered for genes that have at least one GO/KEGG mapping.
- Remove duplicate mappings (e.g., multiple probes mapping to one Entrez ID) to avoid double-counting.

### 2. Setting up Parameter Objects
`GOstats` uses S4 parameter objects to organize test inputs.

**For GO Analysis:**
```R
library(GOstats)
params <- new("GOHyperGParams",
              geneIds = selectedEntrezIds,
              universeGeneIds = entrezUniverse,
              annotation = "hgu95av2.db", # The annotation package for your chip
              ontology = "BP",            # "BP", "CC", or "MF"
              pvalueCutoff = 0.01,
              conditional = TRUE,         # TRUE for conditional test
              testDirection = "over")     # "over" or "under" representation
```

**For KEGG Analysis:**
```R
kparams <- new("KEGGHyperGParams",
               geneIds = selectedEntrezIds,
               universeGeneIds = entrezUniverse,
               annotation = "hgu95av2.db",
               pvalueCutoff = 0.05,
               testDirection = "over")
```

### 3. Running the Test
Execute the test using the `hyperGTest` function.
```R
result <- hyperGTest(params)
```

### 4. Summarizing Results
The result object (class `GOHyperGResult`) can be inspected using several methods:
- `summary(result)`: Returns a data frame of significant terms.
- `pvalues(result)`: Extracts p-values for all terms.
- `geneCounts(result)`: Number of genes in your list associated with each term.
- `universeCounts(result)`: Number of genes in the universe associated with each term.
- `htmlReport(result, file="results.html")`: Generates a web-based report.

## Custom Organisms (Unsupported by Annotation Packages)
If your organism does not have a standard Bioconductor `.db` package:
1. Create a `data.frame` with GO/KEGG to Gene mappings.
2. Wrap it in a `GOFrame` or `KEGGFrame` object.
3. Convert to a `GeneSetCollection` using the `GSEABase` package.
4. Use `GSEAGOHyperGParams` or `GSEAKEGGHyperGParams` constructors.

```R
library(GSEABase)
# goframeData: col1=GOID, col2=Evidence, col3=GeneID
goFrame <- GOFrame(goframeData, organism="Species Name")
gsc <- GeneSetCollection(GOAllFrame(goFrame), setType = GOCollection())

params <- GSEAGOHyperGParams(name="Custom", geneSetCollection=gsc, 
                             geneIds=genes, universeGeneIds=universe,
                             ontology="BP", pvalueCutoff=0.05, 
                             testDirection="over")
```

## Visualization and Distances
- **Induced Graphs**: Use `makeGOGraph` to create a graph of specific terms and their parents.
- **Semantic Similarity**: Use `simUI` (intersection over union of nodes) or `simLP` (longest shared path) to calculate distances between genes based on GO annotations.

## Reference documentation
- [GOstats for Unsupported Organisms](./references/GOstatsForUnsupportedOrganisms.md)
- [How To Use GOstats Testing Gene Lists for GO Term Association](./references/GOstatsHyperG.md)
- [Visualizing and Distances Using GO](./references/GOvis.md)