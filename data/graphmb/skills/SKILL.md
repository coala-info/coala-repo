---
name: graphmb
description: GraphMB is a metagenomic binning tool that uses graph machine learning on assembly graphs to group contigs into bins. Use when user asks to perform metagenomic binning on long-read assemblies, process assembly graphs with machine learning, or resolve bins using contig overlaps and depth.
homepage: https://github.com/MicrobialDarkMatter/GraphMB
---


# graphmb

## Overview
GraphMB is a metagenomic binning tool designed for long-read assemblies. It distinguishes itself from traditional binners by using graph machine learning algorithms to process the assembly graph generated during the assembly process. By treating the assembly as a graph where contigs (or edges) are nodes and their overlaps are edges, GraphMB can resolve bins more accurately than methods relying solely on tetranucleotide frequency (TNF) and coverage.

## Installation and Setup
GraphMB can be installed via pip or conda. It requires Python 3.7+.

```bash
# Via Conda
conda install -c bioconda graphmb

# Via Pip
pip install graphmb
```

## Core CLI Usage

### Required Input Files
GraphMB expects a directory containing the following files (default names):
- `assembly.fasta`: Contig or edge sequences.
- `assembly_graph.gfa`: The assembly graph (Flye 2.9+ recommended).
- `assembly_depth.txt`: Contig depth (typically from `jgi_summarize_bam_contig_depths`).
- `marker_gene_stats.csv` (Optional): CheckM results for the contigs.

### Basic Execution
Run the binner by pointing to the assembly directory:
```bash
graphmb --assembly path/to/data/ --outdir results/output_name/ --markers marker_gene_stats.tsv
```

### Customizing Input Paths
If your files do not use the default naming convention, specify them explicitly:
```bash
graphmb --assembly data/ \
    --outdir results/ \
    --assembly_name edges.fasta \
    --graph_file assembly_graph.gfa \
    --depth edges_depth.txt \
    --markers marker_gene_stats.tsv
```

## Performance and Hardware Optimization

### GPU Acceleration
To use a GPU for both model training and clustering (highly recommended for large graphs):
```bash
graphmb --assembly data/ --outdir results/ --cuda
```

### CPU Threading
If running on CPU, limit the number of cores to prevent resource exhaustion:
```bash
graphmb --assembly data/ --outdir results/ --numcores 8
```

## Expert Tips and Best Practices

### 1. Node Granularity
By default, GraphMB uses edges from the assembly graph as nodes. If you prefer to use full contigs as nodes, use the `--contignodes` flag. This is useful if your assembly graph is already simplified or if you are working with a non-Flye assembly.
```bash
graphmb --assembly data/ --outdir results/ --contignodes
```

### 2. Speed vs. Accuracy
GraphMB performs clustering after every 10 epochs by default to find the best model. To speed up training at the cost of potentially missing the optimal model, increase the evaluation interval:
```bash
# Evaluate every 50 epochs instead of 10
graphmb --assembly data/ --outdir results/ --evalepochs 50
```

### 3. Pre-processing GFA to FASTA
If you only have a GFA file and need to extract the sequences for the `assembly.fasta` requirement:
```bash
awk '/^S/{print ">"$2"\n"$3}' assembly_graph.gfa | fold > assembly.fasta
```

### 4. Marker Genes
While optional, providing CheckM marker gene stats significantly improves results. GraphMB uses these markers in a constrained loss function to guide the neural network toward biologically meaningful clusters.

## Reference documentation
- [GraphMB GitHub Repository](./references/github_com_MicrobialDarkMatter_GraphMB.md)
- [Bioconda GraphMB Overview](./references/anaconda_org_channels_bioconda_packages_graphmb_overview.md)