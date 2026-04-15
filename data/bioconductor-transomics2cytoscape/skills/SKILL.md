---
name: bioconductor-transomics2cytoscape
description: This package automates the creation of 3D trans-omic network visualizations by stacking multiple 2D network layers in Cytoscape. Use when user asks to create 3D network stacks, visualize trans-omic interactions between layers, or convert EC numbers to reaction IDs for network mapping.
homepage: https://bioconductor.org/packages/release/bioc/html/transomics2cytoscape.html
---

# bioconductor-transomics2cytoscape

## Overview

The `transomics2cytoscape` package automates the creation of 3D trans-omic network visualizations. It works by stacking multiple 2D network layers (such as KEGG pathways or custom SIF files) along a Z-axis and drawing "trans-omic" edges between them. This process requires a running instance of Cytoscape with the Cy3D and KEGGscape apps installed.

## Prerequisites

Before running the R workflow, ensure:
1. **Cytoscape** is open and running.
2. **Cy3D** and **KEGGscape** apps are installed within Cytoscape.
3. The `RCy3` package is available to facilitate the connection.

## Core Workflow

### 1. Define Network Layers
Create a "Layer definition file" (TSV) to specify the vertical arrangement.
- **Column 1**: Layer Index (e.g., `kinase-layer`).
- **Column 2**: KEGG pathway ID (e.g., `rno04910`) or a local network filename.
- **Column 3**: Z-height (numeric value).
- **Column 4**: Boolean (`true`/`false`). If `true`, interactions connect to the "edge" (midpoint) of network reactions rather than specific nodes.

### 2. Create the 3D Stack
Use `create3Dnetwork` to import the layers into Cytoscape.

```r
library(transomics2cytoscape)

# Directory containing local network files (if any)
networkDataDir <- "path/to/networks" 
# Path to the TSV layer definition
networkLayers <- "layers.tsv"
# Path to Cytoscape XML style file
stylexml <- "styles.xml"

# Returns the SUID of the created network
suid <- create3Dnetwork(networkDataDir, networkLayers, stylexml)
```

### 3. Add Trans-omic Edges
Define connections between layers using a "Trans-omic interaction file" (TSV).
- **Columns 1-3**: Source layer index, attribute name, and attribute value.
- **Columns 4-6**: Target layer index, attribute name, and attribute value.
- **Column 7**: Interaction type (e.g., `activation`).

```r
# Path to the TSV interaction file
layer1to2 <- "interactions.tsv"

# Add edges to the existing 3D network
suid <- createTransomicEdges(suid, layer1to2)
```

### 4. EC Number Conversion
If your interaction data uses EC numbers but the network (like KEGG global maps) uses Reaction IDs, use `ec2reaction` to convert the IDs in your interaction file.

```r
# ecnum_file: input TSV
# col_num: the column index containing EC numbers
# output_file: path for the converted TSV
ec2reaction(ecnum_file, col_num = 6, output_file = "converted_interactions.tsv")
```

## Usage Tips
- **KEGG Integration**: You do not need to download KEGG files manually; providing the KEGG ID in the layer definition file allows the package to fetch them automatically.
- **Visualization**: After the script finishes, you must manually zoom out or adjust the camera angle in Cytoscape's 3D view to see the full stack.
- **Stability**: Do not interact with the Cytoscape GUI while the R script is executing commands, as this can interrupt the automation sequence.

## Reference documentation

- [Introduction to the transomics2cytoscape package](./references/transomics2cytoscape.md)