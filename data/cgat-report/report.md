# cgat-report CWL Generation Report

## cgat-report

### Tool Description
The provided text is an error log from a container runtime (Singularity/Apptainer) and does not contain the help documentation or usage instructions for the cgat-report tool. The log indicates a failure to build the container image due to 'no space left on device'.

### Metadata
- **Docker Image**: quay.io/biocontainers/cgat-report:0.9.1--py_0
- **Homepage**: https://github.com/AndreasHeger/CGATReport
- **Package**: https://anaconda.org/channels/bioconda/packages/cgat-report/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cgat-report/overview
- **Total Downloads**: 35.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AndreasHeger/CGATReport
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 14:44:28  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/cgat-report:0.9.1--py_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:cfb1ba34637d96787f6e780192bc5f09c04fe0b40c4e1acdcbc88953bce25b5b: unpack entry: lib/libc-2.18.so: unpack to regular file: short write: write /tmp/build-temp-2269349227/rootfs/lib/libc-2.18.so: no space left on device
```


## Metadata
- **Skill**: not generated
