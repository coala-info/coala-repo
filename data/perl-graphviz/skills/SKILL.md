---
name: perl-graphviz
description: The `perl-graphviz` skill facilitates the creation of graph-based visualizations through Perl scripts.
homepage: https://metacpan.org/pod/GraphViz
---

# perl-graphviz

## Overview
The `perl-graphviz` skill facilitates the creation of graph-based visualizations through Perl scripts. While the original `GraphViz` module is available, modern implementations should utilize `GraphViz2`, which provides a more robust wrapper for AT&T's Graphviz toolset. This tool allows you to define nodes and edges with specific attributes and then leverage various layout engines (like `dot` for hierarchical graphs or `neato` for spring-model layouts) to produce output in formats such as PNG, SVG, or PostScript.

## Installation
To install the package via Bioconda:
```bash
conda install bioconda::perl-graphviz
```

## Core Usage Patterns

### 1. Prefer GraphViz2
Always use `GraphViz2` for new projects as the original `GraphViz` module is deprecated. `GraphViz2` offers better attribute handling and supports more modern Graphviz features.

### 2. Basic Script Structure
A typical workflow involves initializing the graph object, defining global attributes, adding components, and rendering the output.

```perl
use strict;
use warnings;
use GraphViz2;

# 1. Initialize with global attributes
my $graph = GraphViz2->new(
    global => { directed => 1 },
    graph  => { label => 'Process Flow', rankdir => 'LR' },
    node   => { shape => 'box', style => 'filled', fillcolor => 'white' },
    edge   => { color => 'blue' },
);

# 2. Add nodes
$graph->add_node(name => 'Start', color => 'green');
$graph->add_node(name => 'Process');
$graph->add_node(name => 'End', shape => 'circle');

# 3. Add edges
$graph->add_edge(from => 'Start', to => 'Process');
$graph->add_edge(from => 'Process', to => 'End', label => 'Done');

# 4. Render to file
$graph->run(format => 'png', output_file => 'flowchart.png');
```

### 3. Selecting the Right Layout Engine (Driver)
Specify the `driver` in the `run` method or the constructor to change the layout logic:
- `dot`: Best for hierarchical or layered graphs (default).
- `neato`: Best for undirected graphs (spring model).
- `twopi`: Radial layouts.
- `circo`: Circular layouts.
- `fdp`: Force-directed layouts.

```perl
$graph->run(driver => 'neato', format => 'svg', output_file => 'network.svg');
```

## Expert Tips and Best Practices

### Attribute Scoping
- **Global**: Set in the `new()` constructor to apply to all elements.
- **Local**: Set within `add_node()` or `add_edge()` to override globals for specific elements.
- **Defaults**: Use `default_node()`, `default_edge()`, or `default_graph()` to change defaults mid-script for subsequent elements.

### Handling Ports and Records
For complex data structures, use the `record` or `Mrecord` shapes. You can link to specific "ports" within a node using the `node_name:port_name` syntax.

```perl
$graph->add_node(name => 'Struct1', shape => 'record', label => '<f0> left|<f1> mid|<f2> right');
$graph->add_edge(from => 'OtherNode', to => 'Struct1:f1');
```

### Logging and Debugging
When troubleshooting layout issues, pass a logger object (like `Log::Handler`) to the constructor to capture the internal commands being sent to the Graphviz binaries.

### Performance with Large Graphs
For extremely large graphs, rendering to `canon` or `dot` format first can help debug the structure before committing to a heavy image rendering process.

## Reference documentation
- [GraphViz2 - A wrapper for AT&T's Graphviz](./references/metacpan_org_pod_GraphViz2.md)
- [GraphViz - Interface to AT&T's GraphViz (Deprecated)](./references/metacpan_org_pod_GraphViz.md)
- [perl-graphviz Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-graphviz_overview.md)