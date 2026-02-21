# cuttlefish CWL Generation Report

## cuttlefish

### Tool Description
The provided text does not contain help information or a description of the tool; it is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build the image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/cuttlefish:2.2.0--h6b3f7d6_5
- **Homepage**: https://github.com/COMBINE-lab/cuttlefish
- **Package**: https://anaconda.org/channels/bioconda/packages/cuttlefish/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cuttlefish/overview
- **Total Downloads**: 14.2K
- **Last updated**: 2025-07-31
- **GitHub**: https://github.com/COMBINE-lab/cuttlefish
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cuttlefish:2.2.0--h6b3f7d6_5 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/lib/x86_64-linux-gnu/libmvec.so.1: unpack to regular file: short write: write /tmp/build-temp-3606941351/rootfs/usr/lib/x86_64-linux-gnu/libmvec.so.1: no space left on device
```


## Metadata
- **Skill**: generated
