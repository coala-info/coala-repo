# linkstats CWL Generation Report

## linkstats_LinkStats

### Tool Description
Collect and process statistics from aligned linked-reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/linkstats:0.1.3--py310h82d6cb0_6
- **Homepage**: https://github.com/wtsi-hpag/LinkStats
- **Package**: https://anaconda.org/channels/bioconda/packages/linkstats/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/linkstats/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wtsi-hpag/LinkStats
- **Stars**: N/A
### Original Help Text
```text
Usage: LinkStats [OPTIONS] COMMAND1 [ARGS]... [COMMAND2 [ARGS]...]...

  LinkStats 0.1.3

  Collect and process statistics from aligned linked-reads.

  Copyright (c) 2022 Ed Harry, Wellcome Sanger Institute, Genome Research Limited.

  
  Usage Example, read SAM/BAM/CRAM from <stdin> and save the summary and molecule data in csv format. Analyse molecules grouped by 5 and 10 minimum reads per molecule.
  -------------
  ...<sam/bam/cram> | LinkStats -t 16 -m 5 -m 10 sam-data - save-csvs results/csvs/

  Usage Example, combine histogram data from multiple sources into summary plots.
  -------------
  LinkStats -t 16 hist-data results/dataset_1_molecular_length_histograms.csv.bz2 hist-data results/dataset_2_molecular_length_histograms.csv.bz2 hist-data results/dataset_3_molecular_length_histograms.csv.bz2 save-plots results/plots/

Options:
  -t, --threads INTEGER RANGE    Number of threads to use. Default=4.  [x>=1]
  -m, --min_reads INTEGER RANGE  Minimum reads per molecule for analysis,
                                 multiple values possible. Default=(1, 3, 5,
                                 10).  [x>=1]
  --version                      Show the version and exit.
  --help                         Show this message and exit.

Commands:
  cov-gap-hist-data  Read in coverage gap histogram data from a CSV FILE.
  coverage-data      Read in coverage gap data from a CSV FILE.
  mol-len-hist-data  Read in molecule length histogram data from a CSV FILE.
  molecule-data      Read in molecular data from a CSV FILE.
  sam-data           Read SAM/BAM/CRAM data from PATH.
  save-csvs          Saves summary, molecule or histogram data to CSV...
  save-plots         Generates plots from any histogram data and saves...
```

