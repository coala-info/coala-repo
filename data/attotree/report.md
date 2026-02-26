# attotree CWL Generation Report

## attotree

### Tool Description
rapid estimation of phylogenetic trees using sketching

### Metadata
- **Docker Image**: quay.io/biocontainers/attotree:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/karel-brinda/attotree
- **Package**: https://anaconda.org/channels/bioconda/packages/attotree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/attotree/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/karel-brinda/attotree
- **Stars**: N/A
### Original Help Text
```text
Program: attotree (rapid estimation of phylogenetic trees using sketching)
Version: 0.1.6
Author:  Karel Brinda <karel.brinda@inria.fr>

usage: attotree [-k INT] [-s INT] [-t INT] [-o FILE] [-m STR] [-d DIR] [-L] [-D] [-V]
                genome [genome ...]

positional arguments:
  genome      input genome file(s) (fasta / gzipped fasta / list of files when "-L")

options:
  -h          show this help message and exit
  -v          show program's version number and exit
  -k INT      kmer size [21]
  -s INT      sketch size [10000]
  -t INT      number of threads [#cores, 20]
  -o FILE     newick output [-]
  -m STR      tree construction method (nj/upgma) [nj]
  -d DIR      tmp dir [default system, /tmp...]
  -L          input files are list(s) of files
  -D          debugging (don't remove tmp dir)
  -V          verbose output
```

