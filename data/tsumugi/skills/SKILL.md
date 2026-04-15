---
name: tsumugi
description: TSUMUGI identifies gene modules and functional relationships by analyzing phenotypic similarities in knockout mouse data. Use when user asks to identify gene clusters based on shared phenotypes, build network graphs for visualization, or find human disease models using Mammalian Phenotype Ontology data.
homepage: https://github.com/akikuno/TSUMUGI-dev
metadata:
  docker_image: "quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0"
---

# tsumugi

---

## Overview

TSUMUGI (Trait-driven Surveillance for Mutation-based Gene module Identification) is a bioinformatics tool designed to "weave together" genes that share functional relationships based on phenotypic similarity. By analyzing knockout (KO) mouse data, it identifies clusters of genes that produce similar biological abnormalities when mutated. It utilizes the Mammalian Phenotype Ontology (MPO) and calculates similarity using Resnik and Phenodigm scores. This skill enables the extraction of gene modules, visualization of phenotypic networks, and identification of potential human disease models.

## Installation and Setup

TSUMUGI can be installed via BioConda or PyPI. BioConda is recommended for managing bioinformatics dependencies.

```bash
# Install via BioConda
conda install -c bioconda tsumugi

# Install via PyPI
pip install tsumugi
```

## Command Line Interface (CLI) Usage

The CLI allows for local processing of large-scale IMPC datasets, providing more flexibility than the web interface.

### Core Commands

*   **Build a Network Graph**: Generate a GraphML file for use in external tools like Cytoscape.
    ```bash
    tsumugi build-graphml --input statistical-results-ALL.csv.gz --output network.graphml
    ```
*   **Build a Web Application Bundle**: Create a standalone offline version of the TSUMUGI web app with specific data.
    ```bash
    tsumugi build-webapp --input statistical-results-ALL.csv.gz --output ./my_webapp
    ```

### Data Requirements

To run local analyses, you typically need the following files from the IMPC:
1.  `statistical-results-ALL.csv.gz`: The primary statistical results.
2.  `mp.obo`: The Mammalian Phenotype Ontology definition file.
3.  `impc_phenodigm.csv`: Phenodigm scores for similarity calculation.

## Expert Tips and Best Practices

### Filtering and Thresholds
*   **Shared Phenotypes**: By default, TSUMUGI visualizes gene pairs that share **3 or more** abnormal phenotypes.
*   **Similarity Scores**: Use the `phenotype_similarity_score` (0–100) to filter for high-confidence functional relationships. A score > 0 is required for visualization.
*   **Effect Size**: Filter by "Phenotype Severity" (effect size) to focus on genes with the most significant biological impact.

### Input Types
*   **Phenotype Search**: Input MPO terms (e.g., `MP:0000137`) to find genes associated with specific traits.
*   **Gene Search**: Input MGI symbols (e.g., `Aak1`) to find phenotypically similar "partner" genes.
*   **Gene List**: When providing a list, limit it to **200 genes** for the web tool; use the CLI for larger sets to avoid performance issues.

### Data Interpretation
*   **Zygosity**: Specify `Homo` (homozygous), `Hetero` (heterozygous), or `Hemi` (hemizygous) to isolate specific inheritance patterns.
*   **Life Stage**: Filter results by life stage (`Embryo`, `Early`, `Interval`, `Late`) to identify developmental vs. adult-onset phenotypes.
*   **Sexual Dimorphism**: Check for phenotypes that appear only in `Male` or `Female` subjects to identify sex-specific gene functions.

### Exporting for Publication
*   **GraphML**: Best for high-quality network analysis in Cytoscape.
*   **JSONL**: Use the gzipped JSONL outputs (`genewise_phenotype_annotations.jsonl.gz`) for downstream programmatic analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| tsumugi build-graphml | Builds a graphml file from pairwise and genewise similarity annotations. |
| tsumugi build-webapp | Builds a web application for visualizing Tsumugi results. |
| tsumugi life-stage | Keep or drop annotations based on life stage. |
| tsumugi mp | Filter gene pairs based on Mammalian Phenotype ontology terms and annotations. |
| tsumugi run | TSUMUGI pipeline for analyzing IMPC statistical results and generating phenotype-disease associations. |
| tsumugi sex | Keep or drop annotations based on sexual dimorphism. |
| tsumugi zygosity | Keep or drop annotations based on zygosity. |
| tsumugi_count | Filter genes based on the number of detected phenotypes per KO or shared between KO pairs. |
| tsumugi_genes | Filter annotations based on gene symbols or gene pairs. |
| tsumugi_score | Filter genes based on the similarity score per KO or shared between KO pairs. |

## Reference documentation
- [TSUMUGI GitHub Repository](./references/github_com_akikuno_TSUMUGI-dev_blob_main_README.md)
- [TSUMUGI CLI Documentation (DE)](./references/github_com_akikuno_TSUMUGI-dev_blob_main_doc_README_DE.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tsumugi_overview.md)