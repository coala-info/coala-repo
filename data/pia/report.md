# pia CWL Generation Report

## pia

### Tool Description
PIA - Protein Inference Algorithms. Performs compilation or analysis of protein search results.

### Metadata
- **Docker Image**: quay.io/biocontainers/pia:1.5.7--hdfd78af_0
- **Homepage**: https://github.com/medbioinf/pia
- **Package**: https://anaconda.org/channels/bioconda/packages/pia/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pia/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-11-13
- **GitHub**: https://github.com/medbioinf/pia
- **Stars**: N/A
### Original Help Text
```text
Usage: PIACli [-chV] [--example] [-n=<name>] [-o=<outfile>] [-t=<threads>]
              [<infile>...]
PIA - Protein Inference Algorithms.
      [<infile>...]         input file(s): search results for the compilation,
                              json and intermediate file for analysis. For the
                              search results, possible further information can
                              be passed, separated by semicolon. The
                              information is in this order:
                            	name of the input file (if not given will be set
                              to the path of the input file),
                            	type of the file (usually guessed, but may also be
                              explicitly given, possible values are e.g. mzid,
                              xtandem),
                            	additional information file (very seldom used)
  -c, --compile             perform a compilation, otherwise perform analysis
      --example             returns an example json for a PIA analysis
  -h, --help                Show this help message and exit.
  -n, --name=<name>         name of the compilation
  -o, --outfile=<outfile>   output file name (e.g. intermediate PIA file)
  -t, --threads=<threads>   maximum number of used threads for compilation (0
                              for use all)
  -V, --version             Print version information and exit.
```


## Metadata
- **Skill**: not generated
