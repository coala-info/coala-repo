# seedme CWL Generation Report

## seedme

### Tool Description
The provided text does not contain help information or usage instructions for the 'seedme' tool; it contains error logs from a container runtime (Apptainer/Singularity) indicating a failure to pull or build the image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/seedme:1.2.4--py27_1
- **Homepage**: https://github.com/HackUCF/seedme
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seedme/overview
- **Total Downloads**: 12.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HackUCF/seedme
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 04:19:41  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/seedme:1.2.4--py27_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:64d8a6f930a4e813f07b862d0ab534ce9ecd0b02a0c7f67cbc94b632ec353045: unpack entry: usr/local/lib/libssl.so.1.0.0: unpack to regular file: short write: write /tmp/build-temp-2929605767/rootfs/usr/local/lib/libssl.so.1.0.0: no space left on device
```


## Metadata
- **Skill**: generated
