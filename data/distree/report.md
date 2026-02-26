# distree CWL Generation Report

## distree

### Tool Description
Extracts a distance matrix from a phylogeny (parallel, low-memory)

### Metadata
- **Docker Image**: quay.io/biocontainers/distree:1.0.0--h4349ce8_0
- **Homepage**: https://github.com/PathoGenOmics-Lab/distree
- **Package**: https://anaconda.org/channels/bioconda/packages/distree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/distree/overview
- **Total Downloads**: 212
- **Last updated**: 2025-08-12
- **GitHub**: https://github.com/PathoGenOmics-Lab/distree
- **Stars**: N/A
### Original Help Text
```text
Extracts a distance matrix from a phylogeny (parallel, low-memory)

Usage: distree [OPTIONS] <phylogeny>

Arguments:
  <phylogeny>  Path to the tree file in Newick format

Options:
      --format <format>  Tree file format (only 'newick' is supported) [default: newick] [possible values: newick]
      --midpoint         Midpoint-root the tree before computing distances
      --lmm              Produce the var-covar matrix C (depth of the MRCA in branch lengths)
      --topology         Ignore branch lengths; use purely topological distances
  -o, --output <FILE>    Path to write the TSV output file (defaults to stdout)
  -h, --help             Print help
  -V, --version          Print version
```

