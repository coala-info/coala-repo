# uropa CWL Generation Report

## uropa

### Tool Description
UROPA - Universal RObust Peak Annotator. UROPA is a peak annotation tool facilitating the analysis of next-generation sequencing methods such as ChIPseq and ATACseq. The advantage of UROPA is that it can accommodate advanced structures of annotation requirements. UROPA is developed as an open source analysis pipeline for peaks generated from standard peak callers.

### Metadata
- **Docker Image**: quay.io/biocontainers/uropa:4.0.3--pyhdfd78af_0
- **Homepage**: https://github.molgen.mpg.de/loosolab/UROPA
- **Package**: https://anaconda.org/channels/bioconda/packages/uropa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/uropa/overview
- **Total Downloads**: 68.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: uropa [-h] [-b] [-g] [--feature [...]] [--feature-anchor [...]] [--distance [...]]
             [--strand] [--relative-location [...]] [--internals] [--filter-attribute]
             [--attribute-values [...]] [--show-attributes [...]] [-i config.json] [-p]
             [-o] [--output-by-query] [-s] [-t n] [-l uropa.log] [-d] [-v] [-c]

UROPA - Universal RObust Peak Annotator.

options:
  -h, --help                       show this help message and exit

Arguments for one query:
  -b , --bed                       Filename of .bed-file to annotate
  -g , --gtf                       Filename of .gtf-file with features
  --feature [ ...]                 Feature for annotation
  --feature-anchor [ ...]          Specific feature anchor to annotate to
  --distance [ ...]                Maximum permitted distance from feature (1 or 2
                                   arguments)
  --strand                         Desired strand of annotated feature relative to peak
  --relative-location [ ...]       Peak location relative to feature location
  --internals                      Set minimum overlap fraction for internal feature
                                   annotations. 0 equates to internals=False and 1 equates
                                   to internals=True. Default is False.
  --filter-attribute               Filter on 9th column of GTF
  --attribute-values [ ...]        Value(s) of attribute corresponding to --filter-
                                   attribute
  --show-attributes [ ...]         A list of attributes to show in output (default: all)

Multi-query configuration file:
  -i config.json, --input config.json
                                   Filename of configuration file (keys in this file
                                   overwrite command-line arguments about query)

Additional arguments:
  -p , --prefix                    Prefix for result file names (defaults to basename of
                                   .bed-file)
  -o , --outdir                    Output directory for output files (default: current
                                   dir)
  --output-by-query                Additionally create output files for each named query
                                   seperately
  -s, --summary                    Create additional visualisation of results in graphical
                                   format
  -t n, --threads n                Multiprocessed run: n = number of threads to run
                                   annotation process
  -l uropa.log, --log uropa.log    Log file name for messages and warnings (default: log
                                   is written to stdout)
  -d, --debug                      Print verbose messages (for debugging)
  -v, --version                    Prints the version and exits
  -c , --chunk                     Number of lines per chunk for multiprocessing (default:
                                   1000)

UROPA is a peak annotation tool facilitating the analysis of next-generation sequencing methods such
as ChIPseq and ATACseq. The advantage of UROPA is that it can accommodate advanced structures of annotation
requirements. UROPA is developed as an open source analysis pipeline for peaks generated from standard peak callers.

Please cite upon usage:
Kondili M, Fust A, Preussner J, Kuenne C, Braun T and Looso M. UROPA: A tool for Universal RObust Peak Annotation.
Scientific Reports 7 (2017), doi: 10.1038/s41598-017-02464-y

Please visit http://uropa-manual.readthedocs.io/config.html for detailed information on configuration.
```

