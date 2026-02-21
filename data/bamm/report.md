# bamm CWL Generation Report

## bamm

### Tool Description
The provided text is a system error log from a container runtime (Apptainer/Singularity) indicating a failure to build or pull the image due to insufficient disk space. It does not contain the tool's help text or argument definitions.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamm:1.7.3--py27h790c10a_7
- **Homepage**: https://github.com/Ecogenomics/BamM
- **Package**: https://anaconda.org/channels/bioconda/packages/bamm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamm/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/Ecogenomics/BamM
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/10 00:34:43  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/bamm:1.7.3--py27h790c10a_7 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:f7a7125ef10bad8015fd9023134da18468512b1075a2a752b57715784761107d: unpack entry: usr/local/lib/libasan.so.5.0.0: unpack to regular file: short write: write /scratch/21813747/build-temp-4242706278/rootfs/usr/local/lib/libasan.so.5.0.0: no space left on device
```


## Metadata
- **Skill**: generated
