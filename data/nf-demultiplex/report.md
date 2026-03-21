# demultiplex CWL Generation Report

## demultiplex_guess

### Tool Description
Retrieve the most frequent barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/demultiplex:1.2.2--pyhdfd78af_1
- **Homepage**: https://github.com/jfjlaros/demultiplex
- **Package**: https://anaconda.org/channels/bioconda/packages/demultiplex/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/demultiplex/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-06-25
- **GitHub**: https://github.com/jfjlaros/demultiplex
- **Stars**: N/A
### Original Help Text
```text
usage: demultiplex guess [-h] [-r] [--format {normal,x,umi,unknown}]
                         [-s START] [-e END] [-o OUTPUT] [-n SAMPLE_SIZE] [-f]
                         [-t THRESHOLD]
                         INPUT

Retrieve the most frequent barcodes.

positional arguments:
  INPUT                 input file

options:
  -h, --help            show this help message and exit
  -r                    extract the barcodes from the read (default: False)
  --format {normal,x,umi,unknown}
                        provdide the header format (default: None)
  -s START              start of the selection (default: None)
  -e END                end of the selection (default: None)
  -o OUTPUT             output file (default: -)
  -n SAMPLE_SIZE        sample size (default: 1000000)
  -f                    select on frequency instead of a fixed amount
                        (default: False)
  -t THRESHOLD          threshold for the selection method (default: 12)
```


## demultiplex_demux

### Tool Description
Demultiplex any number of files given a list of barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/demultiplex:1.2.2--pyhdfd78af_1
- **Homepage**: https://github.com/jfjlaros/demultiplex
- **Package**: https://anaconda.org/channels/bioconda/packages/demultiplex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: demultiplex demux [-h] [-r] [--format {normal,x,umi,unknown}]
                         [-s START] [-e END] [-m MISMATCH] [-d] [-p PATH]
                         BARCODES INPUT [INPUT ...]

Demultiplex any number of files given a list of barcodes.

positional arguments:
  BARCODES              barcodes file
  INPUT                 input files

options:
  -h, --help            show this help message and exit
  -r                    extract the barcodes from the read (default: False)
  --format {normal,x,umi,unknown}
                        provdide the header format (default: None)
  -s START              start of the selection (default: None)
  -e END                end of the selection (default: None)
  -m MISMATCH           number of mismatches (default: 1)
  -d                    use Levenshtein distance (default: False)
  -p PATH               output directory (default: .)
```


## demultiplex_match

### Tool Description
Demultiplex reads based on barcode matching.

### Metadata
- **Docker Image**: quay.io/biocontainers/demultiplex:1.2.2--pyhdfd78af_1
- **Homepage**: https://github.com/jfjlaros/demultiplex
- **Package**: https://anaconda.org/channels/bioconda/packages/demultiplex/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.12/site-packages/demultiplex/__init__.py:1: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import get_distribution
usage: demultiplex match [-h] [-m MISMATCH] [-d] [-p PATH] [-f]
                         BARCODES INPUT [INPUT ...]
demultiplex match: error: the following arguments are required: BARCODES, INPUT
```

