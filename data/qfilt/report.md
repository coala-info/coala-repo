# qfilt CWL Generation Report

## qfilt

### Tool Description
filter sequencing data using some simple heuristics

### Metadata
- **Docker Image**: quay.io/biocontainers/qfilt:0.0.1--h9948957_7
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/qfilt/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: qfilt [-h] [-v] [-o OUTPUT] [-q QSCORE] [-l LENGTH] [-m MODE] [-s] [-p] [-a] [-P CHAR] [-T PREFIX] [-t MISMATCH] [-R COUNT] [-f] [-j] ( -F FASTA QUAL | -Q FASTQ )

filter sequencing data using some simple heuristics

required arguments:
  -F FASTA QUAL            FASTA and QUAL files
  -Q FASTQ                 FASTQ file

optional arguments:
  -h, --help               show this help message and exit
  -v, --version            show current version and exit
  -o OUTPUT                direct retained fragments to a file named OUTPUT (default=stdout)
  -q QSCORE                minimum per-base quality score below which a read will be split
                           or truncated (default=20)
  -l LENGTH                minimum retained fragment LENGTH (default=50)
  -m MODE                  MODE is a 3-bitmask (an integer in [0-7], default=0):
                           if the lowest bit is set, it is like passing -s;
                           if the middle bit is set, it is like passing -p;
                           and if the highest bit is set, it is like passing -a
  -s                       when encountering a low q-score, split instead of truncate
  -p                       tolerate low q-score homopolymeric regions
  -a                       tolerate low q-score ambiguous nucleotides
  -P CHAR                  rather than splitting or truncating, replace low quality bases with CHAR
                           this option OVERRIDES all -m mode options
  -R COUNT                 rather than splitting or truncating, remove reads which 
                           contain more than COUNT low quality bases
                           this option only works in COMBINATION with the -P (punch) option
  -T PREFIX                if supplied, only reads with this PREFIX are retained,
                           and the PREFIX is stripped from each contributing read
  -t MISMATCH              if PREFIX is supplied, prefix matching tolerates at most
                           MISMATCH mismatches (default=0)
  -f FORMAT                output in FASTA or FASTQ format (default=FASTA)
  -j                       output run diagnostics to stderr as JSON (default is to write ASCII text)
```

