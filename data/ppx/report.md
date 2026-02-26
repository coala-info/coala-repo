# ppx CWL Generation Report

## ppx

### Tool Description
Use this command line utility to download files from the PRIDE and MassIVE proteomics repositories. The paths to the downloaded files are written to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppx:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/wfondrie/ppx
- **Package**: https://anaconda.org/channels/bioconda/packages/ppx/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ppx/overview
- **Total Downloads**: 31.4K
- **Last updated**: 2025-06-19
- **GitHub**: https://github.com/wfondrie/ppx
- **Stars**: N/A
### Original Help Text
```text
usage: ppx [-h] [-l LOCAL] [-t TIMEOUT] [-f] [--version]
           identifier [files ...]

Use this command line utility to download files from the PRIDE and MassIVE
proteomics repositories. The paths to the downloaded files are written to
stdout.

positional arguments:
  identifier            The ProteomeXchange, PRIDE, or MassIVE identifier for
                        the project.
  files                 One or more files to download. If none are provided,
                        all files associated with the project are downloaded.
                        Unix-style glob wildcards can be used, but they will
                        need to be enclosed in quotation marks so as not to
                        match files in your current working directory.

options:
  -h, --help            show this help message and exit
  -l, --local LOCAL     The local directory where data will be downloaded. The
                        default is ~/.ppx/<identifier>. This can also be
                        changed globally by setting the PPX_DATA_DIR
                        environment variable to your desired location.
  -t, --timeout TIMEOUT
                        The maximum amount of time to wait for a server
                        response.
  -f, --force           Should ppx download files that are already present in
                        the local data directory?
  --version             Get the version of ppx.

More documentation and examples at: https://ppx.readthedocs.io
```

