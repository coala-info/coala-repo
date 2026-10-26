# valet CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| valet_valet.py | Not completed | runs end to end, but the result differs from the Galaxy expected summary: breakpoints are not reported for the reference, relocation and reloc-dup assemblies and the duplication low coverage count is 693 instead of 692 |

## Metadata
- **Skill**: generated

## valet_valet.py

### Tool Description
VAriant calling evaLuatIon Tool (VALET) - evaluates variant calling performance by comparing VCF files against a reference and alignment data.

### Metadata
- **Docker Image**: quay.io/biocontainers/valet:1.0--3
- **Homepage**: https://github.com/marbl/VALET
- **Package**: https://anaconda.org/channels/bioconda/packages/valet/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/valet:1.0--3 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

