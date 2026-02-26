# parallel-virfinder CWL Generation Report

## parallel-virfinder_parallel-virfinder.py

### Tool Description
Execute virfinder on a FASTA file in parallel

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-virfinder:0.3.1--py310hdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/parallel-virfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-virfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/parallel-virfinder/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/quadram-institute-bioscience/parallel-virfinder
- **Stars**: N/A
### Original Help Text
```text
usage: parallel-virfinder.py [-h] -i INPUT -o OUTPUT [-f FASTA] [-n PARALLEL]
                             [-t TMPDIR] [-s MIN_SCORE] [-p MAX_P_VALUE]
                             [--version] [--no-check] [-v] [-d]

Execute virfinder on a FASTA file in parallel

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input FASTA file
  -o OUTPUT, --output OUTPUT
                        Output CSV file
  -f FASTA, --fasta FASTA
                        Save FASTA file
  -n PARALLEL, --parallel PARALLEL
                        Number of parallel processes [default: 4]
  -t TMPDIR, --tmpdir TMPDIR
                        Temporary directory [default: /tmp]

VirFinder options:
  -s MIN_SCORE, --min-score MIN_SCORE
                        Minimum score [default: 0.9]
  -p MAX_P_VALUE, --max-p-value MAX_P_VALUE
                        Maximum p-value [default: 0.05]

Running options:
  --version             show program's version number and exit
  --no-check            Do not check dependencies at startup
  -v, --verbose         Verbose output
  -d, --debug           Debug output and do not remove temporary files
```

