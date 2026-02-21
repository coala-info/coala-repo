---
name: bioconductor-drawproteins
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/drawProteins.html
---

# bioconductor-drawproteins

## Overview
The `drawProteins` package enables the creation of scale-drawn protein schematics. It automates the process of fetching protein annotations from the UniProt API, converting them into tidy data frames, and rendering them as ggplot2 objects. This allows for highly customizable visualizations of protein architecture, including chains, domains, regions, motifs, and post-translational modifications (PTMs).

## Core Workflow

1.  **Fetch Data**: Use UniProt accession numbers to retrieve feature data.
2.  **Process Data**: Convert the raw JSON/list response into a structured data frame.
3.  **Initialize Canvas**: Create the ggplot2 base layer scaled to the longest protein.
4.  **Add Geoms**: Layer protein features (chains, domains, etc.) onto the canvas.
5.  **Refine**: Apply themes and labels for final output.

## Key Functions and Usage

### Data Retrieval and Preparation
```r
library(drawProteins)

# 1. Get features from UniProt (separate multiple IDs with a space)
ids <- "Q04206 Q01201"
raw_json <- get_features(ids)

# 2. Convert to data frame
prot_data <- feature_to_dataframe(raw_json)

# Optional: Handle alternative transcripts or cleavage products
# This expands the data frame to include isoforms/processed forms
prot_data_expanded <- extract_transcripts(prot_data)
```

### Visualization Layers
The package uses a layered approach where each function takes a ggplot object and returns an updated one.

```r
# Initialize canvas
p <- draw_canvas(prot_data)

# Add the main protein chain
p <- draw_chains(p, prot_data, fill = "lightsteelblue1", outline = "grey")

# Add specific features
p <- draw_domains(p, prot_data)
p <- draw_regions(p, prot_data)
p <- draw_motif(p, prot_data)
p <- draw_repeat(p, prot_data)

# Add post-translational modifications (e.g., phosphorylation)
p <- draw_phospho(p, prot_data, size = 8, fill = "red")
```

### Styling and Customization
Since the output is a `ggplot2` object, standard ggplot2 functions apply.

```r
library(ggplot2)

# Recommended theme for clean schematics
p <- p + theme_bw() +
    theme(panel.grid.minor = element_blank(), 
          panel.grid.major = element_blank(),
          axis.ticks = element_blank(), 
          axis.text.y = element_blank(),
          panel.border = element_blank()) +
    labs(title = "Protein Schematic", subtitle = "Source: UniProt")
```

## Tips for Success
*   **Internet Access**: `get_features()` requires an active internet connection to query the UniProt API.
*   **Labeling**: If plotting multiple proteins or transcripts, use the `labels` argument in `draw_chains()` to provide a character vector of custom names. Note that proteins are plotted from the bottom up.
*   **Feature Types**: If a specific feature (like a "motif") isn't appearing, check the `type` column in your data frame to ensure UniProt has that feature annotated for your specific accession number.
*   **Scaling**: `draw_canvas()` automatically sets the x-axis limit based on the longest protein in the dataset.

## Reference documentation
- [Using drawProteins](./references/drawProteins_BiocStyle.md)
- [Using extract_transcripts in drawProteins](./references/drawProteins_extract_transcripts_BiocStyle.md)
- [Source Vignette: drawProteins](./references/drawProteins_BiocStyle.Rmd)
- [Source Vignette: extract_transcripts](./references/drawProteins_extract_transcripts_BiocStyle.Rmd)