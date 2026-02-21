# catch_chimera CWL Generation Report

## catch_chimera

### Tool Description
The provided text does not contain help information or documentation for the tool. It is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build the image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0
- **Homepage**: https://science.sckcen.be/en/Institutes/EHS/MCB/MIC/Bioinformatics/CATCh
- **Package**: https://anaconda.org/channels/bioconda/packages/catch_chimera/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/catch_chimera/overview
- **Total Downloads**: 2.9K
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
FATAL:   Unable to handle docker://quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:5c8263612cf8c112cb6b758c3764c2fbea96b4a531c3aac1a2331277fc073e0f: unpack entry: usr/local/bin/python3.10: unpack to regular file: short write: write /tmp/build-temp-2871354000/rootfs/usr/local/bin/python3.10: no space left on device
```


## Metadata
- **Skill**: not generated
