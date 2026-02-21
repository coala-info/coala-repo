# ctseq CWL Generation Report

## ctseq

### Tool Description
The provided text does not contain help information or a description of the tool's functionality; it is an error log from a container runtime (Apptainer/Singularity) indicating a failure to extract the image due to lack of disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/ctseq:0.0.2--py_0
- **Homepage**: https://github.com/ryanhmiller/ctseq
- **Package**: https://anaconda.org/channels/bioconda/packages/ctseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ctseq/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ryanhmiller/ctseq
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 14:40:03  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/ctseq:0.0.2--py_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:93cf427cafbec580ced4bbf022ca197705b8463096198a7fe1cecbcefabfd40f: unpack entry: usr/local/bin/x86_64-conda_cos6-linux-gnu-dwp: unpack to regular file: short write: write /tmp/build-temp-1423447448/rootfs/usr/local/bin/x86_64-conda_cos6-linux-gnu-dwp: no space left on device
```


## Metadata
- **Skill**: generated
