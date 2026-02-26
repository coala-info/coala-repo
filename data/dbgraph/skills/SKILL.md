---
name: dbgraph
description: The dbgraph toolset utilizes assembly graphs to generate protein databases and identify peptides from metaproteomics mass spectrometry data. Use when user asks to generate a FASTA database from a FASTG file, run the graph2pro-var pipeline, or identify peptides using a graph-centric approach.
homepage: https://github.com/COL-IU/graph2pro-var/tree/master/Graph2Pro
---


# dbgraph

## Overview
The `dbgraph` (also known as `graph2pro-var`) toolset enables a "graph-centric" approach to metaproteomics. Instead of relying solely on linear contigs, it utilizes the assembly graph to capture genetic variation and fragmented assemblies that traditional methods might miss. This skill provides guidance on generating databases from assembly graphs and executing the integrated search pipeline to identify peptides from mass spectrometry data.

## Core Workflows

### 1. Database Generation (graph2pep)
If you only need to generate a FASTA protein database from an assembly graph (FASTG), use the `DBGraph2Pro` executable.

```bash
./Graph2Pro/DBGraph2Pro -s <assembly_graph.fastg> -S -k <kmer_size> -o <output_database.fasta>
```
*   **-s**: Input assembly graph in FASTG format.
*   **-k**: K-mer size (must match the size used during metagenome assembly).
*   **-S**: Specific flag for graph-to-peptide translation.

### 2. Full Pipeline Execution (graph2pro-var)
The `graph2pro-var.sh` wrapper script runs the complete identification pipeline, including database construction and MS/MS searching via MSGF+.

**Preparation:**
Create a parameter file (e.g., `config.par`) with the following mandatory fields:
```text
id=sample_name
kmer=99
fastg=/path/to/assembly.fastg
ms=/path/to/spectra.mgf
```
*Optional parameters:*
*   `reads=`: Path to raw sequencing reads (enables the `var2pep` algorithm for unassembled reads).
*   `thread=`: Number of threads (default: 8).
*   `memory=`: Memory allocation (default: 32g).
*   `fdr=`: False Discovery Rate threshold (default: 0.01).
*   `cascaded=yes`: Enables cascaded search (unidentified spectra from graph2pro are passed to var2pep).

**Execution:**
```bash
sh graph2pro-var.sh config.par
```

## Expert Tips & Best Practices
*   **Assembly Graph Preparation**: For best results, use **MegaHit** to generate the FASTG file. Use `megahit_toolkit contig2fastg` on the highest k-mer size used in your assembly (e.g., if your k-list ends at 99, use 99 for the conversion and the `kmer` parameter in dbgraph).
*   **Working Directory**: Always run the pipeline in a dedicated folder. The tool generates numerous large intermediate files (e.g., `.mzid`, `.fasta`, `.tsv`) in the current working directory.
*   **Algorithm Selection**: 
    *   If you provide only `fastg` and `ms`, the tool runs **graph2pro**.
    *   If you also provide `reads`, it runs **var2pep** to capture peptides from reads that failed to assemble into the graph.
*   **Output Interpretation**: The primary result is `*.final-peptide.txt`, which aggregates identifications and indicates which algorithm (graph2pro or var2pep) identified each peptide.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_COL-IU_graph2pro-var.md)
- [DBGraph2Pro Tool Details](./references/github_com_COL-IU_graph2pro-var_tree_master_Graph2Pro.md)