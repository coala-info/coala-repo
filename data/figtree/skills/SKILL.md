---
name: figtree
description: Figtree is a graphical viewer for phylogenetic trees and a tool for producing publication-ready figures. Use when user asks to visualize, analyze, or export phylogenetic trees, or generate figures for scientific publications.
homepage: https://github.com/rambaut/figtree
metadata:
  docker_image: "biocontainers/figtree:v1.4.4-3-deb_cv1"
---

# figtree

yaml
name: figtree
description: A graphical viewer for phylogenetic trees and a tool for producing publication-ready figures. Use when Claude needs to visualize, analyze, or export phylogenetic trees, or generate figures for scientific publications.
```
## Overview
FigTree is a powerful application designed for visualizing and manipulating phylogenetic trees. It's particularly useful for generating high-quality figures suitable for scientific publications. You would use FigTree when you need to explore the relationships within a tree, annotate it with data, or export it in various formats for presentation.

## Usage Instructions

FigTree is primarily a graphical application, but it can be invoked from the command line for certain operations or to launch the GUI with specific files.

### Launching FigTree

To launch the FigTree application, simply type `figtree` in your terminal.

```bash
figtree
```

This will open the FigTree graphical user interface, allowing you to load and interact with your tree files.

### Opening Tree Files

You can open tree files directly from the command line by providing the file path as an argument to the `figtree` command. FigTree supports various tree formats, including Newick, Nexus, and others.

```bash
figtree /path/to/your/tree.nwk
```

This command will launch FigTree and automatically load the specified tree file.

### Command-Line Options (Limited)

While FigTree is primarily GUI-driven, some basic command-line arguments might be supported for launching or specifying input files. The primary interaction is through the GUI.

### Expert Tips for Publication-Ready Figures

1.  **Tree Layouts**: Experiment with different tree layouts (e.g., rectangular, cladogram, radial) to best represent your data. Access these options through the "Trees" menu in the GUI.
2.  **Annotation**: Use the "Annotations" panel to add labels, scale bars, branch lengths, and other relevant information. Ensure annotations are clear and legible.
3.  **Styling**: Customize node shapes, colors, branch colors, and font styles to enhance clarity and aesthetic appeal. The "Appearance" panel is your primary tool for this.
4.  **Exporting**: FigTree offers various export formats for figures, including SVG, PDF, and EPS, which are ideal for publications. Use "File" > "Export..." to select your desired format and resolution. For vector graphics (SVG, PDF, EPS), ensure you export at a high enough resolution or use vector formats to maintain quality when scaling.
5.  **Summarized Trees**: FigTree is particularly well-suited for displaying summarized and annotated trees produced by phylogenetic inference software like BEAST.

## Reference documentation
- [FigTree Overview](./references/anaconda_org_channels_bioconda_packages_figtree_overview.md)
- [FigTree GitHub Repository](./references/github_com_rambaut_figtree.md)