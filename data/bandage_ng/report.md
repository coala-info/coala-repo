# bandage_ng CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bandage_ng_image | PASS |  |
| bandage_ng_info | Failed | tool bug: BandageNG 2026.9.1 counts a GFA link and its listed reverse complement as two edges (Edge count 8 instead of 4 on the Galaxy test GFA; Galaxy expects 4); all other statistics match. |
| bandage_ng_layout | PASS |  |
| bandage_ng_querypaths | Failed | image problem: NCBI BLAST (makeblastdb) is not in the bandage_ng image, so querypaths stops with 'The program makeblastdb was not found'. |
| bandage_ng_reduce | PASS |  |

## bandage_ng_info

### Tool Description
Display information about a graph

### Metadata
- **Docker Image**: quay.io/biocontainers/bandage_ng:2026.9.1--hca0ed12_0
- **Homepage**: https://github.com/asl/BandageNG
- **Package**: https://anaconda.org/channels/bioconda/packages/bandage_ng/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bandage_ng/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2026-02-03
- **GitHub**: https://github.com/asl/BandageNG
- **Stars**: N/A
### Original Help Text
```text
Display information about a graph
Usage: BandageNG info [OPTIONS] <graph>

Positionals:
  <graph> TEXT:FILE REQUIRED  A graph file of any type supported by Bandage

Options:
  -h,--help                   Print this help message and exit
  --helpall                   
  --tsv                       Output the information in a single tab-delimited line starting with the graph file

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
```

## bandage_ng_image

### Tool Description
Generate an image file of a graph

### Metadata
- **Docker Image**: quay.io/biocontainers/bandage_ng:2026.9.1--hca0ed12_0
- **Homepage**: https://github.com/asl/BandageNG
- **Package**: https://anaconda.org/channels/bioconda/packages/bandage_ng/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bandage_ng/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2026-02-03
- **GitHub**: https://github.com/asl/BandageNG
- **Stars**: N/A
### Original Help Text
```text
Generate an image file of a graph
Usage: BandageNG image [OPTIONS] <graph> <output_file>

Positionals:
  <graph> TEXT:FILE REQUIRED  A graph file of any type supported by Bandage
  <output_file> TEXT REQUIRED The image file to be created (must end in '.jpg', '.png' or '.svg')

Options:
  -h,--help                   Print this help message and exit
  --helpall                   
  --height UINT:INT in [1 - 32767]
                              Image height
  --width UINT:INT in [1 - 32767]
                              Image width
  --color TEXT:FILE           csv file with 2 columns: first the node name second the node color

If only height or width is set, the other will be determined automatically. If both are set, the image will be exactly that size
```

## bandage_ng_reduce

### Tool Description
Save a subgraph of a larger graph

### Metadata
- **Docker Image**: quay.io/biocontainers/bandage_ng:2026.9.1--hca0ed12_0
- **Homepage**: https://github.com/asl/BandageNG
- **Package**: https://anaconda.org/channels/bioconda/packages/bandage_ng/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bandage_ng/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2026-02-03
- **GitHub**: https://github.com/asl/BandageNG
- **Stars**: N/A
### Original Help Text
```text
Save a subgraph of a larger graph
Usage: BandageNG reduce [OPTIONS] <inputgraph> <outputgraph>

Positionals:
  <inputgraph> TEXT:FILE REQUIRED
                              A graph file of any type supported by Bandage
  <outputgraph> TEXT REQUIRED The filename for the GFA graph to be made (if it does not end in '.gfa', that extension will be added)

Options:
  -h,--help                   Print this help message and exit
  --helpall                   

Bandage reduce takes an input graph and saves a reduced subgraph using the graph scope settings. The saved graph will be in GFA format.
If a graph scope is not specified, then the 'entire' scope will be used, in which case this will simply convert the input graph to GFA format.

Graph scope options (from 'BandageNG --help'; accepted after the subcommand):
[Option Group: Graph scope]
  These settings control the graph scope. If the aroundnodes scope is used, then the --nodes option must also be used. If the aroundblast scope is used, a BLAST query must be given with the --query option. If the aroundcomponent scope is used, then at least one of --nodes, --path or --walk must be used.
  Options:
    --scope SCOPE:value in {entire->0,aroundnodes->1,aroundblast->4,depthrange->5,aroundcomponent->6} OR {0,1,4,5,6} [entire] 
                                Graph scope, from one of the following options: entire, aroundnodes, aroundblast, depthrange, aroundcomponent
    --exact,--partial{false}    Choose between exact or partial node name matching (default: exact)
    --distance INT:INT in [0 - 100] [0] 
                                The number of node steps away to draw for the aroundnodes and aroundblast scopes
    --mindepth FLOAT:FLOAT in [0 - 1e+06] [10] 
                                The minimum allowed depth for the depthrange scope
    --maxdepth FLOAT:FLOAT in [0 - 1e+06] [100] 
                                The maximum allowed depth for the depthrange scope
    --query TEXT:FILE           A FASTA file of either nucleotide or protein sequences to be used as BLAST queries
    --nodes TEXT [0]            A comma-separated list of starting nodes for the aroundnodes and aroundcomponent scopes (default: none)
    --path TEXT [0]             A comma-separated list of path names used as seeds for the aroundcomponent scope (default: none)
    --walk TEXT [0]             A comma-separated list of walk names used as seeds for the aroundcomponent scope (default: none)
```

## bandage_ng_querypaths

### Tool Description
Output graph paths for BLAST queries

### Metadata
- **Docker Image**: quay.io/biocontainers/bandage_ng:2026.9.1--hca0ed12_0
- **Homepage**: https://github.com/asl/BandageNG
- **Package**: https://anaconda.org/channels/bioconda/packages/bandage_ng/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bandage_ng/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2026-02-03
- **GitHub**: https://github.com/asl/BandageNG
- **Stars**: N/A
### Original Help Text
```text
Output graph paths for BLAST queries
Usage: BandageNG querypaths [OPTIONS] <graph> <queries> <output_prefix>

Positionals:
  <graph> TEXT:FILE REQUIRED  A graph file of any type supported by Bandage
  <queries> TEXT:FILE REQUIRED
                              A FASTA file of one or more BLAST queries
  <output_prefix> TEXT REQUIRED
                              The output file prefix (used to create the '.tsv' output file, and possibly FASTA files as well, depending on options)

Options:
  -h,--help                   Print this help message and exit
  --helpall                   
  --pathfasta                 Put all query path sequences in a multi-FASTA file, not in the TSV file
  --hitsfasta                 Produce a multi-FASTA file of all BLAST hits in the query paths
  --gfapaths                  Align to GFA path sequences in addition to nodes

Bandage querypaths searches for queries in the graph using BLAST and outputs the results to a tab-delimited file.
```

## bandage_ng_layout

### Tool Description
Layout the graph

### Metadata
- **Docker Image**: quay.io/biocontainers/bandage_ng:2026.9.1--hca0ed12_0
- **Homepage**: https://github.com/asl/BandageNG
- **Package**: https://anaconda.org/channels/bioconda/packages/bandage_ng/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bandage_ng/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2026-02-03
- **GitHub**: https://github.com/asl/BandageNG
- **Stars**: N/A
### Original Help Text
```text
Layout the graph
Usage: BandageNG layout [OPTIONS] <graph> <layout>

Positionals:
  <graph> TEXT:FILE REQUIRED  A graph file of any type supported by Bandage
  <layout> TEXT REQUIRED      The layout file to be created (must end with .tsv or .layout)

Options:
  -h,--help                   Print this help message and exit
  --helpall                   
```


