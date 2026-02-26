# gfaffix CWL Generation Report

## gfaffix

### Tool Description
Discover and collapse walk-preserving shared affixes of a given variation graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfaffix:0.2.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/GFAffix
- **Package**: https://anaconda.org/channels/bioconda/packages/gfaffix/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gfaffix/overview
- **Total Downloads**: 28.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marschall-lab/GFAffix
- **Stars**: N/A
### Original Help Text
```text
Discover and collapse walk-preserving shared affixes of a given variation graph.

Usage: gfaffix [OPTIONS] <GRAPH>

Arguments:
  <GRAPH>  graph in GFA1 format, supports compressed (.gz) input

Options:
  -o, --output_refined <REFINED_GRAPH_OUT>
          Write refined graph output (GFA1 format) to supplied file instead of stdout; if file name
          ends with .gz, output will be compressed [default: ]
  -t, --output_transformation <TRANSFORMATION_OUT>
          Report original nodes and their corresponding walks in refined graph to supplied file
          [default: ]
  -c, --check_transformation
          Verifies that the transformed parts of the graphs spell out the identical sequence as in
          the original graph
  -a, --output_affixes <AFFIXES_OUT>
          Report identified affixes [default: ]
  -x, --dont_collapse <NO_COLLAPSE_PATH>
          Do not collapse nodes on a given paths/walks ("P"/"W" lines) that match given regular
          expression [default: ]
  -p, --threads <THREADS>
          Run in parallel on N threads [default: 1]
  -v, --verbose
          Sets log level to debug
  -h, --help
          Print help
  -V, --version
          Print version
```

