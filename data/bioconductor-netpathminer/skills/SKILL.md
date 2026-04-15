---
name: bioconductor-netpathminer
description: NetPathMiner constructs, processes, and mines genome-scale biological networks by integrating pathway data with experimental results. Use when user asks to convert pathway files into igraph objects, manage biological annotations, transform metabolic networks into gene-centric representations, or rank active biological paths using gene expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/NetPathMiner.html
---

# bioconductor-netpathminer

## Overview
NetPathMiner is an R/Bioconductor package designed for the construction, processing, and mining of genome-scale biological networks. It supports multiple pathway formats (KGML, SBML, BioPAX) and provides a modular workflow to convert bipartite metabolic networks into reaction or gene-centric networks. Its core strength lies in "path mining"—identifying highly correlated biological paths by weighting network edges with experimental data (e.g., gene expression) and using probabilistic or p-value-based ranking methods.

## Core Workflow

### 1. Database Extraction & Network Construction
NetPathMiner converts pathway files into `igraph` objects.

```r
library(NetPathMiner)

# Load from KGML (KEGG)
graph <- KGML2igraph(filename = "pathway.xml")

# Load from SBML (requires libSBML)
graph <- SBML2igraph(filename = "pathway.sbml", miriam = "all")

# Load from BioPAX (requires rBiopaxParser)
library(rBiopaxParser)
biopax <- readBiopax("pathway.owl")
graph <- BioPAX2igraph(biopax = biopax)

# Signaling network (genes as vertices)
sig_graph <- KGML2igraph(filename = "pathway.xml", parse.as = "signaling")
```

### 2. Handling Annotations
Annotations are stored in the `attr` attribute of vertices. Use these functions to manage biological identifiers (MIRIAM).

```r
# List available attribute names
getAttrNames(graph)

# Check coverage of specific attributes (e.g., UniProt, KEGG)
getAttrStatus(graph, pattern = "^miriam.")

# Fetch missing annotations via BridgeDb (requires RCurl)
graph <- fetchAttribute(graph, organism = "Homo sapiens", 
                        target.attr = "miriam.ncbigene", 
                        source.attr = "miriam.uniprot")
```

### 3. Network Representation Conversion
Convert bipartite metabolic networks (compounds and reactions) into simpler forms for analysis.

```r
# Create Reaction Network (metabolites become edge attributes)
rgraph <- makeReactionNetwork(graph, simplify = TRUE)

# Create Gene Network (expand complexes to individual genes)
ggraph <- makeGeneNetwork(rgraph)

# Expand complexes manually
ggraph <- expandComplexes(rgraph, v.attr = "miriam.uniprot")
```

### 4. Weighting and Path Ranking
Integrate gene expression data to find active biological paths.

```r
# Assign weights based on Pearson correlation
# microarray: matrix with genes as rows, samples as columns
rgraph <- assignEdgeWeights(microarray = exp_data, graph = rgraph, 
                            weight.method = "cor", use.attr = "miriam.uniprot")

# Rank paths using Probabilistic Shortest Path
ranked.p <- pathRanker(rgraph, method = "prob.shortest.path", K = 25, minPathSize = 6)

# Extract paths as Edge IDs for further analysis
eids <- getPathsAsEIDs(paths = ranked.p, graph = rgraph)
```

### 5. Clustering and Classification
Group similar paths or identify paths that discriminate between sample groups.

```r
# Convert paths to binary matrix for clustering
ybinpaths <- pathsToBinary(ranked.p)

# Cluster paths
p.cluster <- pathCluster(ybinpaths, M = 2)
plotClusters(ybinpaths, p.cluster)

# Classify paths based on sample labels (e.g., "Disease" vs "Control")
p.class <- pathClassifier(ybinpaths, target.class = "BCR/ABL", M = 2)
```

### 6. Visualization
NetPathMiner provides specialized plotting functions for networks and ranked paths.

```r
# Plot network colored by cellular compartment
plotNetwork(rgraph, vertex.color = "compartment.name")

# Highlight ranked paths on the network
plotPaths(ranked.p, rgraph, path.clusters = p.class)

# Layout vertices by attribute (e.g., group by pathway)
layout.c <- clusterVertexByAttr(rgraph, "pathway", cluster.strength = 3)
plotPaths(ranked.p, rgraph, layout = layout.c)
```

## Tips for Success
- **Prerequisites**: Ensure `libxml2` is installed on your system. SBML support requires `libSBML`.
- **Attribute Mapping**: Always check `getAttrStatus` before weighting. If coverage is low, use `fetchAttribute` to map identifiers (e.g., mapping UniProt to Affymetrix IDs).
- **Memory Management**: For genome-scale networks, use `simplifyReactionNetwork` to remove reactions missing gene annotations (like spontaneous reactions) to reduce complexity.
- **Integration**: Use `toGraphNEL(graph)` to convert `igraph` objects to Bioconductor `graphNEL` objects for compatibility with other BioC packages.

## Reference documentation
- [NetPathMiner Vignette](./references/NPMVignette.md)
- [NetPathMiner RMarkdown Source](./references/NPMVignette.Rmd)