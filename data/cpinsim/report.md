# cpinsim CWL Generation Report

## cpinsim

### Tool Description
The provided text does not contain help information or usage instructions for the tool. It is a log of a failed container build process (Apptainer/Singularity) due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpinsim:0.5.2--py36_1
- **Homepage**: https://github.com/BiancaStoecker/cpinsim
- **Package**: https://anaconda.org/channels/bioconda/packages/cpinsim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cpinsim/overview
- **Total Downloads**: 7.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BiancaStoecker/cpinsim
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 06:54:03  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/cpinsim:0.5.2--py36_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:3209f3c91e3b3a603aa737463190acc070ac8ea36fbf24c702ed728e3d1181a8: unpack entry: usr/local/lib/libmkl_avx2.so: unpack to regular file: short write: write /scratch/21834835/build-temp-2385819675/rootfs/usr/local/lib/libmkl_avx2.so: no space left on device
```


## Metadata
- **Skill**: generated
