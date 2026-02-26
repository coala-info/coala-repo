# svync CWL Generation Report

## svync

### Tool Description
A tool to standardize VCF files from structural variant callers

### Metadata
- **Docker Image**: quay.io/biocontainers/svync:0.3.0--h9ee0642_0
- **Homepage**: https://github.com/nvnieuwk/svync
- **Package**: https://anaconda.org/channels/bioconda/packages/svync/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svync/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/nvnieuwk/svync
- **Stars**: N/A
### Original Help Text
```text
NAME:
   svync - A tool to standardize VCF files from structural variant callers

USAGE:
   svync [global options] [arguments...]

VERSION:
   0.2.0

GLOBAL OPTIONS:
   --help, -h     show help
   --version, -v  print the version

   Optional

   --mute-warnings, --mw     Mute all warnings. (default: false)
   --nodate, --nd            Don't add the current date to the output VCF header (default: false)
   --output value, -o value  The location to the output VCF file, defaults to stdout

   Required

   --config value, -c value  Configuration file (YAML) used for standardizing the VCF
   --input value, -i value   The input VCF file to standardize
```

