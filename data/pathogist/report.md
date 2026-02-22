# pathogist CWL Generation Report

## pathogist

### Tool Description
The provided text does not contain help information or a description of the tool; it contains error logs related to a container runtime (Singularity/Apptainer) failing to pull the image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathogist:0.3.6--py_0
- **Homepage**: https://github.com/WGS-TB/PathOGiST
- **Package**: https://anaconda.org/channels/bioconda/packages/pathogist/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pathogist/overview
- **Total Downloads**: 23.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/WGS-TB/PathOGiST
- **Stars**: N/A
### Original Help Text
```text
WARNING: Couldn't use cached digest for registry: write /home/qhu/.singularity/cache/blob/blobs/sha256/86f09a646b0ed2518c9af8494f5431a345af2d1192311fc3ff58979bfa33f658: no space left on device
WARNING: Falling back to direct digest.
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/pathogist:0.3.6--py_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-2219286373: no space left on device
```

