# bellavista CWL Generation Report

## bellavista

### Tool Description
The provided text does not contain help documentation or usage instructions for the tool 'bellavista'. It contains log messages and a fatal error related to a container build process (Apptainer/Singularity) failing due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/bellavista:0.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/pkosurilab/BellaVista
- **Package**: https://anaconda.org/channels/bioconda/packages/bellavista/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bellavista/overview
- **Total Downloads**: 406
- **Last updated**: 2025-04-24
- **GitHub**: https://github.com/pkosurilab/BellaVista
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bellavista:0.0.2--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:36b7914fc8ba5e3cd9a86a4a572597a8617a2e754230f1cc116ac7119019afd9: unpack entry: usr/bin/scriptlive: unpack to regular file: short write: write /scratch/21813747/build-temp-4169634166/rootfs/usr/bin/scriptlive: no space left on device
```


## Metadata
- **Skill**: generated
