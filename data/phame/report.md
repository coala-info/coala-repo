# phame CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phame | Failed | tool bug: phame 1.0.2 compares samtools versions as decimals and stops with 'Need samtools >= 1.3 but you have 1.11', so no run and not even --vcheck can start |

## phame

### Tool Description
PhaME (version 1.0.2)

### Metadata
- **Docker Image**: quay.io/biocontainers/phame:1.0.3--pl5321hdfd78af_3
- **Homepage**: https://github.com/LANL-Bioinformatics/PhaME
- **Package**: https://anaconda.org/channels/bioconda/packages/phame/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phame/overview
- **Total Downloads**: 26.0K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/LANL-Bioinformatics/PhaME
- **Stars**: N/A
### Original Help Text
```text
PhaME (version 1.0.2)

USAGE: phame <control file>

-h show this help message and exit
-v show version number and exit
--vcheck checks if all depenencies are correct and in path.
```

