---
name: ncbitax2lin
description: ncbitax2lin is a high-performance utility that transforms the hierarchical NCBI taxonomy database into a flattened CSV format.
homepage: https://github.com/zyxue/ncbitax2lin
---

# ncbitax2lin

## Overview

ncbitax2lin is a high-performance utility that transforms the hierarchical NCBI taxonomy database into a flattened CSV format. While the raw NCBI data is stored in a tree-like structure across multiple files, this tool traverses that tree to produce a single table where each row represents a TaxID and columns represent taxonomic ranks. This allows for rapid lookups and easy integration with data analysis tools like Pandas or R.

## Core Workflow

### 1. Data Preparation
Before running the tool, you must obtain the latest taxonomy data from NCBI.

```bash
# Download the taxonomy dump
wget -N ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz

# Extract the required files
mkdir -p taxdump
tar zxf taxdump.tar.gz -C ./taxdump
```

### 2. Generating Lineages
The primary command requires paths to the `nodes.dmp` and `names.dmp` files extracted in the previous step.

```bash
# Basic usage (outputs to ncbi_lineages_[date].csv.gz)
ncbitax2lin --nodes-file taxdump/nodes.dmp --names-file taxdump/names.dmp

# Specify a custom output filename
ncbitax2lin --nodes-file taxdump/nodes.dmp --names-file taxdump/names.dmp --output my_lineages.csv.gz
```

## Expert Tips and Best Practices

### Handling Accession Numbers
ncbitax2lin maps **TaxIDs** to lineages, not accession numbers directly. If you have a list of NCBI accession numbers (e.g., GenBank IDs):
1. Download the `accession2taxid` mapping files from NCBI (e.g., `nucl_gb.accession2taxid.gz`).
2. Map your accessions to TaxIDs using these files.
3. Use the output from ncbitax2lin to join the TaxIDs to their full lineages.

### Output Structure
The generated CSV includes standard ranks (superkingdom, phylum, class, order, family, genus, species) as well as intermediate ranks (subclass, infraorder, etc.). If a specific rank is not defined for a TaxID, the cell will be empty.

### Performance and Environment
- **Python Support**: Ensure you are using Python 3.9 or newer.
- **Memory**: The tool processes the entire taxonomy tree in memory using Pandas. For the full NCBI taxonomy, ensure the system has at least 8GB of RAM available.
- **Updates**: NCBI periodically regenerates the `taxdump.tar.gz` file. It is recommended to re-run the lineage generation whenever you update your local sequence databases to ensure taxonomic consistency.

## Reference documentation
- [ncbitax2lin GitHub Repository](./references/github_com_zyxue_ncbitax2lin.md)
- [ncbitax2lin Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ncbitax2lin_overview.md)