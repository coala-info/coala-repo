# screed CWL Generation Report

## screed

### Tool Description
A tool for reading and manipulating biological sequence files (FASTA/FASTQ). Note: The provided text is a container runtime error log (Apptainer/Singularity) indicating a 'no space left on device' failure during image extraction, and does not contain CLI help text or argument definitions.

### Metadata
- **Docker Image**: quay.io/biocontainers/screed:1.0.4--py_0
- **Homepage**: http://github.com/dib-lab/screed/
- **Package**: https://anaconda.org/channels/bioconda/packages/screed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/screed/overview
- **Total Downloads**: 40.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dib-lab/screed
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 03:12:24  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/screed:1.0.4--py_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:4cd328ad086ff980e4111970800fd757cf3fc084486f2fb37771f574de77f408: unpack entry: usr/local/lib/libpython3.8.a: unpack to regular file: short write: write /tmp/build-temp-3105704154/rootfs/usr/local/lib/libpython3.8.a: no space left on device
```


## Metadata
- **Skill**: not generated
