# mzml2isa CWL Generation Report

## mzml2isa

### Tool Description
Extract meta information from (i)mzML files and create ISA-tab structure

### Metadata
- **Docker Image**: quay.io/biocontainers/mzml2isa:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/ISA-tools/mzml2isa
- **Package**: https://anaconda.org/channels/bioconda/packages/mzml2isa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mzml2isa/overview
- **Total Downloads**: 39.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ISA-tools/mzml2isa
- **Stars**: N/A
### Original Help Text
```text
usage: mzml2isa -i IN_PATH -o OUT_PATH -s STUDY_ID [options]

Extract meta information from (i)mzML files and create ISA-tab structure

optional arguments:
  -h, --help            show this help message and exit
  -i IN_PATH            input folder or archive containing mzML files
  -o OUT_PATH           out folder (new files will be created here)
  -s STUDY_ID           study identifier (e.g. MTBLSxxx)
  -m USERMETA           additional user provided metadata (JSON format)
  -j JOBS               launch different processes for parsing
  -n                    do NOT split assay files based on polarity
  -c                    do NOT group centroid & profile samples
  -W {ignore,always,error,default,module,once}
                        warning control (with python default behaviour)
  -t TEMPLATE_DIR       directory containing default template files
  --version             show program's version number and exit
  -v                    show more output (default if tqdm is not installed)
```

