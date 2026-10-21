# rnaz CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rnaz_rnazRandomizeAln.pl | PASS | Ran on the real IRE alignment from the RNAz repo; columns are shuffled with the same shape. The CWL had invented options (--seed, string level) that were replaced by the documented ones. |

## Metadata
- **Skill**: generated

## rnaz_rnazRandomizeAln.pl

### Tool Description
Randomize alignments for RNAz analysis by shuffling positions, columns, or the entire alignment to create null models.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnaz:2.1.1--pl5321h503566f_8
- **Homepage**: https://www.tbi.univie.ac.at/~wash/RNAz/
- **Package**: https://anaconda.org/channels/bioconda/packages/rnaz/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/rnaz:2.1.1--pl5321h503566f_8 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

