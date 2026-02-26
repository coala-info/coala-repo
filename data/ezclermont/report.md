# ezclermont CWL Generation Report

## ezclermont

### Tool Description
run a 'PCR' to get Clermont 2013 phylotypes

### Metadata
- **Docker Image**: quay.io/biocontainers/ezclermont:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/nickp60/ezclermont
- **Package**: https://anaconda.org/channels/bioconda/packages/ezclermont/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ezclermont/overview
- **Total Downloads**: 16.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nickp60/ezclermont
- **Stars**: N/A
### Original Help Text
```text
usage: ezclermont [-m MIN_LENGTH] [-e EXPERIMENT_NAME] [-n]
                  [--logfile LOGFILE] [-h] [--version]
                  contigs

run a 'PCR' to get Clermont 2013 phylotypes; version 0.7.0

positional arguments:
  contigs               FASTA formatted genome or set of contigs. If reading
                        from stdin, use '-'

optional arguments:
  -m MIN_LENGTH, --min_length MIN_LENGTH
                        minimum contig length to consider.default: 500
  -e EXPERIMENT_NAME, --experiment_name EXPERIMENT_NAME
                        name of experiment; defaults to file name without
                        extension. If reading from stdin, uses the first
                        contig's ID
  -n, --no_partial      If scanning contigs, breaks between contigs could
                        potentially contain your sequence of interest. if
                        --no_partial, these plausible partial matches will NOT
                        be reported; default behaviour is to consider partial
                        hits if the assembly has more than 4 sequnces(ie, no
                        partial matches for complete genomes, allowing for 1
                        chromosome and several plasmids)
  --logfile LOGFILE     send log messages to logfile instead stderr
  -h, --help            Displays this help message
  --version             show program's version number and exit
```

