# covar CWL Generation Report

## covar

### Tool Description
Calls physically-linked mutation clusters from wastewater amplicon sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/covar:0.3.0--h3dc2dae_0
- **Homepage**: https://github.com/andersen-lab/covar
- **Package**: https://anaconda.org/channels/bioconda/packages/covar/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/covar/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2026-01-23
- **GitHub**: https://github.com/andersen-lab/covar
- **Stars**: N/A
### Original Help Text
```text
Calls physically-linked mutation clusters from wastewater amplicon sequencing data

Usage: covar [OPTIONS] --input <INPUT_BAM> --reference <REFERENCE_FASTA> --annotation <ANNOTATION_GFF>

Options:
  -i, --input <INPUT_BAM>              Input BAM file (must be primer trimmed, sorted and indexed)
  -r, --reference <REFERENCE_FASTA>    Reference genome FASTA file
  -a, --annotation <ANNOTATION_GFF>    Annotation GFF3 file. Used for translating mutations to respective amino acid mutation
  -o, --output <OUTPUT>                Optional output file path. If not provided, output will be printed to stdout
  -s, --start_site <START_SITE>        Genomic start site for variant calling [default: 0]
  -e, --end_site <END_SITE>            Genomic end site for variant calling. Defaults to the length of the reference genome
  -d, --min_depth <MIN_DEPTH>          Minimum coverage depth for a mutation cluster to be considered [default: 1]
  -f, --min_frequency <MIN_FREQUENCY>  Minimum frequency (cluster depth / total depth) to include a cluster in output [default: 0.001]
  -q, --min_quality <MIN_QUALITY>      Minimum base quality for variant calling [default: 20]
  -t, --threads <THREADS>              Number of threads to spawn for variant calling [default: 1]
  -h, --help                           Print help
  -V, --version                        Print version
```


## Metadata
- **Skill**: generated
