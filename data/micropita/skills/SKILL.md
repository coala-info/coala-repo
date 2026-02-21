---
name: micropita
description: microPITA (microbiome Picking Interesting Taxa for Analysis) is a computational tool designed to optimize sample selection in large-scale studies.
homepage: http://huttenhower.sph.harvard.edu/micropita
---

# micropita

## Overview
microPITA (microbiome Picking Interesting Taxa for Analysis) is a computational tool designed to optimize sample selection in large-scale studies. When faced with a large number of samples but limited budget for high-resolution sequencing, this tool allows you to systematically select a subset based on specific ecological or taxonomic criteria, such as maximizing diversity, targeting specific taxa, or finding representative "centroid" samples.

## Core Workflows

### 1. Supervised Selection
Use this when you have specific target features (taxa) or metadata categories of interest.
- **Target Taxa**: Select samples with the highest abundance of specific organisms.
- **Discriminatory**: Select samples that best distinguish between metadata groups (e.g., Case vs. Control).

### 2. Unsupervised Selection
Use this to capture the broad ecological landscape of your dataset without prior hypotheses.
- **Representative (Centroids)**: Select samples that are most typical of the community clusters.
- **Diverse (Extremes)**: Select samples that represent the edges of the ecological space to capture maximum variation.

## Common CLI Patterns

The basic execution follows this structure:
`micropita.py [input_abundance_table] --metadatum [column_name] --method [selection_strategy] --last_metadata_column [column_name]`

### Key Selection Strategies (`--method`)
- `distinctive`: Picks samples that are most different from each other.
- `representative`: Picks samples closest to the medoid of the population.
- `diversity`: Picks samples with the highest alpha diversity.
- `extreme`: Picks samples with the highest/lowest abundance of specific features.

### Essential Arguments
- `-m, --metadatum`: The specific metadata column to use for grouping or selection.
- `-l, --last_metadata_column`: Identifies where metadata ends and abundance data begins in your input file.
- `-n, --number`: The number of samples to select for the second stage.

## Best Practices
- **Data Normalization**: Ensure input abundance tables are normalized (e.g., relative abundance) before running selection to avoid bias from sequencing depth.
- **Metadata Alignment**: Ensure the metadata column names in your input file do not contain special characters or spaces that might break CLI parsing.
- **Tiered Strategy**: For most studies, a "Representative" selection is best for defining a baseline, while "Distinctive" is better for biomarker discovery.

## Reference documentation
- [micropita Overview](./references/anaconda_org_channels_bioconda_packages_micropita_overview.md)