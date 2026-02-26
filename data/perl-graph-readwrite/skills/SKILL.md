---
name: perl-graph-readwrite
description: This tool provides a persistence layer for reading and writing Perl Graph objects across various file formats like XML, Dot, and HTK. Use when user asks to read or write graph data structures, convert between graph file formats, or export graphs for visualization in Graphviz.
homepage: https://github.com/neilb/Graph-ReadWrite
---


# perl-graph-readwrite

## Overview

The `perl-graph-readwrite` skill provides a specialized interface for managing directed graph data structures. It acts as a persistence layer for Jarkko Hietaniemi’s `Graph` module, allowing you to transition between in-memory Perl graph objects and various standardized file formats. You should use this skill to automate the generation of visualization files (like Dot) or to parse graph data from legacy formats (like HTK) into a format suitable for computational analysis in Perl.

## Core Usage Patterns

### Reading and Writing Graphs
The library uses a consistent API where a `Reader` object creates a `Graph` instance from a file, and a `Writer` object exports a `Graph` instance to a file.

**Reading a Dot (Graphviz) file:**
```perl
use Graph::Reader::Dot;
my $reader = Graph::Reader::Dot->new();
my $graph  = $reader->read_graph('input.dot');
```

**Writing to XML:**
```perl
use Graph::Writer::XML;
my $writer = Graph::Writer::XML->new();
$writer->write_graph($graph, 'output.xml');
```

### Format Conversion One-Liner
You can perform quick format conversions from the command line using Perl one-liners. For example, to convert a Dot file to the library's native XML format:

```bash
perl -MGraph::Reader::Dot -MGraph::Writer::XML -e '$g = Graph::Reader::Dot->new->read_graph("in.dot"); Graph::Writer::XML->new->write_graph($g, "out.xml")'
```

## Supported Formats and Modules

| Format | Reader Module | Writer Module | Notes |
| :--- | :--- | :--- | :--- |
| **XML** | `Graph::Reader::XML` | `Graph::Writer::XML` | Best for preserving all Graph object attributes. |
| **Dot** | `Graph::Reader::Dot` | `Graph::Writer::Dot` | Standard Graphviz format for visualization. |
| **HTK** | `Graph::Reader::HTK` | `Graph::Writer::HTK` | Used for Hidden Markov Model lattices. |
| **VCG** | N/A | `Graph::Writer::VCG` | Visualization of Compiler Graphs. |
| **daVinci** | N/A | `Graph::Writer::daVinci` | Legacy graph visualization format. |

## Expert Tips and Best Practices

1.  **Attribute Preservation**: If you need to save a graph and reload it later with all custom attributes (node labels, weights, etc.) intact, always use `Graph::Writer::XML`. Other formats like Dot may lose specific Perl-side metadata during the transition.
2.  **Dependency Management**: Ensure `XML::Parser` and `XML::Writer` are installed in your environment if you intend to use the XML modules, as these are not bundled in the core Perl distribution but are required by this library.
3.  **Graph Version Compatibility**: This library (Version 2.0+) is designed to work with `Graph` module version 0.50 or later. If you encounter errors regarding graph methods, verify your `Graph.pm` version.
4.  **Handling HTK Lattices**: When working with `Graph::Reader::HTK`, be aware that it is specifically tailored for speech recognition lattices. It is highly efficient for this domain but may require manual attribute mapping if used for general-purpose directed graphs.

## Reference documentation
- [Bioconda perl-graph-readwrite Overview](./references/anaconda_org_channels_bioconda_packages_perl-graph-readwrite_overview.md)
- [Graph-ReadWrite GitHub README](./references/github_com_neilb_Graph-ReadWrite.md)