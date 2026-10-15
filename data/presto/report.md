# presto CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| presto_BuildConsensus.py | PASS | Output matches the two Galaxy expected files (max diversity and max error runs); CWL rewritten (wrong -p, --log-file, --out-name flags; outdir created). |

## Metadata
- **Skill**: generated

## presto_BuildConsensus.py

### Tool Description
Reconstructs a consensus sequence from a set of sequences (e.g., reads with the same UMI).

### Metadata
- **Docker Image**: quay.io/biocontainers/presto:0.7.8--pyhdfd78af_0
- **Homepage**: http://presto.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/presto/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/presto:0.7.8--pyhdfd78af_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

