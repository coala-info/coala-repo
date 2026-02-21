# cufflinks CWL Generation Report

## cufflinks

### Tool Description
The provided text does not contain help information or usage instructions. It appears to be a system error log indicating a failure to build or extract a container image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/cufflinks:2.2.1--py35_2
- **Homepage**: https://github.com/santosjorge/cufflinks
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cufflinks/overview
- **Total Downloads**: 80.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/santosjorge/cufflinks
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 16:00:52  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/cufflinks:2.2.1--py35_2 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:750770ad205ed7d1c50884f4f4a8fb50743c9e3366b22c5551f37bdccf99300c: unpack entry: usr/local/bin/gtf_to_sam: unpack to regular file: short write: write /tmp/build-temp-2817140013/rootfs/usr/local/bin/gtf_to_sam: no space left on device
```


## Metadata
- **Skill**: generated
