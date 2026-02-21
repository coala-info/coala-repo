# afterqc CWL Generation Report

## afterqc

### Tool Description
The provided text does not contain help information for the tool 'afterqc'. It is a log of a failed container build/extraction process due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/afterqc:0.9.7--py27_0
- **Homepage**: https://github.com/OpenGene/AfterQC
- **Package**: https://anaconda.org/channels/bioconda/packages/afterqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/afterqc/overview
- **Total Downloads**: 13.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/OpenGene/AfterQC
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/05 13:10:00  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/afterqc:0.9.7--py27_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:ca453801068db0a2f79951116ed9d2f2a9359c0093726d1771783b0fb5ebf3b8: unpack entry: usr/local/lib/python2.7/lib-dynload/select.so: unpack to regular file: short write: write /tmp/build-temp-1417508691/rootfs/usr/local/lib/python2.7/lib-dynload/select.so: no space left on device
```


## Metadata
- **Skill**: generated

## afterqc_after.py

### Tool Description
The provided text does not contain help information or usage instructions for afterqc_after.py. It contains error logs related to a failed Singularity/Apptainer image build due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/afterqc:0.9.7--py27_0
- **Homepage**: https://github.com/OpenGene/AfterQC
- **Package**: https://anaconda.org/channels/bioconda/packages/afterqc/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/05 13:11:17  warn rootless{dev/console} creating empty file in place of device 5:1
FATAL:   Unable to handle docker://quay.io/biocontainers/afterqc:0.9.7--py27_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:ca453801068db0a2f79951116ed9d2f2a9359c0093726d1771783b0fb5ebf3b8: unpack entry: usr/local/lib/python2.7/lib-dynload/select.so: unpack to regular file: short write: write /tmp/build-temp-3025299008/rootfs/usr/local/lib/python2.7/lib-dynload/select.so: no space left on device
```

