# panaroo CWL Generation Report

## panaroo

### Tool Description
The provided text is an error log related to a container runtime (Singularity/Apptainer) failing to pull the panaroo image due to insufficient disk space. It does not contain CLI help information or argument definitions.

### Metadata
- **Docker Image**: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
- **Homepage**: https://gtonkinhill.github.io/panaroo
- **Package**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/panaroo/overview
- **Total Downloads**: 53.7K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/gtonkinhill/panaroo
- **Stars**: N/A
### Original Help Text
```text
WARNING: Couldn't use cached digest for registry: write /home/qhu/.singularity/cache/blob/blobs/sha256/575f3443970a0d882e8e253ae954cd43cbac799f9a941c7ebe324ab9b11060f9: no space left on device
WARNING: Falling back to direct digest.
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3722041442: no space left on device
```

