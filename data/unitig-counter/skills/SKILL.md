---
name: unitig-counter
description: The `unitig-counter` tool is a specialized utility for bacterial genomics that identifies and counts unitigs (non-branching paths in a de Bruijn graph) across multiple strains.
homepage: https://github.com/johnlees/unitig-counter
---

# unitig-counter

## Overview

The `unitig-counter` tool is a specialized utility for bacterial genomics that identifies and counts unitigs (non-branching paths in a de Bruijn graph) across multiple strains. It transforms raw assembly data into a format compatible with genome-wide association studies (GWAS), specifically optimized for `pyseer`. This skill provides the necessary command patterns for building the graph, counting unitigs, and performing downstream graph operations like calculating distances or extending sequences.

## Core Workflow

### 1. Preparing the Input
The tool requires a tab-delimited text file (e.g., `strains.txt`) containing a header and two columns: the strain ID and the file path to the assembly (FASTA).

Example `strains.txt`:
```text
ID  Path
Strain_A    /path/to/strain_A.fasta
Strain_B    /path/to/strain_B.fasta
```

### 2. Counting Unitigs
Run the primary analysis to generate the unitig matrix.

```bash
unitig-counter -strains strains.txt -output output_dir -nb-cores 8
```

**Key Outputs:**
- `output_dir/unitigs.txt`: The full matrix for use with `pyseer --kmers`.
- `output_dir/unitigs.unique_rows.txt`: A reduced matrix of unique patterns for use with `pyseer --Rtab`.
- `output_dir/graph`: The constructed de Bruijn graph directory required for further operations.

### 3. Graph Operations (cdbg-ops)
Once the graph is built, use `cdbg-ops` for sequence analysis.

**Calculating Distance:**
Find the shortest sequence distance between two specific unitigs/sequences within the population graph.
```bash
cdbg-ops dist --graph output_dir/graph --source [SEQUENCE_1] --target [SEQUENCE_2]
```

**Extending Unitigs:**
Extend short unitigs (e.g., significant hits from GWAS) by following paths in the graph to recover more biological context.
```bash
cdbg-ops extend --graph output_dir/graph --unitigs hits.txt > extended_sequences.txt
```

## Best Practices
- **Memory Management**: The tool uses GATB for compressed de Bruijn graphs, which is memory efficient, but ensure `-nb-cores` matches your available CPU resources to speed up the initial graph construction.
- **Contig Spanning**: Be aware that some unitigs may span multiple input contigs. If you need to restrict calls to physical contigs, consider post-processing the output with `unitig-caller` or the `bcalm` package scripts.
- **GWAS Integration**: Use the `.unique_rows.txt` output for initial association testing to reduce the computational burden on `pyseer`, as it eliminates redundant patterns.

## Reference documentation
- [unitig-counter GitHub Repository](./references/github_com_bacpop_unitig-counter.md)