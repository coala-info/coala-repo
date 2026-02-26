# bedgovcf CWL Generation Report

## bedgovcf

### Tool Description
Convert a BED file to a VCF file according to a YAML config

### Metadata
- **Docker Image**: quay.io/biocontainers/bedgovcf:0.1.1--h9ee0642_1
- **Homepage**: https://github.com/nvnieuwk/bedgovcf
- **Package**: https://anaconda.org/channels/bioconda/packages/bedgovcf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bedgovcf/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nvnieuwk/bedgovcf
- **Stars**: N/A
### Original Help Text
```text
NAME:
   bedgovcf - Convert a BED file to a VCF file according to a YAML config

USAGE:
   bedgovcf [global options] [arguments...]

VERSION:
   0.1.0

GLOBAL OPTIONS:
   --help, -h     show help
   --version, -v  print the version

   Optional

   --header, -l              The BED file contains a header line (default: false)
   --output value, -o value  The location to the output VCF file, defaults to stdout
   --sample value, -s value  The name of the sample to use in the VCF file, defaults to the basename of the BED file
   --skip value, -k value    The amount of lines to skip in the BED file (default: 0)

   Required

   --bed value, -b value     The input BED file
   --config value, -c value  Configuration file to use for the conversion in YAML format
   --fai value, -f value     The location to the fasta index file
```

