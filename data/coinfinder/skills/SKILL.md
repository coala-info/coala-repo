---
name: coinfinder
description: Coinfinder identifies coincident genes in pangenomes that appear together or apart more frequently than expected by chance. Use when user asks to find gene associations, identify dissociating genetic elements, or detect linked gene clusters while accounting for phylogenetic signal.
homepage: https://github.com/fwhelan/coinfinder
metadata:
  docker_image: "quay.io/biocontainers/coinfinder:1.2.1--py39hb8976ed_3"
---

# coinfinder

## Overview

Coinfinder is a specialized tool designed for pangenomic comparative genomics. It identifies "coincident" genes—those that appear together or apart more frequently than expected by chance. By utilizing a Bonferroni-corrected Binomial exact test, it distinguishes true functional or evolutionary associations from patterns caused by shared ancestry (phylogenetic signal). It is particularly useful for discovering linked gene clusters, metabolic modules, or antagonistic genetic elements in prokaryotic species.

## Installation

The recommended way to install coinfinder is via Bioconda:

```bash
conda install -c bioconda coinfinder
```

## Core CLI Usage

### Basic Association Analysis
To find genes that tend to co-occur (associate) using Roary output:

```bash
coinfinder -i gene_presence_absence.csv -I -p phylogeny.nwk -o output_prefix --associate
```

### Basic Dissociation Analysis
To find genes that tend to avoid each other (dissociate):

```bash
coinfinder -i gene_presence_absence.csv -I -p phylogeny.nwk -o output_prefix --dissociate
```

### Using Custom Tab-Delimited Input
If not using Roary, provide a tab-delimited file with the format `gene_id[TAB]genome_id`:

```bash
coinfinder -i gene_list.tab -p phylogeny.nwk -o output_prefix --associate
```

## Common Parameters and Flags

| Flag | Description | Recommendation |
| :--- | :--- | :--- |
| `-i` | Path to gene information file. | Required. |
| `-I` | Indicates the input is in Roary CSV format. | Use if input is from Roary/Panaroo. |
| `-p` | Path to Newick formatted phylogeny. | Required; no zero-length branches. |
| `-a` / `-d` | Search for associations or dissociations. | Mandatory choice. |
| `-m` | Apply Bonferroni multiple testing correction. | Highly recommended for pangenomes. |
| `-x` | Number of CPU cores to use. | Default is 2; increase for large datasets. |
| `-r` | Filter saturated (high-abundance) and rare data. | Recommended to reduce noise. |
| `-q` | Path to a file containing a subset of genes to query. | Use for targeted analysis. |

## Expert Tips and Best Practices

### 1. Preparing Panaroo Data
Panaroo's `gene_presence_absence.csv` often lacks the double-quotes expected by coinfinder. Use `sed` to format it correctly before running:
```bash
sed -e 's/^/"/g' -e 's/$/"/g' -e 's/,/","/g' gene_presence_absence.csv > formatted_input.csv
```

### 2. Phylogeny Requirements
The phylogeny (`-p`) must be in Newick format. It is best practice to generate this tree using core gene alignments from the same pangenome pipeline used to generate the gene presence/absence matrix. Ensure the tree contains no zero-length branches, as these can cause the statistical model to fail.

### 3. Data Filtering
Use the `-r` flag to filter out:
- **Saturated genes**: Genes present in nearly all strains (default >95%) which provide little statistical power for association.
- **Rare genes**: Genes present in very few strains (default <5%) which may represent sequencing noise or rare horizontal gene transfer events.
Adjust thresholds using `-U` (upper) and `-F` (lower) if necessary.

### 4. Interpreting Outputs
- **.pairs**: A text file listing significant gene pairs and their p-values.
- **.gexf / .gml**: Network files for visualization in tools like Gephi or Cytoscape.
- **.pdf**: Visual representations including association networks and heatmaps.

## Reference documentation
- [Coinfinder GitHub Repository](./references/github_com_fwhelan_coinfinder.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_coinfinder_overview.md)