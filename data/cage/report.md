# cage CWL Generation Report

## cage

### Tool Description
The provided text does not contain help information for the 'cage' tool; it is an error log from a container build process (Apptainer/Singularity) indicating a 'no space left on device' failure.

### Metadata
- **Docker Image**: quay.io/biocontainers/cage:2016.05.13--he8c0b07_8
- **Homepage**: https://github.com/docker/cagent
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cage/overview
- **Total Downloads**: 25.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/docker/cagent
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cage:2016.05.13--he8c0b07_8 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:3a40e12c7646e7b4a373847bd93caf17738df077b20e7c60642060ca8ae9846e: unpack entry: usr/local/bin/python3.13: unpack to regular file: short write: write /tmp/build-temp-1225681945/rootfs/usr/local/bin/python3.13: no space left on device
```


## Metadata
- **Skill**: generated
