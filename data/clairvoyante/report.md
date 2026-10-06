# clairvoyante CWL Generation Report

## Metadata
- **Skill**: generated

## clairvoyante_ExtractVariantCandidates.py

### Tool Description
Extract variant candidates from a BAM file for Clairvoyante variant calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/clairvoyante:1.02--0
- **Homepage**: https://github.com/aquaskyline/Clairvoyante
- **Package**: https://anaconda.org/channels/bioconda/packages/clairvoyante/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 17:17:19  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/clairvoyante:1.02--0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:b0dc45cd432d14fb6df7d3239dc15d09c63906f8e7bfd373a4647b107fc3746c: unpack entry: lib/libc-2.18.so: unpack to regular file: short write: write /tmp/build-temp-4137425398/rootfs/lib/libc-2.18.so: no space left on device
```

## clairvoyante_callVar.py

### Tool Description
Call variants using a trained Clairvoyante model

### Metadata
- **Docker Image**: quay.io/biocontainers/clairvoyante:1.02--0
- **Homepage**: https://github.com/aquaskyline/Clairvoyante
- **Package**: https://anaconda.org/channels/bioconda/packages/clairvoyante/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 17:17:57  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/clairvoyante:1.02--0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:b0dc45cd432d14fb6df7d3239dc15d09c63906f8e7bfd373a4647b107fc3746c: unpack entry: lib/libc-2.18.so: unpack to regular file: short write: write /tmp/build-temp-2539205230/rootfs/lib/libc-2.18.so: no space left on device
```

