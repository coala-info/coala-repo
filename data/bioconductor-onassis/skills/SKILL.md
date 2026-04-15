---
name: bioconductor-onassis
description: Onassis annotates biological metadata with ontology terms and computes semantic similarity between experiments. Use when user asks to retrieve metadata from GEO or SRA, map textual descriptions to OBO concepts, calculate semantic similarity between terms or samples, and integrate multi-domain annotations for omics analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/Onassis.html
---

# bioconductor-onassis

name: bioconductor-onassis
description: Expert guidance for using the Onassis R package to annotate biological metadata with ontology terms and compute semantic similarity. Use this skill when you need to: (1) Retrieve metadata from GEO or SRA repositories, (2) Map textual descriptions to Open Biomedical Ontologies (OBO) concepts, (3) Calculate semantic similarity between ontology terms or annotated samples, and (4) Integrate multi-domain annotations (e.g., cell type and disease) for downstream omics analysis.

## Overview
Onassis (Ontology Annotation and Semantic Similarity software) is a Bioconductor package designed to bridge the gap between unstructured biological metadata and structured ontology concepts. It leverages Natural Language Processing (NLP) via Conceptmapper to identify entities in text and provides a robust framework for quantifying the similarity between experiments based on their semantic content. This allows for semantically-driven integration and comparison of disparate omics datasets.

## Typical Workflow

### 1. Metadata Retrieval
Onassis provides helper functions to interface with `GEOmetadb`.
```r
library(Onassis)
# Connect to a local GEOmetadb SQLite file
geo_con <- connectToGEODB(path = "path/to/GEOmetadb.sqlite")

# Retrieve specific metadata (e.g., Human Methylation)
meth_metadata <- getGEOMetadata(geo_con, 
                                experiment_type = 'Methylation profiling by high throughput sequencing', 
                                organism = 'Homo sapiens')
```

### 2. Dictionary Creation
You must create a dictionary from an OBO/OWL file or use specialized targets (genes/epigenetic marks).
```r
# From an OBO file
obo_path <- "path/to/ontology.obo"
sample_dict <- CMdictionary(inputFileOrDb = obo_path, dictType = 'OBO', synonymType = 'ALL')

# For ChIP-seq targets (requires org.Hs.eg.db for gene symbols)
targets_dict <- CMdictionary(dictType = 'TARGET', inputFileOrDb = 'org.Hs.eg.db')
```

### 3. Entity Annotation
Use `EntityFinder` or the `annotate` method to map text to the dictionary.
```r
# Annotate a data frame (first column must be ID)
# opts can be customized via CMoptions()
my_opts <- CMoptions(CaseMatch = 'CASE_INSENSITIVE')
annotations <- EntityFinder(input = meth_metadata[, c('gsm', 'title', 'description')], 
                            dictionary = sample_dict, 
                            options = my_opts)

# Filter out generic terms like 'cell' or 'tissue'
filtered_annots <- filterTerms(annotations, c('cell', 'tissue'))
```

### 4. Semantic Similarity
Calculate how similar terms or samples are based on the ontology hierarchy.
```r
# Pairwise similarity between two terms (default: Lin measure)
sim_val <- Similarity(obo_path, "TERM_ID_1", "TERM_ID_2")

# Similarity between two samples (groupwise comparison of their semantic sets)
sample_sim <- Similarity(obo_path, "Sample_A_ID", "Sample_B_ID", filtered_annots)
```

### 5. The Onassis Class Wrapper
For a streamlined workflow, use the `Onassis` class to bundle entities and similarity matrices.
```r
# Create Onassis object and annotate
onassis_obj <- annotate(meth_metadata, 'OBO', obo_path)

# Compute similarity matrix for all samples in the object
onassis_obj <- sim(onassis_obj)

# Collapse highly similar semantic sets (e.g., > 0.9 similarity)
collapsed_obj <- collapse(onassis_obj, 0.9)

# Access results
entities_df <- entities(collapsed_obj)
sim_matrix <- simil(collapsed_obj)
```

## Tips for Success
- **Java Requirement**: Ensure Java (>= 1.8) is installed and `rJava` is properly configured, as Onassis relies on Java-based NLP tools.
- **Input Format**: When using `annotateDF` or `EntityFinder` with a data frame, ensure the first column contains unique identifiers (e.g., GSM or SRS IDs).
- **Search Strategies**: If exact matching is too strict, change the `SearchStrategy` in `CMoptions` to `SKIP_ANY_MATCH` to allow for non-contiguous token matching.
- **Disease Annotation**: When annotating diseases, set `disease = TRUE` in the `annotate` function to explicitly capture "Healthy" controls which might otherwise lack specific disease terms.

## Reference documentation
- [Onassis: Ontology Annotation and Semantic Similarity software](./references/Onassis.md)