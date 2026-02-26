---
name: kegg-pathways-completeness
description: This tool estimates the completeness of KEGG metabolic modules by evaluating the presence of specific KEGG Orthology identifiers against complex logical definitions. Use when user asks to calculate metabolic pathway completeness, analyze functional annotations from genomes or metagenomes, or visualize KEGG module graphs with highlighted enzymes.
homepage: https://github.com/EBI-Metagenomics/kegg-pathways-completeness-tool
---


# kegg-pathways-completeness

## Overview

The `kegg-pathways-completeness` tool provides a programmatic way to estimate how "complete" a KEGG metabolic module is based on the presence or absence of specific KOs in your dataset. Unlike simple mapping, this tool accounts for the complex logical definitions of KEGG modules (e.g., alternative enzymes or multi-subunit complexes). It is essential for moving from a raw list of functional annotations to a high-level understanding of the metabolic capabilities of an organism or a microbial community.

## Installation and Setup

The tool can be installed via Conda or Pip. Note that visualization features require the system-level `graphviz` library.

```bash
# Installation via Bioconda
conda install -c bioconda kegg-pathways-completeness

# Installation via Pip
pip install kegg-pathways-completeness
```

## Core CLI Usage Patterns

### 1. Analyzing a Simple List of KOs
If you have a simple text file containing KO identifiers (e.g., from a single genome), use the `--input-list` flag.

```bash
give_completeness \
  --input-list kos_list.txt \
  --list-separator ',' \
  --outprefix sample_analysis
```

### 2. Metagenomic Analysis (Per-Contig)
For metagenomic datasets where KOs are associated with specific contigs or bins, use the `--input` flag with a tab-separated file.

```bash
give_completeness \
  --input ko_annotations.tsv \
  --add-per-contig \
  --outprefix metagenome_results \
  --outdir results/
```
*Input format for `--input`:* A TSV with two columns: `contig_id` and `KO_id`.

### 3. Generating Pathway Visualizations
To produce PNG diagrams of the pathways with identified KOs highlighted in red, use the `plot_modules_graphs` command or the `-p` flag in the main command.

```bash
# Generate plots for specific modules of interest
plot_modules_graphs \
  -m M00001 M00002 M00009 \
  -i sample_analysis_pathways.tsv \
  -o pathway_plots/
```

## Expert Tips and Best Practices

- **Weighted Completeness**: Use the `--include-weights` flag to see the specific contribution of each KO to the pathway. This is helpful for understanding why a pathway is marked as partially complete (e.g., `K00942(0.25)`).
- **Handling Large Datasets**: When running metagenomic samples with thousands of contigs, the `--add-per-contig` flag significantly increases output file size. Only use it if you specifically need to track pathway distribution across individual sequences.
- **Custom KEGG Versions**: The tool comes with pre-packaged module data. If you need to use a specific or newer version of the KEGG database, you can point the tool to custom files using `--modules-table` and `--graphs`.
- **Visualization Backend**: If the default `graphviz` backend fails in certain environments, try the `--use-pydot` flag in `plot_modules_graphs` for an alternative rendering approach.

## Output Interpretation

- **`*_pathways.tsv`**: The primary summary. Focus on the `completeness` column (0-100%).
- **`matching_ko` vs `missing_ko`**: Use these columns to identify exactly which enzymatic steps are absent, which can guide targeted searches or explain metabolic gaps.

## Reference documentation
- [KEGG Pathways Completeness Tool GitHub](./references/github_com_EBI-Metagenomics_kegg-pathways-completeness-tool.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_kegg-pathways-completeness_overview.md)