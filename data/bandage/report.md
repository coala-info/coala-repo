# bandage CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bandage_image | PASS |  |
| bandage_info | PASS |  |
| bandage_querypaths | Failed | image problem: NCBI BLAST (makeblastdb) is not in the bandage 0.9.0 image, so querypaths stops with 'The program makeblastdb was not found' and exit 139. |
| bandage_reduce | PASS |  |

## bandage_info

### Tool Description
Bandage info takes a graph file as input and outputs (to stdout) statistics about the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/bandage:0.9.0--h9948957_0
- **Homepage**: https://github.com/rrwick/Bandage
- **Package**: https://anaconda.org/channels/bioconda/packages/bandage/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bandage/overview
- **Total Downloads**: 20.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rrwick/Bandage
- **Stars**: N/A
### Original Help Text
```text

Bandage info takes a graph file as input and outputs (to stdout) the following statistics about the graph:
  * Node count: The number of nodes in the graph. Only positive nodes are counted (i.e. each complementary pair counts as one).
  * Edge count: The number of edges in the graph. Only one edge in each complementary pair is counted.
  * Smallest edge overlap: The smallest overlap size (in bp) for the edges in the graph.
  * Largest edge overlap: The smallest overlap size (in bp) for the edges in the graph. For most graphs this will be the same as the smallest edge overlap (i.e. all edges have the same overlap).
  * Total length: The total number of base pairs in the graph.
  * Total length no overlaps: The total number of base pairs in the graph, subtracting bases that are duplicated in edge overlaps.
  * Dead ends: The number of instances where an end of a node does not connect to any other nodes.
  * Percentage dead ends: The proportion of possible dead ends. The maximum number of dead ends is twice the number of nodes (occurs when there are no edges), so this value is the number of dead ends divided by twice the node count.
  * Connected components: The number of regions of the graph which are disconnected from each other.
  * Largest component: The total number of base pairs in the largest connected component.
  * Total length orphaned nodes: The total number of base pairs in orphan nodes (nodes with no edges).
  * N50: Nodes that are this length or greater will collectively add up to at least half of the total length.
  * Shortest node: The length of the shortest node in the graph.
  * Lower quartile node: The median node length for the shorter half of the nodes.
  * Median node: The median node length for the graph.
  * Upper quartile node: The median node length for the longer half of the nodes.
  * Longest node: The length of the longest node in the graph.
  * Median depth: The median depth of the graph, by base.
  * Estimated sequence length: An estimate of the total number of bases in the original sequence, calculated by multiplying each node's length (minus overlaps) by its depth relative to the median.
          
Usage:    Bandage info <graph> [options]
          
Positional parameters:
          <graph>             A graph file of any type supported by Bandage
          
Options:  --tsv               Output the information in a single tab-delimited line starting with the graph file
          
          --help              View this help message
          --helpall           View all command line settings
          --version           View Bandage version number
          
Online Bandage help: https://github.com/rrwick/Bandage/wiki
          
```

## bandage_image

### Tool Description
Bandage image will generate an image file of the graph visualisation without opening the GUI.

### Metadata
- **Docker Image**: quay.io/biocontainers/bandage:0.9.0--h9948957_0
- **Homepage**: https://github.com/rrwick/Bandage
- **Package**: https://anaconda.org/channels/bioconda/packages/bandage/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bandage/overview
- **Total Downloads**: 20.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rrwick/Bandage
- **Stars**: N/A
### Original Help Text
```text

Bandage image will generate an image file of the graph visualisation without opening the GUI.

Usage:    Bandage image <graph> <outputfile> [options]
          
Positional parameters:
          <graph>             A graph file of any type supported by Bandage
          <outputfile>        The image file to be created (must end in '.jpg', '.png' or '.svg')
          
Options:  --height <int>      Image height (default: 1000)
          --width <int>       Image width (default: not set)
          --color <file>       csv file with 2 column first the node name second the node color
          
          If only height or width is set, the other will be determined automatically. If both are set, the image will be exactly that size.
          
          --help              View this help message
          --helpall           View all command line settings
          --version           View Bandage version number
          
Online Bandage help: https://github.com/rrwick/Bandage/wiki
          
```

## bandage_querypaths

### Tool Description
Bandage querypaths searches for queries in the graph using BLAST and outputs the results to a tab-delimited file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bandage:0.9.0--h9948957_0
- **Homepage**: https://github.com/rrwick/Bandage
- **Package**: https://anaconda.org/channels/bioconda/packages/bandage/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bandage/overview
- **Total Downloads**: 20.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rrwick/Bandage
- **Stars**: N/A
### Original Help Text
```text

Bandage querypaths searches for queries in the graph using BLAST and outputs the results to a tab-delimited file.

Usage:    Bandage querypaths <graph> <queries> <output_prefix> [options]
          
Positional parameters:
          <graph>             A graph file of any type supported by Bandage
          <queries>           A FASTA file of one or more BLAST queries
          <output_prefix>     The output file prefix (used to create the '.tsv' output file, and possibly FASTA files as well, depending on options)
          
Options:  --pathfasta         Put all query path sequences in a multi-FASTA file, not in the TSV file
          --hitsfasta         Produce a multi-FASTA file of all BLAST hits in the query paths
          
          --help              View this help message
          --helpall           View all command line settings
          --version           View Bandage version number
          
Online Bandage help: https://github.com/rrwick/Bandage/wiki
          
```

## bandage_reduce

### Tool Description
Bandage reduce takes an input graph and saves a reduced subgraph using the graph scope settings. The saved graph will be in GFA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bandage:0.9.0--h9948957_0
- **Homepage**: https://github.com/rrwick/Bandage
- **Package**: https://anaconda.org/channels/bioconda/packages/bandage/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bandage/overview
- **Total Downloads**: 20.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rrwick/Bandage
- **Stars**: N/A
### Original Help Text
```text

Bandage reduce takes an input graph and saves a reduced subgraph using the graph scope settings. The saved graph will be in GFA format.

If a graph scope is not specified, then the 'entire' scope will be used, in which case this will simply convert the input graph to GFA format.

Usage:    Bandage reduce <inputgraph> <outputgraph> [options]
          
Positional parameters:
          <inputgraph>        A graph file of any type supported by Bandage
          <outputgraph>       The filename for the GFA graph to be made (if it does not end in '.gfa', that extension will be added)
          
Options:  --help              View this help message
          --helpall           View all command line settings
          --version           View Bandage version number
          
Settings: --scope <scope>     Graph scope, from one of the following options: entire, aroundnodes, aroundblast, depthrange (default: entire)
          --nodes <list>      A comma-separated list of starting nodes for the aroundnodes scope (default: none)
          --partial           Use partial node name matching (default: exact node name matching)
          --distance <int>    The number of node steps away to draw for the aroundnodes and aroundblast scopes (0 to 100, default: 0)
          --mindepth <float>  The minimum allowed depth for the depthrange scope (0 to 1e+06, default: 10)
          --maxdepth <float>  The maximum allowed depth for the depthrange scope (0 to 1e+06, default: 100)
          
Online Bandage help: https://github.com/rrwick/Bandage/wiki
          
```


