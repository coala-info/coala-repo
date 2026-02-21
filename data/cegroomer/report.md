# cegroomer CWL Generation Report

## cegroomer

### Tool Description
The provided text does not contain help information or a description for the tool. It appears to be an error log from a container build process (Apptainer/Singularity) failing due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracegroomer:0.1.4--pyhdfd78af_0
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/tracegroomer:0.1.4--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:c09ebaf2c8bd0e3b85b8acbfae8c6fc9ca61589974cff431cf31698a07b9a901: unpack entry: usr/local/include/lzma/index.h: unpack to regular file: short write: write /tmp/build-temp-2543448540/rootfs/usr/local/include/lzma/index.h: no space left on device
```


## Metadata
- **Skill**: not generated
