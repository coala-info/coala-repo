# ogtfinder CWL Generation Report

## ogtfinder

### Tool Description
Optimal growth temperature prediction using proteome-derived features

### Metadata
- **Docker Image**: quay.io/biocontainers/ogtfinder:0.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/SC-Git1/OGTFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/ogtfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ogtfinder/overview
- **Total Downloads**: 551
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SC-Git1/OGTFinder
- **Stars**: N/A
### Original Help Text
```text
usage: ogtfinder [-h] [--domain {Bacteria,Archaea}] [-o OUTDIR] [--force]
                 [--verbose {0,1,2}] [-v] [--debug]
                 <proteome.fasta>

Optimal growth temperature prediction using proteome-derived features

positional arguments:
  <proteome.fasta>

options:
  -h, --help            Show this help message and exit
  --domain {Bacteria,Archaea}
                        Taxonomic domain name (default: Bacteria)
  -o OUTDIR, --outdir OUTDIR
                        Output directory (default: [auto])
  --force               Overwrite output directory (default: OFF)
  --verbose {0,1,2}     Output verbosity. Levels: 0 (silent), 1 (warnings), 2
                        (verbose) (default: 2)
  -v, --version         Show the version and exit
  --debug               Debug mode: also keep intermediate results (default:
                        OFF)
```

