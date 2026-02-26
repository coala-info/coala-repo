# mice CWL Generation Report

## mice

### Tool Description
Parse paths from a GFF/GFA file

### Metadata
- **Docker Image**: quay.io/biocontainers/mice:0.1.2--h4349ce8_0
- **Homepage**: https://github.com/gi-bielefeld/mice
- **Package**: https://anaconda.org/channels/bioconda/packages/mice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mice/overview
- **Total Downloads**: 395
- **Last updated**: 2025-12-01
- **GitHub**: https://github.com/gi-bielefeld/mice
- **Stars**: N/A
### Original Help Text
```text
Parse paths from a GFF/GFA file

Usage: mice [OPTIONS] <GRAPH_INPUT>

Arguments:
  <GRAPH_INPUT>
          Input graph file

Options:
  -o, --out-dir <OUT_DIR>
          Output directory
          
          [default: mice_output]

  -r, --remove-dup <REMOVE_DUPLICATES>
          Remove an element if it occurs more than x times in any genome. Use 0 to disable removal
          
          [default: 0]

  -m, --min-size <MIN_SIZE>
          Minimum element length (in bp) to keep elements that were not merged after the first compression.
          
          Compression is first performed. Elements that remain unmerged and are shorter than this length are then removed, and compression is performed again.
          
          [default: 0]

  -s, --no-group-by
          If set every path is treated as its own genome

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

