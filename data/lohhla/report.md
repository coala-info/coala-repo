# lohhla CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| lohhla | Failed | image problem: the image entrypoint env-execute fails on every command (activate script syntax error under /bin/sh); also rewrote the CWL, whose flags were invented, from the real lohhla help |

## lohhla

### Tool Description
This tool is used for HLA typing from sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/lohhla:20171108--hdfd78af_3
- **Homepage**: https://bitbucket.org/mcgranahanlab/lohhla
- **Package**: https://anaconda.org/channels/bioconda/packages/lohhla/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lohhla/overview
- **Total Downloads**: 7.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
/usr/local/env-execute: 5: /usr/local/etc/conda/activate.d/activate-binutils_linux-64.sh: Syntax error: "(" unexpected
```


## Metadata
- **Skill**: generated
