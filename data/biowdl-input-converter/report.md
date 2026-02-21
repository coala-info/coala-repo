# biowdl-input-converter CWL Generation Report

## biowdl-input-converter

### Tool Description
Parse samplesheets for BioWDL pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/biowdl-input-converter:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/biowdl/biowdl-input-converter
- **Package**: https://anaconda.org/channels/bioconda/packages/biowdl-input-converter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biowdl-input-converter/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biowdl/biowdl-input-converter
- **Stars**: N/A
### Original Help Text
```text
usage: biowdl-input-converter [-h] [-f FORMAT] [-o OUTPUT] [--validate]
                              [--old] [--skip-file-check]
                              [--skip-duplicate-check] [--check-file-md5sums]
                              samplesheet

Parse samplesheets for BioWDL pipelines.

positional arguments:
  samplesheet           The input samplesheet. Format will be automatically
                        detected from file suffix if --format argument not
                        provided

optional arguments:
  -h, --help            show this help message and exit
  -f FORMAT, --format FORMAT
                        The input samplesheet format - tsv, csv, json, or yaml
  -o OUTPUT, --output OUTPUT
                        The output file to which the json is written. Default:
                        stdout
  --validate            Do not generate output but only validate the
                        samplesheet.
  --old                 Output old style JSON as used in BioWDL germline-DNA
                        and RNA-seq version 1 pipelines
  --skip-file-check     Skip the checking if files in the samplesheet are
                        present.
  --skip-duplicate-check
                        Skip the checks for duplicate files in the
                        samplesheet.
  --check-file-md5sums  Do a md5sum check for reads which have md5sums added
                        in the samplesheet.
```


## Metadata
- **Skill**: generated
