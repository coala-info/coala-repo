# nmrml2isa CWL Generation Report

## nmrml2isa

### Tool Description
Extract meta information from nmrML files and create ISA-tab structure

### Metadata
- **Docker Image**: quay.io/biocontainers/nmrml2isa:0.3.3--pyhdfd78af_0
- **Homepage**: http://github.com/ISA-tools/nmrml2isa
- **Package**: https://anaconda.org/channels/bioconda/packages/nmrml2isa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nmrml2isa/overview
- **Total Downloads**: 10.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ISA-tools/nmrml2isa
- **Stars**: N/A
### Original Help Text
```text
usage: nmrml2isa -i IN_PATH -o OUT_PATH -s STUDY_ID [options]

Extract meta information from nmrML files and create ISA-tab structure

optional arguments:
  -h, --help            show this help message and exit
  -i IN_PATH            input folder or archive containing nmrML files
  -o OUT_PATH           out folder (a new directory will be created here)
  -s STUDY_ID           study identifier (e.g. MTBLSxxx)
  -m USERMETA           additional user provided metadata (JSON or XLSX
                        format)
  -j JOBS               launch different processes for parsing
  -W {ignore,always,error,default,module,once}
                        warning control (with python default behaviour)
  -t TEMPLATE_DIR       directory containing default template files
  --version             show program's version number and exit
  -v                    show more output (default if progressbar2 is not
                        installed)
  -q                    do not show any output
```

