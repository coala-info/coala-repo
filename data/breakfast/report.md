# breakfast CWL Generation Report

## breakfast

### Tool Description
Options:

### Metadata
- **Docker Image**: quay.io/biocontainers/breakfast:0.4.6--pyhdfd78af_0
- **Homepage**: https://github.com/rki-mf1/breakfast
- **Package**: https://anaconda.org/channels/bioconda/packages/breakfast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/breakfast/overview
- **Total Downloads**: 14.6K
- **Last updated**: 2025-07-10
- **GitHub**: https://github.com/rki-mf1/breakfast
- **Stars**: N/A
### Original Help Text
```text
Usage: breakfast [OPTIONS]

Options:
  --input-file PATH               Input file  [required]
  --sep TEXT                      Input file separator  [default:         ]
  --outdir PATH                   Output directory for all output files
                                  [default: output]
  --max-dist INTEGER RANGE        Maximum parwise distance  [default: 1; x>=0]
  --min-cluster-size INTEGER RANGE
                                  Minimum cluster size  [default: 2; x>=1]
  --input-cache PATH              Input cached pickle file from previous run
  --output-cache PATH             Path to Output cached pickle file
  --id-col TEXT                   Column with the sequence identifier
                                  [default: accession]
  --clust-col TEXT                Metadata column to cluster  [default:
                                  dna_profile]
  --var-type [covsonar_dna|covsonar_aa|nextclade_dna|nextclade_aa|raw]
                                  Type of variants  [default: covsonar_dna]
  --sep2 TEXT                     Secondary clustering column separator
                                  (between each mutation)  [default:  ]
  --trim-start INTEGER RANGE      Bases to trim from the beginning (0 =
                                  disable)  [default: 264; x>=0]
  --trim-end INTEGER RANGE        Bases to trim from the end (0 = disable)
                                  [default: 228; x>=0]
  --reference-length INTEGER RANGE
                                  Length of reference genome (defaults to
                                  NC_045512.2 length)  [default: 29903; x>=0]
  --skip-del / --no-skip-del      Skip deletions  [default: skip-del]
  --skip-ins / --no-skip-ins      Skip insertions  [default: skip-ins]
  --jobs INTEGER RANGE            Number of jobs (threads) to run
                                  simultaneously  [default: 1; x>=1]
  --version                       Show the version and exit.
  --help                          Show this message and exit.
```

