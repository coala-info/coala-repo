# eido CWL Generation Report

## eido_validate

### Tool Description
Validate a PEP or its components

### Metadata
- **Docker Image**: biocontainers/eido:0.1.9_cv2
- **Homepage**: https://github.com/mayneyao/eidos
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/eido/overview
- **Total Downloads**: 381.6K
- **Last updated**: 2026-02-04
- **GitHub**: https://github.com/mayneyao/eidos
- **Stars**: N/A
### Original Help Text
```text
usage: eido validate [-h] [--st-index ST_INDEX] -s S [-e] [-n S | -c] PEP

Validate a PEP or its components

positional arguments:
  PEP                   Path to a PEP configuration file in yaml format.

options:
  -h, --help            show this help message and exit
  --st-index ST_INDEX   Sample table index to use, samples are identified by
                        'sample_name' by default.
  -s S, --schema S      Path to a PEP schema file in yaml format.
  -e, --exclude-case    Whether to exclude the validation case from an error.
                        Only the human readable message explaining the error
                        will be raised. Useful when validating large PEPs.
  -n S, --sample-name S
                        Name or index of the sample to validate. Only this
                        sample will be validated.
  -c, --just-config     Whether samples should be excluded from the
                        validation.
```


## eido_inspect

### Tool Description
Inspect a PEP

### Metadata
- **Docker Image**: biocontainers/eido:0.1.9_cv2
- **Homepage**: https://github.com/mayneyao/eidos
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: eido inspect [-h] [--st-index ST_INDEX] [-n SN [SN ...]]
                    [-l ATTR_LIMIT]
                    PEP

Inspect a PEP

positional arguments:
  PEP                   Path to a PEP configuration file in yaml format.

options:
  -h, --help            show this help message and exit
  --st-index ST_INDEX   Sample table index to use, samples are identified by
                        'sample_name' by default.
  -n SN [SN ...], --sample-name SN [SN ...]
                        Name of the samples to inspect.
  -l ATTR_LIMIT, --attr-limit ATTR_LIMIT
                        Number of sample attributes to display.
```


## eido_convert

### Tool Description
Convert PEP format using filters

### Metadata
- **Docker Image**: biocontainers/eido:0.1.9_cv2
- **Homepage**: https://github.com/mayneyao/eidos
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: eido convert [-h] [--st-index ST_INDEX] [-f FORMAT]
                    [-n SAMPLE_NAME [SAMPLE_NAME ...]] [-a ARGS [ARGS ...]]
                    [-l] [-d] [-p PATHS [PATHS ...]]
                    [PEP]

Convert PEP format using filters

positional arguments:
  PEP                   Path to a PEP configuration file in yaml format.

options:
  -h, --help            show this help message and exit
  --st-index ST_INDEX   Sample table index to use, samples are identified by
                        'sample_name' by default.
  -f FORMAT, --format FORMAT
                        Output format (name of filter; use -l to see
                        available).
  -n SAMPLE_NAME [SAMPLE_NAME ...], --sample-name SAMPLE_NAME [SAMPLE_NAME ...]
                        Name of the samples to inspect.
  -a ARGS [ARGS ...], --args ARGS [ARGS ...]
                        Provide arguments to the filter function (e.g.
                        arg1=val1 arg2=val2).
  -l, --list            List available filters.
  -d, --describe        Show description for a given filter.
  -p PATHS [PATHS ...], --paths PATHS [PATHS ...]
                        Paths to dump conversion result as key=value pairs.
The following arguments are required: PEP
```


## Metadata
- **Skill**: generated
