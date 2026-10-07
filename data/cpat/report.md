# cpat CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cpat_make_logitModel | PASS |  |

## Metadata
- **Skill**: generated

## cpat_make_logitModel

### Tool Description
Build a logistic regression model using training data (coding and non-coding sequences) to be used by CPAT for coding potential assessment.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpat:3.0.5--py312hc9302aa_4
- **Homepage**: https://cpat.readthedocs.io/en/latest/
- **Package**: https://anaconda.org/channels/bioconda/packages/cpat/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cpat:3.0.5--py312hc9302aa_4 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:f948f85f272f12b8a66be1746fed894ba145c1e49f06f115393369acc8833e96: unpack entry: usr/local/lib/R/doc/manual/R-FAQ.html: unpack to regular file: short write: write /scratch/21834835/build-temp-1317386907/rootfs/usr/local/lib/R/doc/manual/R-FAQ.html: no space left on device
```

