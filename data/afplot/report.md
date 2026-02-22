# afplot CWL Generation Report

## afplot_build

### Tool Description
A tool or script for building a SIF (Singularity Image Format) container for afplot from an OCI/Docker image.

### Metadata
- **Docker Image**: quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1
- **Homepage**: https://github.com/sndrtj/afplot
- **Package**: https://anaconda.org/channels/bioconda/packages/afplot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/afplot/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sndrtj/afplot
- **Stars**: 11
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/05 13:05:55  warn rootless{dev/random} creating empty file in place of device 1:8
2026/02/05 13:05:55  warn rootless{dev/full} creating empty file in place of device 1:7
2026/02/05 13:05:55  warn rootless{dev/urandom} creating empty file in place of device 1:9
2026/02/05 13:05:55  warn rootless{dev/tty} creating empty file in place of device 5:0
2026/02/05 13:05:55  warn rootless{dev/null} creating empty file in place of device 1:3
2026/02/05 13:05:55  warn rootless{dev/zero} creating empty file in place of device 1:5
2026/02/05 13:05:57  warn rootless{usr/local/man} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
FATAL:   Unable to handle docker://quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:04cb4c0c7760a35771d929faf697e001f2861e2a5ed6ae95c2b30251ded53330: unpack entry: usr/local/bin/bcftools: unpack to regular file: short write: write /tmp/build-temp-2518558666/rootfs/usr/local/bin/bcftools: no space left on device
```


## Metadata
- **Skill**: generated

## afplot

### Tool Description
A tool for plotting allele frequencies from VCF files (Note: The provided text is a container execution error log and does not contain help documentation).

### Metadata
- **Docker Image**: quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1
- **Homepage**: https://github.com/sndrtj/afplot
- **Package**: https://anaconda.org/channels/bioconda/packages/afplot/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/05 13:07:19  warn rootless{dev/random} creating empty file in place of device 1:8
2026/02/05 13:07:19  warn rootless{dev/full} creating empty file in place of device 1:7
2026/02/05 13:07:19  warn rootless{dev/urandom} creating empty file in place of device 1:9
2026/02/05 13:07:19  warn rootless{dev/tty} creating empty file in place of device 5:0
2026/02/05 13:07:19  warn rootless{dev/null} creating empty file in place of device 1:3
2026/02/05 13:07:19  warn rootless{dev/zero} creating empty file in place of device 1:5
2026/02/05 13:07:21  warn rootless{usr/local/man} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
FATAL:   Unable to handle docker://quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:04cb4c0c7760a35771d929faf697e001f2861e2a5ed6ae95c2b30251ded53330: unpack entry: usr/local/bin/bcftools: unpack to regular file: short write: write /tmp/build-temp-1869178092/rootfs/usr/local/bin/bcftools: no space left on device
```

