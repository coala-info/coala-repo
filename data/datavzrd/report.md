# datavzrd CWL Generation Report

## datavzrd

### Tool Description
A tool to create visual HTML reports from collections of CSV/TSV tables.

### Metadata
- **Docker Image**: quay.io/biocontainers/datavzrd:2.23.2
- **Homepage**: https://github.com/datavzrd/datavzrd
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/datavzrd/overview
- **Total Downloads**: 1.0M
- **Last updated**: 2026-02-24
- **GitHub**: https://github.com/datavzrd/datavzrd
- **Stars**: N/A
### Original Help Text
```text
datavzrd 2.23.2
A tool to create visual HTML reports from collections of CSV/TSV tables.

USAGE:
    datavzrd [FLAGS] [OPTIONS] <CONFIG> --output <output>

FLAGS:
        --debug               Activates debug mode. Javascript files are not minified
    -h, --help                Prints help information
        --overwrite-output    Overwrites the contents of the given output directory if it is not empty
    -V, --version             Prints version information
    -v, --verbose             Verbose mode (-v, -vv, -vvv, etc.)

OPTIONS:
    -o, --output <output>              Output file
    -w, --webview-url <webview-url>    Sets the URL of the webview host. Note that when using the link the row data can
                                       temporarily occur (in base64-encoded form) in the server logs of the given
                                       webview host [env: DATAVZRD_WEBVIEW_URL=]  [default:
                                       https://datavzrd.github.io/view/]

ARGS:
    <CONFIG>    Config file containing file paths and settings
```


## Metadata
- **Skill**: generated
