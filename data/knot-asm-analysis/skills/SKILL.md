---
name: knot-asm-analysis
description: knot-asm-analysis resolves fragmented bacterial genome assemblies by identifying paths between contig extremities using long-read data to produce an augmented assembly graph. Use when user asks to resolve fragmented assemblies, identify adjacencies between contigs, or generate visual analysis reports for genome scaffolding.
homepage: https://github.com/natir/knot
---

# knot-asm-analysis

## Overview

KNOT (Knowledge Network Overlap exTraction) is a specialized tool designed to resolve fragmented bacterial genome assemblies by leveraging long-read data. It identifies paths between contig extremities in the underlying read string graph, producing an Augmented Assembly Graph (AAG) that highlights potential adjacencies and repeat-induced connections. This allows researchers to manually or automatically investigate why an assembly is fragmented and determine the most likely orientation of contigs.

## Core CLI Usage

### Running the Main Pipeline

The primary command `knot` executes a Snakemake-based pipeline to generate the AAG.

**Basic execution with raw reads:**
```bash
knot -r raw_reads.fasta -c contigs.fasta -o project_name
```

**Execution with an existing assembly graph (GFA):**
```bash
knot -r raw_reads.fasta -c contigs.fasta -g assembly_graph.gfa -o project_name
```

**Using corrected reads:**
```bash
knot -C corrected_reads.fasta -c contigs.fasta -o project_name
```

### Optimization and Performance

KNOT allows passing Snakemake parameters directly by using the `--` separator.

**Enable parallel processing:**
```bash
knot -r reads.fasta -c contigs.fasta -o out -- -j 8
```

**Search mode optimization:**
Use `--search-mode` to define how the tool optimizes pathfinding between contigs.
- `base`: Optimizes for the number of bases (default).
- `node`: Optimizes for the number of nodes (reads) in the path.

### Generating Analysis Reports

After running the main pipeline, use `knot.analysis` to generate a visual HTML report.

```bash
knot.analysis -i project_name -c -p -o knot_report.html
```

- `-i`: The output prefix used in the initial `knot` run.
- `-c`: Perform path classification based on length and composition.
- `-p`: Execute a Hamiltonian path search to suggest a potential scaffold.

## Expert Tips and Best Practices

- **Input Format Restriction**: KNOT strictly requires FASTA format for reads. If you have FASTQ files, they must be converted to FASTA before running the tool.
- **Contig Filtering**: Use `--contig-min-length <int>` to ignore very short contigs that may clutter the graph and complicate pathfinding.
- **Read Type Specification**: Explicitly set `--read-type pb` for PacBio or `--read-type ont` for Oxford Nanopore to ensure underlying tools like minimap2 use appropriate presets.
- **Interpreting the AAG CSV**:
    - **Short paths**: High confidence adjacencies.
    - **Long paths**: Likely caused by genomic repeats.
    - **nb_read**: The number of reads in the path; fewer reads over a long distance may indicate lower confidence.
- **Intermediate Files**: KNOT creates a directory named `{prefix}_knot`. If a run fails, check this directory for the `contigs_filtred.fasta` and PAF files to verify if the initial mapping succeeded.



## Subcommands

| Command | Description |
|---------|-------------|
| KNOT | KNOT is a tool for analyzing contigs and their assembly graphs. |
| knot.analysis.generate_report | Generate a report from knot output. |

## Reference documentation

- [KNOT Main Documentation](./references/github_com_natir_knot_blob_master_Readme.md)
- [KNOT Repository Overview](./references/github_com_natir_knot.md)