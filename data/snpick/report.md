# snpick CWL Generation Report

## snpick

### Tool Description
A fast and efficient tool for extracting variable sites and generating a VCF with actual bases, including ambiguous bases and codons.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpick:1.0.0--h3f2c17f_0
- **Homepage**: https://github.com/PathoGenOmics-Lab/snpick
- **Package**: https://anaconda.org/channels/bioconda/packages/snpick/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snpick/overview
- **Total Downloads**: 766
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PathoGenOmics-Lab/snpick
- **Stars**: N/A
### Original Help Text
```text
A fast and efficient tool for extracting variable sites and generating a VCF with actual bases, including ambiguous bases and codons.

Usage: snpick [OPTIONS] --fasta <FASTA> --output <OUTPUT>

Options:
  -f, --fasta <FASTA>            Input FASTA alignment file
  -o, --output <OUTPUT>          Output FASTA file with variable sites
  -t, --threads <THREADS>        Number of threads to use (optional) [default: 4]
  -g, --include-gaps             Consider the '-' (gap) symbol in variable site detection
      --vcf                      Generate VCF file with variable sites
      --vcf-output <VCF_OUTPUT>  Output VCF file (optional)
  -h, --help                     Print help
  -V, --version                  Print version
```

