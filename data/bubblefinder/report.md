# bubblefinder CWL Generation Report

## bubblefinder_BubbleFinder

### Tool Description
Compute and output the SPQR tree of the input graph

### Metadata
- **Docker Image**: quay.io/biocontainers/bubblefinder:1.0.3--h503566f_0
- **Homepage**: https://github.com/algbio/BubbleFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/bubblefinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bubblefinder/overview
- **Total Downloads**: 699
- **Last updated**: 2026-01-24
- **GitHub**: https://github.com/algbio/BubbleFinder
- **Stars**: N/A
### Original Help Text
```text
Error: unknown command '-help'. Expected one of: superbubbles, directed-superbubbles, snarls, ultrabubbles, spqr-tree.

Usage:
  BubbleFinder <command> -g <graphFile> -o <outputFile> [options]

Commands:
  superbubbles
      Bidirected superbubbles (GFA -> bidirected by default)
  directed-superbubbles
      Directed superbubbles (directed graph)
  snarls
      Snarls (typically on bidirected graphs from GFA)
  ultrabubbles
      Ultrabubbles (requires: each connected component has at least one tip; bidirected -> oriented directed graph -> superbubbles)
  spqr-tree
      Compute and output the SPQR tree of the input graph

Format options (input format):
  --gfa
      GFA input (bidirected).
  --gfa-directed
      GFA input interpreted as a directed graph.
  --graph
      .graph text format with one directed edge per line:
        • first line: two integers n and m
            - n = number of distinct node IDs declared
            - m = number of directed edges
        • next m lines: 'u v' (separated by whitespace),
            each describing a directed edge from u to v.
        • u and v are arbitrary node identifiers (strings
            without whitespace).
  If none of these is given, the format is auto-detected
  from the file extension (e.g. .gfa, .graph).

Compression:
  Compression is auto-detected from the file name suffix:
    .gz / .bgz  -> gzip
    .bz2        -> bzip2
    .xz         -> xz

General options:
  -g <file>
      Input graph file (possibly compressed)
  -o <file>
      Output file
  -j <threads>
      Number of threads
  --gfa
      Force GFA input (bidirected)
  --gfa-directed
      Force GFA input interpreted as directed graph
  --graph
      Force .graph text format (see 'Format options' above)
  --clsd-trees <file>
      Write CLSD superbubble trees (ultrabubble hierarchy) to <file> (ultrabubbles command only)
  --report-json <file>
      Write JSON metrics report
  -m <bytes>
      Stack size in bytes
  -h, --help
      Show this help message and exit
```

