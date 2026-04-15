---
name: bioconductor-gseabase
description: The GSEABase package provides a standardized framework for managing, mapping, and performing set operations on gene sets and their associated metadata in R. Use when user asks to create GeneSet objects from various sources, map gene identifiers between different types, or manage collections of gene sets for pathway analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/GSEABase.html
---

# bioconductor-gseabase

## Overview

The `GSEABase` package provides a standardized framework for managing gene sets in R. It moves beyond simple character vectors by encapsulating gene identifiers with metadata, including the source of the set (e.g., GO, KEGG, Broad Institute), the identifier type (e.g., Entrez, Symbol, Annotation), and versioning information.

## Core Data Structures

*   **GeneSet**: A single set of gene identifiers with associated metadata.
*   **GeneColorSet**: An extension of `GeneSet` that includes "coloring" to represent phenotypic associations (e.g., expression direction and phenotype response).
*   **GeneSetCollection**: A container for multiple `GeneSet` or `GeneColorSet` objects, allowing for batch operations like ID mapping.

## Key Workflows

### 1. Creating Gene Sets

**From an ExpressionSet:**
```R
library(GSEABase)
data(sample.ExpressionSet)
# Create a GeneSet from a subset of an ExpressionSet
egs <- GeneSet(sample.ExpressionSet[1:50,], setName="MyGeneSet")
```

**From GO Terms:**
```R
# Create a set based on specific GO IDs and evidence codes
goSet <- GeneSet(GOCollection(c("GO:0005488", "GO:0019825"), evidenceCode="IDA"),
                 geneIdType=EntrezIdentifier("org.Hs.eg.db"),
                 setName="GO_Example")
```

**From Broad Institute XML:**
```R
# Import MSigDB/Broad XML files
fl <- system.file("extdata", "Broad1.xml", package="GSEABase")
bgs <- GeneSet(BroadCollection(), urls=fl)
```

### 2. Identifier Mapping

`GSEABase` handles the complexity of mapping between different ID types using Bioconductor annotation packages.

```R
# Map from Probeset IDs (AnnotationIdentifier) to Entrez IDs
entrezSet <- mapIdentifiers(egs, EntrezIdentifier())

# Map a Broad Symbol set to specific chip probe IDs
probeSet <- mapIdentifiers(bgs, AnnotationIdentifier("hgu95av2"))
```

### 3. Set Operations and Subsetting

You can use standard logical operators on `GeneSet` objects if they share the same `geneIdType`.

```R
# Intersection, Union, and Difference
commonGenes <- set1 & set2
allGenes    <- set1 | set2
uniqueTo1   <- setdiff(set1, set2)

# Subsetting an ExpressionSet by a GeneSet
# This automatically handles ID matching based on the ExpressionSet's annotation
subExprSet <- sample.ExpressionSet[bgs,]
```

### 4. GeneSetCollections

Manage multiple pathways or categories simultaneously.

```R
# Create a collection from an ExpressionSet induced by GO terms
gsc <- GeneSetCollection(sample.ExpressionSet, setType=GOCollection())

# Access a specific set by name
mySet <- gsc[["GO:0005737"]]

# Map IDs for the entire collection
gscEntrez <- mapIdentifiers(gsc, EntrezIdentifier())
```

### 5. GeneColorSet (Phenotype Association)

Use `GeneColorSet` to track how specific genes relate to a phenotype.

```R
gcs <- GeneColorSet(EntrezIdentifier(),
                    setName="ResistanceSet",
                    geneIds=c("1244", "538"),
                    phenotype="Cisplatin resistance",
                    geneColor=c("Increase", "Increase"),
                    phenotypeColor=c("Resistant", "Resistant"))
```

## Tips and Best Practices

*   **Check ID Types**: Before performing set operations (`&`, `|`), ensure both sets have the same `geneIdType`. Use `mapIdentifiers()` to align them if necessary.
*   **Metadata**: Use `details(object)` to view the full curation history, including creation date and contributor.
*   **Broad XML**: When working with MSigDB files, use `getBroadSets("path/to/file.xml")` as a shortcut to create a `GeneSetCollection`.
*   **Visualization**: `GeneSetCollection` objects can be exported to HTML reports using the `ReportingTools` package via the `publish()` function.

## Reference documentation

- [An introduction to GSEABase](./references/GSEABase.md)