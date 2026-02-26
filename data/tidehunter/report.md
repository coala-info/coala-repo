# tidehunter CWL Generation Report

## tidehunter_TideHunter

### Tool Description
Tandem repeats detection and consensus calling from noisy long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/tidehunter:1.5.5--h5ca1c30_3
- **Homepage**: https://github.com/yangao07/TideHunter
- **Package**: https://anaconda.org/channels/bioconda/packages/tidehunter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tidehunter/overview
- **Total Downloads**: 41.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yangao07/TideHunter
- **Stars**: N/A
### Original Help Text
```text
[main] Error: please specify an input file.

TideHunter: Tandem repeats detection and consensus calling from noisy long reads

Version: 1.5.5	Contact: gaoy1@chop.edu

Usage:   TideHunter [options] in.fa/fq > cons.fa

Options: 
  Seeding:
    -k --kmer-length INT    k-mer length (no larger than 16) [8]
    -w --window-size INT    window size, set as >1 to enable minimizer seeding [1]
    -H --HPC-kmer           use homopolymer-compressed k-mer [False]
  Tandem repeat criteria:
    -c --min-copy    INT    minimum copy number of tandem repeat (>=2) [2]
    -e --max-diverg  INT    maximum allowed divergence rate between two consecutive repeats [0.25]
    -p --min-period  INT    minimum period size of tandem repeat (>=2) [30]
    -P --max-period  INT    maximum period size of tandem repeat (<=4294967295) [10K]
  Scoring parameters for partial order alignment:
    -M --match    INT       match score [2]
    -X --mismatch INT       mismatch penalty [4]
    -O --gap-open INT(,INT) gap opening penalty (O1,O2) [4,24]
    -E --gap-ext  INT(,INT) gap extension penalty (E1,E2) [2,1]
                            TideHunter provides three gap penalty modes, cost of a [4mg[0m-long gap:
                            - convex (default): min{[4mO1[0m+[4mg[0m*[4mE1[0m, [4mO2[0m+[4mg[0m*[4mE2[0m}
                            - affine (set [4mO2[0m as 0): [4mO1[0m+[4mg[0m*[4mE1[0m
                            - linear (set [4mO1[0m as 0): [4mg[0m*[4mE1[0m
  Adapter sequence:
    -5 --five-prime  STR    5' adapter sequence (sense strand) [NULL]
    -3 --three-prime STR    3' adapter sequence (anti-sense strand) [NULL]
    -a --ada-mat-rat FLT    minimum match ratio of adapter sequence [0.80]
  Output:
    -o --output      STR    output file [stdout]
    -m --min-len     INT    only output consensus sequence with min. length of [30]
    -r --min-cov  FLOAT|INT only output consensus sequence with at least [4mR[0m supporting units for all bases: [0.00]
                            if [4mr[0m is fraction: [4mR[0m = [4mr[0m * total copy number
                            if [4mr[0m is integer: [4mR[0m = [4mr[0m
    -u --unit-seq           only output unit sequences of each tandem repeat, no consensus sequence [False]
    -l --longest            only output consensus sequence of tandem repeat that covers the longest read sequence [False]
    -F --full-len           only output full-length consensus sequence. [False]
                            full-length: consensus sequence contains both 5' and 3' adapter sequence
                            *Note* only effective when -5 and -3 are provided.
    -s --single-copy        output additional single-copy full-length consensus sequence. [False]
                            *Note* only effective when -F is set and -5 and -3 are provided.
    -f --out-fmt     INT    output format [1]
                            - 1: FASTA
                            - 2: Tabular
                            - 3: FASTQ
                            - 4: Tabular with quality score
                              for [3] and [4], qualiy score of each base represents the ratio of the consensus coverage to the # total copies.
  Computing resource:
    -t --thread      INT    number of threads to use [4]

  General options:
    -h --help               print this help usage information
    -v --version            show version number
```

