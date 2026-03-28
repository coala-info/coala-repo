---
name: kegg-pathways-completeness
description: This tool evaluates the completeness of KEGG modules and pathways based on provided KO annotations. Use when user asks to calculate pathway completeness from KO lists, analyze functional profiles per contig, or visualize metabolic modules as graphs.
homepage: https://github.com/EBI-Metagenomics/kegg-pathways-completeness-tool
---


# kegg-pathways-completeness

## Overview
The `kegg-pathways-completeness` tool is a bioinformatics utility designed to bridge the gap between raw KO annotations and high-level functional understanding. It evaluates how "complete" a KEGG module is based on the presence or absence of specific enzymes (KOs) within a sample or contig. This is particularly useful for metabolic reconstruction, comparing functional profiles across environments, and identifying missing steps in biochemical pathways.

## Core Workflows

### 1. Calculating Completeness
The primary command is `give_completeness`. It supports two main input types:

**From a simple list of KOs:**
Use this when you have a global set of KOs for a sample.
```bash
give_completeness \
  --input-list kos_list.txt \
  --list-separator ',' \
  --outprefix sample_summary
```

**From per-contig annotations:**
Use this to maintain the genomic context of the annotations.
```bash
give_completeness \
  --input ko_annotations.tsv \
  --add-per-contig \
  --outprefix contig_analysis
```

### 2. Visualizing Pathways
To generate PNG diagrams of pathways with identified KOs highlighted in red, use `plot_modules_graphs`.

**Plotting from previous results:**
```bash
plot_modules_graphs \
  -i sample_summary_pathways.tsv \
  -o pathway_plots/
```

**Plotting specific modules of interest:**
```bash
plot_modules_graphs -m M00001 M00002 M00003
```

## Expert Tips and Best Practices

- **Weighting**: Use the `--include-weights` flag to see the relative contribution of each KO to the module definition (e.g., `K00942(0.25)`). This helps identify which KOs are critical for "OR" logic gates in KEGG definitions.
- **Visualization Requirements**: Ensure `graphviz` is installed on the system path. If the default backend fails, try the `--use-pydot` flag.
- **Custom Data**: If working with a specific version of the KEGG database, you can override the internal data using `--modules-table` and `--graphs`.
- **Input Formatting**: 
    - For `--input`, the file must be tab-separated: `ContigID <tab> KO1 <tab> KO2 ...`
    - For `--input-list`, ensure the `--list-separator` matches your file (default is a comma).



## Subcommands

| Command | Description |
|---------|-------------|
| give_completeness | Script generates modules pathways completeness by given set of KOs |
| plot_modules_graphs | Script generates plots for each contig |

## Reference documentation
- [KEGG Pathways Completeness Tool README](./references/github_com_EBI-Metagenomics_kegg-pathways-completeness-tool_blob_master_README.md)