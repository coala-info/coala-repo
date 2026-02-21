# ucsc-bedjointaboffset CWL Generation Report

## ucsc-bedjointaboffset

### Tool Description
The provided text does not contain help information for the tool. It is an error log indicating a failure to build the container image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-bedjointaboffset:377--h199ee4e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-bedjointaboffset/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-bedjointaboffset/overview
- **Total Downloads**: 9.6K
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
2026/02/14 08:33:33  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/ucsc-bedjointaboffset:377--h199ee4e_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:c2741db69648dddf25e5edcfb6df31f48f59b1515b2cd2a6186b619f2a1cc164: unpack entry: usr/local/lib/libcrypto.a: unpack to regular file: short write: write /tmp/build-temp-2723465116/rootfs/usr/local/lib/libcrypto.a: no space left on device
```


## Metadata
- **Skill**: generated
