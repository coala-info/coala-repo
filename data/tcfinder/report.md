# tcfinder CWL Generation Report

## tcfinder

### Tool Description
finds clusters of samples from a list of identifiers within a phylo4 phylogeny (see https://cran.r-project.org/web/packages/phylobase/vignettes/phylobase.html)

### Metadata
- **Docker Image**: quay.io/biocontainers/tcfinder:1.0.0--h4349ce8_0
- **Homepage**: https://github.com/PathoGenOmics-Lab/tcfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/tcfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tcfinder/overview
- **Total Downloads**: 802
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PathoGenOmics-Lab/tcfinder
- **Stars**: N/A
### Original Help Text
```text
tcfinder (transmission cluster finder) finds clusters of samples from a list of identifiers within a phylo4 phylogeny (see https://cran.r-project.org/web/packages/phylobase/vignettes/phylobase.html)

Usage: tcfinder [OPTIONS] --tree <TREE> --targets <TARGETS> --output <OUTPUT>

Options:
  -i, --tree <TREE>                  
  -t, --targets <TARGETS>            
  -o, --output <OUTPUT>              Output CSV file with clustering result
  -s, --minimum-size <MINIMUM_SIZE>  Minimum number of tips (cluster size) [default: 2]
  -p, --minimum-prop <MINIMUM_PROP>  Minimum proportion of targets in cluster [default: 0.9]
  -v, --verbose                      Prints debug messages
  -h, --help                         Print help
  -V, --version                      Print version
```

