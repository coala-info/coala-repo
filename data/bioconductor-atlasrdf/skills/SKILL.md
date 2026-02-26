---
name: bioconductor-atlasrdf
description: This tool queries the Expression Atlas RDF store to retrieve gene expression data linked to experimental factors and biological conditions. Use when user asks to find differentially expressed genes for specific diseases, map ontology terms to EFO URIs, retrieve Reactome pathways, or perform gene set enrichment analysis.
homepage: https://bioconductor.org/packages/3.5/bioc/html/AtlasRDF.html
---


# bioconductor-atlasrdf

name: bioconductor-atlasrdf
description: Querying the Expression Atlas RDF store at the European Bioinformatics Institute (EBI). Use this skill to find genes differentially expressed under specific biological conditions (diseases, phenotypes, cell types), map ontology terms (EFO), retrieve Reactome pathways, and perform gene set enrichment analysis using RDF-linked data.

## Overview

The `AtlasRDF` package provides an interface to the Expression Atlas RDF store. It allows users to query gene expression data linked to experimental factors (like "type II diabetes" or "brain") and integrates with other RDF resources like UniProt (proteins) and Reactome (pathways). It is particularly useful for identifying candidate genes associated with specific conditions and discovering related experimental factors through enrichment analysis.

## Core Workflow

### 1. Finding Ontology Terms (EFO)
AtlasRDF uses the Experimental Factor Ontology (EFO). You must identify the correct EFO URI for your condition of interest.

```r
library(AtlasRDF)

# Search for a term directly
termhits <- searchForEFOTerms("type II diabetes")

# Or map from another ontology (e.g., SNOMEDCT) via BioPortal
efomappings <- getOntologyMappings("http://purl.bioontology.org/ontology/SNOMEDCT/44054006")
```

### 2. Extracting Gene Lists
Once you have the EFO URI and the taxon URI, you can retrieve differentially expressed genes.

```r
# Get taxon URI
humanURI <- getTaxonURI("human")

# Get Ensembl genes for a specific factor (e.g., EFO_0001360 for Type II Diabetes)
typeIIgenelist <- getSpeciesSpecificEnsemblGenesForExFactor("http://www.ebi.ac.uk/efo/EFO_0001360", humanURI)
```

### 3. Pathway Analysis
Retrieve Reactome pathways associated with your gene list.

```r
# Get ranked pathways (returns a list, most common first)
pathways <- getRankedPathwaysForGeneIds(typeIIgenelist[,3])

# Get genes associated with a specific pathway URI
pathway_genes <- getGenesForPathwayURI("http://identifiers.org/reactome/REACT_12627.3")
```

### 4. Gene Set Enrichment
Perform Fisher's Exact Test to find other experimental factors where your gene set is enriched. This requires background data sets (gene list and factor counts).

```r
# Load background data (usually provided as .RData files)
load("human/human_gene_list.RData")
load("human/human_factor_counts.RData")

# Perform enrichment
enrichment_results <- doFishersEnrichment(pathway_genes, human_genelist_bg, human_factor_counts)

# Filter for specific categories (e.g., only diseases using EFO_0000408)
disease_results <- includeOnlySubclasses("efo:EFO_0000408", enrichment_results)

# Sort and visualize
sorted_results <- orderEnrichmentResults(disease_results)
vizPvalues(sorted_results[1:20], "0.000001")
```

### 5. Linking to Raw Data
To move from RDF metadata to raw experimental data, retrieve ArrayExpress experiment IDs.

```r
# Get experiment IDs for a specific gene URI
experiments <- getExperimentIdsForGeneURI("http://identifiers.org/ensembl/ENSG00000142556")
# These IDs can be used with the 'ArrayExpress' R package
```

## Tips and Best Practices
- **URI Handling**: Most functions require full URIs (e.g., `http://www.ebi.ac.uk/efo/EFO_...`). Always verify the URI from `searchForEFOTerms` before querying.
- **Performance**: Functions like `getRankedPathwaysForGeneIds` can be slow for large gene lists as they query remote RDF endpoints.
- **Enrichment Backgrounds**: Ensure you use the correct background files for the species you are studying. If local files are unavailable, use `data(transcription_pathway_enrichment)` for practice.
- **Filtering**: Use `includeOnlySubclasses` to narrow down enrichment results to specific branches of the EFO (e.g., cell types vs. diseases).

## Reference documentation
- [AtlasRDF Vignette](./references/AtlasRDF_vignette.md)