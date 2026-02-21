# dadi CWL Generation Report

## dadi

### Tool Description
The provided text does not contain help information or a description of the tool; it is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build the image due to lack of disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/dadi:2.0.5--py36hc1659b7_0
- **Homepage**: https://bitbucket.org/gutenkunstlab/dadi
- **Package**: https://anaconda.org/channels/bioconda/packages/dadi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dadi/overview
- **Total Downloads**: 17.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 16:59:35  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/dadi:2.0.5--py36hc1659b7_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:e53aa5a7b30cf5bf1b4c810b8682c94fa2074aec51733d6f98a69c300f11281f: unpack entry: usr/local/bin/assistant: unpack to regular file: short write: write /tmp/build-temp-2320231007/rootfs/usr/local/bin/assistant: no space left on device
```


## Metadata
- **Skill**: not generated
