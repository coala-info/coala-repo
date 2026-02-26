---
name: phylogenize
description: Phylogenize identifies associations between microbial genes and their environments while accounting for evolutionary relationships. Use when user asks to perform phylogenetic regression, identify gene-environment associations, or use the POMS method to analyze microbial pangenome data.
homepage: https://github.com/pbradleylab/phylogenize
---


# phylogenize

## Overview
Phylogenize is a specialized bioinformatics tool designed to identify associations between microbial genes and their environments. Unlike standard association tests, phylogenize accounts for the evolutionary relationships between microbes using phylogenetic regression or the POMS (Phylogenetic Organization of Mutational Sites) method. This ensures that observed gene-environment links are likely due to functional adaptation rather than shared ancestry. It is most effective when working with large pangenome resources like GTDB or MGnify and requires species-level quantification data as input.

## Installation and Environment Setup
The tool is primarily distributed via Bioconda. It is recommended to use a dedicated environment to manage its R and system dependencies.

```bash
# Create and activate environment
conda create -n phylogenize
conda activate phylogenize

# Install phylogenize
conda install bioconda::phylogenize
```

**Expert Tip for AWS/Headless Servers:**
If running on a headless Linux server (like an AWS EC2 instance), you must install additional font and X11 libraries to enable the tool's automated plotting features:
```bash
conda install -c conda-forge xorg-libxt
sudo apt install fontconfig zlib1g
```

## Database Management
Phylogenize relies on pre-computed pangenome databases. While GTDB is the default for mixed environments, specialized MGnify databases are available for specific hosts.

- **Default Database:** GTDB (v214) containing ~43,000 species.
- **Specialized Databases:** Human gut (v2.0.2), Marine (v2.0), Cow rumen, Pig gut, etc.
- **Downloading:** Use the internal R function to fetch and decompress databases from Zenodo.

```r
# In R
library("phylogenize")
phylogenize::download.zenodo.db("URL_TO_DATABASE_ZIP")
```

## Data Preparation Workflow
Before running phylogenize, you must quantify species abundance. The species names in your abundance matrix **must** match the taxonomy used in the selected phylogenize database.

1.  **Quantification:** Use Kraken2 followed by Bracken.
2.  **Database Matching:** 
    - For Human Gut: Use the UHGG v1.0 Kraken2 database.
    - For General/Mixed: Use the GTDB v202 Kraken2 database.
3.  **Input Files:** You typically need a community composition matrix (microbes vs. samples) and environmental metadata.

## Execution Patterns
The tool can be controlled via an R session or by modifying a configuration file (`phylogenize_default.cfg`).

### R Interface
This is the most common way to interact with the tool for custom workflows.
```r
library("phylogenize")
# Core analysis typically involves:
# 1. Loading data
# 2. Selecting a model (Phylogenetic Regression or POMS)
# 3. Running the association test
```

### Configuration-Based Run
For reproducible pipelines, users often modify the `phylogenize_default.cfg` file to specify:
- `db_type`: (e.g., "gtdb" or "mgnify")
- `method`: (e.g., "regression" or "poms")
- `abundance_column`: The metadata column defining the environment/phenotype.

## Best Practices and Expert Tips
- **Version Consistency:** Always use version 2.0.0-alpha or later. Earlier versions (v0.91) are no longer supported and lack significant improvements in differential abundance testing (MaAsLin2/ANCOM-BC2 integration).
- **Gene Screening:** Use the `gene_min_frac` option to filter out genes that appear too infrequently to provide statistical power.
- **Taxon Filtering:** If the analysis is taking too long, use the option to test only a subset of taxa to verify the pipeline before running a full-scale analysis.
- **Memory Management:** When working with the GTDB database (~43k species), ensure your system has sufficient RAM (typically >32GB) to load the pangenome matrices.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_pbradleylab_phylogenize.md)
- [Phylogenize Wiki and General Guide](./references/github_com_pbradleylab_phylogenize_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_phylogenize_overview.md)