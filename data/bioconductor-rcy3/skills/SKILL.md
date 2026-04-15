---
name: bioconductor-rcy3
description: This tool provides a programmatic interface to automate Cytoscape network creation, visualization, and analysis from within the R environment. Use when user asks to create networks from data frames or igraph objects, apply visual style mappings, filter network components, or integrate with databases like STRING and NDEx.
homepage: https://bioconductor.org/packages/release/bioc/html/RCy3.html
---

# bioconductor-rcy3

name: bioconductor-rcy3
description: Expert guidance for using the RCy3 R package to automate Cytoscape. Use this skill when you need to create, manipulate, visualize, or analyze biological networks in Cytoscape from an R environment. It covers data import (data.frames, igraph, graphNEL), visual style mapping, network filtering, identifier mapping, and integration with external databases like STRING and NDEx.

# bioconductor-rcy3

## Overview
RCy3 is a Bioconductor package that provides a programmatic interface to Cytoscape via the CyREST API. It allows R users to transform data into networks, apply complex visual styles, and perform automated network analysis without manual interaction with the Cytoscape GUI.

## Core Workflow

### 1. Connection and Setup
Cytoscape must be running locally before executing RCy3 commands.
```r
library(RCy3)
cytoscapePing() # Confirm connection
```

### 2. Creating Networks
RCy3 supports multiple input formats. It automatically handles the transfer to Cytoscape.
*   **From Data Frames:** Requires a node data frame (with an `id` column) and an edge data frame (with `source` and `target` columns).
    ```r
    createNetworkFromDataFrames(nodes_df, edges_df, title="My Network")
    ```
*   **From igraph:**
    ```r
    createNetworkFromIgraph(igraph_obj, title="igraph Network")
    ```
*   **From graphNEL:**
    ```r
    createNetworkFromGraph(graphNEL_obj, title="graphNEL Network")
    ```

### 3. Data Import and Mapping
You can load additional attributes into the Cytoscape Node or Edge tables using `loadTableData`.
```r
# Matches 'id' in data.frame to 'name' in Cytoscape Node Table
loadTableData(my_data_df, data.key.column="id", table.key.column="name")
```

### 4. Visual Styles and Mappings
Visual styles control the appearance of the network based on data values.
*   **Defaults:** Set global properties.
    ```r
    setNodeShapeDefault("ELLIPSE")
    setNodeColorDefault("#AAAAAA")
    ```
*   **Discrete Mapping:** Map categories to specific visuals (e.g., molecule type to shape).
    ```r
    setNodeShapeMapping('moleculeType', c('kinase', 'TF'), c('DIAMOND', 'TRIANGLE'))
    ```
*   **Continuous Mapping:** Map numeric ranges to gradients (e.g., log2FC to color).
    ```r
    setNodeColorMapping('log2fc', c(-2, 0, 2), c('#0000FF', '#FFFFFF', '#FF0000'))
    ```
*   **Passthrough Mapping:** Use the data value directly (e.g., gene symbol as label).
    ```r
    setNodeLabelMapping('symbol')
    ```

### 5. Network Manipulation and Filtering
*   **Layouts:** Apply algorithms to position nodes.
    ```r
    layoutNetwork('force-directed')
    ```
*   **Selection:** Select nodes/edges by attribute or connectivity.
    ```r
    selectNodes(c("BRCA1", "TP53"), by.col="name")
    selectFirstNeighbors()
    createSubnetwork(subnetwork.name="Selected Subnetwork")
    ```
*   **Filters:** Create complex selection logic.
    ```r
    createColumnFilter(filter.name='high_score', column='score', 5, 'GREATER_THAN')
    ```

### 6. External Integrations
*   **STRING:** Query the STRING database for disease or protein networks.
    ```r
    string.cmd = 'string disease query disease="breast cancer" cutoff=0.9'
    commandsRun(string.cmd)
    ```
*   **NDEx:** Import or export networks to the Network Data Exchange.
    ```r
    importNetworkFromNDEx(network_uuid)
    ```

## Tips and Best Practices
*   **SUIDs vs Names:** Cytoscape uses SUIDs (internal IDs) for precision. When using names, specify `by.col="name"` in selection functions.
*   **Session Management:** Save your work frequently using `saveSession('filename')`.
*   **App Automation:** Many Cytoscape apps (like STRINGapp or enhancedGraphics) expose functionality via `commandsRun()` or `commandsPOST()`.
*   **Performance:** For very large networks, minimize visual updates by using `clearSelection()` and avoiding frequent style refreshes until data loading is complete.

## Reference documentation
- [Cancer networks and data](./references/Cancer-networks-and-data.md)
- [Custom Graphics](./references/Custom-Graphics.md)
- [Cytoscape and NDEx](./references/Cytoscape-and-NDEx.md)
- [Cytoscape and graphNEL](./references/Cytoscape-and-graphNEL.md)
- [Cytoscape and iGraph](./references/Cytoscape-and-iGraph.md)
- [Filtering Networks](./references/Filtering-Networks.md)
- [Group nodes](./references/Group-nodes.md)
- [Identifier mapping](./references/Identifier-mapping.md)
- [Importing data](./references/Importing-data.md)
- [Jupyter bridge and RCy3](./references/Jupyter-bridge-rcy3.md)
- [Network functions and visualization](./references/Network-functions-and-visualization.md)
- [Overview of RCy3](./references/Overview-of-RCy3.md)
- [Phylogenetic trees](./references/Phylogenetic-trees.md)
- [Upgrading existing scripts](./references/Upgrading-existing-scripts.md)