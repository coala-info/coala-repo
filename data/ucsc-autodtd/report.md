# ucsc-autodtd CWL Generation Report

## ucsc-autodtd

### Tool Description
The provided text is an error log indicating a failure to build or extract the container image ('no space left on device') and does not contain the help text for the tool. Based on the tool name, it is a UCSC Genome Browser utility used to automatically create a DTD from XML files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-autodtd:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-autodtd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-autodtd/overview
- **Total Downloads**: 25.3K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/ucsc-autodtd:482--h0b57e2e_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:aaad627d37386a966a870ede488633184ce9e3676c66161aa247aa038d109cad: unpack entry: usr/local/lib/libquadmath.so.0.0.0: unpack to regular file: short write: write /tmp/build-temp-2436431124/rootfs/usr/local/lib/libquadmath.so.0.0.0: no space left on device
```


## Metadata
- **Skill**: generated
