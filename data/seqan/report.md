# seqan CWL Generation Report

## seqan

### Tool Description
The provided text does not contain help documentation or usage instructions for the 'seqan' tool. It is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build or extract a Docker image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/seqan:2.4.0--0
- **Homepage**: http://www.seqan.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqan/overview
- **Total Downloads**: 35.5K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/seqan/seqan
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 20:04:06  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/seqan:2.4.0--0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:1f60db19b89e28e661d32add514881a8b0eef20e6c550e0366933879c30da2d3: unpack entry: usr/local/share/doc/seqan/html/img/list.pdf: unpack to regular file: short write: write /tmp/build-temp-2209427995/rootfs/usr/local/share/doc/seqan/html/img/list.pdf: no space left on device
```


## Metadata
- **Skill**: generated
