---
name: bioconductor-gaggle
description: This tool facilitates interactive data exchange between R and other biological software using the Gaggle framework. Use when user asks to broadcast or receive name lists, matrices, networks, and associative arrays between R and applications like Cytoscape, MeV, or STRING.
homepage: https://bioconductor.org/packages/3.8/bioc/html/gaggle.html
---


# bioconductor-gaggle

name: bioconductor-gaggle
description: Facilitates interactive data exchange between R and other biological software (Geese) using the Gaggle framework. Use this skill to broadcast and receive name lists, matrices, networks (GraphNEL), and associative arrays (environments) between R and tools like Cytoscape, MeV, or STRING.

# bioconductor-gaggle

## Overview

The `gaggle` package acts as an R "Goose" within the Gaggle framework, a Java-based system for integrating heterogeneous bioinformatics software. It allows for the seamless "broadcasting" of data objects between R and other desktop applications or web resources. This is particularly useful for workflows that combine R's statistical power with the interactive visualization capabilities of tools like Cytoscape.

## Core Workflow

### 1. Initialization
Before using the R package, the **Gaggle Boss** application must be running on your computer. It acts as the central hub for all data broadcasts.

```r
library(gaggle)
# Connect the R session to the Gaggle Boss
gaggleInit()
```

### 2. Managing Connections
You can interact with other "geese" (connected programs) using these management functions:

*   `geese()`: Lists all currently active programs registered with the Boss.
*   `setTargetGoose(gooseName)`: Sets a specific program as the recipient for future broadcasts. If not set, broadcasts go to all geese.
*   `getTargetGoose()`: Returns the current target.
*   `showGoose()` / `hideGoose()`: Controls the window visibility of the target application.

### 3. Broadcasting Data (R to Other Apps)
The `broadcast()` function is generic and handles four primary data types:

| R Data Type | Gaggle Type | Typical Use Case |
| :--- | :--- | :--- |
| `character vector` | Name List | Selecting genes in Cytoscape or STRING |
| `matrix` | Matrix | Sending expression data to MeV |
| `graphNEL` | Network | Visualizing R-generated graphs in Cytoscape |
| `environment` | Associative Array | Sending metadata or key-value pairs |

**Example: Sending a Network to Cytoscape**
```r
library(graph)
# Create a simple graph
g <- randomEGraph(LETTERS[1:8], edges=10)
# Broadcast to the current target (e.g., Cytoscape)
broadcast(g)
```

### 4. Receiving Data (Other Apps to R)
When another application broadcasts data to R, the R console will display a notification (Note: notifications may not appear in the Windows RGui; use R.exe or RStudio). You must manually capture the incoming data into an R variable:

*   `getNameList()`: Captures an incoming list of names.
*   `getMatrix()`: Captures an incoming matrix.
*   `getNetwork()`: Captures an incoming network as a `graphNEL` object.
*   `getCluster()`: Captures clustered data.
*   `getTuple()`: Captures associative arrays/environments.

**Example: Capturing a selection from Cytoscape**
```r
# After clicking 'Broadcast Names' in Cytoscape:
selectedGenes <- getNameList()
```

## Technical Tips for Windows Users
*   **RGui Limitation**: The graphical RGui on Windows does not display "Broadcast Received" messages. Use the command line or check for data manually if you expect a broadcast.
*   **Java Pathing**: Ensure your Windows `CLASSPATH` does not contain entries with spaces or the R bin directory, as this can interfere with `rJava` connectivity.

## Reference documentation
- [The Gaggle](./references/gaggle.md)