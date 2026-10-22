# srnamapper CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| srnamapper | PASS | Rewrote CWL from help (binary is srnaMapper; flags -r/-g/-o/-e); small RNA reads from nf-core smrnaseq mapped to bwa-indexed genome gave 69 valid SAM alignments |

## srnamapper

### Tool Description
A tool for specifically mapping small RNA reads to a reference genome, allowing for a user-defined number of mismatches.

### Metadata
- **Docker Image**: quay.io/biocontainers/srnamapper:1.0.12--h577a1d6_0
- **Homepage**: https://github.com/mzytnicki/srnaMapper
- **Package**: https://anaconda.org/channels/bioconda/packages/srnamapper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/srnamapper/overview
- **Total Downloads**: 12.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mzytnicki/srnaMapper
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/srnamapper:1.0.12--h577a1d6_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

## Metadata
- **Skill**: generated

