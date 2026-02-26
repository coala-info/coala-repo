# pygmes CWL Generation Report

## pygmes

### Tool Description
Evaluate completeness and contamination of a MAG.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygmes:0.1.7--py_0
- **Homepage**: https://github.com/openpaul/pygmes
- **Package**: https://anaconda.org/channels/bioconda/packages/pygmes/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pygmes/overview
- **Total Downloads**: 15.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/openpaul/pygmes
- **Stars**: N/A
### Original Help Text
```text
usage: pygmes [-h] [--input INPUT] --output OUTPUT --db DB [--noclean]
              [--cleanup] [--ncores NCORES] [--meta] [--quiet] [--debug] [-v]

Evaluate completeness and contamination of a MAG.

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        path to the fasta file, or in metagenome mode path to
                        bin folder
  --output OUTPUT, -o OUTPUT
                        Path to the output folder
  --db DB, -d DB        Path to the diamond DB
  --noclean             GeneMark-ES needs clean fasta headers and will fail if
                        you dont proveide them. Set this flag if you don't
                        want pygmes to clean your headers
  --cleanup             Delete everything but the output files
  --ncores NCORES, -n NCORES
                        Number of threads to use with GeneMark-ES and Diamond
  --meta                Run in metaegnomic mode
  --quiet, -q           Silcence most output
  --debug               Debug and thus ignore safety
  -v, --version         show program's version number and exit
```


## Metadata
- **Skill**: generated
