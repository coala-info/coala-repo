# carp CWL Generation Report

## carp

### Tool Description
Calculate SCJ CARP index

### Metadata
- **Docker Image**: quay.io/biocontainers/carp:0.1.1--h4349ce8_0
- **Homepage**: https://github.com/gi-bielefeld/scj-carp
- **Package**: https://anaconda.org/channels/bioconda/packages/carp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/carp/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-10-05
- **GitHub**: https://github.com/gi-bielefeld/scj-carp
- **Stars**: N/A
### Original Help Text
```text
Usage: carp [OPTIONS] <--gfa <f>|--unimog <f>>

Options:
  -s, --size-thresh <st>    Size threshold for nodes (nodes of lower sizes are discarded) [default: 0]
  -g, --gfa <f>             Specify input as GFA file.
  -u, --unimog <f>          Specify input as unimog file.
  -a, --write-ancestor <p>  Path to write ancestral adjacencies to.
  -m, --write-measure <p>   Path to write the carp measure to.
  -t, --num-threads <t>     Number of threads to use to calculate SCJ CARP index. [default: 1]
  -h, --help                Print help
```

