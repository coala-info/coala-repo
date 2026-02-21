# afwdist CWL Generation Report

## afwdist

### Tool Description
allele frequency-weighted distances

### Metadata
- **Docker Image**: quay.io/biocontainers/afwdist:1.0.0--h4349ce8_0
- **Homepage**: https://github.com/PathoGenOmics-Lab/afwdist
- **Package**: https://anaconda.org/channels/bioconda/packages/afwdist/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/afwdist/overview
- **Total Downloads**: 560
- **Last updated**: 2025-08-09
- **GitHub**: https://github.com/PathoGenOmics-Lab/afwdist
- **Stars**: N/A
### Original Help Text
```text
afwdist (allele frequency-weighted distances)

Usage: afwdist [OPTIONS] --input <INPUT> --reference <REFERENCE> --output <OUTPUT>

Options:
  -i, --input <INPUT>          Input tree in CSV format (mandatory CSV columns are 'sample', 'position', 'sequence' and 'frequency')
  -r, --reference <REFERENCE>  Reference sequence in FASTA format
  -o, --output <OUTPUT>        Output CSV file with distances between each pair of samples
  -s, --include-reference      Include reference as a sample with 100% fixed alleles
  -v, --verbose                Enable debug messages
  -h, --help                   Print help
  -V, --version                Print version
```


## Metadata
- **Skill**: generated
