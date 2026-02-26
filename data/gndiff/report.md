# gndiff CWL Generation Report

## gndiff

### Tool Description
Extracts scientific names, their IDs and families from the query and reference
files, prints out a match of a query data to the reference data.

The files can be in comma-separated (CSV), tab-separated (TSV) formats, or
just contain name-strings only (one per line).

TSV/CSV files must contain 'ScientificName' field, 'Family' and 'TaxonID'
fields are also ingested.

### Metadata
- **Docker Image**: quay.io/biocontainers/gndiff:0.3.0--he881be0_1
- **Homepage**: https://github.com/gnames/gndiff
- **Package**: https://anaconda.org/channels/bioconda/packages/gndiff/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gndiff/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2025-07-31
- **GitHub**: https://github.com/gnames/gndiff
- **Stars**: N/A
### Original Help Text
```text
Extracts scientific names, their IDs and families from the query and reference
files, prints out a match of a query data to the reference data.

The files can be in comma-separated (CSV), tab-separated (TSV) formats, or
just contain name-strings only (one per line).

TSV/CSV files must contain 'ScientificName' field, 'Family' and 'TaxonID'
fields are also ingested.

Usage:
  gndiff query_file reference_file [flags]

Flags:
  -f, --format string   Sets output format. Can be one of:
                        'csv', 'tsv', 'compact', 'pretty'
                        default is 'csv'.
  -h, --help            help for gndiff
  -p, --port int        Port to run web GUI.
  -q, --quiet           Do not output info and warning logs.
  -V, --version         shows build version and date, ignores other flags.
```

