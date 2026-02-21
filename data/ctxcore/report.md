# ctxcore CWL Generation Report

## ctxcore

### Tool Description
The provided text does not contain help information or usage instructions. It appears to be a log output from a failed container build process (Apptainer/Singularity) indicating a 'no space left on device' error during the extraction of the ctxcore OCI image.

### Metadata
- **Docker Image**: quay.io/biocontainers/ctxcore:0.2.0--pyh7e72e81_1
- **Homepage**: https://scenic.aertslab.org
- **Package**: https://anaconda.org/channels/bioconda/packages/ctxcore/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ctxcore/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-11-13
- **GitHub**: https://github.com/aertslab/ctxcore
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/ctxcore:0.2.0--pyh7e72e81_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:2c03c3d773a2a6817dfbee021c2ecdd5ffe7dd4cdce3cc905fd189fef3fc75ca: unpack entry: usr/local/lib/libarrow.so.2200.0.0: unpack to regular file: short write: write /tmp/build-temp-1791351071/rootfs/usr/local/lib/libarrow.so.2200.0.0: no space left on device
```


## Metadata
- **Skill**: generated
