---
name: bioconductor-ggmsa
description: The ggmsa package provides a ggplot2-based framework for visualizing and annotating multiple sequence alignments. Use when user asks to visualize multiple sequence alignments, add sequence logos or conservation bars to alignments, and plot specific regions of FASTA or Biostrings data.
homepage: https://bioconductor.org/packages/release/bioc/html/ggmsa.html
---

# bioconductor-ggmsa

## Overview
The `ggmsa` package is a ggplot2-based tool for visualizing multiple sequence alignments. It supports various input formats (FASTA, Biostrings objects, etc.) and provides a modular approach to MSA annotation. Users can layer information such as sequence logos and conservation bars directly onto the alignment plot using a syntax familiar to ggplot2 users.

## Typical Workflow

1.  **Load the Library**
    ```r
    library(ggmsa)
    library(ggplot2)
    ```

2.  **Import Data**
    `ggmsa` accepts file paths to FASTA files or R objects like `DNAStringSet`, `AAStringSet`, and `AAMultipleAlignment`.
    ```r
    # Example using internal data
    protein_file <- system.file("extdata", "sample.fasta", package = "ggmsa")
    ```

3.  **Basic Visualization**
    The core function is `ggmsa()`. You can specify a range of positions to display.
    ```r
    # Plot positions 300 to 350
    ggmsa(protein_file, start = 300, end = 350, color = "Clustal", font = "DroidSansMono")
    ```

4.  **Adding Annotations**
    Use the `+` operator to add layers.
    ```r
    ggmsa(protein_file, start = 221, end = 280) + 
      geom_seqlogo(color = "Chemistry_AA") + 
      geom_msaBar()
    ```

## Key Functions and Customization

### Core Plotting
- `ggmsa(data, start, end, color, font, char_width, seq_name)`: Main function to initialize the MSA plot.
- `available_msa()`: Lists supported input formats and objects.

### Color Schemes and Fonts
- `available_colors()`: Lists available color schemes (e.g., "Clustal", "Zappo_AA", "Chemistry_NT").
- `available_fonts()`: Lists available font families (e.g., "helvetical", "mono", "DroidSansMono").

### Annotation Layers (Geoms)
- `geom_seqlogo()`: Adds a sequence logo above the alignment to show residue preference.
- `geom_msaBar()`: Adds a bar chart showing sequence conservation.
- `geom_GC()`: Displays GC content (useful for nucleotide sequences).
- `geom_seed()`: Highlights the seed region (specifically for miRNA).
- `geom_helix()`: Depicts RNA secondary structure as arc diagrams (requires secondary structure data).

## Tips for Effective Visualization
- **Subsetting**: For large alignments, always use the `start` and `end` parameters to focus on specific regions of interest to maintain readability.
- **Character Width**: Adjust `char_width` (default is often 0.5 to 0.9) to control the spacing of residues.
- **Integration**: Since `ggmsa` returns a ggplot object, you can further customize the theme or combine it with other plots using packages like `patchwork` or `aplot`.

## Reference documentation
- [ggmsa-Getting Started](./references/ggmsa.Rmd)
- [ggmsa-Getting Started (Markdown)](./references/ggmsa.md)