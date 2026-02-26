# opentargets-validator CWL Generation Report

## opentargets-validator_opentargets_validator

### Tool Description
Open Targets evidence string validator, version 1.0.0.

### Metadata
- **Docker Image**: quay.io/biocontainers/opentargets-validator:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/opentargets/validator
- **Package**: https://anaconda.org/channels/bioconda/packages/opentargets-validator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/opentargets-validator/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/opentargets/validator
- **Stars**: N/A
### Original Help Text
```text
usage: opentargets_validator [-h] --schema SCHEMA [--log-level LOGLEVEL] [-v]
                             [data]

Open Targets evidence string validator, version 1.0.0.

options:
  -h, --help            show this help message and exit
  --log-level LOGLEVEL  Log level. Default: INFO
  -v, -V, --version     show program's version number and exit

input files:
  Either of the input files listed below could be:
    * STDIN (-)
    * Local uncompressed JSON (*.json)
    * Local compressed JSON (*.json.gz)
    * Remote uncompressed JSON (https://example.com/example.json)

  data                  Data file to validate. If not specified, STDIN is the
                        default.
  --schema SCHEMA       Schema file to validate against. Mandatory.
```

