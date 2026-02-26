---
name: scarap
description: The scarap toolkit automates prokaryotic comparative genomics by identifying orthologous groups and performing phylogenetic reconstruction. Use when user asks to identify orthologous groups, extract core genomes, or generate phylogenetic trees from bacterial genomic data.
homepage: https://pypi.org/project/scarap
---


# scarap

## Overview
The `scarap` toolkit is designed for high-throughput prokaryotic comparative genomics. It streamlines the process of moving from raw or assembled genomic data to evolutionary insights by automating the identification of orthologous groups, alignment of core genes, and subsequent phylogenetic reconstruction. It is particularly useful for researchers working with large sets of bacterial genomes who need a consistent, reproducible pipeline for comparative analysis.

## Usage Guidelines

### Installation
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the bioconda channel.
```bash
conda install -c bioconda scarap
```

### Core Workflow Patterns
While specific subcommands depend on the version installed, the general workflow for `scarap` typically involves:

1.  **Input Preparation**: Gather your prokaryotic genome assemblies (usually in FASTA format) or annotated genomes (GFF/GBK).
2.  **Orthology Identification**: Use the toolkit to identify clusters of orthologous groups (COGs) across your dataset.
3.  **Core Genome Extraction**: Filter for genes present in a defined threshold of strains (e.g., 95% or 100% for a strict core).
4.  **Alignment and Phylogeny**: Generate multiple sequence alignments (MSA) for core genes and concatenate them for tree building.

### Best Practices
- **Consistent Annotation**: For the best results in comparative genomics, ensure all input genomes are annotated using the same tool (e.g., Prokka or Bakta) before running `scarap` to avoid artifacts caused by different gene-calling algorithms.
- **Resource Management**: Comparative genomics is computationally intensive. When running `scarap` on large datasets (100+ genomes), ensure you allocate sufficient CPU cores and memory, as the alignment and ortholog clustering steps are memory-heavy.
- **Quality Control**: Always check the "core genome" size reported by the tool. A unexpectedly small core genome often indicates the inclusion of a poor-quality assembly or a taxonomically distant outlier in your dataset.

## Reference documentation
- [scarap on PyPI](./references/pypi_org_project_scarap.md)
- [scarap Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scarap_overview.md)