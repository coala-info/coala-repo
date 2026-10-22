# stranger CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| stranger | PASS | repo ExpansionHunter test VCF: 24 variants annotated (21 normal, 1 pre_mutation, 2 full_mutation), TRGT VCF also works; CWL fixed (no --output option, output is stdout) |

## stranger

### Tool Description
Stranger is a tool for annotating STR (Short Tandem Repeat) variants in VCF files with information about repeat expansions and their clinical significance.

### Metadata
- **Docker Image**: quay.io/biocontainers/stranger:0.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/moonso/stranger
- **Package**: https://anaconda.org/channels/bioconda/packages/stranger/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/stranger/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/moonso/stranger
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/stranger:0.10.0--pyhdfd78af_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```


## Metadata
- **Skill**: generated
