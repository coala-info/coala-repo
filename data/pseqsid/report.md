# pseqsid CWL Generation Report

## pseqsid

### Tool Description
Calculates pairwise sequence identity, similarity and normalized similarity score of proteins in a multiple sequence alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/pseqsid:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/amaurypm/pseqsid
- **Package**: https://anaconda.org/channels/bioconda/packages/pseqsid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pseqsid/overview
- **Total Downloads**: 769
- **Last updated**: 2026-02-17
- **GitHub**: https://github.com/amaurypm/pseqsid
- **Stars**: N/A
### Original Help Text
```text
pseqsid 1.1.0
Calculates pairwise sequence identity, similarity and normalized similarity score of proteins in a
multiple sequence alignment.

USAGE:
    pseqsid [OPTIONS] <MSA>

ARGS:
    <MSA>    Multiple Sequence Alignment file

OPTIONS:
    -i, --identity               Calculate pairwise sequence identity
    -s, --similarity             Calculate pairwise sequence similarity
    -n, --nss                    Calculate pairwise sequence Normalized Similarity Score
    -l, --length <LENGTH>        Sequence length to be use for identity and similarity calculations
                                 [default: smallest] [possible values: smallest, mean, largest,
                                 alignment]
    -g, --grouping <GROUPING>    Similarity amino acid grouping definition file. A default one is
                                 created if required and not provided
    -m, --matrix <MATRIX>        Type of matrix to be used for Normalized Similarity Score [default:
                                 blosum62] [possible values: blosum62, pam250, gonnet]
    -p, --po <PO>                Gap opening penalty (Po) [default: 10.0]
    -e, --pe <PE>                Gap extending penalty (Pe) [default: 0.5]
    -t, --threads <THREADS>      Number of threads to use. 0 use all available threads [default: 0]
    -h, --help                   Print help information
    -V, --version                Print version information
```

