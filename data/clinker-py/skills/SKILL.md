---
name: clinker-py
description: clinker-py automates the comparison and interactive visualization of gene clusters by performing global protein alignments and calculating cluster similarity. Use when user asks to compare gene clusters, generate interactive clustermaps from GenBank or GFF3 files, or visualize homology between genomic regions.
homepage: https://github.com/gamcil/clinker
metadata:
  docker_image: "quay.io/biocontainers/clinker-py:0.0.32--pyhdfd78af_0"
---

# clinker-py

## Overview
clinker-py is a specialized bioinformatics pipeline designed to automate the comparison of gene clusters. It extracts protein sequences from input files, performs global alignments to determine homology, and calculates an optimal display order based on cluster similarity. The tool produces an interactive visualization (clustermap.js) that allows for manual refinement of gene groupings, colors, and layouts before exporting to vector formats like SVG.

## Core Workflows

### Basic Visualization
To generate a standard comparison plot from a set of GenBank files:
`clinker clusters/*.gbk -p plot.html`
*   **Note**: If no filename is provided after `-p`, clinker will serve the plot dynamically via a local Python HTTP server.

### Working with GFF3
When using GFF3 files, ensure a corresponding FASTA file (with the same base name and a standard extension like `.fa` or `.fasta`) exists in the same directory:
`clinker region1.gff3 region2.gff3 -p`

### Session Management
For large datasets or iterative work, use session files to avoid recomputing alignments:
*   **Save a session**: `clinker *.gbk -s session.json`
*   **Resume/Add to session**: `clinker -s session.json new_cluster.gbk -p`
    *   clinker will only align the new files against the existing ones in the session.

## Advanced CLI Patterns

### Custom Gene Grouping and Coloring
By default, clinker groups genes by sequence similarity. You can override this using functional annotations:
*   **Define functions**: Create a 2-column CSV (`functions.csv`) mapping gene IDs to names (e.g., `GENE_001,PKS`).
    `clinker *.gbk -gf functions.csv -p`
*   **Map colors**: Create a 2-column CSV (`colors.csv`) mapping group names to hex codes (e.g., `PKS,#ff0000`).
    `clinker *.gbk -gf functions.csv -cm colors.csv -p`

### Alignment Tuning
*   **Identity Threshold**: Filter out weak links by increasing the minimum identity (default is 0.3):
    `clinker *.gbk -i 0.5`
*   **No Alignment**: If you only need to-scale maps without homology links:
    `clinker *.gbk -na -p`

### Output Customization
*   **Matrix Output**: Save a cluster similarity matrix for downstream statistical analysis:
    `clinker *.gbk -mo similarity_matrix.csv`
*   **Delimited Results**: Save raw alignment scores to a CSV:
    `clinker *.gbk -o alignments.csv -dl ","`

## Expert Tips
*   **Input Order**: Use the `-ufo` (use file order) flag if you want the vertical arrangement of clusters to match the order in which you provided the files on the command line, rather than the automatically calculated similarity order.
*   **Scaffold Extraction**: If your GenBank files contain large scaffolds but you only want to visualize a specific region, use the `--ranges` flag:
    `clinker scaffold.gbk -r scaffold_1:10000-25000`
*   **Performance**: For many clusters, use the `-j` flag to specify the number of parallel alignment jobs (e.g., `-j 8`).
*   **Visual Refinement**: The HTML output is interactive. You can drag cluster names to reorder them, click gene labels to rename groups, and click the legend circles to change colors directly in the browser before saving the SVG.

## Reference documentation
- [clinker GitHub README](./references/github_com_gamcil_clinker.md)
- [clinker Wiki](./references/github_com_gamcil_clinker_wiki.md)
- [clinker-py Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_clinker-py_overview.md)