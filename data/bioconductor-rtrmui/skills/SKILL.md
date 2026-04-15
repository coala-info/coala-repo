---
name: bioconductor-rtrmui
description: This tool provides a Shiny-based graphical user interface for identifying transcriptional regulatory modules by integrating motif enrichment, gene expression, and protein interaction data. Use when user asks to identify transcriptional regulatory modules, visualize protein-protein interaction networks of transcription factors, or perform motif enrichment analysis through an interactive web interface.
homepage: https://bioconductor.org/packages/release/bioc/html/rTRMui.html
---

# bioconductor-rtrmui

name: bioconductor-rtrmui
description: Identification of transcriptional regulatory modules (TRMs) using a Shiny-based graphical user interface. Use when the user needs to interactively identify TRMs, visualize protein-protein interaction (PPI) networks of transcription factors, or perform motif enrichment analysis through a web-based interface rather than command-line R scripts.

# bioconductor-rtrmui

## Overview

The `rTRMui` package provides a Shiny-based graphical user interface for the `rTRM` package. It facilitates the identification of transcriptional regulatory modules (TRMs) by integrating transcription factor (TF) motif enrichment data, gene expression data, and protein-protein interaction networks. It is designed to be user-friendly, allowing researchers to upload datasets and visualize results without extensive R coding.

## Workflow and Usage

### Launching the Interface

The primary function of this package is to launch the local Shiny application.

```R
library(rTRMui)
runTRM()
```

Once executed, a web browser window will open with the rTRMui home page.

### Data Input Requirements

To use the tool effectively, you generally need two types of input files (examples are available for download on the home page):

1.  **Enriched Motifs List**: A file containing motifs identified in genomic regions (e.g., ChIP-seq peaks).
2.  **Expressed Genes List**: A file containing the list of genes expressed in the specific biological context (e.g., mouse embryonic stem cells).

### Interactive Parameters

Within the UI, you can configure the following:
- **Target Organism**: Select the species (e.g., mouse, human).
- **Target Transcription Factor**: Define the primary TF of interest (e.g., Sox2).
- **Query Transcription Factors**: Select which TFs to include in the search for modules.
- **Bridge Distance**: Set the maximum distance between TFs in the PPI network.
- **Filter Options**: Option to filter out Ubiquitin/Sumo proteins from the PPI network to reduce noise.
- **Search Mode**: Choose between "Strict TRM" or "Extended TRM".

### Interpreting Results

The interface provides several tabs for analysis:
- **Plot**: Visualizes the identified TRM as a network graph where nodes are TFs and edges represent interactions.
- **Table**: Provides a list of the TFs included in the identified module.
- **Tutorial/Help**: Contains detailed instructions on navigating the specific UI elements.

## Tips

- **Dependency**: `rTRMui` requires both `rTRM` and `shiny` to be installed.
- **Headless Environments**: Since `runTRM()` attempts to open a web browser, ensure you are working in an environment that supports a browser (like a local RStudio session) or use the `host` and `port` arguments if configuring for a remote server.
- **Sample Data**: If you are new to the package, download the `esc_expressed.txt` and `sox2_motifs.txt` files from the home page to run the built-in tutorial.

## Reference documentation

- [rTRMui](./references/rTRMui.md)