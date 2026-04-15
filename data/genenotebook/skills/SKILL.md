---
name: genenotebook
description: GeneNoteBook is a comparative genomics platform for integrating and visualizing genome annotations, functional domains, orthology, and expression data. Use when user asks to initialize the server, add genome assemblies or annotations, import protein domains and orthogroups, or manage expression data.
homepage: https://genenotebook.github.io
metadata:
  docker_image: "quay.io/biocontainers/genenotebook:0.3.2--h4ac6f70_2"
---

# genenotebook

## Overview

GeneNoteBook is a specialized platform designed for comparative genomics research. It functions as a collaborative environment where researchers can integrate multiple types of genomic data—including genome annotations, protein domains (InterProScan), orthology relationships, and RNA-seq expression levels—into a unified, searchable interface. This skill provides the necessary command-line patterns to initialize the server, import diverse biological datasets, and manage the underlying genomic database.

## Installation and Setup

GeneNoteBook is primarily distributed via Bioconda.

```bash
# Install via conda
conda install -c bioconda genenotebook

# Start the GeneNoteBook daemon (defaults to localhost:3000)
genenotebook run
```

## Data Management Patterns

The `genenotebook add` command is the primary entry point for building your comparative genomics database.

### Adding Genomes and Annotations
To populate the notebook, you must add genome sequences and their corresponding structural annotations.

```bash
# Add a genome assembly (FASTA)
genenotebook add genome --file species_assembly.fasta --name "Species Name"

# Add gene annotations (GFF3)
genenotebook add annotation --file annotations.gff3 --genome "Species Name"
```

### Integrating Functional and Comparative Data
GeneNoteBook excels at layering functional information on top of gene models.

*   **Protein Domains**: Import InterProScan results to visualize functional domains directly on gene models.
*   **Orthogroups**: Add orthology data (e.g., from OrthoFinder) to enable phylogenetic tree visualizations and cross-species navigation.
*   **Expression Data**: Load transcriptomic data to display expression barplots with standard error bars.

```bash
# Add protein domains
genenotebook add domains --file interproscan_results.tsv --genome "Species Name"

# Add orthogroups
genenotebook add orthogroups --file Orthogroups.txt

# Add expression levels
genenotebook add expression --file expression_matrix.tsv --genome "Species Name"
```

## Expert Tips and Best Practices

*   **Automatic Indexing**: GeneNoteBook automatically indexes gene attributes upon import. You can immediately perform complex queries via the web interface once the `add` command completes.
*   **Version Control**: The system includes a built-in version history for manual annotations. If you use the web interface to edit gene descriptions or symbols, these changes are tracked and can be reverted.
*   **Data Export**: While the CLI is used for data ingestion, the web interface allows for exporting filtered results into canonical formats like FASTA (for sequences), GFF3 (for annotations), and TSV (for expression data).
*   **User Access**: For collaborative environments, use the user profile system to configure private access to specific datasets.

## Reference documentation

- [GeneNoteBook Documentation](./references/genenotebook_github_io_index.md)
- [genenotebook - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_genenotebook_overview.md)