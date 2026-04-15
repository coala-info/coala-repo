---
name: perl-graph
description: The perl-graph tool manages abstract graph data structures and executes graph theory algorithms within a Perl environment. Use when user asks to model complex relationships, create directed or undirected graphs, check for directed acyclic graphs, find connected components, or calculate shortest paths.
homepage: http://metacpan.org/pod/Graph
metadata:
  docker_image: "quay.io/biocontainers/perl-graph:0.9735--pl5321hdfd78af_0"
---

# perl-graph

## Overview
The `perl-graph` skill enables the management of abstract graph data structures. Unlike visualization tools, this module focuses on the mathematical and algorithmic representation of graphs. It supports directed and undirected graphs, hyperedges, and weighted attributes. Use this skill to model complex relationships, such as metabolic pathways, genomic assemblies, or dependency trees, and to execute standard graph theory algorithms directly within a Perl environment.

## Implementation Patterns

### Basic Graph Construction
Initialize graphs based on the required logic (directed for flow/dependencies, undirected for simple relationships).

```perl
use Graph;
use Graph::Directed;
use Graph::Undirected;

# Create a directed graph
my $g = Graph::Directed->new;

# Add edges (vertices are created automatically)
$g->add_edge("A", "B");
$g->add_edge("B", "C");

# Check for existence
if ($g->has_edge("A", "B")) {
    print "Edge exists\n";
}
```

### Common One-Liner Patterns
For quick analysis of graph data from the command line, use Perl one-liners:

*   **Check if a graph is a DAG (Directed Acyclic Graph):**
    ```bash
    perl -MGraph::Directed -e '$g=Graph::Directed->new; while(<>){chomp; @e=split; $g->add_edge(@e)} print $g->is_dag ? "DAG\n" : "Not a DAG\n"' edges.txt
    ```

*   **Find Connected Components:**
    ```bash
    perl -MGraph::Undirected -e '$g=Graph::Undirected->new; while(<>){chomp; @e=split; $g->add_edge(@e)} @c=$g->connected_components; print scalar @c, " components found\n"' edges.txt
    ```

### Expert Tips
*   **Memory Management:** The module uses weak references. Ensure you are using Perl 5.6.0 or later to avoid memory leaks in complex, circular graph structures.
*   **Vertex Identification:** Vertices are treated as strings by default. If using complex objects as vertices, ensure they stringify uniquely or use the `refvertexed` option during initialization.
*   **Attributes:** You can attach weights or labels to edges and vertices using `$g->set_edge_attribute($u, $v, $name, $value)`. This is essential for running Minimum Spanning Tree (MST) or Shortest Path algorithms.
*   **Avoid Graphics:** Do not attempt to use this module for rendering images (PNG/SVG). Use it to calculate the data, then export to a format like Graphviz (DOT) if visualization is required.

## Reference documentation
- [Graph - metacpan.org](./references/metacpan_org_pod_Graph.md)
- [perl-graph - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-graph_overview.md)