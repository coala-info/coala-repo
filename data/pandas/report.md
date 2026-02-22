# pandas CWL Generation Report

## pandas

### Tool Description
The provided text does not contain help information or usage instructions for the pandas tool. It consists of error messages from a container runtime (Singularity/Apptainer) indicating a failure to pull and build a SIF image for pandas due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/pandas:2.2.1
- **Homepage**: https://github.com/pandas-dev/pandas
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pandas/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/pandas-dev/pandas
- **Stars**: N/A
### Original Help Text
```text
WARNING: Couldn't use cached digest for registry: write /home/qhu/.singularity/cache/blob/blobs/sha256/509adc4983db6c608fa516bea822c29bf34d5b3f039d331fc705fc27492a0987: no space left on device
WARNING: Falling back to direct digest.
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/pandas:2.2.1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3642966867: no space left on device
```

