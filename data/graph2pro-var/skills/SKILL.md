---
name: graph2pro-var
description: The `graph2pro-var` tool is a specialized suite for meta-proteogenomics that integrates mass spectrometry (MS) data with genomic/transcriptomic assembly graphs.
homepage: https://github.com/COL-IU/graph2pro-var
---

# graph2pro-var

## Overview

The `graph2pro-var` tool is a specialized suite for meta-proteogenomics that integrates mass spectrometry (MS) data with genomic/transcriptomic assembly graphs. It utilizes two primary algorithms: **graph2pro**, which identifies peptides based on the assembly graph, and **var2pep**, which leverages unassembled sequencing reads to improve identification sensitivity by capturing variants not present in the primary assembly. This skill provides guidance on configuring the pipeline, preparing assembly graphs, and managing the identification workflow.

## Installation and Setup

Install the package via Bioconda for the most stable environment:

```bash
conda install bioconda::graph2pro-var
```

If using the source version, run the provided installation script to compile the underlying components (MSGF+, FragGeneScan, etc.):

```bash
./install
```

## Core Workflow and CLI Usage

The pipeline is controlled by a wrapper script, `graph2pro-var.sh`, which requires a parameter file (`.par`) to define the run configuration.

### 1. Prepare the Parameter File
Create a text file (e.g., `project.par`) with the following key-value pairs. Ensure there are no spaces around the `=` sign.

**Mandatory Parameters:**
- `id`: Prefix for all output files.
- `kmer`: The k-mer size used during the metagenome assembly.
- `fastg`: Path to the assembly graph file.
- `ms`: Path to the mass spectrometry spectral file.

**Optional Parameters:**
- `reads`: Path to the sequencing reads (required for the `var2pep` step).
- `thread`: Number of CPU threads (default: 8).
- `memory`: RAM allocation (default: 32g; increase for large spectral files).
- `fdr`: False Discovery Rate threshold (default: 0.01).
- `cascaded`: Set to `yes` to perform a cascaded search (only unidentified spectra from graph2pro are passed to var2pep).

### 2. Execute the Pipeline
Run the wrapper script pointing to your parameter file. It is recommended to run this in a dedicated directory as the tool generates numerous intermediate files.

```bash
sh path/to/graph2pro-var.sh project.par
```

For long-running jobs on a cluster, use `nohup`:

```bash
nohup sh path/to/graph2pro-var.sh project.par > project.log &
```

## Expert Tips and Best Practices

### Assembly Graph Preparation
The quality of identification depends heavily on the `.fastg` file.
- **MegaHit**: Run with a specific k-list (e.g., `--k-list 21,29,39,59,79,99`) and use `megahit_toolkit contig2fastg 99` to generate the graph.
- **Consistency**: The `kmer` value in your `.par` file **must** match the k-mer size used to generate the `.fastg` file.

### Database Generation Only
If you only need to generate a protein database from an assembly graph without running the full MS search:
```bash
./Graph2Pro/DBGraph2Pro -s assembly_graph.fastg -S -k 49 -o output_database.fasta
```

### Interpreting Results
- `*.final-peptide.txt`: The primary output listing identified peptides and their supporting spectra.
- `*.graph2pro.fasta`: The database generated from the assembly graph.
- `*.var2pro.fasta`: The database generated from variant-carrying reads.
- `*.mzid`: Standard MSGF+ search results for downstream proteomics tools.

### Resource Management
Meta-proteogenomic searches are computationally intensive. If the pipeline fails during the MSGF+ search phase, check the `memory` parameter in the `.par` file. Large spectral files often require 64GB or more of RAM.

## Reference documentation
- [graph2pro-var GitHub Repository](./references/github_com_COL-IU_graph2pro-var.md)
- [graph2pro-var Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_graph2pro-var_overview.md)