# quatradis CWL Generation Report

## quatradis_tradis

### Tool Description
This script contains a number of tools for running or supporting TraDIS experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
- **Homepage**: https://github.com/quadram-institute-bioscience/QuaTradis
- **Package**: https://anaconda.org/channels/bioconda/packages/quatradis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/quatradis/overview
- **Total Downloads**: 49.8K
- **Last updated**: 2025-09-21
- **GitHub**: https://github.com/quadram-institute-bioscience/QuaTradis
- **Stars**: N/A
### Original Help Text
```text
usage: This script contains a number of tools for running or supporting TraDIS experiments.
       [-h] [--profile] [-V] {plot,compare,pipeline,utils} ...

options:
  -h, --help            show this help message and exit
  --profile             Turn on profiling.  Prints out cumulative time in each function to stdout and to an output file (tradis.profile).  The profile file can be read by tools such as snakeviz.
  -V, --version         Output the software version

Tradis Tools:
  {plot,compare,pipeline,utils}
    plot                TraDIS plot file tools
    compare             Comparative analysis and visualisation of TraDIS experiments (albatradis)
    pipeline            TraDIS pipelines that stitch together other tools in this package.
    utils               Miscellaneous utilities.
```

