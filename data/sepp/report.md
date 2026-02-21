# sepp CWL Generation Report

## sepp

### Tool Description
The provided text does not contain help information for the tool 'sepp'. It is an error log from a container build process (Singularity/Apptainer) indicating a failure due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/sepp:4.5.6--py39hbcbf7aa_2
- **Homepage**: https://github.com/seppukudevelopment/seppuku
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sepp/overview
- **Total Downloads**: 938.3K
- **Last updated**: 2026-02-12
- **GitHub**: https://github.com/seppukudevelopment/seppuku
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/sepp:4.5.6--py39hbcbf7aa_2 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:bc034c24d912ae4168681d768752458d0f38774fea463ac19bf835a9b557a881: unpack entry: usr/local/bin/python3.9: unpack to regular file: short write: write /tmp/build-temp-3920761560/rootfs/usr/local/bin/python3.9: no space left on device
```


## Metadata
- **Skill**: generated
