# barrnap CWL Generation Report

## barrnap

### Tool Description
The provided text does not contain help information for barrnap; it is an error log indicating a failure to build or extract the container image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/barrnap:0.9--0
- **Homepage**: https://github.com/tseemann/barrnap
- **Package**: https://anaconda.org/channels/bioconda/packages/barrnap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/barrnap/overview
- **Total Downloads**: 177.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tseemann/barrnap
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/10 01:33:38  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/barrnap:0.9--0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:fa59ab95ff91072542c2f4d72167bae7c39ec32067247bfc488f0ce04c667263: unpack entry: usr/local/lib/perl5/5.22.2/x86_64-linux-thread-multi/Devel/PPPort.pm: unpack to regular file: short write: write /scratch/21813747/build-temp-1331507111/rootfs/usr/local/lib/perl5/5.22.2/x86_64-linux-thread-multi/Devel/PPPort.pm: no space left on device
```


## Metadata
- **Skill**: generated
