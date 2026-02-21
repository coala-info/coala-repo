---
name: protgraph
description: ProtGraph is a specialized tool designed to bridge the gap between static protein sequences and the complex reality of biological variation.
homepage: https://github.com/mpc-bioinformatics/ProtGraph
---

# protgraph

## Overview

ProtGraph is a specialized tool designed to bridge the gap between static protein sequences and the complex reality of biological variation. While standard FASTA files provide a linear representation of a protein, ProtGraph parses UniProtKB SP-EMBL entries to build directed acyclic graphs (DAGs). These graphs incorporate canonical sequences alongside isoforms, signal peptides, propeptides, and variants (mutations or conflicts). By representing proteins as graphs, you can more accurately calculate the theoretical search space for mass spectrometry and identify peptides that result from specific biological features.

## Installation and Setup

ProtGraph can be installed via pip or conda. Note that it has specific dependencies for database and graph handling.

```bash
# Installation via Bioconda
conda install -c bioconda protgraph

# Installation via Pip
pip install protgraph
```

**Critical Dependency Note:**
- **Biopython:** UniProt updated the SP-EMBL format in August 2022. If you encounter parsing errors, ensure you are using a compatible Biopython version or the latest patch from the ProtGraph repository.
- **Database Drivers:** For SQLite exports, `apsw` is required. For PostgreSQL, `psycopg` is required and may require a local PostgreSQL installation to build the wheel.

## Common CLI Patterns

The primary interface is the `protgraph` command. It processes SP-EMBL files (usually `.txt` or `.dat`) to generate graphs and statistics.

### Basic Graph Generation
To generate a protein graph from a UniProt entry:
```bash
protgraph examples/QXXXXX.txt
```
By default, ProtGraph will parse the features, build the graph, and apply Trypsin digestion.

### Generating Statistics
To retrieve information about the complexity of the protein (nodes, edges, and possible paths):
```bash
# -cnp adds the number of non-repeating paths between start and end nodes
protgraph -cnp examples/QXXXXX.txt
```

### Exploring Options
For a full list of flags including digestion enzymes, export formats, and feature filtering:
```bash
protgraph --help
```

## Expert Tips and Best Practices

### Input Selection
Always prefer **SP-EMBL (.txt or .dat)** files over FASTA files. FASTA files lack the feature table (FT) section required to build the graph's alternative paths (variants, signal peptides, etc.).

### Handling Biological Features
- **Variants:** ProtGraph automatically adds nodes for amino acid substitutions described in the `VARIANT` lines of the input file.
- **Signal Peptides:** The tool adds edges to mimic the removal of signal peptides, allowing for the identification of mature protein forms.
- **Digestion:** While Trypsin is the default, you can specify other proteases via CLI flags to see how the peptide search space changes.

### Output Formats
ProtGraph is primarily a converter. You can export the resulting graphs for use in:
- **Visualization:** Tools like Gephi.
- **Analysis:** Python (igraph), R, or C++ workflows.
- **Identification:** Converting the graph back into an "augmented" FASTA file that includes all feature-induced peptide sequences for use in standard search engines.

## Reference documentation
- [ProtGraph Main Repository](./references/github_com_mpc-bioinformatics_ProtGraph.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_protgraph_overview.md)