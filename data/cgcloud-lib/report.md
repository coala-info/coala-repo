# cgcloud-lib CWL Generation Report

## cgcloud-lib

### Tool Description
The provided text does not contain help documentation or usage instructions for cgcloud-lib. It consists of system logs and a fatal error message regarding a container build failure (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/cgcloud-lib:1.6.0--py27_1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cgcloud-lib/overview
- **Total Downloads**: 19.3K
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
2026/02/11 14:49:42  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/cgcloud-lib:1.6.0--py27_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:77c6c00e8b61bb628567c060b85690b0b0561bb37d8ad3f3792877bddcfe2500: unpack entry: lib/libc-2.18.so: unpack to regular file: short write: write /tmp/build-temp-3719594828/rootfs/lib/libc-2.18.so: no space left on device
```


## Metadata
- **Skill**: not generated
