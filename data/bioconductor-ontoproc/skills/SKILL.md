---
name: bioconductor-ontoproc
description: bioconductor-ontoproc provides R interfaces for mapping informal biological terms to formal ontologies and visualizing their hierarchical relationships. Use when user asks to map cell type labels to formal identifiers, query molecular features of cell types, subset SingleCellExperiment objects by ontology hierarchy, or visualize relationships between biological terms.
homepage: https://bioconductor.org/packages/release/bioc/html/ontoProc.html
---


# bioconductor-ontoproc

name: bioconductor-ontoproc
description: Specialized R package for ontology-oriented data analysis, focusing on cell type identification, mapping informal terms to formal ontologies (Cell Ontology, Gene Ontology, etc.), and visualizing ontological hierarchies. Use this skill when you need to map single-cell RNA-seq cell labels to formal identifiers, query molecular features of cell types, or visualize relationships between biological terms.

# bioconductor-ontoproc

## Overview
The `ontoProc` package provides R interfaces to biological ontologies with a specific focus on single-cell biology and cell type identification. It allows users to bridge the gap between informal cell type labels (e.g., from Seurat tutorials) and formal, persistent identifiers from the Cell Ontology (CL), Protein Ontology (PR), and others. It supports mapping, subsetting SingleCellExperiment objects based on ontology hierarchies, and visualizing term relationships.

## Core Workflows

### 1. Loading Ontologies
The package provides cached versions of major ontologies.
```r
library(ontoProc)
cl = getCellOnto()   # Cell Ontology
go = getGeneOnto()   # Gene Ontology
pr = getPROnto()     # Protein Ontology
efo = getOnto("efoOnto") # Experimental Factor Ontology
```

### 2. Mapping Informal Terms to Formal Tags
Use `liberalMap` to find formal terms lexically close to a target string.
```r
# Search for terms related to "lung ciliated cell"
matches = liberalMap("lung ciliated cell", cl)
```

### 3. Querying Cell Features
Retrieve molecular features (e.g., marker genes) associated with a specific Cell Ontology ID.
```r
# Get features for a mature CD1a-positive dermal dendritic cell
feats = CLfeats(cl, "CL:0002531")
```

Find cell types associated with specific gene symbols:
```r
# Find cell types mentioning ITGAM
cell_mentions = sym2CellOnto("ITGAM", cl, pr)
```

### 4. Working with SingleCellExperiment (SCE)
You can bind formal ontology tags to SCE objects and subset them based on the hierarchy.
```r
# Assuming hpca_map is a data.frame with 'informal' and 'formal' columns
# Bind tags to an SCE object based on existing 'label.fine' column
sce = bind_formal_tags(sce, "label.fine", hpca_map)

# Subset SCE to include only monocytes and their descendants
mono_sce = subset_descendants(sce, cl, "^monocyte$")
```

### 5. Visualization
Visualize the relationship between terms using `onto_plot2`.
```r
library(ontologyPlot)
tags_to_plot = c("CL:0000492", "CL:0001054", "CL:0000236")
onto_plot2(cl, tags_to_plot)
```

### 6. Handling OWL Files
For newer or custom ontologies in OWL format, use the `owlready2` interface.
```r
# Cache and load an OWL ontology
owl_path = owl2cache(url="http://purl.obolibrary.org/obo/cl.owl")
cle = setup_entities2(owl_path)

# Search labels within the OWL-derived object
vein_terms = search_labels(cle, "*vein*")
```

## Tips and Best Practices
- **Identifier Formats**: Older cached ontologies use colons (e.g., `CL:0000492`), while newer OWL-derived objects often use underscores (e.g., `CL_0000492`). Use `gsub(":", "_", tags)` if necessary when switching between methods.
- **Caching**: `owl2cache` and `getOnto` use `BiocFileCache`. If you encounter network issues, check your local cache.
- **Interactive Exploration**: Use `ctmarks()` to launch a Shiny app for exploring cell type markers interactively.

## Reference documentation
- [ontoProc: Ontology interfaces for Bioconductor, with focus on cell type identification](./references/ontoProc.md)
- [ontoProc: some ontology-oriented utilites with single-cell focus for Bioconductor](./references/ontoProc.Rmd)
- [owlents: using OWL directly in ontoProc](./references/owlents.md)