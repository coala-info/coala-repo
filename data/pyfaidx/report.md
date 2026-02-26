# pyfaidx CWL Generation Report

## pyfaidx_faidx

### Tool Description
Fetch sequences from FASTA. If no regions are specified, all entries in the
input file are returned. Input FASTA file must be consistently line-wrapped,
and line wrapping of output is based on input line lengths.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfaidx:0.9.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/mdshw5/pyfaidx
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfaidx/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyfaidx/overview
- **Total Downloads**: 778.2K
- **Last updated**: 2025-09-03
- **GitHub**: https://github.com/mdshw5/pyfaidx
- **Stars**: N/A
### Original Help Text
```text
usage: faidx [-h] [-b BED] [-o OUT]
             [-i {bed,chromsizes,nucleotide,transposed}] [-c] [-r] [-y]
             [-a SIZE_RANGE] [-n | -f] [-t] [-x] [-l] [-s DEFAULT_SEQ]
             [-d DELIMITER] [-e HEADER_FUNCTION]
             [-u {stop,first,last,longest,shortest}] [-g REGEX] [-v] [-m | -M]
             [--no-output] [--no-rebuild] [--version]
             fasta [regions ...]

Fetch sequences from FASTA. If no regions are specified, all entries in the
input file are returned. Input FASTA file must be consistently line-wrapped,
and line wrapping of output is based on input line lengths.

positional arguments:
  fasta                 FASTA file
  regions               space separated regions of sequence to fetch e.g.
                        chr1:1-1000

options:
  -h, --help            show this help message and exit
  --no-rebuild          do not rebuild the .fai index even if it is out of
                        date. default: False
  --version             print pyfaidx version number

input options:
  -b, --bed BED         bed file of regions (zero-based start coordinate)

output options:
  -o, --out OUT         output file name (default: stdout)
  -i, --transform {bed,chromsizes,nucleotide,transposed}
                        transform the requested regions into another format.
                        default: None
  -c, --complement      complement the sequence. default: False
  -r, --reverse         reverse the sequence. default: False
  -y, --auto-strand     reverse complement the sequence when start > end
                        coordinate. default: False
  -a, --size-range SIZE_RANGE
                        selected sequences are in the size range [low, high].
                        example: 1,1000 default: None
  -x, --split-files     write each region to a separate file (names are
                        derived from regions)
  -l, --lazy            fill in --default-seq for missing ranges. default:
                        False
  -s, --default-seq DEFAULT_SEQ
                        default base for missing positions and masking.
                        default: None
  -m, --mask-with-default-seq
                        mask the FASTA file using --default-seq default: False
  -M, --mask-by-case    mask the FASTA file by changing to lowercase. default:
                        False
  --no-output           do not output any sequence. default: False

header options:
  -n, --no-names        omit sequence names from output. default: False
  -f, --long-names      output full (long) names from the input fasta headers.
                        default: headers are truncated after the first
                        whitespace
  -t, --no-coords       omit coordinates (e.g. chr:start-end) from output
                        headers. default: False
  -d, --delimiter DELIMITER
                        delimiter for splitting names to multiple values
                        (duplicate names will be discarded). default: None
  -e, --header-function HEADER_FUNCTION
                        python function to modify header lines e.g: "lambda x:
                        x.split("|")[0]". default: lambda x: x.split()[0]
  -u, --duplicates-action {stop,first,last,longest,shortest}
                        entry to take when duplicate sequence names are
                        encountered. default: stop

matching arguments:
  -g, --regex REGEX     selected sequences are those matching regular
                        expression. default: .*
  -v, --invert-match    selected sequences are those not matching 'regions'
                        argument. default: False

Please cite: Shirley MD, Ma Z, Pedersen BS, Wheelan SJ. (2015) Efficient
"pythonic" access to FASTA files using pyfaidx. PeerJ PrePrints 3:e1196
https://dx.doi.org/10.7287/peerj.preprints.970v1
```

