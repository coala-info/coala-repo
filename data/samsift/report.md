# samsift CWL Generation Report

## samsift

### Tool Description
advanced filtering and tagging of SAM/BAM alignments using Python expressions

### Metadata
- **Docker Image**: quay.io/biocontainers/samsift:0.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/karel-brinda/samsift
- **Package**: https://anaconda.org/channels/bioconda/packages/samsift/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samsift/overview
- **Total Downloads**: 261.3K
- **Last updated**: 2025-09-19
- **GitHub**: https://github.com/karel-brinda/samsift
- **Stars**: N/A
### Original Help Text
```text
Program: samsift (advanced filtering and tagging of SAM/BAM alignments using Python expressions)
Version: 0.3.1
Author:  Karel Brinda <karel.brinda@inria.fr>

Usage:   samsift [-i FILE] [-o FILE] [-f [PY_EXPR ...]] [-c [PY_CODE ...]] [-m STR] 
                    [-0 [PY_CODE ...]] [-d [PY_EXPR ...]] [-t [PY_EXPR ...]]

Basic options:
  -h, --help        show this help message and exit
  -v, --version     show program's version number and exit
  -i FILE           input SAM/BAM file [-]
  -o FILE           output SAM/BAM file [-]
  -f [PY_EXPR ...]  filtering expression [True]
  -c [PY_CODE ...]  code to be executed (e.g., assigning new tags) [None]
  -m STR            mode: strict (stop on first error)
                          nonstop-keep (keep alignments causing errors)
                          nonstop-remove (remove alignments causing errors) [strict]

Advanced options:
  -0 [PY_CODE ...]  initialization [None]
  -d [PY_EXPR ...]  debugging expression to print [None]
  -t [PY_EXPR ...]  debugging trigger [True]
```

