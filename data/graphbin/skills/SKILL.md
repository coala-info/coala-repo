---
name: graphbin
description: GraphBin is a post-processing tool designed to refine metagenomic binning.
homepage: https://github.com/Vini2/GraphBin
---

# graphbin

## Overview
GraphBin is a post-processing tool designed to refine metagenomic binning. While traditional binners rely on k-mer composition and coverage, GraphBin utilizes the assembly graph's topology. It applies a label propagation algorithm to propagate bin assignments from high-confidence contigs to their neighbors in the graph. This is particularly effective for recovering short contigs that are often discarded by standard binning algorithms and for correcting errors where contigs were assigned to the wrong taxonomic group.

## Command Line Usage

The primary command is `graphbin`. You must specify the assembler used to generate the graph, as input requirements vary by assembler.

### Common Parameters
- `--assembler`: The assembly tool used (`spades`, `sga`, or `megahit`).
- `--graph`: Path to the assembly graph file (usually `.gfa` or `.asqg`).
- `--contigs`: Path to the fasta file containing the assembled contigs.
- `--binned`: Path to the initial binning result in `.csv` format.
- `--output`: Path to the directory where refined bins will be stored.

### Assembler-Specific Patterns

#### SPAdes
Requires the `.paths` file generated during assembly to map contigs to graph edges.
```bash
graphbin --assembler spades \
  --graph assembly_graph_with_scaffolds.gfa \
  --contigs contigs.fasta \
  --paths scaffolds.paths \
  --binned initial_bins.csv \
  --output ./refined_output
```

#### MEGAHIT
Uses the `.gfa` file produced by the `megahit_toolkit`.
```bash
graphbin --assembler megahit \
  --graph intermediate_contigs.gfa \
  --contigs final.contigs.fa \
  --binned initial_bins.csv \
  --output ./refined_output
```

#### SGA
Uses the `.asqg` graph format.
```bash
graphbin --assembler sga \
  --graph assembly.asqg \
  --contigs assembly-contigs.fa \
  --binned initial_bins.csv \
  --output ./refined_output
```

## Best Practices and Tips

- **Input Format**: Ensure the `--binned` CSV file follows the format: `contig_id,bin_label`. No headers should be present unless specified by the version.
- **Graph Selection**: For SPAdes, use the `assembly_graph_with_scaffolds.gfa` rather than the simplified `assembly_graph.fastg` for better connectivity information.
- **Short Contigs**: GraphBin is specifically useful for "rescuing" short contigs. If your initial binner has a minimum length cutoff (e.g., 1000bp), GraphBin can often assign the smaller fragments to the correct bins based on their connections to the larger, binned contigs.
- **Environment**: It is recommended to run GraphBin within a dedicated Conda environment due to its dependencies on `python-igraph` and `cogent3`.

## Reference documentation
- [GraphBin GitHub Repository](./references/github_com_metagentools_GraphBin.md)
- [Bioconda GraphBin Package Overview](./references/anaconda_org_channels_bioconda_packages_graphbin_overview.md)