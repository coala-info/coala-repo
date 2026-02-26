---
name: keggcharter
description: KEGGCharter maps functional annotation data onto KEGG metabolic pathways to visualize genomic potential and differential expression across multi-omic datasets. Use when user asks to convert functional identifiers to KEGG Orthologs, visualize taxonomic contributions to metabolic pathways, or represent quantification data as heatmaps on pathway maps.
homepage: https://github.com/iquasere/KEGGCharter
---


# keggcharter

## Overview

KEGGCharter is a bioinformatics tool designed to transform functional annotation tables into biological context. It automates the process of converting various functional identifiers—such as KEGG IDs, EC numbers, and COG IDs—into KEGG Orthologs (KO) and subsequently mapping them onto KEGG metabolic pathways. 

The tool is specifically optimized for multi-omic datasets, allowing you to:
1. **Visualize Genomic Potential**: Assign specific colors to different taxa to see their contribution to metabolic pathways.
2. **Represent Differential Expression**: Generate heatmaps within KEGG pathway boxes to compare expression levels across multiple samples or conditions.
3. **Automate ID Conversion**: Handle the heavy lifting of cross-referencing different functional databases via the KEGG API.

## Installation

Install via Bioconda for the most stable environment:
```bash
conda install -c conda-forge -c bioconda keggcharter
```

## Common CLI Patterns

### Basic Functional Mapping
To generate a metabolic map for a specific pathway (e.g., Methane Metabolism, map00680) using a simple list of KOs:
```bash
keggcharter -f input.tsv -o output_folder -mm 00680 -koc 'KO_Column_Name'
```

### Mapping Taxonomic Potential
To see which organisms are performing which functions, specify the column containing taxonomic information:
```bash
keggcharter -f input.tsv -o output_folder -mm 00680 -tc 'Taxonomy_Column'
```
*Note: If your dataset represents a single taxon not listed in the file, use `-it "Taxon Name"` instead.*

### Visualizing Differential Expression
To represent quantification data (transcriptomics or proteomics) as heatmaps on the pathway boxes:
```bash
keggcharter -f input.tsv -o output_folder -mm 00680 -qcol 'Sample1,Sample2,Sample3'
```

### High-Efficiency/Resumed Runs
KEGGCharter downloads KGML files and cross-references IDs from the KEGG API. To avoid redundant network requests when adding new maps to an existing analysis:
```bash
keggcharter -f input.tsv -o output_folder -mm 00010,00020 --resume
```

## Expert Tips and Best Practices

*   **Persistent Resources**: Use the `-rd` (resources directory) flag to point to a permanent folder on your system. This stores KGML and EC-to-box relationship files, significantly speeding up future runs.
*   **Map Discovery**: If you are unsure of the map IDs, run `keggcharter --show-available-maps` to get a full list of supported KEGG pathways and their descriptions.
*   **Mock Data for Quick Checks**: If you have a list of IDs but no quantification or taxonomy and just want to see them on a map, use the `-iq` (input quantification) and `-it` (input taxonomy) flags to generate mock data for visualization.
*   **Taxonomic Validation**: When using the `-tc` flag, ensure your taxonomies match KEGG's expected prefixes. You can check the valid organism list at `https://www.genome.jp/kegg/catalog/org_list.html`.
*   **Handling Missing Genomes**: If working with environmental samples or uncharacterized microbes, use `--include-missing-genomes` to map KOs even if the specific organism isn't in the KEGG Genomes database.
*   **Broad Mapping**: Use `--map-all` to ignore KEGG's specific taxonomic constraints and represent every identified function for every KO, regardless of whether KEGG officially attributes that function to the specific species in your data.

## Reference documentation
- [KEGGCharter GitHub Repository](./references/github_com_iquasere_KEGGCharter.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_keggcharter_overview.md)