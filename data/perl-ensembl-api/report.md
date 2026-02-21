# perl-ensembl-api CWL Generation Report

## perl-ensembl-api

### Tool Description
The provided text is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build or extract the tool's image due to insufficient disk space ('no space left on device'). It does not contain CLI help text or argument definitions.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-ensembl-api:98--0
- **Homepage**: https://www.ensembl.org/info/docs/api/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-ensembl-api/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-ensembl-api/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 10:27:12  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/perl-ensembl-api:98--0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:7b9be1a745e06254712b943548e6453fdc0b0e69b0e99aca3ef04974172ad526: unpack entry: usr/local/bin/mysqltest: unpack to regular file: short write: write /tmp/build-temp-1787527582/rootfs/usr/local/bin/mysqltest: no space left on device
```


## Metadata
- **Skill**: not generated
