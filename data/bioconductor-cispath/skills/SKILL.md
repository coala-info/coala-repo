---
name: bioconductor-cispath
description: This tool identifies and visualizes the shortest functional pathways between proteins using large-scale protein-protein interaction data. Use when user asks to identify shortest paths between proteins, visualize molecular interaction networks, or format protein-protein interaction data from databases like STRING, GeneMANIA, and PINA.
homepage: https://bioconductor.org/packages/release/bioc/html/cisPath.html
---


# bioconductor-cispath

name: bioconductor-cispath
description: Visualization and management of protein-protein interaction (PPI) networks and the identification of functional pathways. Use this skill when a user needs to identify the shortest functional paths between proteins, visualize molecular interaction networks, or integrate PPI data from sources like STRING, GeneMANIA, and PINA within R.

# bioconductor-cispath

## Overview
The `cisPath` package is an R tool designed to identify and visualize the shortest functional pathways between proteins using large-scale protein-protein interaction (PPI) data. It allows users to transform raw interaction data from major databases into structured formats suitable for network analysis and provides a web-based visualization interface to explore these pathways.

## Core Workflow

### 1. Data Preparation
`cisPath` requires PPI data. You can format data from common databases using specific parser functions.

```r
library(cisPath)

# Example: Formatting STRING database data
# download.file("https://string-db.org/data/protein.links.v11.5/9606.protein.links.v11.5.txt.gz", "9606.links.txt.gz")
# formatSTRING(input="9606.links.txt.gz", output="PPI_data.txt", species="9606")

# Example: Formatting GeneMANIA data
# formatGeneMANIA(input="combined_score.txt", output="PPI_data.txt", species="H. Sapiens")
```

### 2. Identifying Shortest Paths
The primary function `cisPath` identifies the shortest paths between a source protein and a target protein based on interaction scores/costs.

```r
# Find paths between two proteins (using Swiss-Prot AC or Gene Symbols)
# PPI_file should be a tab-delimited file: ProteinA, ProteinB, Score
cisPath(
    sourceP = "P01106", 
    targetP = "P62993", 
    PPI_file = "PPI_data.txt", 
    output = "output_pathway.html",
    by_gene_symbol = FALSE
)
```

### 3. Network Visualization
The package generates HTML files that use Cytoscape.js or similar web technologies for interactive visualization.

- **Output**: The `output` parameter in `cisPath()` or `generateNetwork()` specifies the HTML file.
- **Interaction**: Open the resulting HTML file in a web browser to move nodes, zoom, and inspect edge weights.

### 4. Managing the Local Database
You can create a local mapping of protein identifiers to facilitate faster lookups.

```r
# Create a mapping file from Swiss-Prot data
# formatSIF(input="uniprot_sprot.dat", output="mapping.txt")
```

## Key Functions
- `cisPath()`: Main function to find and visualize the shortest path between two proteins.
- `formatSTRING()`: Pre-processes STRING database files.
- `formatGeneMANIA()`: Pre-processes GeneMANIA database files.
- `formatPINA()`: Pre-processes PINA database files.
- `formatIntAct()`: Pre-processes IntAct database files.
- `combinePPI()`: Merges PPI data from different sources into a single file.

## Tips for Success
- **Input Format**: Ensure the PPI file is tab-delimited with three columns: Protein A, Protein B, and a confidence score (or cost).
- **Identifier Consistency**: Be consistent with protein identifiers (UniProt Accession vs. Gene Symbols). Use the `by_gene_symbol` argument accordingly.
- **Path Costs**: `cisPath` treats the score in the input file as a "cost." If your data uses "confidence scores" where higher is better, you may need to transform them (e.g., 1/score) before processing if the function doesn't handle the inversion automatically.

## Reference documentation
- [cisPath Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/cisPath.html)