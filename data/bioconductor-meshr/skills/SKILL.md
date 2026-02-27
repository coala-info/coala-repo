---
name: bioconductor-meshr
description: This tool performs Medical Subject Headings (MeSH) over-representation and enrichment analysis for functional gene annotation. Use when user asks to conduct MeSH enrichment tests, annotate genes with MeSH terms, or retrieve species-specific MeSH databases from AnnotationHub.
homepage: https://bioconductor.org/packages/release/bioc/html/meshr.html
---


# bioconductor-meshr

name: bioconductor-meshr
description: Perform Medical Subject Headings (MeSH) Over-Representation Analysis (ORA) and enrichment analysis. Use this skill when a user needs to annotate genes with MeSH terms, retrieve MeSH data from AnnotationHub, or conduct enrichment tests for specific species and MeSH categories.

## Overview

The `meshr` package provides a framework for MeSH enrichment analysis. MeSH (Medical Subject Headings) offers a more comprehensive vocabulary than Gene Ontology (GO), making it particularly useful for functional annotation in minor species. Since Bioconductor 3.14, the package uses an `AnnotationHub` workflow to retrieve SQLite-based MeSH databases dynamically.

## Workflow: Data Acquisition

Before running enrichment analysis, you must retrieve the necessary `MeSHDb` objects using `AnnotationHub` and `MeSHDbi`.

```r
library(AnnotationHub)
library(MeSHDbi)

ah <- AnnotationHub()

# 1. Retrieve the general MeSH term database
dbfile_mesh <- query(ah, c("MeSHDb", "MeSH.db", "v002"))[[1]]
MeSH.db <- MeSHDbi::MeSHDb(dbfile_mesh)

# 2. Retrieve the species-specific gene-to-MeSH mapping (e.g., Danio rerio)
dbfile_spec <- query(ah, c("MeSHDb", "Danio rerio", "v002"))[[1]]
MeSH.Dre.eg.db <- MeSHDbi::MeSHDb(dbfile_spec)
```

## Workflow: MeSH Enrichment Analysis

Enrichment is performed using the `meshHyperGTest` function with a `MeSHHyperGParams` parameter object.

### 1. Setup Parameters
Define the gene sets and the specific MeSH category/database to test.

```r
library(meshr)

# Example using Pseudomonas aeruginosa PAO1
# geneid: all genes in the universe
# sig.geneid: your genes of interest (e.g., differentially expressed genes)

meshParams <- new("MeSHHyperGParams",
    geneIds = sig.geneid,
    universeGeneIds = geneid,
    annotation = "MeSH.Pae.PAO1.eg.db", # The species-specific MeSHDb object name
    meshdb = "MeSH.db",                 # The general MeSHDb object name
    category = "A",                     # MeSH Category (e.g., A: Anatomy, B: Organisms, C: Diseases)
    database = "gpa",                   # Mapping source (e.g., 'gpa', 'pubmed')
    pvalueCutoff = 0.05, 
    pAdjust = "BH")
```

### 2. Run the Test
```r
meshR <- meshHyperGTest(meshParams)
```

### 3. Inspect Results
```r
# View top enriched terms
head(summary(meshR))

# Access specific slots
pvalues(meshR)
geneCounts(meshR)
```

## Tips and Customization

- **Categories**: MeSH terms are organized into categories. Common ones include:
    - `A`: Anatomy
    - `B`: Organisms
    - `C`: Diseases
    - `D`: Chemicals and Drugs
    - `G`: Phenomena and Processes
- **Switching Parameters**: You can update an existing params object without recreating it:
    ```r
    category(meshParams) <- "B"
    meshR_B <- meshHyperGTest(meshParams)
    ```
- **Database Selection**: The `database` parameter specifies the source of the gene-MeSH relationship. Common values include "gpa", "pubmed", or specific strain names depending on the species-specific database content.

## Reference documentation

- [AnnotationHub-style MeSH ORA Framework](./references/MeSH.Rmd)
- [MeSH ORA Framework Guide](./references/MeSH.md)