# python3-pyfaidx CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| python3-pyfaidx | PASS |  |

## python3-pyfaidx

### Tool Description
Fetch sequences from FASTA files by region (pyfaidx).

### Metadata
- **Docker Image**: biocontainers/python3-pyfaidx:v0.4.8.1-1-deb_cv1
- **Homepage**: https://github.com/mdshw5/pyfaidx
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/python3-pyfaidx/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: faidx [-h] [-b BED] [-o OUT]
             [-i {bed,chromsizes,nucleotide,transposed}] [-c] [-r]
             [-a SIZE_RANGE] [-n | -f] [-x] [-l] [-s DEFAULT_SEQ]
             [-d DELIMITER] [-g REGEX | -v] [-m | -M] [--no-rebuild]
             [--version]
             fasta [regions [regions ...]]

Fetch sequences from FASTA. If no regions are specified, all entries in the
input file are returned. Input FASTA file must be consistently line-wrapped,
and line wrapping of output is based on input line lengths.

positional arguments:
  fasta                 FASTA file
  regions               space separated regions of sequence to fetch e.g.
                        chr1:1-1000

optional arguments:
  -h, --help            show this help message and exit
  -b BED, --bed BED     bed file of regions
  -o OUT, --out OUT     output file name (default: stdout)
  -i {bed,chromsizes,nucleotide,transposed}, --transform {bed,chromsizes,nucleotide,transposed}
                        transform the requested regions into another format.
                        default: None
  -c, --complement      complement the sequence. default: False
  -r, --reverse         reverse the sequence. default: False
  -a SIZE_RANGE, --size-range SIZE_RANGE
                        selected sequences are in the size range [low, high].
                        example: 1,1000 default: None
  -n, --no-names        omit sequence names from output. default: False
  -f, --full-names      output full names including description. default:
                        False
  -x, --split-files     write each region to a separate file (names are
                        derived from regions)
  -l, --lazy            fill in --default-seq for missing ranges. default:
                        False
  -s DEFAULT_SEQ, --default-seq DEFAULT_SEQ
                        default base for missing positions and masking.
                        default: N
  -d DELIMITER, --delimiter DELIMITER
                        delimiter for splitting names to multiple values
                        (duplicate names will be discarded). default: None
  -g REGEX, --regex REGEX
                        selected sequences are those matching regular
                        expression. default: .*
  -v, --invert-match    selected sequences are those not matching 'regions'
                        argument. default: False
  -m, --mask-with-default-seq
                        mask the FASTA file using --default-seq default: False
  -M, --mask-by-case    mask the FASTA file by changing to lowercase. default:
                        False
  --no-rebuild          do not rebuild the .fai index even if it is out of
                        date. default: False
  --version             print pyfaidx version number

Please cite: Shirley MD, Ma Z, Pedersen BS, Wheelan SJ. (2015) Efficient
"pythonic" access to FASTA files using pyfaidx. PeerJ PrePrints 3:e1196
https://dx.doi.org/10.7287/peerj.preprints.970v1
```


## Metadata
- **Skill**: not generated
