# sapling CWL Generation Report

## sapling

### Tool Description
Sapling is an algorithm for summarizing and inferring tumor phylogenies from
bulk DNA sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/sapling:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/elkebir-group/Sapling
- **Package**: https://anaconda.org/channels/bioconda/packages/sapling/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sapling/overview
- **Total Downloads**: 36
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/elkebir-group/Sapling
- **Stars**: N/A
### Original Help Text
```text
usage: sapling [-h] -f F [--init_trees INIT_TREES] [-o O] [--sep SEP] [-a RHO]
               [-t TAU] [-l ELL] [--big_expand] [-b BEAM_WIDTH]
               [-L {cvxopt,pLP,fastppm}] [--alt_roots] [-m] [--use_clusters]
               [--version]

Sapling is an algorithm for summarizing and inferring tumor phylogenies from
bulk DNA sequencing data

options:
  -h, --help            show this help message and exit
  -f F                  Input filename with mutation read counts (use '-' for
                        STDIN)
  --init_trees INIT_TREES
                        Input filename with initial backbone trees to expand
  -o O                  Output filename to store trees and frequencies
                        (default: STDOUT)
  --sep SEP             Input/output column separator (default: \t)
  -a RHO, --rho RHO     Rho parameter, minimum deviation allowed from max
                        likelihood (default: 0.9, ignored when beam_width
                        specified)
  -t TAU, --tau TAU     Tau parameter, maximum number of backbone trees
                        (default: 5)
  -l ELL, --ell ELL     Ell parameter, minimum number of mutations (default:
                        -1, unlimited)
  --big_expand          Use big expand (new mutations are anywhere, not just
                        as leaves or splitting a single edge)
  -b BEAM_WIDTH, --beam_width BEAM_WIDTH
                        Maximum beam width (default: -1, limited only by
                        --rho)
  -L {cvxopt,pLP,fastppm}
                        Regression method (default: fastppm)
  --alt_roots           Explore alternative root nodes
  -m, --poly_clonal_root
                        Allow poly clonal root node
  --use_clusters        Use provided clustering (taking median read depth and
                        using average frequency for variant counts)
  --version             Show program's version number and exit
```

