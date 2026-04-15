---
name: gsea
description: GSEA performs gene set enrichment analysis to identify groups of genes that are overrepresented in a large set of genes and may have an association with disease phenotypes. Use when user asks to perform pathway enrichment analysis, configure GSEA command-line parameters, format expression datasets and phenotype labels, or select enrichment metrics based on sample size.
homepage: https://www.gsea-msigdb.org/gsea
metadata:
  docker_image: "quay.io/biocontainers/gsea:4.3.2--hdfd78af_0"
---

# gsea

## Overview
GSEA is a computational method that shifts the focus from individual genes to groups of genes (gene sets) that share common biological functions, chromosomal locations, or regulation. This skill assists in configuring the command-line interface (CLI) version of GSEA, ensuring proper formatting of expression datasets and phenotype labels, and selecting appropriate enrichment metrics based on sample size.

## Input File Requirements
GSEA requires specific tab-delimited formats. Ensure files are formatted correctly before execution:
- **Expression Dataset (.gct)**: Contains gene expression values. The first column is the Gene Symbol, the second is Description (can be "na"), followed by sample columns.
- **Phenotype Labels (.cls)**: Defines the experimental groups (e.g., Control vs. Treatment).
- **Gene Sets (.gmt)**: Contains the pathways or gene lists to be tested (e.g., MSigDB collections).

## Common CLI Patterns
The bioconda version typically wraps the Java implementation. Use the following patterns for execution:

### Basic Enrichment Analysis
```bash
gsea-cli GSEA -res expression.gct -cls phenotype.cls#Treatment_vs_Control -gmx pathways.gmt -out output_dir
```

### Key Parameters
- `-nperm`: Number of permutations. Use `1000` for publication-quality results.
- `-permute`: Use `phenotype` for datasets with at least 7 samples per group; use `gene_set` for smaller sample sizes.
- `-metric`: Default is `Signal2Noise`. Use `tTest` as an alternative for different variance distributions.
- `-scoring_scheme`: Default is `weighted`. Use `classic` if you do not want to account for the magnitude of expression.

## Expert Tips
- **Gene ID Matching**: Ensure the gene identifiers in your `.gct` file match the identifiers in the `.gmt` file (e.g., both use HUGO Gene Symbols).
- **Collapsing Probes**: If your data uses probe IDs, use the `-collapse true` parameter and provide a `.chip` file to map probes to gene symbols.
- **Memory Management**: GSEA can be memory-intensive. If running via CLI, ensure the Java heap size is sufficient (e.g., `export _JAVA_OPTIONS="-Xmx4G"`).
- **Leading Edge Analysis**: After the run, examine the "leading edge" genes in the output report to identify the specific genes driving the enrichment score.

## Reference documentation
- [GSEA Overview](./references/anaconda_org_channels_bioconda_packages_gsea_overview.md)
- [GSEA MSigDB Home](./references/www_gsea-msigdb_org_gsea.md)