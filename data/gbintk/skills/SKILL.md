---
name: gbintk
description: gbintk is a metagenomic binning suite that utilizes assembly graph topology to refine or generate contig assignments. Use when user asks to refine existing metagenomic bins, perform de novo binning with MetaCoAG, or visualize binning results on an assembly graph.
homepage: https://github.com/metagentools/gbintk
---


# gbintk

## Overview

`gbintk` (GraphBin-Tk) is a comprehensive suite designed for assembly graph-based metagenomic binning. It integrates three powerful algorithms—GraphBin, GraphBin2, and MetaCoAG—into a single interface. By utilizing the topology of the assembly graph alongside traditional composition and coverage data, `gbintk` can resolve ambiguous contig assignments, refine existing bins, and handle overlapped binning where a single contig may belong to multiple species.

## Core Workflows

### 1. Preparing Initial Bins
Before refining bins with GraphBin or GraphBin2, you must format your existing binning results (e.g., from MaxBin2 or MetaBAT2).
```bash
gbintk prepare --bins /path/to/bins --out initial_bins.csv
```

### 2. Refined Binning (GraphBin / GraphBin2)
Use these commands to improve existing binning results using the assembly graph.
- **GraphBin**: Best for standard refinement.
- **GraphBin2**: Best when you expect contigs to belong to multiple bins (overlapped binning).

```bash
# Standard refinement
gbintk graphbin --graph assembly_graph.gfa --contigs contigs.fasta --bins initial_bins.csv --out refined_output/

# Refinement with overlapped binning support
gbintk graphbin2 --graph assembly_graph.gfa --contigs contigs.fasta --bins initial_bins.csv --out refined_output/
```

### 3. De Novo Binning (MetaCoAG)
Use MetaCoAG when you want to perform binning from scratch using composition, coverage, and the assembly graph.
```bash
gbintk metacoag --graph assembly_graph.gfa --contigs contigs.fasta --abundance abundance.tsv --out binning_results/
```

### 4. Evaluation and Visualization
After binning, use the built-in tools to assess quality or generate visual representations of the graph-based assignments.
```bash
# Evaluate against a ground truth
gbintk evaluate --bins refined_bins.csv --gt ground_truth.csv

# Visualise the binning results on the graph
gbintk visualise --graph assembly_graph.gfa --bins refined_bins.csv --out visualisation_dir/
```

## Expert Tips and Best Practices

- **Assembler Compatibility**: `gbintk` is optimized for assembly graphs produced by metaSPAdes (`assembly_graph_with_scaffolds.gfa`), MEGAHIT (using the `megahit_toolkit` to export GFA), and metaFlye (`assembly_graph.gfa`).
- **Input Consistency**: Ensure that the contig headers in your FASTA file exactly match the node names in your GFA file. Discrepancies here are the most common cause of tool failure.
- **Refinement vs. De Novo**: If you already have high-quality bins from a tool like MetaBAT2, use `graphbin` or `graphbin2` to "clean up" unassigned contigs. If starting from scratch, `metacoag` is the preferred entry point.
- **Memory Management**: Assembly graphs for complex metagenomes can be large. Ensure your environment has sufficient RAM to load the full graph structure into memory, especially when using `visualise`.

## Reference documentation
- [GraphBin-Tk GitHub Repository](./references/github_com_metagentools_gbintk.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_gbintk_overview.md)