# cdst CWL Generation Report

## cdst_run

### Tool Description
Run CDS analysis pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/cdst:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/l1-mh/CDST
- **Package**: https://anaconda.org/channels/bioconda/packages/cdst/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cdst/overview
- **Total Downloads**: 64
- **Last updated**: 2025-09-10
- **GitHub**: https://github.com/l1-mh/CDST
- **Stars**: N/A
### Original Help Text
```text
usage: cdst run [-h] -i INPUT [INPUT ...] -o OUTPUT [-L MIN_CDS_LEN]
                [-T {mst,hc,both}] [-v]

options:
  -h, --help            show this help message and exit
  -i, --input INPUT [INPUT ...]
                        Input CDS FASTA files
  -o, --output OUTPUT   Output directory
  -L, --min-cds-len MIN_CDS_LEN
                        Minimum CDS length
  -T, --tree {mst,hc,both}
                        Tree type to generate (default: both)
  -v, --verbose         Verbose output
```


## cdst_generate

### Tool Description
Generate CDS files

### Metadata
- **Docker Image**: quay.io/biocontainers/cdst:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/l1-mh/CDST
- **Package**: https://anaconda.org/channels/bioconda/packages/cdst/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdst generate [-h] -i INPUT [INPUT ...] -o OUTPUT [-L MIN_CDS_LEN] [-v]

options:
  -h, --help            show this help message and exit
  -i, --input INPUT [INPUT ...]
                        Input CDS FASTA files
  -o, --output OUTPUT   Output directory
  -L, --min-cds-len MIN_CDS_LEN
                        Minimum CDS length
  -v, --verbose         Verbose output
```


## cdst_matrix

### Tool Description
Generate a matrix from JSON input.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdst:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/l1-mh/CDST
- **Package**: https://anaconda.org/channels/bioconda/packages/cdst/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdst matrix [-h] -j JSON -o OUTPUT [-v]

options:
  -h, --help           show this help message and exit
  -j, --json JSON      Input JSON file of MD5 hash lists
  -o, --output OUTPUT  Output directory
  -v, --verbose        Verbose output
```


## cdst_mst

### Tool Description
Compute the Minimum Spanning Tree (MST) of a difference matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdst:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/l1-mh/CDST
- **Package**: https://anaconda.org/channels/bioconda/packages/cdst/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdst mst [-h] -m MATRIX -o OUTPUT

options:
  -h, --help           show this help message and exit
  -m, --matrix MATRIX  Input difference matrix CSV
  -o, --output OUTPUT  Output directory
```


## cdst_hc

### Tool Description
Performs hierarchical clustering on a difference matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdst:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/l1-mh/CDST
- **Package**: https://anaconda.org/channels/bioconda/packages/cdst/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdst hc [-h] -m MATRIX -o OUTPUT

options:
  -h, --help           show this help message and exit
  -m, --matrix MATRIX  Input difference matrix CSV
  -o, --output OUTPUT  Output directory
```


## Metadata
- **Skill**: generated
