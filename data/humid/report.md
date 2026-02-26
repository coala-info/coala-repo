# humid CWL Generation Report

## humid

### Tool Description
Deduplicate a dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/humid:1.0.4--heae3180_2
- **Homepage**: https://github.com/jfjlaros/HUMID
- **Package**: https://anaconda.org/channels/bioconda/packages/humid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/humid/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jfjlaros/HUMID
- **Stars**: N/A
### Original Help Text
```text
Required parameter missing.
humid: Deduplicate a dataset.

positional arguments:
  files		FastQ files (type vector<string>)

optional arguments:
  -n		word length (type unsigned long int, default: 24)
  -m		allowed mismatches (type unsigned long int, default: 1)
  -l		log file name (type string, default: /dev/stderr)
  -d		output directory (type string, default: .)
  -s		calculate statistics (type flag, default: disabled)
  -q		write deduplicated FastQ files (type flag, default: enabled)
  -a		write annotated FastQ files (type flag, default: disabled)
  -e		use edit distance (type flag, default: disabled)
  -x		use maximum clustering method (type flag, default: disabled)
```

