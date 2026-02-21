# cath-tools CWL Generation Report

## cath-tools

### Tool Description
The provided text does not contain help documentation or usage instructions. It appears to be a system log showing a fatal error during a container build process (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
- **Homepage**: https://github.com/UCLOrengoGroup/cath-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cath-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cath-tools/overview
- **Total Downloads**: 11.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/UCLOrengoGroup/cath-tools
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 12:45:18  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:b893cfd62d42906754badac77fbbfd2163ac2d47ffb6f8db2545be759bb0f72c: unpack entry: usr/local/bin/cath-refine-align: unpack to regular file: short write: write /tmp/build-temp-4039890862/rootfs/usr/local/bin/cath-refine-align: no space left on device
```


## Metadata
- **Skill**: generated
