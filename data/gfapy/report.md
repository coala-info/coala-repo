# gfapy CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gfapy_gfapy-convert | PASS | nf-core assembly.gfa converts to GFA2 with 6 S, 2 E and 5 O lines |
| gfapy_gfapy-mergelinear | PASS | nf-core B-3106.gfa goes from 469 to 465 segments; vlevel is now an integer |
| gfapy_gfapy-renumber | PASS | nf-core assembly.gfa segments renumbered 1 to 6 by size |
| gfapy_gfapy-validate | PASS | nf-core assembly.gfa is accepted with no message; a link to a missing segment is reported |

## gfapy_gfapy-convert

### Tool Description
Convert a GFA file to the other specification version

### Metadata
- **Docker Image**: quay.io/biocontainers/gfapy:1.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/ggonnella/gfapy
- **Package**: https://anaconda.org/channels/bioconda/packages/gfapy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gfapy/overview
- **Total Downloads**: 37.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ggonnella/gfapy
- **Stars**: N/A
### Original Help Text
```text
usage: gfapy-convert [-h] [--version] filename

Convert a GFA file to the other specification version

positional arguments:
  filename

options:
  -h, --help  show this help message and exit
  --version   show program's version number and exit
```


## gfapy_gfapy-mergelinear

### Tool Description
Merge linear paths in a GFA graph

### Metadata
- **Docker Image**: quay.io/biocontainers/gfapy:1.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/ggonnella/gfapy
- **Package**: https://anaconda.org/channels/bioconda/packages/gfapy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gfapy-mergelinear [-h] [--redundant] [--no-progress] [--quiet]
                         [--short] [--vlevel VLEVEL] [--version]
                         filename

Merge linear paths in a GFA graph

positional arguments:
  filename

options:
  -h, --help         show this help message and exit
  --redundant, -r    create redundant paths, similar to the contigs
                     constructed by Readjoiner
  --no-progress, -p  do not show progress log
  --quiet, -q        suppress output
  --short            use short names for merged segments
  --vlevel VLEVEL    validation level
  --version          show program's version number and exit
```


## gfapy_gfapy-validate

### Tool Description
Validate a GFA file

### Metadata
- **Docker Image**: quay.io/biocontainers/gfapy:1.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/ggonnella/gfapy
- **Package**: https://anaconda.org/channels/bioconda/packages/gfapy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gfapy-validate [-h] [--version] filename

Validate a GFA file

positional arguments:
  filename

options:
  -h, --help  show this help message and exit
  --version   show program's version number and exit
```


## gfapy_gfapy-renumber

### Tool Description
Renumber the segments of a GFA assembly graph. The largest segment is renamed 01, down to the smallest segment 99. The amount of zero-padding required is determined automatically.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfapy:1.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/ggonnella/gfapy
- **Package**: https://anaconda.org/channels/bioconda/packages/gfapy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gfapy-renumber [-h] [-o OUT] [--version] gfa

Renumber the segments of a GFA assembly graph. The largest segment is renamed
01, down to the smallest segment 99. The amount of zero-padding required is
determined automatically.

positional arguments:
  gfa                input GFA file

options:
  -h, --help         show this help message and exit
  -o OUT, --out OUT  output GFA file [/dev/stdout]
  --version          show program's version number and exit
```

## Metadata
- **Skill**: generated
