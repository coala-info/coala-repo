# plascope CWL Generation Report

## plascope

### Tool Description
The provided text does not contain help information for the tool. It is a log of a container build failure due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/plascope:1.3.1--1
- **Homepage**: https://github.com/GuilhemRoyer/PlaScope
- **Package**: https://anaconda.org/channels/bioconda/packages/plascope/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plascope/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/GuilhemRoyer/PlaScope
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 21:52:38  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/plascope:1.3.1--1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:910814d58b548b783820fc68dfec9d7c0e2d41baaaa54f6c513828fef5928aba: unpack entry: usr/local/lib/libtk8.6.so: unpack to regular file: short write: write /tmp/build-temp-3307857542/rootfs/usr/local/lib/libtk8.6.so: no space left on device
```


## Metadata
- **Skill**: generated

## plascope_plaScope.sh

### Tool Description
The provided text does not contain help information for the tool, but appears to be an error log from a container runtime (Singularity/Apptainer) indicating a failure to build the image due to lack of disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/plascope:1.3.1--1
- **Homepage**: https://github.com/GuilhemRoyer/PlaScope
- **Package**: https://anaconda.org/channels/bioconda/packages/plascope/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 21:53:46  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/plascope:1.3.1--1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:910814d58b548b783820fc68dfec9d7c0e2d41baaaa54f6c513828fef5928aba: unpack entry: usr/local/lib/libtk8.6.so: unpack to regular file: short write: write /tmp/build-temp-1863993534/rootfs/usr/local/lib/libtk8.6.so: no space left on device
```

