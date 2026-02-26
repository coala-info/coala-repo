---
name: shiptv
description: "shiptv creates interactive HTML visualizations of phylogenetic trees with integrated metadata. Use when user asks to convert Newick files to interactive web-based visualizations, map metadata from TSV or GenBank files onto tree leaves, collapse low support branches, or prune trees for exploration."
homepage: https://github.com/peterk87/shiptv
---


# shiptv

## Overview
shiptv (Standalone HTML Interactive Phylogenetic Tree Viz) transforms static phylogenetic data into dynamic web-based visualizations powered by Phylocanvas. It allows users to map custom metadata (from TSV or GenBank files) directly onto tree leaves, providing a side-by-side view of evolutionary relationships and associated sample data. This tool is particularly useful for genomic epidemiology and comparative phylogenetics where metadata exploration is as critical as the tree topology itself.

## Core CLI Patterns

### Basic Tree Generation
To convert a standard Newick tree into an interactive HTML file:
```bash
shiptv -n input.treefile -o visualization.html
```

### Integrating Metadata
Metadata must be a tab-delimited (TSV) file where the first column contains IDs matching the leaf names in the Newick file.
```bash
shiptv -n tree.nwk --metadata metadata.tsv -o tree.html
```

### Automated GenBank Metadata Extraction
If you have reference genomes in GenBank format, shiptv can automatically extract metadata fields and flag user samples.
```bash
shiptv -r references.gb -n tree.nwk -o tree.html -m extracted_metadata.tsv
```

## Expert Tips and Best Practices

### Handling Tree Quality
*   **Collapse Low Support**: Use `-C` to simplify trees by collapsing internal branches with low bootstrap/support values. For IQ-TREE (UFBoot), a common threshold is 95:
    ```bash
    shiptv -n tree.nwk -C 95.0 -o tree.html
    ```
*   **Midpoint Rooting**: If your tree is unrooted, use the `--midpoint-root` flag to improve visual interpretation.

### Metadata Optimization
*   **Field Selection**: Use `--metadata-fields-in-order` with a text file (one field per line) to control which columns appear in the HTML select box and their display order.
*   **Highlighting**: Use `--highlight-user-samples` to visually distinguish your specific samples from reference sequences extracted from GenBank files.

### Interactive Controls
*   **Full Window Mode**: Once the HTML is opened in a browser, use `Shift + Ctrl + F` to toggle full-window mode.
*   **Pruning**: If you only want to visualize a subset of a large tree, provide a list of leaf names to `--leaflist`.

## Troubleshooting
*   **ID Mismatches**: Ensure the first column of your metadata TSV exactly matches the leaf labels in your Newick file.
*   **Missing Metadata**: If the tree renders but metadata is missing, check if `--fix-metadata` (enabled by default) is interfering with non-standard GenBank formats; you can disable it with `--no-fix-metadata`.

## Reference documentation
- [shiptv GitHub Repository](./references/github_com_peterk87_shiptv.md)
- [shiptv Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_shiptv_overview.md)