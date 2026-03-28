# mlstdb CWL Generation Report

## mlstdb_fetch

### Tool Description
This tool downloads MLST scheme information from BIGSdb databases. It will automatically handle authentication and save the results.

### Metadata
- **Docker Image**: quay.io/biocontainers/mlstdb:0.2.0--pyh7e72e81_0
- **Homepage**: https://github.com/himal2007/mlstdb
- **Package**: https://anaconda.org/channels/bioconda/packages/mlstdb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mlstdb/overview
- **Total Downloads**: 865
- **Last updated**: 2026-01-06
- **GitHub**: https://github.com/himal2007/mlstdb
- **Stars**: N/A
### Original Help Text
```text
Usage: mlstdb fetch [OPTIONS]

  BIGSdb Scheme Fetcher Tool

  This tool downloads MLST scheme information from BIGSdb databases. It will
  automatically handle authentication and save the results.

Options:
  -h, --help                  Show this message and exit.
  -d, --db [pubmlst|pasteur]  Database to use (pubmlst or pasteur)
  -e, --exclude TEXT          Scheme name must not include provided term
                              (default: cgMLST)
  -m, --match TEXT            Scheme name must include provided term (default:
                              MLST)
  -s, --scheme-uris TEXT      Optional: Path to custom scheme_uris.tab file
  -f, --filter TEXT           Filter species or schemes using a wildcard
                              pattern
  -r, --resume                Resume processing from where it stopped
  -v, --verbose               Enable verbose logging for debugging
```


## mlstdb_update

### Tool Description
Update MLST schemes and create BLAST database.

Downloads MLST schemes from the specified input file and creates a BLAST
database from the downloaded sequences. Authentication tokens should be set
up using fetch.py.

### Metadata
- **Docker Image**: quay.io/biocontainers/mlstdb:0.2.0--pyh7e72e81_0
- **Homepage**: https://github.com/himal2007/mlstdb
- **Package**: https://anaconda.org/channels/bioconda/packages/mlstdb/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mlstdb update [OPTIONS]

  Update MLST schemes and create BLAST database.

  Downloads MLST schemes from the specified input file and creates a BLAST
  database from the downloaded sequences. Authentication tokens should be set
  up using fetch.py.

Options:
  -h, --help                  Show this message and exit.
  -i, --input TEXT            Path to mlst_schemes_<db>.tab containing MLST
                              scheme URLs  [required]
  -d, --directory TEXT        Directory to save the downloaded MLST schemes
                              (default: pubmlst)
  -b, --blast-directory TEXT  Directory for BLAST database (default: blast)
  -v, --verbose               Enable verbose logging for debugging
```


## Metadata
- **Skill**: generated
