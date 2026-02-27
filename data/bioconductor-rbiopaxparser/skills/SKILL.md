---
name: bioconductor-rbiopaxparser
description: This package parses BioPAX files into a flat data table format for querying and analyzing biological pathways in R. Use when user asks to parse OWL files, list pathway components, visualize regulatory graphs, or create and modify BioPAX models.
homepage: https://bioconductor.org/packages/release/bioc/html/rBiopaxParser.html
---


# bioconductor-rbiopaxparser

## Overview

The `rBiopaxParser` package allows R users to interact with BioPAX (Biological Pathways Exchange) data. It maps the complex, nested OWL/XML structure of BioPAX into a flat, high-performance `data.table` format. This enables efficient querying of biological entities (proteins, small molecules), interactions (biochemical reactions, controls), and pathways.

## Core Workflows

### 1. Loading and Parsing Data
You can download data directly from supported databases (like NCI/PID) or read local `.owl` files.

```R
library(rBiopaxParser)

# Download BioCarta data from NCI
file <- downloadBiopaxData("NCI", "biocarta")

# Parse the BioPAX file
biopax <- readBiopax(file)

# View summary of the model
print(biopax)

# Access the internal data.table directly
head(biopax$dt)
```

### 2. Accessing Pathway Information
Use convenience functions to list and select specific instances without manual filtering of the data table.

```R
# List all pathways
pw_list <- listInstances(biopax, class="pathway")

# Get components of a specific pathway
pwid <- "pid_p_100002_wntpathway"
components <- listPathwayComponents(biopax, pwid)

# Get specific properties (e.g., NAME)
name <- getInstanceProperty(biopax, pwid, property="NAME")

# Find all IDs referenced by an instance (recursive)
refs <- getReferencedIDs(biopax, pwid, recursive=TRUE)
```

### 3. Visualization and Graph Analysis
The package can convert BioPAX pathways into regulatory graphs (nodes = molecules, edges = activation/inhibition).

```R
# Create a regulatory graph
# splitComplexMolecules=TRUE breaks complexes into individual protein nodes
g <- pathway2RegulatoryGraph(biopax, pwid, splitComplexMolecules=TRUE)

# Layout and plot (requires Rgraphviz)
g_laidout <- layoutRegulatoryGraph(g)
plotRegulatoryGraph(g_laidout)

# Compare or combine pathways
merged_g <- uniteGraphs(graph1, graph2)
```

### 4. Modifying and Creating BioPAX Models
You can build models from scratch or modify existing ones by adding entities and interactions.

```R
# Initialize a new model
new_biopax <- createBiopax()

# Add a protein and its participant instance
new_biopax <- addPhysicalEntity(new_biopax, class="protein", NAME="ProteinA", id="p_A")
new_biopax <- addPhysicalEntityParticipant(new_biopax, referencedPhysicalEntityID="p_A", id="pep_A")

# Add a reaction and a control (Activation)
new_biopax <- addBiochemicalReaction(new_biopax, LEFT="pep_A", RIGHT="pep_B", id="reac_1")
new_biopax <- addControl(new_biopax, CONTROL_TYPE="ACTIVATION", CONTROLLER="pep_A", CONTROLLED="reac_1", id="ctrl_1")

# Export to file
writeBiopax(new_biopax, file="my_model.owl")
```

## Tips for Large Datasets
- **Reactome/Large Files**: Parsing large files like the full Reactome database can take significant time (up to an hour) and memory. Use `readBiopax` once and save the resulting object as an `.RData` file for future sessions.
- **Data Table Access**: For custom queries not covered by convenience functions, use `biopax$dt`. It is a `data.table` and supports fast subsetting: `biopax$dt[class == "protein" & property == "NAME"]`.
- **BioPAX Levels**: The package has full support for Level 2. Level 3 support is available but may require manual inspection of the `dt` for complex nested properties.

## Reference documentation
- [rBiopaxParser Vignette](./references/rBiopaxParserVignette.md)