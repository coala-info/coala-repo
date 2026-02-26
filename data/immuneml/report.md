# immuneml CWL Generation Report

## immuneml_immune-ml

### Tool Description
immuneML command line tool

### Metadata
- **Docker Image**: quay.io/biocontainers/immuneml:3.0.17--pyhdfd78af_0
- **Homepage**: https://github.com/uio-bmi/immuneML
- **Package**: https://anaconda.org/channels/bioconda/packages/immuneml/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/immuneml/overview
- **Total Downloads**: 65.9K
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/uio-bmi/immuneML
- **Stars**: N/A
### Original Help Text
```text
usage: immune-ml [-h] [--tool TOOL]
                 [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [--version]
                 specification_path result_path

immuneML command line tool

positional arguments:
  specification_path    Path to specification YAML file. Always used to define
                        the analysis.
  result_path           Output directory path.

options:
  -h, --help            show this help message and exit
  --tool TOOL           Name of the tool which calls immuneML. This name will
                        be used to invoke appropriate API call, which will
                        then do additional work in tool-dependent way before
                        running standard immuneML.
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level to use
  --version             show program's version number and exit
```

