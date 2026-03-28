# owl CWL Generation Report

## owl_profile

### Tool Description
Profile a BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/owl:0.4.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/owl
- **Package**: https://anaconda.org/channels/bioconda/packages/owl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/owl/overview
- **Total Downloads**: 287
- **Last updated**: 2026-01-31
- **GitHub**: https://github.com/PacificBiosciences/owl
- **Stars**: N/A
### Original Help Text
```text
Profile a BAM file

Usage: owl profile [OPTIONS] --bam <BAM> --regions <REGIONS>

Options:
  -b, --bam <BAM>                      Input BAM file
  -r, --regions <REGIONS>              Genomic region(s) to score for MSI (bed format with motif)
  -s, --sample <SAMPLE>                Sample name, SM bam tag is default
  -f, --flag <FLAG>                    Filter flag [default: 0]
  -m, --min-mg <MIN_MG>                Min MG [default: 0.98]
  -m, --max-filt-frac <MAX_FILT_FRAC>  Max fraction of filtered reads [default: 0.2]
  -m, --min-cov <MIN_COV>              Min coverage [default: 5]
  -m, --min-mapq <MIN_MAPQ>            Min mapQ [default: 10]
  -m, --min-bq <MIN_BQ>                Min region avg base qual [default: 25]
  -m, --min-idt <MIN_IDT>              Min motif alignment identity [default: 90]
  -k, --keep-lengths                   Keep motif spans in the output in the ln field
  -v, --verbose...                     Verbosity
  -h, --help                           Print help
```


## owl_merge

### Tool Description
Merge multiple profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/owl:0.4.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/owl
- **Package**: https://anaconda.org/channels/bioconda/packages/owl/overview
- **Validation**: PASS

### Original Help Text
```text
Merge multiple profiles

Usage: owl merge [OPTIONS] --files <FILES>...

Options:
  -f, --files <FILES>...  Input files to merge
  -v, --verbose...        Verbosity
  -h, --help              Print help
```


## owl_score

### Tool Description
Score profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/owl:0.4.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/owl
- **Package**: https://anaconda.org/channels/bioconda/packages/owl/overview
- **Validation**: PASS

### Original Help Text
```text
Score profiles

Usage: owl score [OPTIONS] --file <FILE> --prefix <PREFIX>

Options:
  -f, --file <FILE>            Input file to score
  -m, --min-depth <MIN_DEPTH>  Min depth [default: 5]
  -c, --cov <COV>              Coefficient of variance cutoff [default: 5]
  -u, --unphased               Exclude unphased reads
  -m, --minimize               Canonicalize motifs (reverse complement, and rotate, keeping lowest)
  -s, --samples <SAMPLES>...   Only score these samples
  -p, --prefix <PREFIX>        Prefix for output files
  -m, --min-pass <MIN_PASS>    Min percentage sites for QC [default: 50]
  -v, --verbose...             Verbosity
  -h, --help                   Print help
```


## Metadata
- **Skill**: generated
