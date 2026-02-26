# pywgsim CWL Generation Report

## pywgsim

### Tool Description
Short read simulator for paired end reads based on wgsim.

### Metadata
- **Docker Image**: quay.io/biocontainers/pywgsim:0.6.0--py310h397c9d8_0
- **Homepage**: https://github.com/ialbert/pywgsim
- **Package**: https://anaconda.org/channels/bioconda/packages/pywgsim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pywgsim/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-06-12
- **GitHub**: https://github.com/ialbert/pywgsim
- **Stars**: N/A
### Original Help Text
```text
usage: pywgsim [-h] [-e 0.02] [-D 500] [-s 50] [-N 1000] [-1 70] [-2 70]
               [-r 0.001] [-R 0.15] [-X 0.25] [-S 0] [-A 0.05] [-f] [-v]
               [-g None]
               genome [read1] [read2]

Short read simulator for paired end reads based on wgsim.

positional arguments:
  genome                FASTA reference sequence
  read1                 FASTQ file for first in pair (read1.fq)
  read2                 FASTQ file for second in pair (read2.fq)

options:
  -h, --help            show this help message and exit
  -e 0.02, --err 0.02   the base error rate
  -D 500, --dist 500    outer distance between the two ends
  -s 50, --stdev 50     standard deviation
  -N 1000, --num 1000   number of read pairs
  -1 70, --L1 70        length of the first read
  -2 70, --L2 70        length of the second read
  -r 0.001, --mut 0.001
                        rate of mutations
  -R 0.15, --frac 0.15  fraction of indels
  -X 0.25, --ext 0.25   probability an indel is extended
  -S 0, --seed 0        seed for the random generator
  -A 0.05, --amb 0.05   disregard if the fraction of ambiguous bases higher
                        than FLOAT
  -f, --fixed           each chromosome gets N sequences
  -v, --version         print version number
  -g None, --gff None   GFF output file (default: stdout)
```

