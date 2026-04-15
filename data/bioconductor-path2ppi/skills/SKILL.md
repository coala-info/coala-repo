---
name: bioconductor-path2ppi
description: This tool predicts protein-protein interaction networks for a target species by mapping pathway-specific interactions from multiple reference organisms using homology data. Use when user asks to predict protein-protein interactions for a specific pathway, infer interaction networks based on homology, or combine interaction data from multiple reference species for a target organism.
homepage: https://bioconductor.org/packages/release/bioc/html/Path2PPI.html
---

# bioconductor-path2ppi

name: bioconductor-path2ppi
description: Predict protein-protein interaction (PPI) networks for a target species by combining pathway-specific PPI data from multiple reference species. Use this skill when you need to infer interactions for a specific biological pathway in a less-studied organism using homology data (BLAST results) and established interaction databases (iRefIndex).

# bioconductor-path2ppi

## Overview

The `Path2PPI` package implements a homology-based approach to predict protein-protein interactions for specific pathways in a target organism. It works by mapping known interactions from well-characterized reference species (e.g., Human, Yeast) to a target species using BLAST+ homology scores. The package combines evidence from multiple reference organisms and provides a scoring system to rank the reliability of predicted interactions.

## Core Workflow

### 1. Initialization and Data Loading
Create the main `Path2PPI` object and load your homology and interaction data.

```r
library(Path2PPI)

# Initialize the object
# Path2PPI(pathway_name, target_species_name, target_taxon_id)
ppi <- Path2PPI("Autophagy induction", "Podospora anserina", "5145")

# Data required for each reference species:
# 1. Protein list (named character vector: names = IDs, values = trivial names)
# 2. iRefIndex data frame (interaction database)
# 3. Homology data frame (BLAST+ outfmt 6 results)
```

### 2. Adding Reference Species
Add one or more reference organisms to the object. This step automatically filters for relevant interactions.

```r
ppi <- addReference(ppi, 
                    organism = "Homo sapiens", 
                    taxId = "9606", 
                    proteins = human.ai.proteins, 
                    irefindex = human.ai.irefindex, 
                    homologs = pa2human.ai.homologs)

# View summary of added references
showReferences(ppi)
```

### 3. Predicting PPIs
Run the prediction algorithm. The `h.range` argument is critical as it defines how E-values are mapped to homology scores [0, 1].

```r
# h.range: c(lower_bound, upper_bound)
# E-values <= lower_bound get score 1; >= upper_bound get score 0
ppi <- predictPPI(ppi, h.range = c(1e-60, 1e-20), interaction.threshold = 0.7)

# View prediction summary
ppi
```

### 4. Visualizing Results
`Path2PPI` provides specialized plotting methods to inspect the predicted network.

```r
# Standard PPI plot
plot(ppi)

# Multiple edges plot (shows contributions from different species)
plot(ppi, multiple.edges = TRUE)

# Hybrid plot (shows target proteins, reference proteins, and homology links)
plot(ppi, type = "hybrid")
```

### 5. Exporting and Inspecting Data
Extract the predicted network as data frames or igraph objects.

```r
# Get the predicted edge list
target_ppi <- getPPI(ppi)

# Get the hybrid network (includes homology and reference interactions)
hybrid_net <- getHybridNetwork(ppi, igraph = FALSE)

# Inspect a specific predicted interaction
showInteraction(ppi, interaction = c("ProtA_ID", "ProtB_ID"), mode = "detailed")
```

## Key Functions and Parameters

- `Path2PPI()`: Constructor. Requires taxonomy ID as a string.
- `addReference()`: Integrates reference data. It searches 10 different columns in iRefIndex to find matches, making it robust to different identifier types (UniProt, Ensembl, etc.).
- `predictPPI()`:
    - `h.range`: Defines the sensitivity to homology.
    - `interaction.threshold`: Minimum score required to include a predicted interaction.
    - `complexes`: Boolean; whether to consider protein complexes from iRefIndex.
- `showReferences()`: Use `returnValue = "interactions"` to extract the processed reference interactions.

## Tips for Success

- **Protein Identifiers**: While multiple formats are supported, UniProt identifiers are highly recommended for the best compatibility with iRefIndex.
- **Homology Data**: Ensure your BLAST results are generated using `-outfmt 6` (tab-delimited).
- **Scoring**: The final score for an interaction increases if it is found in multiple reference species or if multiple homologs in the target species point to the same reference interaction.
- **Trivial Names**: Providing trivial names in the protein list (as values in a named vector) significantly improves the readability of generated plots.

## Reference documentation

- [Path2PPI - Tutorial, example and the algorithm](./references/Path2PPI-tutorial.md)