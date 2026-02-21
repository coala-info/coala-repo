---
name: panx
description: The panx skill enables the analysis and exploration of bacterial pan-genomes.
homepage: http://pangenome.de
---

# panx

## Overview
The panx skill enables the analysis and exploration of bacterial pan-genomes. It integrates DIAMOND for sequence alignment, MCL for clustering, and phylogeny-aware post-processing to categorize the genetic repertoire of a species. This tool is particularly effective for identifying genomic signatures associated with specific phenotypes, such as antibiotic resistance or virulence, by visualizing gene distributions across phylogenetic trees.

## Core Workflows and CLI Patterns

### Installation and Environment
The primary distribution method is via Bioconda. Ensure the environment is configured to handle large-scale genomic data.
```bash
conda install -c bioconda panx
```

### Running the Analysis Pipeline
The panX pipeline typically requires a set of annotated genomes (GenBank or GFF format). The analysis is divided into several automated steps:
- **Homology Search**: Uses DIAMOND for fast protein alignment.
- **Clustering**: Uses MCL to group orthologous genes into clusters.
- **Phylogenetic Analysis**: Constructs trees for each gene cluster and a core-genome SNP tree.
- **Characterization**: Calculates diversity, dN/dS ratios, and gene gain/loss events.

### Interactive Visualization
After the analysis pipeline completes, panX generates a collection of JSON files and data structures compatible with its web-based visualization tool.
- Use the output to explore the **Gene Cluster Table** to filter by annotation or diversity.
- Map **Metadata** (e.g., host, location, resistance) onto the species tree to find correlations with gene presence/absence.

### Expert Tips
- **Memory Management**: For datasets with hundreds of strains, ensure sufficient RAM is allocated for the MCL clustering phase.
- **Input Quality**: Ensure consistent locus tag naming across input files to prevent fragmentation of gene clusters.
- **Phenotype Association**: Use the "Presence/Absence" pattern view to identify genes that are perfectly concordant with a specific metadata trait.

## Reference documentation
- [panX: Pan-genome Analysis & Exploration](./references/pangenome_org_index.md)
- [Bioconda panx Package Overview](./references/anaconda_org_channels_bioconda_packages_panx_overview.md)