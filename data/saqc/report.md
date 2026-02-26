# saqc CWL Generation Report

## saqc

### Tool Description
saqc

### Metadata
- **Docker Image**: quay.io/biocontainers/saqc:2.6.0
- **Homepage**: https://github.com/Helmholtz-UFZ/saqc
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/saqc/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-12-21
- **GitHub**: https://github.com/Helmholtz-UFZ/saqc
- **Stars**: N/A
### Original Help Text
```text
Usage: saqc [OPTIONS]

Options:
  --version                       Show the version and exit.
  -c, --config PATH               Path to a configuration file. Use a '.json'
                                  extension to provide a JSON-configuration.
                                  Otherwise files are treated as CSV.
                                  [required]
  -d, --data PATH                 Path to a data file.  [required]
  -o, --outfile PATH              Path to a output file.
  --scheme [simple|float|dmp|positional]
                                  A flagging scheme to use.  [default: simple]
  --nodata FLOAT                  Set a custom nodata value.  [default: nan]
  -ll, --log-level [DEBUG|INFO|WARNING]
                                  Set log verbosity.  [default: INFO]
  --json-field TEXT               Use the value from the given FIELD from the
                                  root object of a json file. The value must
                                  hold a array of saqc tests. If the option is
                                  not given, a passed JSON config is assumed
                                  to have an array of saqc tests as root
                                  element.
  --help                          Show this message and exit.
```

