# beagle CWL Generation Report

## beagle_build

### Tool Description
The provided text is a log of a failed container build process (Apptainer/Singularity) for the Beagle tool and does not contain CLI help documentation or argument definitions.

### Metadata
- **Docker Image**: quay.io/biocontainers/beagle:5.5_27Feb25.75f--hdfd78af_0
- **Homepage**: https://github.com/yampelo/beagle
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/beagle/overview
- **Total Downloads**: 41.8K
- **Last updated**: 2025-09-18
- **GitHub**: https://github.com/yampelo/beagle
- **Stars**: 1339
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/beagle:5.5_27Feb25.75f--hdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0ffb0b2f697a3b30a85d8514a35b564d34b7083f2f0693b8cfd47d77a0b9b969: unpack entry: usr/local/bin/pcre2test: unpack to regular file: short write: write /scratch/21813747/build-temp-1663539165/rootfs/usr/local/bin/pcre2test: no space left on device
```


## Metadata
- **Skill**: generated

## beagle

### Tool Description
The provided text does not contain help information or usage instructions for the tool. It appears to be a system error log from a container runtime (Apptainer/Singularity) indicating a failure to extract the OCI image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/beagle:5.5_27Feb25.75f--hdfd78af_0
- **Homepage**: https://github.com/yampelo/beagle
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/beagle:5.5_27Feb25.75f--hdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0ffb0b2f697a3b30a85d8514a35b564d34b7083f2f0693b8cfd47d77a0b9b969: unpack entry: usr/local/bin/pcre2test: unpack to regular file: short write: write /scratch/21813747/build-temp-4190002388/rootfs/usr/local/bin/pcre2test: no space left on device
```

