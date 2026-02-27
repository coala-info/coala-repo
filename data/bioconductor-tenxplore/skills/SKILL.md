---
name: bioconductor-tenxplore
description: The tenXplore package maps cell types to Gene Ontology terms and retrieves gene signatures for single-cell RNA-seq data. Use when user asks to map cell types to GO terms, retrieve gene signatures for specific organisms, or identify expression signatures for anatomic structures.
homepage: https://bioconductor.org/packages/release/bioc/html/tenXplore.html
---


# bioconductor-tenxplore

## Overview
The `tenXplore` package provides tools to bridge formal ontologies with single-cell RNA-seq (scRNA-seq) data, specifically focusing on the 10x Genomics 1.3 million neuron dataset. It facilitates the discovery of expression signatures for anatomic structures and cell types by mapping Cell Ontology terms to Gene Ontology (GO) terms and their associated gene sets.

## Typical Workflow

### 1. Mapping Cell Types to Gene Ontology
To find gene signatures for a specific cell type, use the `ontoProc` integration to map cell type strings to GO terms.

```r
library(tenXplore)
library(ontoProc)

# Load GO term data
data(allGOterms)

# Find GO terms associated with a specific cell type
cellTypeToGO("serotonergic neuron", gotab = allGOterms)
```

### 2. Retrieving Gene Signatures
Once a cell type is identified, you can retrieve the specific genes (symbols and Ensembl IDs) associated with those GO terms for a specific organism.

**For Mouse (Mus musculus):**
```r
library(org.Mm.eg.db)
cellTypeToGenes("serotonergic neuron", gotab = allGOterms, orgDb = org.Mm.eg.db)
```

**For Human (Homo sapiens):**
```r
library(org.Hs.eg.db)
cellTypeToGenes("serotonergic neuron", gotab = allGOterms, orgDb = org.Hs.eg.db)
```

### 3. Exploratory Multivariate Analysis
The package is designed to support the discrimination of neuron types. Note that string matching between Cell Ontology and Gene Ontology can be "spotty." If a direct match is not found, consider:
- Using broader cell type terms.
- Manually filtering large result sets when matching on general cell types.
- Utilizing `ontologyIndex` and `ontologyPlot` for hierarchical visualization of the terms.

## Usage Tips
- **Data Availability:** The primary focus is the 1.3 million neuron dataset from 10x Genomics. Because this dataset lacks extensive anatomical metadata, the package relies on ontology-based gene sets to provide biological context.
- **Ontology Mapping:** If `cellTypeToGO` returns an empty set, the string may not have a direct mapping in the current `allGOterms` object. Try synonyms or parent terms from the Cell Ontology.
- **Dependencies:** Ensure `ontoProc` and the relevant `org.XX.eg.db` packages are installed to perform the gene mapping.

## Reference documentation
- [tenXplore: ontology for scRNA-seq, applied to 10x 1.3 million neurons](./references/tenXplore.md)