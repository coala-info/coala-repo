---
name: bioconductor-fella
description: bioconductor-fella performs network-based enrichment analysis for metabolomics data by propagating signal through a hierarchical KEGG graph. Use when user asks to perform pathway enrichment, identify intermediate biological entities like enzymes or reactions, and visualize metabolite-pathway relationships as a sub-network.
homepage: https://bioconductor.org/packages/release/bioc/html/FELLA.html
---


# bioconductor-fella

name: bioconductor-fella
description: Network-based enrichment analysis for metabolomics data using the FELLA R package. Use this skill to perform pathway enrichment by propagating signal from a list of affected metabolites through a hierarchical KEGG graph (metabolites, reactions, enzymes, modules, and pathways). It is particularly useful for identifying intermediate biological entities (enzymes/reactions) that explain the connection between metabolites and pathways, and for visualizing these relationships as a sub-network.

# bioconductor-fella

## Overview

FELLA is a Bioconductor package designed for the secondary analysis of metabolomics data. Unlike standard Over-Representation Analysis (ORA) which treats pathways as disjoint sets, FELLA uses a hierarchical network representation of the KEGG database. By applying diffusion algorithms or PageRank, it propagates "flow" from a list of input metabolites to identify the most relevant pathways and the intermediate reactions, enzymes, and modules that connect them.

## Typical Workflow

### 1. Database Building
FELLA requires a local database built from a specific KEGG organism. This is a one-time setup per organism.

```r
library(FELLA)
# 1. Build the graph from KEGG (requires internet)
graph <- buildGraphFromKEGGREST(organism = "hsa")

# 2. Build the data object (saves matrices for diffusion/pagerank)
buildDataFromGraph(
  keggdata.graph = graph,
  databaseDir = "my_fella_db",
  internalDir = FALSE,
  matrices = "diffusion",
  normality = "diffusion"
)

# 3. Load the database
fella.data <- loadKEGGdata(databaseDir = "my_fella_db", internalDir = FALSE)
```

### 2. Defining Input Metabolites
Input should be a character vector of KEGG compound IDs.

```r
# Map compounds to the internal graph
compounds.input <- c("C00025", "C00043", "C00064")
analysis.obj <- defineCompounds(compounds = compounds.input, data = fella.data)

# Check for excluded compounds (those not in the graph)
getExcluded(analysis.obj)
```

### 3. Running Enrichment
FELLA supports three main methods: `hypergeom`, `diffusion`, and `pagerank`. Diffusion is generally preferred for network-based insights.

```r
# Using the wrapper function for convenience
analysis.obj <- enrich(
  compounds = compounds.input,
  data = fella.data,
  methods = "diffusion",
  approx = "normality" # Fast z-score approximation
)

# Or calling specific methods
analysis.obj <- runDiffusion(analysis.obj, data = fella.data, approx = "normality")
```

### 4. Exporting and Visualizing Results
Results can be exported as tables or visualized as a sub-network.

```r
# Generate a results table
results.tab <- generateResultsTable(
  method = "diffusion",
  nlimit = 100,
  object = analysis.obj,
  data = fella.data
)

# Plot the top-scoring sub-network
plot(
  analysis.obj,
  method = "diffusion",
  data = fella.data,
  nlimit = 50
)

# Export as an igraph object for custom visualization
g <- generateResultsGraph(
  object = analysis.obj,
  method = "diffusion",
  nlimit = 50,
  data = fella.data
)
```

## Key Functions and Parameters

- `buildGraphFromKEGGREST`: Downloads KEGG data. Use `filter.path` to exclude broad "overview" pathways (e.g., "01100").
- `enrich`: A wrapper that combines `defineCompounds` and the `run...` methods.
- `approx`: Determines the statistical significance calculation.
    - `"normality"`: Fast, uses analytical z-scores.
    - `"simulation"`: Slower, uses permutation testing (requires `niter`).
    - `"gamma"` or `"t"`: Parametric alternatives to the normal distribution.
- `generateEnzymesTable`: Specifically extracts enzymes from the results, including associated genes.

## Tips for Success

1. **ID Mapping**: Ensure metabolites are converted to KEGG IDs (e.g., "C00001") before starting.
2. **Memory Management**: The diffusion matrices can be large (~1GB). If memory is limited, load only the necessary matrices using `loadMatrix` in `loadKEGGdata`.
3. **Organism Codes**: Use standard KEGG 3-letter codes (e.g., "hsa" for human, "mmu" for mouse).
4. **Connected Components**: When generating graphs, use `thresholdConnectedComponent` to filter out small, potentially noisy clusters in the visualization.

## Reference documentation

- [FELLA: an R package to enrich metabolomics data](./references/FELLA.md)
- [A fatty liver study on Mus musculus](./references/musmusculus.md)
- [An overview of FELLA: data enrichment for metabolomics summary data](./references/quickstart.md)