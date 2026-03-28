---
name: odgi
description: "odgi is a suite of tools designed to manipulate, analyze, and visualize large-scale pangenome graphs using a succinct binary format. Use when user asks to convert GFA files to binary format, sort graphs to improve locality, generate pangenome visualizations, or extract specific paths and statistics."
homepage: https://github.com/vgteam/odgi
---

# odgi

## Overview
`odgi` is a specialized suite of tools designed to handle large-scale pangenome graphs. It uses a succinct, dynamic memory representation to allow for efficient manipulation of DNA sequence graphs that would otherwise be too large for standard tools. It is particularly effective for transforming GFA files into a binary format (.og), sorting graphs to improve locality, and generating high-resolution visualizations of pangenome structure and path relationships.

## Core Workflows and CLI Patterns

### 1. Graph Construction and Conversion
The primary entry point for most workflows is converting a GFA file into the optimized `.og` format.

```bash
# Convert GFA to odgi binary format
odgi build -g input.gfa -o graph.og

# Convert odgi binary back to GFA
odgi view -i graph.og -g > output.gfa
```

### 2. Sorting and Optimization
Sorting is critical for performance and visualization. A well-sorted graph minimizes the "delta" between connected nodes, reducing the memory footprint and making visualizations clearer.

```bash
# Sort the graph using a multi-step approach (recommended for complex graphs)
odgi sort -i input.og -o sorted.og -p n -P -s -S

# Apply a specific layout-based sort
odgi sort -i input.og -o sorted.og -Y
```

### 3. Visualization
`odgi` provides powerful tools to "see" the pangenome.

```bash
# Generate a 1D visualization of the graph (PNG)
odgi viz -i sorted.og -o visualization.png

# Create a 2D layout (requires a .lay file)
odgi layout -i sorted.og -o graph.lay
odgi draw -i sorted.og -c graph.lay -p visualization_2d.png
```

### 4. Analysis and Manipulation
Extracting specific regions or calculating statistics is a common requirement.

```bash
# Get general statistics about the graph
odgi stats -i graph.og -S

# Extract a specific path or region
odgi extract -i graph.og -p PathName -o region.og

# Find the similarity between paths
odgi similarity -i graph.og -p path_list.txt > similarity.tsv
```

## Expert Tips and Best Practices

- **Succinctness**: Always work with `.og` files rather than `.gfa` for intermediate steps. The binary format is significantly faster to load and requires less RAM.
- **Sorting is Mandatory**: Never run `odgi viz` or `odgi stats` on an unsorted graph if you want meaningful results. Use `odgi sort` with the `-p` (path-guided) or `-Y` (layout-guided) flags to improve graph locality.
- **GPU Acceleration**: If available, use the `--gpu` flag with `odgi layout` to achieve massive speedups (up to 50x) on large pangenomes.
- **Thread Management**: Most `odgi` commands support the `-t` or `--threads` flag. Always set this to match your environment's CPU capacity to maximize performance.
- **Path Names**: When using `odgi extract` or `odgi similarity`, ensure your path names match exactly what is in the GFA. Use `odgi paths -i graph.og -L` to list all available paths.



## Subcommands

| Command | Description |
|---------|-------------|
| odgi bin | Binning of pangenome sequence and path information in the graph. |
| odgi break | Break cycles in the graph and drop its paths. |
| odgi build | Construct a dynamic succinct variation graph in ODGI format from a GFAv1. |
| odgi degree | Describe the graph in terms of node degree. |
| odgi draw | Draw previously-determined 2D layouts of the graph with diverse annotations. |
| odgi explode | Breaks a graph into connected components storing each component in its own file. |
| odgi extract | Extract subgraphs or parts of a graph defined by query criteria. |
| odgi flatten | Generate linearizations of a graph. |
| odgi groom | Harmonize node orientations. |
| odgi inject | Inject BED interval ranges as paths in the graph. |
| odgi kmers | Display and characterize the kmer space of a graph. |
| odgi layout | Establish 2D layouts of the graph using path-guided stochastic gradient descent. The graph must be sorted and id-compacted. |
| odgi normalize | Compact unitigs and simplify redundant furcations. |
| odgi panpos | Get the pangenome position of a given path and nucleotide position (1-based). |
| odgi pathindex | Create a path index for a given graph. |
| odgi paths | Interrogate the embedded paths of a graph. Does not print anything to stdout by default! |
| odgi pav | Presence/absence variants (PAVs). It prints to stdout a TSV table with the 'PAV ratios'. For a given path range 'PR' and path 'P', the 'PAV ratio' is the ratio between the sum of the lengths of the nodes in 'PR' that are crossed by 'P' divided by the sum of the lengths of all the nodes in 'PR'. Each node is considered only once. |
| odgi priv | Differentially private sampling of graph subpaths. Apply the exponential mechanism to randomly sample shared sub-haplotypes with a given ε, target coverage, and minimum length. |
| odgi procbed | Intersect and adjust BED interval into PanSN-defined path subranges. Lift BED files into graphs produced by odgi extract. Uses path range information in the path names. |
| odgi prune | Remove parts of the graph. |
| odgi server | Start a basic HTTP server with a given path index file to go from *path:position* to *pangenome:position* very efficiently. |
| odgi similarity | Provides a sparse similarity matrix for paths or groups of paths. Each line prints in a tab-delimited format to stdout. |
| odgi sort | Apply different kind of sorting algorithms to a graph. The most prominent one is the PG-SGD sorting algorithm. |
| odgi squeeze | Squeezes multiple graphs in ODGI format into the same file in ODGI format. |
| odgi stepindex | Generate a step index from a given graph. If no output file is provided via *-o, --out*, the index will be directly written to *INPUT_GRAPH.stpidx*. |
| odgi unchop | Merge unitigs into a single node preserving the node order. |
| odgi unitig | Output unitigs of the graph. |
| odgi untangle | Project paths into reference-relative BEDPE (optionally PAF), to decompose paralogy relationships. |
| odgi validate | Validate a graph checking if the paths are consistent with the graph topology. |
| odgi view | Project a graph into other formats. |
| odgi viz | Visualize a variation graph in 1D. |
| odgi_chop | Divide nodes into smaller pieces preserving node topology and order. |
| odgi_cover | Cover the graph with paths. |
| odgi_crush | Replaces runs of Ns with single Ns (for example, ANNNT becomes ANT). |
| odgi_depth | Find the depth of a graph as defined by query criteria. Without specifying any non-mandatory options, it prints in a tab-delimited format path, start, end, and mean.depth to stdout. |
| odgi_flip | Flip (reverse complement) paths to match the graph. |
| odgi_heaps | Extract matrix of path pangenome coverage permutations for power law regression. |
| odgi_matrix | Write the graph topology in sparse matrix format. |
| odgi_overlap | Find the paths touched by given input paths. |
| odgi_position | Find, translate, and liftover graph and path positions between graphs. Results are printed to stdout. |
| odgi_stats | Metrics describing a variation graph and its path relationship. |
| odgi_tension | evaluate the tension of a graph helping to locate structural variants and abnormalities |
| odgi_tips | Identifying break point positions relative to given query (reference) path(s) of all the tips in the graph or of tips of given path(s). Prints BED records to stdout. |

## Reference documentation
- [Optimized Dynamic Genome/Graph Implementation (odgi)](./references/github_com_pangenome_odgi_blob_master_README.md)
- [ODGI Citation and Abstract](./references/github_com_pangenome_odgi_blob_master_CITATION.cff.md)