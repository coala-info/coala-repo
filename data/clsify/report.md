# clsify CWL Generation Report

## clsify_cli

### Tool Description
Classify sequence files and extract sample information using regular expressions.

### Metadata
- **Docker Image**: quay.io/biocontainers/clsify:0.1.1--py_0
- **Homepage**: https://github.com/holtgrewe/clsify
- **Package**: https://anaconda.org/channels/bioconda/packages/clsify/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clsify/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/holtgrewe/clsify
- **Stars**: N/A
### Original Help Text
```text
usage: clsify cli [-h] [--sample-regex SAMPLE_REGEX] [-o OUTPUT]
                  seq_files [seq_files ...]

positional arguments:
  seq_files

optional arguments:
  -h, --help            show this help message and exit
  --sample-regex SAMPLE_REGEX
                        Regular expression to match file name to sample name.
  -o OUTPUT, --output OUTPUT
                        Path to output file
```


## clsify_web

### Tool Description
Start the clsify web server

### Metadata
- **Docker Image**: quay.io/biocontainers/clsify:0.1.1--py_0
- **Homepage**: https://github.com/holtgrewe/clsify
- **Package**: https://anaconda.org/channels/bioconda/packages/clsify/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clsify web [-h] [--host HOST] [--port PORT]
                  [--public-url-prefix PUBLIC_URL_PREFIX] [--debug]

optional arguments:
  -h, --help            show this help message and exit
  --host HOST           Server host
  --port PORT           Server port
  --public-url-prefix PUBLIC_URL_PREFIX
                        The prefix that this app will be served under (e.g.,
                        if behind a reverse proxy.)
  --debug               Whether or not to enable debugging.
```

