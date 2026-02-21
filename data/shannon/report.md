# shannon CWL Generation Report

## shannon

### Tool Description
The provided text does not contain help information or a description of the tool; it contains system logs and a fatal error message regarding a failed container build due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/shannon:0.0.2--py_0
- **Homepage**: http://sreeramkannan.github.io/Shannon/
- **Package**: https://anaconda.org/channels/bioconda/packages/shannon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shannon/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sreeramkannan/Shannon
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 22:25:18  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/shannon:0.0.2--py_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0fe89e1394bfff815ce709c373e1e1c6ccd8ebfe050bd01b0438a74da80fba44: unpack entry: usr/local/include/readline/rltypedefs.h: unpack to regular file: short write: write /tmp/build-temp-3722320828/rootfs/usr/local/include/readline/rltypedefs.h: no space left on device
```


## Metadata
- **Skill**: generated

## shannon_shannon.py

### Tool Description
The provided text does not contain help information for the tool. It consists of system error messages related to a container image build failure (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/shannon:0.0.2--py_0
- **Homepage**: http://sreeramkannan.github.io/Shannon/
- **Package**: https://anaconda.org/channels/bioconda/packages/shannon/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 22:26:19  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/shannon:0.0.2--py_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0fe89e1394bfff815ce709c373e1e1c6ccd8ebfe050bd01b0438a74da80fba44: unpack entry: usr/local/include/readline/rltypedefs.h: unpack to regular file: short write: write /tmp/build-temp-1078058170/rootfs/usr/local/include/readline/rltypedefs.h: no space left on device
```

