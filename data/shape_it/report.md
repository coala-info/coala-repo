# shape_it CWL Generation Report

## shape_it

### Tool Description
The provided text does not contain help information or usage instructions. It appears to be a fatal error log from a container runtime (Apptainer/Singularity) indicating a failure to build or extract a container image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/shapeshifter-cli:1.0.0--py_0
- **Homepage**: https://github.com/facebookarchive/Keyframes
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shape_it/overview
- **Total Downloads**: 9.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/facebookarchive/Keyframes
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 22:28:19  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/shapeshifter-cli:1.0.0--py_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:8998d7eb4062a62746cfaedcd37d253a22318fb73e32df3ffc5e35a8931d13c6: unpack entry: usr/local/bin/pzstd: unpack to regular file: short write: write /tmp/build-temp-3380657185/rootfs/usr/local/bin/pzstd: no space left on device
```


## Metadata
- **Skill**: not generated
