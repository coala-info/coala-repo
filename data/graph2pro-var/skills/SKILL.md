---
name: graph2pro-var
description: graph2pro-var is a meta-proteogenomic pipeline that identifies proteins and peptides by integrating assembly graphs and raw sequencing reads with mass spectrometry data. Use when user asks to identify peptides from assembly graphs, capture protein variants from unassembled reads, or perform meta-proteogenomic database searching.
homepage: https://github.com/COL-IU/graph2pro-var
---

# graph2pro-var

## Overview

graph2pro-var is a meta-proteogenomic pipeline designed to improve protein and peptide identification by leveraging the information stored in assembly graphs and raw sequencing reads. Traditional methods often rely on assembled contigs, which can lose significant biological variation. This tool uses two primary algorithms: **graph2pro**, which identifies peptides by traversing the assembly graph, and **var2pep**, which utilizes unassembled reads to capture additional variants. The pipeline automates the process of database generation, MS/MS searching (via MSGF+), and result summarization.

## Core Workflow

### 1. Prepare the Assembly Graph
The pipeline requires an assembly graph in `.fastg` format.
- **Recommended Tool**: Use MegaHit to generate the graph.
- **Conversion**: Use the `megahit_toolkit` to convert contigs to fastg:
  `megahit_toolkit contig2fastg [kmer_size] intermediate_contigs/k[kmer_size].contigs.fa > assembly.fastg`
- **Note**: The k-mer size used for the graph must be recorded for the parameter file.

### 2. Configure the Parameter File (.par)
Create a text file (e.g., `project.par`) containing the following key-value pairs. Ensure there are no spaces around the `=` sign.

| Parameter | Requirement | Description |
| :--- | :--- | :--- |
| `id` | Required | Prefix for all output files. |
| `kmer` | Required | K-mer size used for assembly graph generation. |
| `fastg` | Required | Path to the assembly graph file. |
| `ms` | Required | Path to the mass spectrometry spectral file (MGF). |
| `reads` | Optional | Path to sequencing reads (required for var2pep step). |
| `thread` | Optional | Number of threads (default: 8). |
| `memory` | Optional | RAM allocation (default: 32g). Increase for large MGF files. |
| `fdr` | Optional | False Discovery Rate threshold (default: 0.01). |
| `cascaded` | Optional | Set to `yes` to only search unidentified spectra in the Var2Pep step. |

### 3. Execute the Pipeline
Run the wrapper script from within a dedicated working directory to manage the large volume of intermediate files.

```bash
# Standard execution
sh /path/to/graph2pro-var/graph2pro-var.sh project.par

# Background execution for large datasets
nohup sh /path/to/graph2pro-var/graph2pro-var.sh project.par > project.log &
```

### 4. Summarize Results
After the pipeline completes, generate a report of identified spectra and unique peptides across the different approaches (contig-only, graph2pro, and var2pep).

```bash
sh /path/to/graph2pro-var/summarize.sh project.par
```

## Expert Tips and Best Practices

- **Working Directory**: Always run the script from a fresh directory. The pipeline generates numerous intermediate files (e.g., `*.mzid`, `*.tsv`, `*.fasta`) in the current folder.
- **Memory Management**: If the pipeline crashes during the MSGF+ search phase, increase the `memory` parameter in the `.par` file (e.g., `memory=64g`).
- **Partial Runs**: If you only have assembly graphs and spectra but no raw reads, omit the `reads=` line in the parameter file. The pipeline will automatically stop after the `graph2pro` phase.
- **Database Extraction**: If you only need to generate a protein database from a FASTG file without running the full MS search, use the standalone `DBGraph2Pro` tool:
  `./Graph2Pro/DBGraph2Pro -s assembly.fastg -S -k [kmer] -o output.fasta`
- **FDR Control**: The pipeline produces specific TSV files for different stages (e.g., `*.fgs.tsv.0.01.tsv` for contigs, `*.graph2pro.tsv.0.01.tsv` for the graph). Review these individually to compare the gain in identifications provided by the graph-based approach.



## Subcommands

| Command | Description |
|---------|-------------|
| DBGraph2Pro | DBGraph2Pro version 0.1 |
| install | Copy files and set attributes |

## Reference documentation
- [Main README](./references/github_com_COL-IU_graph2pro-var_blob_master_README.md)
- [Wrapper Script Logic](./references/github_com_COL-IU_graph2pro-var_blob_master_graph2pro-var.sh.md)
- [Result Summarization](./references/github_com_COL-IU_graph2pro-var_blob_master_summarize.sh.md)