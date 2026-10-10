# minvar CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| minvar | Failed | image problem: the report step runs sierrapy, which aborts because the image has no UTF-8 locale (Click error); real HIV reads (SRR7724269) were mapped and called before the crash |

## minvar

### Tool Description
optional arguments:

### Metadata
- **Docker Image**: quay.io/biocontainers/minvar:2.2.2--py35_0
- **Homepage**: https://git.io/minvar
- **Package**: https://anaconda.org/channels/bioconda/packages/minvar/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minvar/overview
- **Total Downloads**: 180.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: minvar [-h] [-f F] [-r] [-k] [-v]

optional arguments:
  -h, --help       show this help message and exit

Input files:
  Required input

  -f F, --fastq F  input reads in fastq format
  -r, --recal      turn on recalibration with GATK <default: False>
  -k, --keep       keep intermediate files <default: False>
  -v, --version    show program's version number and exit
```


## Metadata
- **Skill**: generated
