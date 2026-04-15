---
name: panaroo
description: Panaroo is a graph-based tool used to construct and analyze prokaryotic pangenomes from annotated GFF3 files while accounting for assembly errors and fragmentation. Use when user asks to construct a pangenome, handle fragmented assemblies, merge existing pangenomes, or generate core-genome alignments for phylogenetics.
homepage: https://gtonkinhill.github.io/panaroo
metadata:
  docker_image: "quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0"
---

# panaroo

## Overview
Panaroo is a specialized tool designed to construct pangenomes from annotated prokaryotic genomes (GFF3 files). Unlike traditional pangenome tools, it uses a graph-based approach to account for assembly errors, contamination, and fragmentation. This skill provides the necessary command-line patterns to run the pipeline, manage different stringency levels, and interpret the resulting pangenome graph.

## Core Workflows

### Basic Pangenome Construction
The most common use case is generating a pangenome from a directory of GFF files.
```bash
panaroo -i *.gff -o output_directory --clean-mode strict -t 8
```
*   `-i`: Input GFF3 files (Prokka or Bakta outputs are recommended).
*   `-o`: Output directory for results.
*   `--clean-mode`: Defines how aggressively to remove potential artifacts (`strict`, `moderate`, or `sensitive`).

### Handling Fragmented Assemblies
If working with highly fragmented draft genomes, use the `refind` mode to search for missing genes in the original assemblies.
```bash
panaroo -i *.gff -o output_refind --refind_prop_match 0.5
```

### Merging Pangenomes
To add new samples to an existing Panaroo run without re-clustering the entire dataset:
```bash
panaroo-merge -i new_gffs/*.gff -d previous_output_directory -o merged_output
```

## Best Practices and Tips
*   **Input Consistency**: Ensure all input GFF files are annotated using the same tool (e.g., all Prokka) to avoid artificial inflation of the accessory genome due to naming discrepancies.
*   **Contamination Removal**: Use the `strict` cleaning mode if you suspect your dataset contains low-level contamination or poor-quality assemblies.
*   **Visualization**: Panaroo produces a `final_graph.gml` file. This can be visualized in Cytoscape or Gephi to inspect the structure of the pangenome and identify recombination hotspots.
*   **Gene Alignment**: To generate core-genome alignments for phylogenetics, use the `--alignment` flag:
    ```bash
    panaroo -i *.gff -o output --alignment core --aligner mafft
    ```

## Common CLI Patterns
| Task | Command Flag |
| :--- | :--- |
| Increase CPU threads | `-t [number]` |
| Set sequence identity threshold | `--id [0.0-1.0]` (Default: 0.95) |
| Define core gene threshold | `--core_threshold [0.0-1.0]` (Default: 0.95) |
| Rapid run (skip graph filtering) | `--fast` |

## Reference documentation
- [Panaroo Overview](./references/anaconda_org_channels_bioconda_packages_panaroo_overview.md)
- [Panaroo Documentation and Quickstart](./references/gthlab_au_panaroo.md)