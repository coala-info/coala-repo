# bamdash CWL Generation Report

## bamdash

### Tool Description
The provided text does not contain help information or a description of the tool; it is an error log from a container build process (Apptainer/Singularity) indicating a 'no space left on device' failure.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamdash:0.4.5--pyhdfd78af_0
- **Homepage**: https://github.com/jonas-fuchs/BAMdash
- **Package**: https://anaconda.org/channels/bioconda/packages/bamdash/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamdash/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/jonas-fuchs/BAMdash
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bamdash:0.4.5--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:71dd950fcf8d9b127ab7a831dd8a90a91dd56a987d33450942513f1dd7bbd8d9: unpack entry: usr/local/lib/libkrb5.so.3.3: unpack to regular file: short write: write /scratch/21813747/build-temp-2557363835/rootfs/usr/local/lib/libkrb5.so.3.3: no space left on device
```


## Metadata
- **Skill**: generated
