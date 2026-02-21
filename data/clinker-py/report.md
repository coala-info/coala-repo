# clinker-py CWL Generation Report

## clinker-py

### Tool Description
The provided text does not contain help information or usage instructions. It appears to be a fatal error log from a container runtime (Singularity/Apptainer) indicating a 'no space left on device' failure during the image build/extraction process.

### Metadata
- **Docker Image**: quay.io/biocontainers/clinker-py:0.0.32--pyhdfd78af_0
- **Homepage**: https://github.com/gamcil/clinker
- **Package**: https://anaconda.org/channels/bioconda/packages/clinker-py/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clinker-py/overview
- **Total Downloads**: 33.0K
- **Last updated**: 2025-12-25
- **GitHub**: https://github.com/gamcil/clinker
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/clinker-py:0.0.32--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/bin/bash: unpack to regular file: short write: write /tmp/build-temp-2329120394/rootfs/usr/bin/bash: no space left on device
```


## Metadata
- **Skill**: generated
