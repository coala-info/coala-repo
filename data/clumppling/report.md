# clumppling CWL Generation Report

## clumppling

### Tool Description
The provided text does not contain help information for the tool 'clumppling'. It appears to be an error log from a container runtime (Singularity/Apptainer) indicating a failure to build or extract the OCI image due to lack of disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/clumppling:2.0.6--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/clumppling
- **Package**: https://anaconda.org/channels/bioconda/packages/clumppling/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clumppling/overview
- **Total Downloads**: 873
- **Last updated**: 2025-12-04
- **GitHub**: https://github.com/PopGenClustering/Clumppling
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/clumppling:2.0.6--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr: mkdirall: unpriv.mkdirall: mkdir /tmp/build-temp-1699263214/rootfs/usr: no space left on device
```


## Metadata
- **Skill**: generated
