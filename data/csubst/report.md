# csubst CWL Generation Report

## csubst

### Tool Description
The provided text does not contain help information for the tool 'csubst'. It appears to be a fatal error log from a container runtime (Apptainer/Singularity) indicating a failure to build or extract the OCI image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/csubst:1.4.20--py310ha6711e0_1
- **Homepage**: https://github.com/kfuku52/csubst
- **Package**: https://anaconda.org/channels/bioconda/packages/csubst/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/csubst/overview
- **Total Downloads**: 10.6K
- **Last updated**: 2026-02-15
- **GitHub**: https://github.com/kfuku52/csubst
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/csubst:1.4.20--py310ha6711e0_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:36bcff332cad04f8bef1a1684fba5e7d8bdf0cf6b2730d291c4c6146907ce000: unpack entry: usr/local/include/GL/glew.h: unpack to regular file: short write: write /tmp/build-temp-1636056777/rootfs/usr/local/include/GL/glew.h: no space left on device
```


## Metadata
- **Skill**: generated
