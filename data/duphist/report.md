# duphist CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| duphist | Failed | image problem: the image has BusyBox split, which lacks -d and --additional-suffix, so no alignment or tree jobs run and the result table is empty. |

## duphist

### Tool Description
DupHIST reconstructs the order and timing of gene duplication events from a config file naming CDS, protein and group info files.

### Metadata
- **Docker Image**: quay.io/biocontainers/duphist:1.1.0--hdfd78af_1
- **Homepage**: https://github.com/minjeongjj/DupHIST
- **Package**: https://anaconda.org/channels/bioconda/packages/duphist/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/duphist/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2026-02-23
- **GitHub**: https://github.com/minjeongjj/DupHIST
- **Stars**: N/A
### Original Help Text
```text
Usage: duphist [config_file_name]
```
