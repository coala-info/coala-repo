# cvlr CWL Generation Report

## cvlr

### Tool Description
The provided text does not contain help information for the tool 'cvlr'. It is a log of a failed container build process (Apptainer/Singularity) that terminated due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/cvlr:1.0--h61e1b1b_6
- **Homepage**: https://github.com/EmanueleRaineri/releases/
- **Package**: https://anaconda.org/channels/bioconda/packages/cvlr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cvlr/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-06-19
- **GitHub**: https://github.com/EmanueleRaineri/releases
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cvlr:1.0--h61e1b1b_6 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/lib/x86_64-linux-gnu/libmvec.so.1: unpack to regular file: short write: write /tmp/build-temp-4243612046/rootfs/usr/lib/x86_64-linux-gnu/libmvec.so.1: no space left on device
```


## Metadata
- **Skill**: generated
