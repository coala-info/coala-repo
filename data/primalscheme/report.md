# primalscheme CWL Generation Report

## primalscheme_multiplex

### Tool Description
Design a multiplex PCR scheme.

### Metadata
- **Docker Image**: quay.io/biocontainers/primalscheme:1.4.1--pyh7cba7a3_0
- **Homepage**: https://github.com/aresti/primalscheme
- **Package**: https://anaconda.org/channels/bioconda/packages/primalscheme/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/primalscheme/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aresti/primalscheme
- **Stars**: N/A
### Original Help Text
```text
Usage: primalscheme multiplex [OPTIONS] FASTA

  Design a multiplex PCR scheme.

Options:
  -a, --amplicon-size <int>     Amplicon size target. Pass twice to set an
                                exact range, otherwise expect +/- 5.0%.
                                [default: 380, 420; x>=90]
  -o, --outpath <dir>           Path to output directory.  [default: ./output]
  -n, --name <str>              Prefix name for your outputs.  [default:
                                scheme]
  -t, --target-overlap <int>    Target insert overlap size.  [default: 0;
                                x>=0]
  -d, --debug / --no-debug      Set log level DEBUG.
  -f, --force / --no-force      Force output to an existing directory,
                                overwrite files.
  -p, --pinned / --no-pinned    Only consider primers from the first
                                reference.
  -g, --high-gc / --no-high-hc  Use config suitable for high-GC sequences.
  -h, --help                    Show this message and exit.
```

