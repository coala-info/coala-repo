# fstic CWL Generation Report

## fstic

### Tool Description
Calculates pairwise genetic distances between samples using standard estimators.

### Metadata
- **Docker Image**: quay.io/biocontainers/fstic:1.0.0--h4349ce8_0
- **Homepage**: https://github.com/PathoGenOmics-Lab/fstic
- **Package**: https://anaconda.org/channels/bioconda/packages/fstic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fstic/overview
- **Total Downloads**: 252
- **Last updated**: 2025-08-12
- **GitHub**: https://github.com/PathoGenOmics-Lab/fstic
- **Stars**: N/A
### Original Help Text
```text
fstic 1.0.0
Paula Ruiz-Rodriguez <paula.ruiz.rodriguez@csic.es>
Calculates pairwise genetic distances between samples using standard estimators.

USAGE:
    fstic [FLAGS] [OPTIONS] --output <OUTPUT_FILE> --reference <FASTA_FILE> --table <TABLE_FILES>... --table-list <TABLE_LIST> --vcf <VCF_FILES>... --vcf-list <VCF_LIST>

FLAGS:
    -h, --help         Prints help information
        --normalize    Normalize by the number of loci (affects: fst, chord, bray-curtis, jost_d).
    -V, --version      Prints version information

OPTIONS:
    -f, --formula <FORMULA>          The distance formula to use. [default: fst]  [possible values: fst, gst, nei,
                                     chord, bray-curtis, jost_d, reynolds, rogers]
        --min-af <FREQ>              Minimum alternate allele frequency to keep a variant. [default: 0.05]
        --min-alt-reads <AD>         Minimum number of alternate allele reads to keep a variant. [default: 2]
        --min-alt-rev-reads <ADR>    Minimum number of alternate allele reverse reads to keep a variant. [default: 2]
        --min-depth <DP>             Minimum total read depth to keep a variant. [default: 30]
    -o, --output <OUTPUT_FILE>       Output file name for the distance matrix.
    -r, --reference <FASTA_FILE>     Reference FASTA file (required for all inputs).
        --table <TABLE_FILES>...     One or more input table files (format detected by extension: .csv, .tsv, .tab).
        --table-list <TABLE_LIST>    A file containing a list of input table files.
        --vcf <VCF_FILES>...         One or more input VCF files.
        --vcf-list <VCF_LIST>        A file containing a list of input VCF files.
    -w, --workers <NUM_WORKERS>      Number of worker threads (default: all available cores).
```

