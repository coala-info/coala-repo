# core-snp-filter CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| core-snp-filter_coresnpfilter | PASS |  |

## Metadata
- **Skill**: generated

## core-snp-filter_coresnpfilter

### Tool Description
Core-SNP-filter: Filter alignments based on core genome threshold and invariant sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/core-snp-filter:0.2.0--h3ab6199_2
- **Homepage**: https://github.com/rrwick/Core-SNP-filter
- **Package**: https://anaconda.org/channels/bioconda/packages/core-snp-filter/overview
- **Validation**: PASS
### Original Help Text
```text
Core-SNP-filter

Usage: coresnpfilter [OPTIONS] <INPUT>

Arguments:
  <INPUT>  Input alignment

Options:
  -c, --core <CORE>        Restrict to core genome (0.0 to 1.0, default = 0.0)
  -e, --exclude_invariant  Exclude invariant sites
  -t, --table <TABLE>      Create a table with per-site information
  -C, --invariant_counts   Output invariant site counts (suitable for IQ-TREE -fconst) and nothing
                           else
  -h, --help               Print help
  -V, --version            Print version
```

